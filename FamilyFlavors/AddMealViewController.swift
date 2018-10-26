//
//  AddMealViewController.swift
//  FamilyFlavors
//
//  Created by Yuval Reiss on 10/20/18.
//  Copyright © 2018 reiss.yuval. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class AddMealViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
 

    var categories: [String] = ["Healthy", "Sweet", "Spicey"]
    
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeCategories: UITextField!
    @IBOutlet weak var photo: UIImageView!
    var delegate: AddRecipeDelegate?
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true) {
            //After complete
        }
    }
    
    @objc internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            photo.image = image
        } else {
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let categoryPicker:UIPickerView = UIPickerView()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        recipeTitle.setBottomBorder()
        recipeCategories.setBottomBorder()
        
        recipeCategories.inputView = categoryPicker
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.recipeCategories.text = categories[row]
        self.view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func didTapAdd(_ sender: Any) {
        
        guard let recipeTitle: String = recipeTitle.text else {
            return
        }
        
        guard let recipeCategoryString: String = recipeCategories.text else {
            return
        }
        
        guard let recipeImage: UIImage = photo.image else {
            return
        }
        
        let newRecipe :Recipe = Recipe.init(title: recipeTitle, image: recipeImage, category: recipeCategoryString)
        delegate?.addRecipe(newRecipe: newRecipe)
        
        NetworkManager.sharedInstance.postRecipes(in: newRecipe)
        
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
 
 
    
 
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

