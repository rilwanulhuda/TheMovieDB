//
//  MainViewController.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 18/06/21.
//

import UIKit

class MainViewController: UITabBarController {
    var homeVC: HomeViewController!
    var popularVC: PopularViewController!
    var topRatedVC: TopRatedViewController!
    var upcomingVC: UpcomingViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
    }

    private func setupComponent() {
        homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)

        popularVC = PopularViewController()
        popularVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        topRatedVC = TopRatedViewController()
        topRatedVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)

        upcomingVC = UpcomingViewController()
        upcomingVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)

        viewControllers = [homeVC, popularVC, topRatedVC, upcomingVC].compactMap { UINavigationController(rootViewController: $0) }
    }
}
