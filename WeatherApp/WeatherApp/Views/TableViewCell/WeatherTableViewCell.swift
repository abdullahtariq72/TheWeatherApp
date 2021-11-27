//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var tempDegreeImg: UIImageView!
    @IBOutlet weak var tempImgView: UIImageView!
    
    //MARK: - NIBs Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /**
         set up  UI Views for cell*/
        parentView.layer.cornerRadius = 10.0
        parentView.layer.shadowRadius = 4
        parentView.layer.shadowOpacity = 0.1
        parentView.layer.shadowColor = Colors.APP_BLUE_COLOR.cgColor
        parentView.layer.shadowOffset = CGSize(width: 2, height: 3)
    }

}
