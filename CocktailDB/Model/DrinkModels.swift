//
//  DrinkModels.swift
//  CocktailDB
//
//  Created by Macbook Pro 13 on 19.07.2020.
//  Copyright © 2020 Anastasia Kholod. All rights reserved.
//

import Foundation

struct Drink: Codable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
    
}

struct Drinks: Codable {
    var drinks: [Drink]
}
