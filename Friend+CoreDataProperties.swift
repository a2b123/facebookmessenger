//
//  Friend+CoreDataProperties.swift
//  FbMessengerProject
//
//  Created by Amar Bhatia on 4/27/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import Foundation
import CoreData


extension Friend {

    @NSManaged public var name: String?
    @NSManaged public var profileImageName: String?
    @NSManaged public var messages: NSSet?
    @NSManaged public var lastMessage: Message?

}

// MARK: Generated accessors for messages
//extension Friend {
//
//    @objc(addMessagesObject:)
//    @NSManaged public func addToMessages(_ value: Message)
//
//    @objc(removeMessagesObject:)
//    @NSManaged public func removeFromMessages(_ value: Message)
//
//    @objc(addMessages:)
//    @NSManaged public func addToMessages(_ values: NSSet)
//
//    @objc(removeMessages:)
//    @NSManaged public func removeFromMessages(_ values: NSSet)
//
//}
