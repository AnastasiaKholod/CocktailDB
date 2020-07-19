//
//  FilterControllers.swift
//  CocktailDB
//
//  Created by Macbook Pro 13 on 18.07.2020.
//  Copyright © 2020 Anastasia Kholod. All rights reserved.
//

import Foundation
import UIKit

class FiltersController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories = [String]()
    var selectedCategories = [String]()
    var selectedIndexes = [Int]()
    
    @IBOutlet weak var filterTable: UITableView!
    
    @IBOutlet weak var applyButton: UIButton!
    
    @IBAction func applyPressed(_ sender: Any) {
        
        let selectedIndexPaths = filterTable.indexPathsForSelectedRows
        
        let sortedIndexes = selectedIndexPaths?.sorted(by: { (f, s) -> Bool in
            return f < s
        })
        
        var selectedRows:[Int] = []
        if sortedIndexes != nil {
            for i in sortedIndexes! {
                selectedRows.append(i[1])
            }
        }
        var selectedCategories0 = [String]()
        if selectedRows.count > 0 {
            for i in selectedRows {
                selectedCategories0.append(categories[i])
            }
            selectedCategories = selectedCategories0
            performSegue(withIdentifier: "unwindToDriks", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiltersCell",
                                                 for: indexPath) as! FiltersCell
        
        cell.filter.text = categories.self[indexPath.row]
        
        if selectedIndexes.contains(indexPath.row) {
            
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DrinksController
        {
            let drinksController = segue.destination as? DrinksController
            drinksController?.selectedCategories = selectedCategories
            drinksController?.wasCategoriesSelected = true
            drinksController?.categories = categories
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index,category) in categories.enumerated(){
            if selectedCategories.contains(category){
                selectedIndexes.append(index)
            }
        }
        for row in selectedIndexes{
            filterTable.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



