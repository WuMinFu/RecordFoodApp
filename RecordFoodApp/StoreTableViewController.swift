//
//  StoreTableViewController.swift
//  RecordFoodApp
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController {
    
    var storeName : String?
    var information : String?
    var theMenu : String?
    var storeMap : String?
    
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var mapImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let storeName = storeName,let information = information,let theMenu = theMenu,let storeMap = storeMap{
            storeImage.image = UIImage(named: storeName)
            informationLabel.text = information
            menuImage.image = UIImage(named: theMenu)
            mapImage.image = UIImage(named: storeMap)
        }
        
    }

    // MARK: - Table view data source

   

}
