//
//  Message+CoreDataProperties.swift
//  FbMessengerProject
//
//  Created by Amar Bhatia on 4/24/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import Foundation
import CoreData


extension Message {

    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var isSender: NSNumber?
    @NSManaged public var friend: Friend?

}
