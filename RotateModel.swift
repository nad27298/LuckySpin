//
//  RotateModel.swift
//  RotationLucky
//
//  Created by Macbook on 2/8/21.
//

import Foundation
import UIKit
import CoreData

class RotateModel {
    
    var id: Int = 0
    var name1: String = ""
    var name2: String = ""
    var name3: String = ""
    var name4: String = ""
    var name5: String = ""
    var name6: String = ""
    var name7: String = ""
    
    init(data: NSManagedObject) {
        self.id = data.value(forKeyPath: "id") as? Int ?? 0
        self.name1 = data.value(forKeyPath: "name1") as? String ?? ""
        self.name2 = data.value(forKeyPath: "name2") as? String ?? ""
        self.name3 = data.value(forKeyPath: "name3") as? String ?? ""
        self.name4 = data.value(forKeyPath: "name4") as? String ?? ""
        self.name5 = data.value(forKeyPath: "name5") as? String ?? ""
        self.name6 = data.value(forKeyPath: "name6") as? String ?? ""
        self.name7 = data.value(forKeyPath: "name7") as? String ?? ""
    }
    
}
