//
//  Recipe.swift
//  FamilyFlavors
//
//  Created by Yuval Reiss on 10/18/18.
//  Copyright © 2018 reiss.yuval. All rights reserved.
//

import Foundation
import UIKit


class Recipe {
    
    var title: String
    var category: String
    var image: UIImage
    
    
    init(title:String, image: UIImage, category: String) {
        self.title = title
        self.category = category
        self.image = image
    }
    
    
}

