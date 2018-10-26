//
//  RecipeTableViewCell.swift
//  FamilyFlavors
//
//  Created by Yuval Reiss on 10/18/18.
//  Copyright © 2018 reiss.yuval. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
  
    @IBOutlet weak var healthy: UIImageView!
    @IBOutlet weak var spicey: UIImageView!
    @IBOutlet weak var sweet: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
