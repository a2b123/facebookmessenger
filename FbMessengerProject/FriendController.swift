//
//  ViewController.swift
//  FbMessengerProject
//
//  Created by Amar Bhatia on 4/20/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import UIKit
import CoreData


class FriendController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    let cellId = "cellId"
    
//    var messages: [Message]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        do {
            try fetchResultsController.performFetch()
        } catch let err {
            print(err)
        }
        
        navigationItem.title = "Recent"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Messages", style: .plain, target: self, action: #selector(addMessages))
        collectionView?.backgroundColor = .white
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        
    }

    func addMessages() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        mark.name = "Mark Zuckerburg"
        mark.profileImageName = "zuckprofile"
        
        
        FriendController.createMessageWithText(text: "Hello, my name is Mark. Nice to meet you..", friend: mark, minutesAgo: 0, context: context)

        let bill = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        bill.name = "Bill Gates"
        bill.profileImageName = "bill_gates_profile"
        
        
        FriendController.createMessageWithText(text: "Hello, I'm Bill Gates..", friend: bill, minutesAgo: 0, context: context)

    }
    
    lazy var fetchResultsController: NSFetchedResultsController<Friend> = {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastMessage.date", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "lastMessage != nil")
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc as! NSFetchedResultsController<Friend>
    }()
    
    var blockOperations = [BlockOperation]()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == . insert {
            blockOperations.append(BlockOperation(block: { 
                self.collectionView?.insertItems(at: [newIndexPath!])
            }))
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({
            
            for operation in self.blockOperations {
                operation.start()
            }
        }, completion: { (completed) in
            let lastItem = self.fetchResultsController.sections![0].numberOfObjects - 1
            let indexPath = IndexPath(item: lastItem, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        
        })
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = fetchResultsController.sections?[section].numberOfObjects {
            return count
        }
        
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        
        let friend = fetchResultsController.object(at: indexPath) as! Friend
        
        cell.message = friend.lastMessage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = ChatLogController(collectionViewLayout: layout)

        let friend = fetchResultsController.object(at: indexPath) as! Friend

        controller.friend = friend
        
        controller.friend = friend
        navigationController?.pushViewController(controller, animated: true)
    }
    

}

