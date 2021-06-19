//
//  UpcomingViewController.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 18/06/21.
//

import UIKit

class UpcomingViewController: UIViewController {
    @IBOutlet var upcomingMoviesTableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(startRefresh), for: .valueChanged)
        return rc
    }()
    
    var viewModel: UpcomingMoviesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupViewModel()
        getUpcomingMovies()
    }
    
    private func setupComponent() {
        upcomingMoviesTableView.rowHeight = UITableView.automaticDimension
        upcomingMoviesTableView.estimatedRowHeight = 80
        upcomingMoviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        upcomingMoviesTableView.refreshControl = refreshControl
    }
    
    private func setupViewModel() {
        let networkService = NetworkService.share
        let upcomingProvider = MoviesProvider(networkService: networkService)
        viewModel = UpcomingMoviesViewModel(moviesProvider: upcomingProvider)
        viewModel?.delegate = self
    }
    
    private func getUpcomingMovies() {
        viewModel.getUpcomingMovies()
    }
    
    @objc func startRefresh() {
        viewModel.page = 1
        viewModel.getUpcomingMovies()
    }
}

extension UpcomingViewController: UpcomingMoviesViewModelDelegate {
    func didSuccesGetUpcomingMovies() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        
        upcomingMoviesTableView.reloadData()
    }
    
    func didFailGetUpcomingMovies(message: String) {
        print("Failed To Get Upcoming Movies")
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
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
        print("willDisplay at index \(indexPath.row)")
        
        if indexPath.row == viewModel.movies.count - 1, !viewModel.movies.isEmpty {
            if viewModel.movies.count < viewModel.totalResults, viewModel.page < viewModel.totalPages {
                print("Start Load More Movies")
                
                viewModel.isLoadingMore = true
                viewModel.page += 1
                viewModel.getUpcomingMovies()
            }
        }
    }
}
