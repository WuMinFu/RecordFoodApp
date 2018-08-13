//
//  ViewController.swift
//  RecordFoodApp
//
//  Created by mac on 2018/8/12.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource{
    
    struct CellIdentifier {
        static let identifier = "foodCell"
    }
    
    @IBOutlet weak var foodTableView: UITableView!
    
    var food : [Food] = [Food(image: "咖哩飯",name: "阿娟咖哩飯",opening_hr: "時間：\n11:00–21:00", address: "地址：台南市中西區保安路36號", information: "地址：台南市中西區保安路36號\n\n電話：06-2248134；06-2209246\n\n營業時間：11:00 - 21:00\n\n公休：週四\n\n推薦菜色：咖哩飯、雞肉飯、鴨肉羹\n\nFB：https://www.facebook.com/pages/阿娟咖哩飯鴨肉羹/329673023713547", theMenu: "阿娟菜單",storeMap: "阿娟地圖")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.identifier, for: indexPath) as? FoodTableViewCell else {
            return UITableViewCell()
        }
        cell.foodImage.image = UIImage(named: food[indexPath.row].image)
        cell.foodNameLabel.text = food[indexPath.row].name
        cell.addressLabel.text = food[indexPath.row].address
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        foodTableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? StoreTableViewController
        
        let indexPath = self.foodTableView.indexPathForSelectedRow
        
        controller?.storeName = food[indexPath!.row].name
        controller?.information  = food[indexPath!.row].information
        controller?.theMenu = food[indexPath!.row].theMenu
        controller?.storeMap = food[indexPath!.row].storeMap
        
        /*第二種傳值方法
         if let row = tableView.indexPathForSelectedRow?.row{
         controller?.name = season[row]
         }
         */
    }
}

