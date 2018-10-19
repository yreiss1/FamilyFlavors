//
//  Recipe.swift
//  FamilyFlavors
//
//  Created by Yuval Reiss on 10/18/18.
//  Copyright © 2018 reiss.yuval. All rights reserved.
//

import Foundation


class Recipe {
    
    var title: String
    var category: Category
    
    
    init(title:String, category:Category) {
        self.title = title
        self.category = category
    }
    
    
}

enum Category: String {
    case BREAKFAST = "Breakfast"
    case LUNCH = "Lunch"
    case DINNER = "Dinner"
    case DESSERT = "Dessert"
}
