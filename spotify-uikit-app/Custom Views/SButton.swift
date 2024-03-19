//
//  SButton.swift
//  spotify-uikit-app
//
//  Created by loratech on 28/02/24.
//

import Foundation
import UIKit

class SButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(color: UIColor, title: String, image: UIImage?) {
        self.init(frame: .zero)
        set(color: color, title: title, image: image)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final func set(color: UIColor, title: String, image: UIImage? = nil) {
        configuration?.baseBackgroundColor = color
        configuration?.title = title
        
        if image != nil {
            configuration?.image = image
            configuration?.imagePadding = 5
            configuration?.imagePlacement = .leading
        }
        
         
    }
    
    private func configure() {
        configuration = .bordered()
        configuration?.cornerStyle = .capsule 
        translatesAutoresizingMaskIntoConstraints = false

    }
    
}


#Preview("Spotify Button"){
    let button = SButton()
    button.set(color: .systemGreen, title: "Sign up free")
    button.configuration?.baseForegroundColor = .white
    return button
}
