//
//  FriendControllerHelper.swift
//  FbMessengerProject
//
//  Created by Amar Bhatia on 4/21/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import Foundation
import UIKit
import CoreData


let delegate = UIApplication.shared.delegate as? AppDelegate
let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext


extension FriendController {
    
    func clearData() {
        
        if let context = managedContext {
            
            do {
                
                let entityNames = ["Friend", "Message"]
                
                for entityName in entityNames {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                    
                    for object in objects! {
                        context.delete(object)
                    }
                }
                
                try(context.save())
                
            } catch let err {
                print(err)
            }
            
        }

        
    }
    
    func setupData() {
        
        clearData()
        
        
        if let context = managedContext {
            
            createSteveMessagesWithContext(context: context)
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Trump"
            donald.profileImageName = "donald_trump_profile"
            
            FriendController.createMessageWithText(text: "You're fired", friend: donald, minutesAgo: 5, context: context)
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gandhi.name = "Mahtma Gandhi"
            gandhi.profileImageName = "gandhi"
            
            FriendController.createMessageWithText(text: "Love, Peace, and Joy", friend: gandhi, minutesAgo: 60 * 24, context: context)
            
            let hillary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            hillary.name = "Hillary Clinton"
            hillary.profileImageName = "hillary_profile"
            
            FriendController.createMessageWithText(text: "Please vote for me, you did for Billy!", friend: hillary, minutesAgo: 8 * 60 * 24, context: context)
            
            
            do {
                try(context.save())
            } catch let err {
                print(err)
            }
            

        }
        
//        loadData()
    }
    
    private func createSteveMessagesWithContext(context: NSManagedObjectContext) {
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        FriendController.createMessageWithText(text: "Good morning...", friend: steve, minutesAgo: 3, context: context)
        FriendController.createMessageWithText(text: "Hello, how are you? Hope you are having a good morning!", friend: steve, minutesAgo: 2, context: context)
        FriendController.createMessageWithText(text: "Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs. Please make your purchase with us.", friend: steve, minutesAgo: 1, context: context)
        
        //response message
        FriendController.createMessageWithText(text: "Yes, totally looking to buy an iPhone 8", friend: steve, minutesAgo: 1, context: context, isSender: true)

        FriendController.createMessageWithText(text: "Totally understand that you want the new iPhone 8, but you'll have to wait until Septemeber for the new release. Sorry, that's just how Apple likes to do things", friend: steve, minutesAgo: 1, context: context)
        
        FriendController.createMessageWithText(text: "Fantastic, I'll just use my gigantic iPhone 6 Plus until then you jerk!!!", friend: steve, minutesAgo: 1, context: context, isSender: true)


    }
    
    private func createFriend(name: String, profileImageName: String, context: NSManagedObjectContext) {
        let friend = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        friend.name = name
        friend.profileImageName = profileImageName
    }
    
    static func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext, isSender: Bool = false) -> Message {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * 60) as NSDate?
        message.isSender = NSNumber(value: isSender as Bool)
        
        friend.lastMessage = message
        
        return message
    }
    
//    func loadData() {
//        
//        if let context = managedContext {
//            
//            if let friends = fetchFriends() {
//                
//                messages = [Message]()
//                
//                for friend in friends {
//                    print(friend.name)
//                    let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
//                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
//                    fetchRequest.fetchLimit = 1
//                    
//                    do {
//                        let fetchMessages = try(context.fetch(fetchRequest)) as? [Message]
//                        messages?.append(contentsOf: fetchMessages!)
//                    } catch let err {
//                        print(err)
//                    }
//                }
//                
//                messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
//            }
//        }
//    }
//    
//    private func fetchFriends() -> [Friend]? {
//        
//        if let context = managedContext {
//                let request =  NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
//            
//            do {
//                return try context.fetch(request) as? [Friend]
//            } catch let err {
//                print(err)
//            }
//            
//        }
//        
//        return nil
//
//    }
    
}
