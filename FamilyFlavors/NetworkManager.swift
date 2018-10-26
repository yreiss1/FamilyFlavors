//
//  NetworkManager.swift
//  FamilyFlavors
//
//  Created by Yuval Reiss on 10/25/18.
//  Copyright © 2018 reiss.yuval. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private let headers = ["x-apikey": "f22738e5bf0d2c7269a9fdc3614db45f09e70"]

    
    // Single Instance of Network Manager
    static var sharedInstance: NetworkManager = NetworkManager()
    
    private init() {
        
    }
    
    
    func getRecipes(completionHandler: @escaping (RequestStatus, [Recipe]?) -> ()){
        var recipes: [Recipe] = []
        let url:String = "https://familyflavors-d997.restdb.io/rest/recipe"
        Alamofire.request(url, headers: headers).responseJSON
            { response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSArray
                for item in response { // loop through data items
                    let obj = item as! NSDictionary
                    let string: String = obj["Image"] as! String
                    let decodedData = NSData(base64Encoded: string)
                    let decodedimage = UIImage(data: decodedData! as Data)
                    let recipe = Recipe(title:obj["Title"] as! String, image:decodedimage as! UIImage, category:obj["Category"] as! String)
                    recipes.append(recipe)
                }
                completionHandler(.SUCCESS, recipes)
            case .failure(let error):
                print("Request failed with error: \(error)")
                completionHandler(.FAIL, nil)
                }
        }
        
        
    }
    
    func postRecipes(in recipe:Recipe) {
        
        let imageData = recipe.image.jpegData(compressionQuality: 0.1)!
        let parameters = [
            "Title": recipe.title,
            "Category": recipe.category,
            "Image":imageData.base64EncodedString()
        ]
        
        Alamofire.request("https://familyflavors-d997.restdb.io/rest/recipe", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
    
        
    }
}
enum RequestStatus {
    case SUCCESS
    case FAIL
}
