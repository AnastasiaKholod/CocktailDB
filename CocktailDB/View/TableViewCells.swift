//
//  TableViewCells.swift
//  CocktailDB
//
//  Created by Macbook Pro 13 on 19.07.2020.
//  Copyright © 2020 Anastasia Kholod. All rights reserved.
//

import Foundation
import UIKit

class FiltersCell: UITableViewCell {
    
    weak var delegate : FiltersController?
    
    @IBOutlet weak var filter: UILabel!
}

class DrinksCell: UITableViewCell {
    
    @IBOutlet weak var drinkPicture: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    
    weak var delegate : DrinksController?

}
