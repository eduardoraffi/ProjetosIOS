//
//  Favorites+CoreDataProperties.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 22/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdrop_path: String?
    @NSManaged public var genre_ids: Data?
    @NSManaged public var id: Int16
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    @NSManaged public var vote_average: Double
    @NSManaged public var vote_count: Int16
    @NSManaged public var genreToString: String

}
