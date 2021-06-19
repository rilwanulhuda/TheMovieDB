//
//  TopRatedViewController.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 18/06/21.
//

import UIKit

class TopRatedViewController: UIViewController {
    @IBOutlet weak var topRatedMoviesTableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(startRefresh), for: .valueChanged)
        return rc
    }()
    
    var viewModel: TopRatedMoviesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupViewModel()
        getTopRatedMovies()
    }
    
    private func setupComponent() {
        topRatedMoviesTableView.rowHeight = UITableView.automaticDimension
        topRatedMoviesTableView.estimatedRowHeight = 80
        topRatedMoviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        topRatedMoviesTableView.refreshControl = refreshControl
    }
    
    private func setupViewModel() {
        let networkService = NetworkService.share
        let topRatedProvider = MoviesProvider(networkService: networkService)
        viewModel = TopRatedMoviesViewModel(moviesProvider: topRatedProvider)
        viewModel.delegate = self
    }
    
    private func getTopRatedMovies() {
        viewModel.getTopRatedMovies()
    }
    
    @objc func startRefresh() {
        viewModel.page = 1
        viewModel.getTopRatedMovies()
    }
}

extension TopRatedViewController: TopRatedMoviesViewModelDelegate {
    func didSuccesGetTopRated() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        
        topRatedMoviesTableView.reloadData()
    }
    
    func didFailGetTopRated(message: String) {
        print("Failed To Get Top Rated Movies")
        
        
    }
}

extension TopRatedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        let movie = viewModel.movies[indexPath.row]
        cell.setupView(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay cell at index \(indexPath.row)")
        
        if indexPath.row == viewModel.movies.count - 1, !viewModel.movies.isEmpty {
            if viewModel.movies.count < viewModel.totalResults, viewModel.page < viewModel.totalPages {
                print("Start Load More Movies")
                
                viewModel.isLoadingMore = true
                viewModel.page += 1
                viewModel.getTopRatedMovies()
            }
        }
    }
}
