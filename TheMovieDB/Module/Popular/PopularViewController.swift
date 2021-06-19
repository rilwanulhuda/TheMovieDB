//
//  PopularViewController.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 17/06/21.
//

import UIKit

class PopularViewController: UIViewController {
    @IBOutlet var popularMoviesTableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(startRefresh), for: .valueChanged)
        return rc
    }()
    
    var viewModel: PopularMoviesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupViewModel()
        getPopularMovies()
    }

    private func setupComponent() {
        popularMoviesTableView.rowHeight = UITableView.automaticDimension
        popularMoviesTableView.estimatedRowHeight = 80
        popularMoviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        popularMoviesTableView.refreshControl = refreshControl
    }
    
    private func setupViewModel() {
        let networkService = NetworkService.share
        let popularProvider = MoviesProvider(networkService: networkService)
        viewModel = PopularMoviesViewModel(moviesProvider: popularProvider)
        viewModel.delegate = self
    }
    
    private func getPopularMovies() {
        viewModel.getPopularMovies()
    }
    
    @objc func startRefresh() {
        viewModel.page = 1
        viewModel.getPopularMovies()
    }
}

extension PopularViewController: PopularMoviesViewModelDelegate {
    func didSuccesGetPopular() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        
        popularMoviesTableView.reloadData()
    }
    
    func didFailGetPopular(message: String) {
        print("Failed To Get Popular Movies \(message)")
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
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
                print("Start Load More Movies..")
                
                viewModel.isLoadingMore = true
                viewModel.page += 1
                viewModel.getPopularMovies()
            }
        }
    }
}
