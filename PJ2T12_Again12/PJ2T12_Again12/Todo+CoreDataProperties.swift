//
//  Todo+CoreDataProperties.swift
//  PJ2T12_Again12
//
//  Created by KHJ on 2023/12/11.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var date: Date?
    @NSManaged public var image: String?
    @NSManaged public var review: String?
    @NSManaged public var status: Bool
    @NSManaged public var title: String?
    @NSManaged public var isTodo: Bool
    @NSManaged public var isSaved: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var reviewImage: Data?
    
    var wrappedDate: Date {
        date ?? Date()
    }
    
    var wrappedImage: String {
        return image ?? "paperplane"
    }

    var wrappedReview: String {
        return review ?? "No review"
    }

    var wrappedTitle: String {
        return title ?? "Todo"
    }
    
    var wrappedId: UUID {
        return id ?? UUID() 
    }

}

extension Todo : Identifiable {

}
