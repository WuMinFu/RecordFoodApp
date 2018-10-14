//
//  ViewController.swift
//  RecordFoodApp
//
//  Created by mac on 2018/8/12.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController ,UITableViewDataSource{
    
    struct CellIdentifier {
        static let identifier = "foodCell"
    }

    var food = [Food]()
    
    @IBOutlet weak var foodTableView: UITableView!
    
    
    //    var food : [Food] = [Food(image: UIImage(named: "咖哩飯")!.pngData()!,name: "阿娟咖哩飯",storeName: "阿娟咖哩飯",address: "台南市中西區保安路36號", phoneNumber: "06-2248134；06-2209246", opening_hr: "11:00–21:00", generalHolidays: "週四", recommended: "咖哩飯、雞肉飯、鴨肉羹", officialWeb: "https://www.facebook.com/pages/阿娟咖哩飯鴨肉羹/329673023713547", theMenu: "阿娟菜單")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.identifier, for: indexPath) as? FoodTableViewCell else {
            return UITableViewCell()
        }
        cell.foodImage.image = UIImage(data : food[indexPath.row].image)
        cell.foodNameLabel.text = food[indexPath.row].name
        cell.openLabel.text = "時間：\n\(food[indexPath.row].opening_hr)"
        cell.addressLabel.text = "地址：\(food[indexPath.row].address)"
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        foodTableView.dataSource = self

        if let food = Food.readFromFile(){
            self.food = food
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //處理新增cell
    @IBAction func addBack(segue: UIStoryboardSegue){
        if let controller = segue.source as? AddFoodViewController, let addFood = controller.addFood{
            
            food.insert(Food(image: addFood.image, name: addFood.name,storeName: "", address: "", phoneNumber: "", opening_hr: "請點選然後新增資訊", generalHolidays: "", recommended: "", officialWeb: "", theMenu: ""), at: 0)
            Food.saveFile(food: food)
            foodTableView.insertRows(at: [IndexPath(row: 0, section: 0)]
                , with: .fade)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let name = food[indexPath.row].name
        
        if editingStyle == .delete {
            food.remove(at: indexPath.row)

            tableView.beginUpdates()
            tableView.deleteRows(
                at: [indexPath], with: .fade)
            tableView.endUpdates()
            print("刪除的是 \(name)")
            Food.saveFile(food: food)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? StoreTableViewController, let indexPath = self.foodTableView.indexPathForSelectedRow {
            controller.food = food[indexPath.row]
            controller.delegate = self
            
        }
    
        
        /*第二種傳值方法
         if let row = tableView.indexPathForSelectedRow?.row{
         controller?.name = season[row]
         }
         */
    }
    
}
extension FoodViewController: EditFoodTableViewControllerDelegate{
    func update(food: Food) {
        if let indexPath = foodTableView.indexPathForSelectedRow {
            self.food[indexPath.row] = food
            Food.saveFile(food: self.food)
            foodTableView.reloadRows(at: [indexPath],with: .automatic)
        }
    }
}

