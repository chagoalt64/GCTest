//
//  UIView+extensions.swift
//  GCTest
//
//  Created by Santiago Borjon on 10/08/21.
//

import UIKit

extension UIView {
    
    func pin(to superview: UIView, top: CGFloat = 0.0, leading: CGFloat = 0.0, trailing: CGFloat = 0.0, bottom: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom).isActive = true
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
