//
//  RotateEntity.swift
//  RotationLucky
//
//  Created by Macbook on 2/8/21.
//

import Foundation
import UIKit
import CoreData

class RotateEntity {
    
    static let shared = RotateEntity()
    
    func insertData(_ name1: String,_ name2: String,_ name3: String,_ name4: String,_ name5: String,_ name6: String,_ name7: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
       
        let entity = NSEntityDescription.entity(forEntityName: "Rotate", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue(self.nextAvailble("id", forEntityName: "Rotate", in: managedContext), forKeyPath: "id")
        person.setValue(name1, forKeyPath: "name1")
        person.setValue(name2, forKeyPath: "name2")
        person.setValue(name3, forKeyPath: "name3")
        person.setValue(name4, forKeyPath: "name4")
        person.setValue(name5, forKeyPath: "name5")
        person.setValue(name6, forKeyPath: "name6")
        person.setValue(name7, forKeyPath: "name7")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not insert. \(error), \(error.userInfo)")
        }
    }
    
    func nextAvailble(_ idKey: String, forEntityName entityName: String, in context: NSManagedObjectContext) -> NSNumber? {
        let req = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName)
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        req.entity = entity
        req.fetchLimit = 1
        req.propertiesToFetch = [idKey]
        
        let indexSort = NSSortDescriptor.init(key: idKey, ascending: false)
        req.sortDescriptors = [indexSort]
        
        do {
            let fetchedData = try context.fetch(req)
            let firstObject = fetchedData.first as! NSManagedObject
            if let foundValue = firstObject.value(forKey: idKey) as? NSNumber {
                return NSNumber.init(value: foundValue.intValue + 1)
            }
        } catch let error as NSError {
            print("Could not get id primary key. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func getNSMO() -> [NSManagedObject] {
        var listData = [NSManagedObject]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Rotate")
        
        do {
            try listData = managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return listData
    }
    
    func getData() -> [RotateModel] {
        var listData = [RotateModel]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Rotate")
       
        do {
            let listCata = try managedContext.fetch(fetchRequest)
            for item in listCata {
                listData.append(RotateModel(data: item))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return listData
    }
    
    func getDataId(_ id: Int) -> [RotateModel] {
        var listData = [RotateModel]()
        for item in self.getData() {
            if item.id == id {
                listData.append(item)
            }
        }
        return listData
    }
    
    func deleteId(_ id: Int) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        for item in self.getNSMO() {
            if item.value(forKeyPath: "id") as? Int == id {
                managedContext.delete(item)
            }
        }
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func deleteAll() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        for item in self.getNSMO() {
            managedContext.delete(item)
        }
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func updateData(_ newname1: String,_ newname2: String,_ newname3: String,_ newname4: String,_ newname5: String,_ newname6: String,_ newname7: String, _ id: Int) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rotate")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                if newname1 != "" {
                    results?[0].setValue(newname1, forKeyPath: "name1")
                }
                if newname2 != "" {
                    results?[0].setValue(newname2, forKeyPath: "name2")
                }
                if newname3 != "" {
                    results?[0].setValue(newname3, forKeyPath: "name3")
                }
                if newname4 != "" {
                    results?[0].setValue(newname4, forKeyPath: "name4")
                }
                if newname5 != "" {
                    results?[0].setValue(newname5, forKeyPath: "name5")
                }
                if newname6 != "" {
                    results?[0].setValue(newname6, forKeyPath: "name6")
                }
                if newname7 != "" {
                    results?[0].setValue(newname7, forKeyPath: "name7")
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
            return false
        }
    }
    
}
