//
//  WelcomeViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signUpButton: SButton = {
        let signUpButton = SButton(color: Colors.primaryGreen!, title: "Sign up free", image: nil)
        signUpButton.configuration?.baseForegroundColor = Colors.primaryBlack
        
        
        return signUpButton
    }()
    
    @objc func didTapSignUp() {
        let signUpViewController = SignUpViewController()
        signUpViewController.navigationItem.largeTitleDisplayMode = .never 
        navigationController?.pushViewController(signUpViewController, animated: true)
        
    }
    
    
    private let spotifyButton: SButton = {
        let spotifyButton = SButton(color: Colors.primaryGreen!, title: "Continue with Spotify", image: nil)
        spotifyButton.configuration?.baseForegroundColor = Colors.primaryBlack
        
        return spotifyButton
    }()
    
    
    private let googleButton: SButton = {
       let googleButton = SButton()
        googleButton.set(color: Colors.primaryWhite!, title: "Continue with Google", image: Images.googleLogo)
        googleButton.configuration?.baseForegroundColor = Colors.primaryBlack
        
        
        return googleButton
    }()
    
    private let facebookButton: SButton = {
        let facebookButton = SButton(color: Colors.primaryWhite!, title: "Continue with Facebook", image: Images.facebookLogo)
        facebookButton.configuration?.baseForegroundColor = Colors.primaryBlack
        return facebookButton
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(configuration: UIButton.Configuration.plain())
        button.setTitle("Log in", for: .normal)
        button.tintColor = .white
        button.isHighlighted = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func didTapSignIn() {
        let signInViewController = SignInViewController()
        signInViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(signInViewController, animated: true)
    }
     
    
    private let spotifyLogo: UIImageView = {
        let imageLogo = Images.spotifyIconWhite
        imageLogo.contentMode = .scaleAspectFit
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        
        return imageLogo
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.gray.cgColor,
            Colors.primaryBlack?.cgColor as Any,
            Colors.primaryBlack?.cgColor as Any,
            Colors.primaryBlack?.cgColor as Any,
            Colors.primaryBlack?.cgColor as Any
        ]
    
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(spotifyLogo)
        view.addSubview(signUpButton)
        view.addSubview(facebookButton)
        view.addSubview(googleButton)
        view.addSubview(spotifyButton)
        view.addSubview(signInButton)
        
        spotifyButton.addTarget(self, action: #selector(didTapSpotify), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            spotifyLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            spotifyLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spotifyLogo.heightAnchor.constraint(equalToConstant: 100),
            spotifyLogo.widthAnchor.constraint(equalToConstant: 100),
            
            signUpButton.bottomAnchor.constraint(equalTo: facebookButton.topAnchor, constant: -20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            
            facebookButton.bottomAnchor.constraint(equalTo: googleButton.topAnchor, constant: -20),
            facebookButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            facebookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            facebookButton.heightAnchor.constraint(equalToConstant: 60),
            
            googleButton.bottomAnchor.constraint(equalTo: spotifyButton.topAnchor, constant: -20),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            googleButton.heightAnchor.constraint(equalToConstant: 60),
            
            spotifyButton.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -5),
            spotifyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            spotifyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            spotifyButton.heightAnchor.constraint(equalToConstant: 60),
            
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 60),
            
            
            
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
