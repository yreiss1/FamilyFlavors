//
//  ViewController.swift
//  FamilyFlavors
//
//  Created by Yuval Reiss on 10/18/18.
//  Copyright © 2018 reiss.yuval. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, NSURLConnectionDelegate, UITableViewDelegate, UITableViewDataSource {
    var recipes = [Recipe]()

    @IBOutlet weak var tblJSON: UITableView!
    

    let headers = [
        
        "x-apikey": "f22738e5bf0d2c7269a9fdc3614db45f09e70",
        
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url:String = "https://familyflavors-d997.restdb.io/rest/recipe"
        Alamofire.request(url, headers: headers).responseJSON
            { response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSArray
                for item in response { // loop through data items
                    let obj = item as! NSDictionary
                    let recipe = Recipe(title:obj["Title"] as! String, image:obj["Image"] as! String)
                    self.recipes.append(recipe)
                }
                self.tblJSON.reloadData()
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
        }
       
        tblJSON.delegate = self
        tblJSON.dataSource = self
    }
    
    //Displays the cells in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RecipeTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! RecipeTableViewCell
        
        let recipe = recipes[indexPath.row]
        cell.nameLabel.text = recipe.title as String
        cell.photoImageView.image = UIImage(data: (NSData(base64Encoded: recipe.image)! as Data))
    
        
        
        // Configure the cell...
        return cell
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "viewRecipe", sender: indexPath)
        //tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

