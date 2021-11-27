//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import Foundation
import UIKit

extension UIView{
    
    
    func setGradientBackground(colorTop: UIColor, colorCenter: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.locations = [0, 0, 1]

        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)

        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)

        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))

        gradientLayer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)

        
        gradientLayer.colors = [colorTop.cgColor,colorCenter.cgColor, colorBottom.cgColor]

        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setGradientBackground(colorTop: UIColor,colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.locations = [0, 1]

        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)

        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)

        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))

        gradientLayer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)

        
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]

        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }

}
