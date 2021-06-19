//
//  HomeViewController.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 16/06/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var moviesHomeTableView: UITableView!

    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(startRefresh), for: .valueChanged)
        return rc
    }()

    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupViewModel()
        getMovies()
    }

    private func setupComponent() {
        moviesHomeTableView.rowHeight = UITableView.automaticDimension
        moviesHomeTableView.estimatedRowHeight = 80
        moviesHomeTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        moviesHomeTableView.refreshControl = refreshControl
    }

    private func setupViewModel() {
        let networkService = NetworkService.share
        let moviesProvider = MoviesProvider(networkService: networkService)
        viewModel = HomeViewModel(moviesProvider: moviesProvider)
        viewModel.delegate = self
    }

    private func getMovies() {
        viewModel.getNowPlaying()
    }

    @objc func startRefresh() {
        viewModel.page = 1
        viewModel.getNowPlaying()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didSuccessGetMovies() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }

        moviesHomeTableView.reloadData()
    }

    func didFailGetMovies(message: String) {
        print("Failed Get Movies: \(message)")

        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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
        print("willDisplay cell at index: \(indexPath.row)")

        if indexPath.row == viewModel.movies.count - 1, !viewModel.movies.isEmpty {
            if viewModel.movies.count < viewModel.totalResults, viewModel.page < viewModel.totalPages {
                print("Start load more movies..")

                viewModel.isLoadingMore = true
                viewModel.page += 1
                viewModel.getNowPlaying()
            }
        }
    }
}
