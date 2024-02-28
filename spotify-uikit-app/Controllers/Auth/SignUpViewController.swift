//
//  SignUpViewController.swift
//  spotify-uikit-app
//
//  Created by loratech on 28/02/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let label: UILabel = {
       let label = UILabel()
        label.text = "What's you email?"
        label.textColor = Colors.primaryWhite
        label.font = UIFont.boldSystemFont(ofSize: 36)
        
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let email: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .systemGray.withAlphaComponent(0.8)
        textfield.placeholder = "Enter your email."
        textfield.tintColor = .white
        textfield.layer.cornerRadius = 10
        return textfield
    }()
    
    private let confirmLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You'll need to confirm this email later."
        label.textColor = .white
        
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray.withAlphaComponent(0.8)
        button.setTitle("Next", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 25
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.primaryBlack
        title = "Create account"
        
        view.addSubview(label)
        view.addSubview(email)
        view.addSubview(confirmLabel)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            email.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            email.heightAnchor.constraint(equalToConstant: 50),
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
            confirmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.topAnchor.constraint(equalTo: confirmLabel.bottomAnchor, constant: 50),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

#Preview("Sign Up VC"){
    SignUpViewController()
}
