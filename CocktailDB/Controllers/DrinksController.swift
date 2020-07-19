//
//  ViewController.swift
//  CocktailDB
//
//  Created by Macbook Pro 13 on 17.07.2020.
//  Copyright © 2020 Anastasia Kholod. All rights reserved.
//

import UIKit
import Foundation


class DrinksController: UITableViewController {
    
    var wasCategoriesSelected = false
    var selectedCategories = [String]()
    var categories = [String]()
    var drinks = [Drink]()
    var drinksAll = [[Drink]]()
    
    @IBOutlet var drinksTable: UITableView!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return selectedCategories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return selectedCategories[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("numberOfRowsInSection\(section)\(selectedCategories[section]) is\(drinksAll[section].count)")
        
        return drinksAll[section].count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkscell",
                                                 for: indexPath) as! DrinksCell
        
        cell.drinkName.text = drinksAll[indexPath.section][indexPath.row].strDrink
        cell.imageView?.downloaded(from: "\(drinksAll[indexPath.section][indexPath.row].strDrinkThumb)")
        return cell
    }
    
    func urlString(category: String) -> String {
        
        let urlStringRaw = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(category)"
        let urlString = urlStringRaw.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return urlString!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if wasCategoriesSelected == false {
            parseCategories(urlString: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list")
        }
        
        if selectedCategories.count > 0 {
            drinksAll = []
            for category in selectedCategories {
                
                parseDrinks(urlString: urlString(category: category))
            }
            drinksTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is FiltersController
        {
            let filtersController = segue.destination as? FiltersController
            filtersController?.categories = categories
            filtersController?.selectedCategories = selectedCategories
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func parseCategories(urlString: String) {
        
        let decoder = JSONDecoder()
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                
                if let jsonFilters = try? decoder.decode(Filters.self, from: data) {
                    
                    for i in jsonFilters.drinks {
                        categories.append(i.strCategory)
                    }
                    selectedCategories = categories
                }
            }
        }
    }
    
    func parseDrinks(urlString: String) {
        
        let decoder = JSONDecoder()
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                
                if let jsonDrinks = try? decoder.decode(Drinks.self, from: data) {
                    drinks = jsonDrinks.drinks
                    drinksAll.append(drinks)
                }
            }
        }
    }
}




