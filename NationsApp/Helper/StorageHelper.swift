//
//  StorageHelper.swift
//  NationsApp
//
//  Created by Nizar Elhraiech on 2019-01-25.
//  Copyright © 2019 Nizar. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StorageHelper {
    static func save(country : Country) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CountryC", in: managedContext!)!
        let newCountry = NSManagedObject(entity: entity, insertInto: managedContext)
        newCountry.setValue(Int(country.id!), forKeyPath: "id")
        newCountry.setValue(country.name, forKeyPath: "name")
        newCountry.setValue(country.latitude, forKeyPath: "latitude")
        newCountry.setValue(country.longitude, forKeyPath: "longitude")
        newCountry.setValue(country.distance, forKeyPath: "distance")
        newCountry.setValue(country.flag, forKeyPath: "flag")
        
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func insertAndUpdateNote(id : Int , note : String){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName : "CountryC")
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        do{
            let test = try managedContext?.fetch(fetchRequest)
            let objectUpdate = test![0] as! NSManagedObject
             objectUpdate.setValue(note, forKey: "note")
            do {
                try managedContext?.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        
    }
    static func getAllCountrys() -> [Country] {
        var countries = [Country]()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CountryC")
        do {
            let result = try managedContext?.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let name = data.value(forKey: "name") as! String
                let id = String(data.value(forKey: "id") as! Int)
                let flag = data.value(forKey: "flag") as! String
                let latitude = data.value(forKey: "latitude") as! String
                let longitude = data.value(forKey: "longitude") as! String
                let distance = data.value(forKey: "distance") as! Double
                let country = Country(id: id, enabled: "", code3l: "", code2l: "", name: name, officialName: "", flag: flag, latitude: latitude, longitude: longitude, zoom: "", distance: distance)

                countries.append(country)
            }

            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return countries
        
    }
    static func getCountry(id : Int) -> String {
        var note : String?
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName : "CountryC")
        print("id :  \(id)")
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        do {
            
            let test = try managedContext?.fetch(fetchRequest)
            let getObject = test![0] as! NSManagedObject
            note = getObject.value(forKey: "note") as? String
            if note == nil {
                note = ""
            }
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return note!
        
    }
}
