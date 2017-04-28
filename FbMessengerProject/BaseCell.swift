//
//  BaseCell.swift
//  FbMessengerProject
//
//  Created by Amar Bhatia on 4/21/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .cyan
        
    }
    
    
}
