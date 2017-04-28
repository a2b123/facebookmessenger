//
//  CustomTabBarController.swift
//  FbMessengerProject
//
//  Created by Amar Bhatia on 4/24/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        
        let friendsController = FriendController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "recent")


        

        viewControllers = [recentMessagesNavController,         createNavControllerWithTitle(title: "Recent", imageName: "recent"),         createNavControllerWithTitle(title: "Groups", imageName: "groups"),        createNavControllerWithTitle(title: "People", imageName: "people"),
            createNavControllerWithTitle(title: "Settings", imageName: "settings")]

        
    }
    
    
    private func createNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        
        let viewController = UIViewController()
        
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
        
    }
}
