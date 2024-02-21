//
//  TabBarViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UITabBar.appearance().tintColor = .white
        
        setViewControllers([
            createHomeNavigationController(),
            createSearchNavigationController(),
            createLibraryNavigationController()
        
        ], animated: false)
    }
    
    
    
    private func createHomeNavigationController() -> UINavigationController {
        let homeViewController = HomeViewController()
        homeViewController.title = "Browse"
        homeViewController.navigationItem.largeTitleDisplayMode = .always
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.navigationBar.prefersLargeTitles = true
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        return homeNavigationController
    }
    
    private func createSearchNavigationController() -> UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.navigationItem.largeTitleDisplayMode = .always
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchNavigationController.navigationBar.prefersLargeTitles = true
        searchNavigationController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return searchNavigationController
    }
    
    private func createLibraryNavigationController() -> UINavigationController {
        let libraryViewController = LibraryViewController()
        libraryViewController.title = "Library"
        libraryViewController.navigationItem.largeTitleDisplayMode = .always
        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
        libraryNavigationController.navigationBar.prefersLargeTitles = true
        libraryNavigationController.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "books.vertical"), tag: 3)
        return libraryNavigationController
    }
}

#Preview("TabBar View Controller"){
    TabBarViewController()
}
