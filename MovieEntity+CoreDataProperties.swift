//
//  MovieEntity+CoreDataProperties.swift
//  TheMovieDB
//
//  Created by Alejandro on 11/08/22.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var release_date: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var rating: String?

}

extension MovieEntity : Identifiable {

}
