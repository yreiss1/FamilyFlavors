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

class ViewController: UIViewController, NSURLConnectionDelegate, UITableViewDelegate, UITableViewDataSource{
    var recipes: [Recipe] = []

    @IBOutlet weak var numRecipeLabel: UILabel!
    @IBOutlet weak var tblJSON: UITableView!
    weak var activityIndicatorView: UIActivityIndicatorView!
    var oldRecipeCount:Int = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        oldRecipeCount = 0
        
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        tblJSON.backgroundView = activityIndicatorView
        tblJSON.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.activityIndicatorView = activityIndicatorView
        
        tblJSON.delegate = self
        tblJSON.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(oldRecipeCount == 0) {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
            self.tblJSON.addSubview(activityIndicatorView)
            self.tblJSON.bringSubviewToFront(activityIndicatorView)

            self.tblJSON.tableFooterView = activityIndicatorView
            self.tblJSON.tableFooterView?.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                //MARK: Loading more data
                NetworkManager.sharedInstance.getRecipes { (result, recipes) in
                    if (result == .SUCCESS) {
                        self.recipes = recipes!
                        self.numRecipeLabel.text = "\(self.recipes.count)"
                        OperationQueue.main.addOperation {
                            self.tblJSON.reloadData()
                        }
                    }
                }
                
            }
            
            
        }
        activityIndicatorView.stopAnimating()
        self.tblJSON.tableFooterView?.isHidden = true
        oldRecipeCount = recipes.count
        
        tblJSON.reloadData()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        oldRecipeCount = 0
    }
    //Displays the cells in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RecipeTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! RecipeTableViewCell
        
        let recipe = recipes[indexPath.row]
        cell.nameLabel.text = recipe.title as String
        cell.photoImageView.image = recipe.image
        
        switch(recipe.category){
        case "Sweet":
            cell.healthy.alpha = 0.25
            cell.spicey.alpha = 0.25
        case "Spicey":
            cell.healthy.alpha = 0.25
            cell.sweet.alpha = 0.25
        case "Healthy":
            cell.sweet.alpha = 0.25
            cell.spicey.alpha = 0.25
            
        default:
            cell.sweet.alpha = 0.25
            cell.spicey.alpha = 0.25
            cell.healthy.alpha = 0.25
        }
        
        
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

    func addRecipe(newRecipe:Recipe) {
        self.recipes.append(newRecipe)
    }


}

protocol AddRecipeDelegate {
    func addRecipe(newRecipe: Recipe)
}

