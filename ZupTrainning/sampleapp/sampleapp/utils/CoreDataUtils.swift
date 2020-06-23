//
//  CoreDataUtils.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 22/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataUtils {
    
    static var favoritesData: [NSManagedObject] = []
    
    static func save(movie: MoviesResponse.Movie) {
        if !checkFavorited(movieTitle: movie.title!) {
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            let managedContext =
                appDelegate.persistentContainer.viewContext
            let entity =
                NSEntityDescription.entity(forEntityName: "Favorites",
                                           in: managedContext)!
            let favorites = NSManagedObject(entity: entity,
                                            insertInto: managedContext)
            favorites.setValue(movie.adult, forKey: "adult")
            favorites.setValue(movie.backdrop_path, forKey: "backdrop_path")
            favorites.setValue(NSKeyedArchiver.archivedData(withRootObject: movie.genre_ids ?? []), forKey: "genre_ids")
            favorites.setValue(movie.id, forKey: "id")
            favorites.setValue(movie.original_language, forKey: "original_language")
            favorites.setValue(movie.original_title, forKey: "original_title")
            favorites.setValue(movie.popularity, forKey: "popularity")
            favorites.setValue(movie.overview, forKey: "overview")
            favorites.setValue(movie.poster_path, forKey: "poster_path")
            favorites.setValue(movie.release_date, forKey: "release_date")
            favorites.setValue(movie.title, forKey: "title")
            favorites.setValue(movie.vote_count, forKey: "vote_count")
            favorites.setValue(movie.vote_average, forKey: "vote_average")
            
            do {
                favoritesData.append(favorites)
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } else {
            deleteData(movie.title!)
        }
    }
    
    static func deleteData(_ movieTitle: String){
        do{
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            let managedContext =
                appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
            let favorites = try managedContext.fetch(fetchRequest)
            for object in favorites {
                if let managedObjectData: NSManagedObject = object as? NSManagedObject {
                    let teste = object as! Favorites
                    if(teste.title == movieTitle || teste.title == nil){
                        managedContext.delete(managedObjectData)
                    }
                }
            }
            try managedContext.save()

        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func checkFavorited(movieTitle: String) -> Bool{
        let filtered = recoverData().filter({($0.title?.contains(movieTitle) ?? false)})
        return filtered.count > 0 ? true : false
    }
    
    static func recoverData() -> [Favorites] {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return []
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        let managedContext =
            appDelegate.persistentContainer.viewContext
        do{
            return try managedContext.fetch(fetchRequest) as! [Favorites]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    static func clearDC(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Favorites")
        do {
            let objectList = try managedContext.fetch(fetchRequest)

            for managedObject in objectList {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    managedContext.delete(managedObjectData)
                }
            }
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
}
