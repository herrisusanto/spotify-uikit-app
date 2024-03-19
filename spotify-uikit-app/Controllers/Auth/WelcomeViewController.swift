//
//  WelcomeViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "spotify_background")

        return imageView
    }()

    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7

        return view
    }()

    
    private let spotifyButton: SButton = {
        let spotifyButton = SButton(color: .white, title: "Continue with Spotify", image: nil)
        spotifyButton.tintColor = .black


        return spotifyButton
    }()

    
    private let spotifyLogo: UIImageView = {
        let imageLogo = Images.spotifyIconGreen
        imageLogo.contentMode = .scaleAspectFit
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        
        return imageLogo
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.text = "Listen to Millions\nof Songs on\nthe go."
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Spotify"
        view.backgroundColor = .blue
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.addSubview(spotifyLogo)
        view.addSubview(spotifyButton)
        view.addSubview(label)

        spotifyButton.addTarget(self, action: #selector(didTapSpotify), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
        overlayView.frame = view.bounds

        spotifyButton.frame = CGRect(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.width-40, height: 50)

        spotifyLogo.frame = CGRect(x: (view.width-120)/2, y: (view.height-350)/2, width: 120, height: 120)

        label.frame = CGRect(x: 30, y: spotifyLogo.bottom+30, width: view.width-60, height: 150)
    }
    
    @objc func didTapSpotify() {
        let authViewController = AuthViewController()
        authViewController.completionHandler = { [weak self] success in
            self?.handleSignIn(success: success)
        }
        authViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(authViewController, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        // MARK:  Log user in or yell at them for error
        guard success else {
            let alert = UIAlertController(title: "Oopss!", message: "Something when wrong when Sign In!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        let mainAppTabBarViewController = TabBarViewController()
        mainAppTabBarViewController.modalPresentationStyle = .fullScreen
        present(mainAppTabBarViewController, animated: true)
    }
}


#Preview("Welcome View Controller"){
    WelcomeViewController()
}
