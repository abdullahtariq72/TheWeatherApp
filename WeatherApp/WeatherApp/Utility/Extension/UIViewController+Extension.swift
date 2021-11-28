//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import Foundation
import UIKit

extension UIViewController{
    
    func addLogoToNavigationBarItem() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "app_logo")
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        self.navigationController?.navigationBar.barTintColor = Colors.LIGHTGRAY_COLOR
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func addNavBarButton(image: UIImage, direction: String, buttonAction: Selector) {
        let btn : UIButton = UIButton(frame: CGRect(x:0, y:0, width:40, height:40))
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.contentMode = .left
        let customImage = image.withRenderingMode(.alwaysTemplate)
        btn.setImage(customImage, for: .normal)
        btn.imageView!.tintColor = Colors.APP_BLUE_COLOR
        btn.addTarget(self, action: buttonAction, for: .touchDown)
        let barButton: UIBarButtonItem = UIBarButtonItem(customView: btn)
        direction == "left" ? self.navigationItem.setLeftBarButtonItems([barButton], animated: false) : self.navigationItem.setRightBarButtonItems([barButton], animated: false)
        
    }
    
    func showLoader() {
        self.view.isUserInteractionEnabled = false
        ARSLineProgressConfiguration.backgroundViewStyle = .full
        ARSLineProgressConfiguration.blurStyle = .extraLight
        ARSLineProgressConfiguration.circleColorOuter = Colors.APP_BLUE_COLOR.cgColor
        ARSLineProgressConfiguration.circleColorMiddle = Colors.GRAY_COLOR.cgColor
        ARSLineProgress.show()
    }

    func hideLoader(){
        self.view.isUserInteractionEnabled = true
        ARSLineProgress.hide()
    }
    
}
