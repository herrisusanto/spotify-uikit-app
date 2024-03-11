//
//  SignInViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 28/02/24.
//

import UIKit

class SignInViewController: UIViewController {
    
    private let emailOrUsernameLabel: UILabel = {
       let label = UILabel()
        label.text = "Email or username"
        label.textColor = Colors.primaryWhite
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let emailOrUsername: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter email or username."
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.systemGray4.cgColor
        
        textfield.backgroundColor = .tertiarySystemBackground
        textfield.textColor = .black
        return textfield
    }()
    
    private let passwordLabel: UILabel = {
       let label = UILabel()
        label.text = "Password"
        label.textColor = Colors.primaryWhite
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let password: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter password"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.cornerRadius = 10
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.systemGray4.cgColor
        textfield.backgroundColor = .tertiarySystemBackground
        textfield.textColor = .black
        
        
        return textfield
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray.withAlphaComponent(0.8)
        button.setTitle("Log In", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    private let logInWithoutPassword: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.primaryBlack
        button.tintColor = Colors.primaryWhite
        button.setTitle("Log in without password", for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        title = nil
        view.backgroundColor = Colors.primaryBlack
        view.addSubview(emailOrUsernameLabel)
        view.addSubview(emailOrUsername)
        view.addSubview(passwordLabel)
        view.addSubview(password)
        view.addSubview(signInButton)
        view.addSubview(logInWithoutPassword)
        
        NSLayoutConstraint.activate([
            emailOrUsernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailOrUsernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailOrUsernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailOrUsername.topAnchor.constraint(equalTo: emailOrUsernameLabel.bottomAnchor, constant: 20),
            emailOrUsername.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailOrUsername.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailOrUsername.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailOrUsername.heightAnchor.constraint(equalToConstant: 50),
            
            passwordLabel.topAnchor.constraint(equalTo: emailOrUsername.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            password.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            password.heightAnchor.constraint(equalToConstant: 50),
            
            signInButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 50),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            logInWithoutPassword.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 50),
            logInWithoutPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            logInWithoutPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            logInWithoutPassword.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}


#Preview("Sign In VC"){
    SignInViewController()
}
