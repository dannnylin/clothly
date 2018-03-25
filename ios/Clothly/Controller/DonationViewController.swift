//
//  DonationViewController.swift
//  Clothly
//
//  Created by Danny on 3/24/18.
//  Copyright © 2018 Stanley Zeng. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class DonationViewController: UIViewController {
    
    var organization: Organization! {
        didSet {
            orgLabel.text = organization.name!
        }
    }
    
    let pickerData: [String] = ["Tops", "Bottoms", "Shoes", "Overalls", "Accessories", "Other"]
    var selectedRow: Int = 0
    
    @IBOutlet weak var orgLabel: UILabel!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func create() -> DonationViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "donationViewController") as! DonationViewController
        let _ = controller.view
        return controller
    }
    
    @IBAction func submitPressed(sender: UIButton) {
        let json: [String: Any] = [
            "orgName": organization.name,
            "type": pickerData[selectedRow],
            "gender": "Male",
            "ageGroup": "Youth",
            "instructions": instructionsTextView.text,
            "orgId": organization.id,
            "quantity": 10,
            "pickUpDate": "2018-03-23",
            "donorId": 1
        ]
        DataService.sharedInstance.createDonation(data: json)
    }
}

extension DonationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedRow = component
    }
}
