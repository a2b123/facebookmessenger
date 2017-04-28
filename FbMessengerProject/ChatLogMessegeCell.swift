//
//  ChatLogMessengerCell.swift
//  FbMessengerProject
//
//  Created by Amar Bhatia on 4/21/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import Foundation
import UIKit

class ChatLogMessageCell: BaseCell {
    
    let messsageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Sample Message"
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = UIColor.clear
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    
    let textBubbleView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    static let grayBubbleImage = UIImage(named: "bubble_gray")?.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    
    static let blueBubbleImage = UIImage(named: "bubble_blue")?.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)

    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ChatLogMessageCell.grayBubbleImage
        imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        return imageView
    }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(textBubbleView)
        addSubview(messsageTextView)
        textBubbleView.addSubview(bubbleImageView)
        
        addSubview(profileImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(30)]|", views: profileImageView)
        
        textBubbleView.addConstraintsWithFormat(format: "H:|[v0]|", views: bubbleImageView)
        textBubbleView.addConstraintsWithFormat(format: "V:|[v0]|", views: bubbleImageView)
        
    
        
        backgroundColor = .white
        
    }
}
