//
//  PhilosopherObject.swift
//  Hero
//
//  Created by Byron Mejia on 12/24/22.
//

import CoreData

struct PhilosopherObject: Hashable {
    private var _philosopherNSManagedObject: NSManagedObject!
    
    var philosopherNSManagedObject: NSManagedObject {
        set {
            _philosopherNSManagedObject = newValue
            fillPhilosopherModel(from: newValue)
        }
        get { _philosopherNSManagedObject }
    }
    
    private mutating func fillPhilosopherModel(from nsManagedObj: NSManagedObject){
        if let id = nsManagedObj.value(forKey: "id"),
           let name = nsManagedObj.value(forKey: "name"),
           let period = nsManagedObj.value(forKey: "period"),
           let country = nsManagedObj.value(forKey: "country"),
           let sentence = nsManagedObj.value(forKey: "sentence"),
           let isNew = nsManagedObj.value(forKey: "isNew"),
           let isNew = isNew as? Bool {
            
            let image = nsManagedObj.value(forKey: "image") ?? ""
            let imageDat = nsManagedObj.value(forKey: "imageDat") as? Data ?? nil
            
            philosopher = Philosopher(id: "\(id)", name: "\(name)", period: "\(period)", country: "\(country)", sentence: "\(sentence)", image: "\(image)", imageDat: imageDat, isNew: isNew)
            
        }
    }
    
    var philosopher: Philosopher?
    
    init(nsManagedObject: NSManagedObject) {
        self.philosopherNSManagedObject = nsManagedObject
    }
}
