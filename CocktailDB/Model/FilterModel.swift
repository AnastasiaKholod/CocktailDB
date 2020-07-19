//
//  FilterModel.swift
//  CocktailDB
//
//  Created by Macbook Pro 13 on 19.07.2020.
//  Copyright © 2020 Anastasia Kholod. All rights reserved.
//

import Foundation

struct Filter: Codable {
    var strCategory: String
    
}

struct Filters: Codable {
    var drinks: [Filter]
}
