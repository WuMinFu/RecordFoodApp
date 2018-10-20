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

    // var food = [Food]()
    
    @IBOutlet weak var foodTableView: UITableView!
    
    
    var food : [Food] = [Food(image: UIImage(named: "Example")!.pngData()!,name: "範例名稱",storeName: "範例店名",address: "", phoneNumber: "", opening_hr: "", generalHolidays: "", recommended: "", officialWeb: "",introduction: "請點選然後新增資訊")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.identifier, for: indexPath) as? FoodTableViewCell else {
            
            return UITableViewCell()
        }
        cell.foodImage.image = UIImage(data : food[indexPath.row].image)
        cell.foodNameLabel.text = food[indexPath.row].name
        cell.introductionLabel.text = "介紹：\n\(food[indexPath.row].introduction)"
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
            
            food.insert(Food(image: addFood.image, name: addFood.name,storeName: "", address: "", phoneNumber: "", opening_hr: "", generalHolidays: "", recommended: "", officialWeb: "", introduction: "請點選然後新增資訊"), at: 0)
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
        if let controller = segue.destination as? FoodInfoViewController, let indexPath = self.foodTableView.indexPathForSelectedRow {
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

