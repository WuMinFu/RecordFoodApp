//
//  AddFoodViewController.swift
//  RecordFoodApp
//
//  Created by mac on 2018/8/18.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    var addFood: Food?
    var foodimage : Data?
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func photoButton(_ sender: Any) {
        let foodActionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        
        let foodAlbumAction = UIAlertAction(title: "從相冊選擇", style: UIAlertAction.Style.default){ (action:UIAlertAction)in
            
            self.initPhotoPicker()
            
        }
        
        let foodPhotoAction = UIAlertAction(title: "拍照", style: UIAlertAction.Style.default){ (action:UIAlertAction)in
            
            
            self.initCameraPicker()
            
        }
        
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel){ (action:UIAlertAction)in
            
            
        }
        
        
        foodActionSheet.addAction(foodAlbumAction)
        foodActionSheet.addAction(foodPhotoAction)
        foodActionSheet.addAction(cancelAction)
        
        foodActionSheet.popoverPresentationController?.sourceView = self.view
        foodActionSheet.popoverPresentationController?.sourceRect = CGRect(x: view.frame.maxX/2, y: view.frame.maxY, width: 1.0, height: 1.0)
        
        self.present(foodActionSheet, animated: true, completion: nil)

    }
    
    //從相冊選擇
    func initPhotoPicker(){
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        //在需要的地方present出来
        self.present(photoPicker, animated: true, completion: nil)
    }
    //拍照
    func initCameraPicker(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            
            print("不支持拍照")
            
        }
        
    }
    
    
    
    //相機
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        
        //將圖片顯示在畫面上
        foodImage.image = image
        self.foodimage = image.pngData()
        
        // 退出相機介面
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        
        if error != nil {
            
            print("保存失败")
            
            
        } else {
            
            print("保存成功")
            
            
        }
    }
    
    
    
    //  完成
    @IBAction func addFoodItemButton(_ sender: Any) {
        
        guard let foodName = foodNameTextField.text, foodName.count > 0 ,let foodimage = foodimage else{
            return
        }
        
        if addFood == nil {
            addFood = Food(image: foodimage, name: foodName,storeName: "", address: "", phoneNumber: "", opening_hr: "", generalHolidays: "", recommended: "", officialWeb: "", theMenu: "")
        }
        performSegue(withIdentifier: "addBack", sender: nil)
        
    }
}
