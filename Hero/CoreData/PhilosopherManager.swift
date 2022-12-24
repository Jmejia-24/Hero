//
//  PhilosopherManager.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import CoreData

protocol Storage {
    func create<T>(object: T, completion: @escaping (Result<Bool, Failure>) -> ())
    func fetch<T: NSManagedObject>(completion: @escaping (Result<[T]?, Failure>) -> ())
    func saveDataOf(philosophers: [Philosopher])
}

struct PhilosopherManager {
    
    let mainContext: NSManagedObjectContext
    private let fetchRequest = NSFetchRequest<PhilosopherEntity>(entityName: "PhilosopherEntity")
    
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.mainContext = mainContext
    }
    
    private func deleteObjectsfromCoreData() {
        do {
            var objects = try mainContext.fetch(fetchRequest)
            objects = objects.filter { !$0.isNew }
            _ = objects.map({mainContext.delete($0)})
            
            try mainContext.save()
        } catch {
            print("Deleting Error: \(error)")
        }
    }
    
    private func saveDataToCoreData(philosophers: [Philosopher]) {
        mainContext.perform {
            for philosopher in philosophers {
                let philosopherEntity = PhilosopherEntity(context: mainContext)
                philosopherEntity.id = philosopher.id
                philosopherEntity.name = philosopher.name
                philosopherEntity.period = philosopher.period
                philosopherEntity.country = philosopher.country
                philosopherEntity.sentence = philosopher.sentence
                philosopherEntity.image = philosopher.image
                philosopherEntity.imageDat = philosopher.imageDat
                philosopherEntity.isNew = philosopher.isNew
            }
            
            do {
                try mainContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}

extension PhilosopherManager: Storage {
    
    func saveDataOf(philosophers: [Philosopher]) {
        deleteObjectsfromCoreData()
        saveDataToCoreData(philosophers: philosophers)
    }
    
    func create<T>(object: T, completion: @escaping (Result<Bool, Failure>) -> ()) {
        guard let philosopher = object as Any as? Philosopher else {
            completion(.failure(.statusCode))
            return
        }
        
        let philosopherEntity = PhilosopherEntity(context: mainContext)
        
        philosopherEntity.name = philosopher.name
        philosopherEntity.period = philosopher.period
        philosopherEntity.country = philosopher.country
        philosopherEntity.sentence = philosopher.sentence
        philosopherEntity.image = philosopher.image
        philosopherEntity.imageDat = philosopher.imageDat
        philosopherEntity.isNew = philosopher.isNew
        
        do {
            try mainContext.save()
            completion(.success(true))
        } catch {
            completion(.failure(.statusCode))
        }
    }
    
    func fetch<T>(completion: @escaping (Result<[T]?, Failure>) -> ()) where T : NSManagedObject {
        let fetchRequest = NSFetchRequest<T>(entityName: "PhilosopherEntity")
        
        do {
            let philosophers = try mainContext.fetch(fetchRequest)
            completion(.success(philosophers))
        } catch {
            completion(.failure(.statusCode))
        }
    }
}
