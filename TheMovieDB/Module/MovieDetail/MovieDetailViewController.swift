//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 19/06/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet var backdropPathImageView: UIImageView!
    @IBOutlet var posterPathImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var taglineLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var originalTitleLabel: UILabel!
    @IBOutlet var budgetLabel: UILabel!
    @IBOutlet var revenueLabel: UILabel!
    @IBOutlet var homePageLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var productionCompaniesLabel: UILabel!
    @IBOutlet var productionCountriesLabel: UILabel!
    @IBOutlet var trailersCollectionView: UICollectionView!
    @IBOutlet var trailersCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: MovieDetailViewModel!
    var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupViewModel()
        getMovieDetail()
    }
    
    private func setupComponent() {
        title = "Movie Detail"
        
        trailersCollectionView.register(UINib(nibName: "TrailersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TrailersCollectionViewCell")
    }
    
    private func setupViewModel() {
        let networkService = NetworkService.share
        let movieProvider = MoviesProvider(networkService: networkService)
        viewModel = MovieDetailViewModel(movieProvider: movieProvider)
        viewModel.delegate = self
    }
    
    private func getMovieDetail() {
        viewModel.getMovieDetail(movieId: movieId)
    }
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func didSuccessGetMovieDetail() {
        guard let movieDetail = viewModel.movieDetail else {
            print("viewModel.movieDetail: nil")
            return
        }
        
        titleLabel.text = movieDetail.title
        releaseDateLabel.text = movieDetail.releaseDate
        taglineLabel.text = movieDetail.tagline
        overviewLabel.text = movieDetail.overview
        originalTitleLabel.text = movieDetail.originalTitle
        homePageLabel.text = movieDetail.homePage
        runtimeLabel.text = movieDetail.runtime
        budgetLabel.text = movieDetail.budget
        revenueLabel.text = movieDetail.revenue
        
        posterPathImageView.kf.indicatorType = .activity
        backdropPathImageView.kf.indicatorType = .activity
        posterPathImageView.kf.setImage(with: movieDetail.posterPathUrl)
        backdropPathImageView.kf.setImage(with: movieDetail.backdropPathUrl)
        genresLabel.text = movieDetail.genres
        productionCompaniesLabel.text = movieDetail.productionCompanies
        productionCountriesLabel.text = movieDetail.productionCountries
        
        trailersCollectionView.reloadData()
        
        print("Success Get Movie Detail")
    }
    
    func didFailGetMovieDetail(message: String) {
        print("Did Fail Get Movie Detail: \(message)")
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.trailers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrailersCollectionViewCell", for: indexPath) as! TrailersCollectionViewCell
        let trailer = viewModel.trailers[indexPath.item]
        cell.setupView(model: trailer)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let videoUrl = viewModel.trailers[indexPath.item].videoUrl else { return }
        if UIApplication.shared.canOpenURL(videoUrl) {
            UIApplication.shared.open(videoUrl, options: [:], completionHandler: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 3 * 12
        let width: CGFloat = (collectionView.frame.width / 2) - padding
        let height: CGFloat = (width / 177) * 118
        trailersCollectionViewHeightConstraint.constant = height + 16
        return CGSize(width: width, height: height)
    }
}
