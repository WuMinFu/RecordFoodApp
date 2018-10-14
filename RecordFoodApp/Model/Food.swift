//
//  Food.swift
//  RecordFoodApp
//
//  Created by mac on 2018/8/12.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation

struct Food : Codable{
    var image : Data
    var name : String
    var storeName : String
    var address : String
    var phoneNumber : String
    var opening_hr : String
    var generalHolidays : String
    var recommended : String
    var officialWeb : String
    var theMenu : String
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory,  in: .userDomainMask).first!
    //需要Codable才能轉型
    static func saveFile(food: [Food]){
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(food){
            let url = Food.documentsDirectory.appendingPathComponent("food")
            try? data.write(to: url)
            print(url)
        }
    }
    static func readFromFile() -> [Food]? {
        let  propertyDecoder = PropertyListDecoder()
        let url = Food.documentsDirectory.appendingPathComponent("food")
        print(url)
        if let data = try? Data(contentsOf: url),let lovers = try? propertyDecoder.decode([Food].self, from: data){
            return lovers
        }else{
            return nil
        }
    }
}
