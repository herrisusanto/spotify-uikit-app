//
//  ViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))

        fetchData()
    }

    private func fetchData() {
        NetworkManager.shared.getRecommendedGenres{ result in 
            switch result {
                case .success(let model):
                    let genres = model.genres
                    var seeds = Set<String>()
                    while seeds.count < 5 {
                        if let random = genres.randomElement() {
                            seeds.insert(random)
                        }
                    }
                    NetworkManager.shared.getRecommendations(genres: seeds) { response in
                        switch response {
                            case .success(let model):
                                print(model.tracks)
                            case .failure(let error):
                                break
                        }
                    }

                case .failure(let failure):
                    break
            }
        }
    }

    @objc func didTapSettings() {
        let settingsViewController = SettingsViewController()
        settingsViewController.title = "Settings"
        settingsViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(settingsViewController, animated: true)
    }


}

#Preview("Home View Controller"){
    HomeViewController()
}

