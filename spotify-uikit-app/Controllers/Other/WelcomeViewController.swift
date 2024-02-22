//
//  WelcomeViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal) 
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        title = "Spotify"
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.width-40, height: 50)
    }
    
    @objc func didTapSignIn() {
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
