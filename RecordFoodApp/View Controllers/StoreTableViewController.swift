//
//  StoreTableViewController.swift
//  RecordFoodApp
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

protocol  EditFoodTableViewControllerDelegate  {
    func  update(food:  Food)
}

class StoreTableViewController: UITableViewController {
    
    var  food:  Food?
    var  delegate: EditFoodTableViewControllerDelegate?
    
    
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var storeNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var openTimeTextField: UITextField!
    @IBOutlet weak var restTextField: UITextField!
    @IBOutlet weak var recommendedTextField: UITextField!
    @IBOutlet weak var officialWebTextField: UITextField!

 
    override func viewDidLoad() {
        super.viewDidLoad()
        if let food = food {
            foodImageView.image = UIImage(data: food.image)
            foodNameTextField.text = food.name
            storeNameTextField.text = food.storeName
            addressTextField.text = food.address
            phoneNumberTextField.text = food.phoneNumber
            openTimeTextField.text = food.opening_hr
            restTextField.text = food.generalHolidays
            recommendedTextField.text = food.recommended
            officialWebTextField.text = food.officialWeb
        }
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let image = foodImageView.image?.pngData(),let name = foodNameTextField.text,let storeName = storeNameTextField.text,let address = addressTextField.text,let phoneNumber = phoneNumberTextField.text,let opening_hr = openTimeTextField.text,let generalHolidays = restTextField.text,let recommended = recommendedTextField.text,let officialWeb = officialWebTextField.text,let theMenu = food?.theMenu else {
            return
        }
        food = Food(image: image, name: name,storeName: storeName, address: address, phoneNumber: phoneNumber, opening_hr: opening_hr, generalHolidays: generalHolidays, recommended: recommended, officialWeb: officialWeb, theMenu: theMenu )
        delegate?.update(food:  food!)
        navigationController?.popViewController(animated:  true)
    }
    @IBAction func keyEnd(_ sender: Any) {
        view.endEditing(true)
    }
    // MARK: - Table view data source

   

}
