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

class AddMealViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
 

    var categories: [String] = ["Healthy", "Sweet", "Savory"]
    
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeCategories: UITextField!
    @IBOutlet weak var photo: UIImageView!
    
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary//UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true) {
            //After complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
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
        
        guard let taskTitle: String = recipeTitle.text else {
            return
        }
        
        guard let recipeCategoryString: String = recipeCategories.text else {
            return
        }
        
        guard let image: UIImage = photo.image else {
            return
        }
        
        post(taskTitle: taskTitle, recipeCategory: recipeCategoryString, image: image)
    }
    
    
    func post(taskTitle:String, recipeCategory: String, image:UIImage) {
       
        
        let imageData = image.jpegData(compressionQuality: 0.1)!
        let parameters = [
            "Title": taskTitle,
            "Category": recipeCategory,
            "Image":imageData.base64EncodedString()
            ]
        
        let headers = [
            
            "x-apikey": "f22738e5bf0d2c7269a9fdc3614db45f09e70",
            
        ]
        
        Alamofire.request("https://familyflavors-d997.restdb.io/rest/recipe", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        _ = navigationController?.popViewController(animated: true)

        
    }
 
    
 
}

