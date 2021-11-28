//
//  UITextField+Extension.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import Foundation
import UIKit
extension UITextField{
    
    func borderedTextField(){
        layer.borderWidth = 1.0
        layer.borderColor = Colors.APP_BLUE_COLOR.cgColor
        layer.cornerRadius = 8.0
        textColor = .black
        clipsToBounds = true
        layer.masksToBounds = true
        self.paddingLeft(inset: 10)
    }
    
    func paddingLeft(inset: CGFloat){
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.leftViewMode = UITextField.ViewMode.always
    }
}
