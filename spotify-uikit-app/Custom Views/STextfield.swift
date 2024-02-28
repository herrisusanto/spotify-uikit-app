//
//  STextfield.swift
//  spotify-uikit-app
//
//  Created by loratech on 28/02/24.
//

import UIKit

class STextfield: UIViewController {
    var label: String = ""
    var placeholder: String = ""
    
    let padding: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a label
        let label = UILabel()
        label.text = self.label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        

        // Create a text field
        let textField = UITextField()
        textField.placeholder = self.placeholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray.withAlphaComponent(0.5)
        textField.translatesAutoresizingMaskIntoConstraints = false

        // Add the label and text field to the view
        view.addSubview(label)
        view.addSubview(textField)

        // Set up constraints
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
}


#Preview("Spotify Textfield"){
    let textfield = STextfield()
    textfield.label = "Username or Email"
    textfield.placeholder = "Enter username or email"
    
    return textfield
}
