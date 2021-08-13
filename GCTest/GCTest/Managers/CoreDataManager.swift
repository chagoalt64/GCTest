//
//  CoreDataManager.swift
//  GCTest
//
//  Created by Santiago Borjon on 12/08/21.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    //MARK: - Singleton var
    static let shared = CoreDataManager()
    
    //MARK: - Private Vars
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Private Methods
    private func save () -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                return false
            }
        }
        return true
    }
    
    //MARK: - Public Methods
    func saveRoute(_ route: Route) -> Bool {
        //Create new route
        let newRoute = RouteDAO(context: persistentContainer.viewContext)
        newRoute.name = route.name
        newRoute.iniLat = route.iniLat
        newRoute.iniLon = route.iniLon
        newRoute.endLat = route.endLat
        newRoute.endLon = route.endLon
        newRoute.path = route.path
        newRoute.startDate = route.startDate
        newRoute.endDate = route.endDate
        newRoute.distance = route.distance
        //Save new route
        return save()
    }
    
    func getRoutes() -> [Route] {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        //Request routes on DESC order based on endTime
        let request: NSFetchRequest<RouteDAO> = RouteDAO.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "endDate", ascending: false)]

        //Fetch the data
        var result = [RouteDAO]()
        do {
            result = try context.fetch(request)
        } catch {
            print("Error getting routes: \(error)")
        }
        
        //Transform the result to an array of Route objects
        return Route.routesFromDAO(result)
    }
    
    func deleteRoute(_ route:Route) -> Bool {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        //Search for the route stored and delete it
        let request: NSFetchRequest<RouteDAO> = RouteDAO.fetchRequest()
        request.predicate = NSPredicate(format: "(startDate = %@) AND (name = %@)", route.startDate as NSDate, route.name as NSString)
        
        //Fetch the data
        var result = [RouteDAO]()
        do {
            result = try context.fetch(request)
        } catch {
            print("Error getting routes: \(error)")
            return false
        }
        
        //Delete the results
        result.forEach { item in
            context.delete(item)
        }

        //Save the changes
        return save()
    }
}

extension CoreDataManager {
    enum Entity: String {
        case route = "RouteDAO"
    }
}
