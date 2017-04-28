//
//  MessageCell.swift
//  FbMessengerProject
//
//  Created by Amar Bhatia on 4/21/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import Foundation
import UIKit

class MessageCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(red: 0, green: 134/255, blue: 249/255, alpha: 1) : UIColor.white
            nameLabel.textColor = isHighlighted ? .white : .black
            timeLabel.textColor = isHighlighted ? .white : .black
            messageLabel.textColor = isHighlighted ? .white : .black
            
//            print(isHighlighted)
        }
    }
    
    var message: Message? {
        didSet {
            
            if let profileImageName = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
                hasReadImageView.image = UIImage(named: profileImageName)
            }
            
            nameLabel.text = message?.friend?.name
            messageLabel.text = message?.text
            
            if let date = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                let elaspsedTimeInSeconds = Date().timeIntervalSince(date as Date)
                let secondInDays: TimeInterval = 60 * 60 * 24
                
                if elaspsedTimeInSeconds > 7 * secondInDays {
                    dateFormatter.dateFormat = "MM/dd/yy"
                } else if elaspsedTimeInSeconds > 7 * secondInDays {
                    dateFormatter.dateFormat = "EEE"
                }
                
                timeLabel.text = dateFormatter.string(from: date as Date)
                
            }
            
        }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 32
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "zuckprofile")
        return imageView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Friend's Name"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "My friends said blah blah blah blah blah blahblah blah blahblah blah blahblah blah blahblah blah blahblah blah blahblah blah blahblah blah blah"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "5:05 PM"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .right
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "zuckprofile")
        return imageView
        
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    
    override func setupView() {
        
        addSubview(profileImageView)
        addSubview(dividerLine)
        
        setupContainerView()
        
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(68)]", views: profileImageView)
        
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLine)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLine)
        
    }
    
    private func setupContainerView () {
        
        addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
        
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]-10-|", views: nameLabel, timeLabel)
        containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        containerView.addConstraintsWithFormat(format: "H:|[v0]-8-[v1(20)]-10-|", views: messageLabel, hasReadImageView)
        containerView.addConstraintsWithFormat(format: "V:|[v0(24)]", views: timeLabel)
        containerView.addConstraintsWithFormat(format: "V:[v0(20)]|", views: hasReadImageView)
        
        
        
        
    }
    
}



