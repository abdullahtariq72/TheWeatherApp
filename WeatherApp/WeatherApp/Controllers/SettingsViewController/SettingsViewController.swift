//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Abdullah Tariq on 11/27/21.
//

import UIKit
import BetterSegmentedControl

class SettingsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var daysTextField: UITextField!
    @IBOutlet weak var switchView: UIView!
    
    
    //MARK: - Variables
    var iconsSegmentedControl: BetterSegmentedControl!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         Initiate Views for Controller*/
        setViews()
    }
    
    //MARK: - Set Up Controller Views
    func setViews(){
        /**
         Seeting logo to NavBar for Controller*/
        addLogoToNavigationBarItem()
        
        /**
         Setting up toggle swich view*/
        setUpSwitchView()
        
        /**
         set delegate and view for textfield
         */
        daysTextField.delegate = self
        daysTextField.borderedTextField()

        
    }
    
    //MARK: - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        iconsSegmentedControl.setIndex(UserDefaultsHandler.sharedInstance.getTempType() == K.CELSIUS ? 0 : 1)
        self.daysTextField.text = UserDefaultsHandler.sharedInstance.getNumOfDays()
    }
    
    //MARK: - Switch Theme Setup
    func setUpSwitchView(){
        iconsSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 0, y: 0, width: switchView.frame.width, height: switchView.frame.height),
            segments: IconSegment.segments(withIcons: [UIImage(named: K.CELSIUS)!, UIImage(named: K.FARENHEIT)!],
                                           iconSize: CGSize(width: 20.0, height: 20.0),
                                           normalIconTintColor: .white,
                                           selectedIconTintColor: Colors.APP_BLUE_COLOR),
            options: [.cornerRadius(15.0),
                      .backgroundColor( Colors.APP_BLUE_COLOR),
                      .indicatorViewBackgroundColor( Colors.WHITE_GRAY_COLOR)])
        iconsSegmentedControl.addTarget(self,
                                        action: #selector(segmentedControlValueChanged(_:)),
                                        for: .valueChanged)
        switchView.addSubview(iconsSegmentedControl)

    }
    
    //MARK: - IBActions for Custom Targets
    @IBAction func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        UserDefaultsHandler.sharedInstance.setTempType(tempType: sender.index == 0 ? K.CELSIUS : K.FARENHEIT)
    }
    
}


//MARK: - UITextField Delegates
extension SettingsViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        return updateText.count < 3
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let days = textField.text{
            UserDefaultsHandler.sharedInstance.setNumOfDays(days: days)
        }
        
    }
}
