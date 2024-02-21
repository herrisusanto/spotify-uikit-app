//
//  UIView+Ext.swift
//  spotify-uikit-app
//
//  Created by loratech on 21/02/24.
//

import Foundation
import SwiftUI

extension UIView {
    
    @available(iOS 13, *)
    private struct Preview: UIViewRepresentable {
        typealias UIViewType = UIView
        let view: UIView
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            
        }
    }
    
    @available(iOS 13, *)
    func showPreview() -> some View {
        Preview(view: self)
    }
    
}
