//
//  ViewController.swift
//  Project1
//
//  Created by Eduardo Carrillo on 3/28/19.
//  Copyright © 2019 Eduardo Carrillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories = ["Airplanes", "Beaches", "Bridges", "Cats", "Cities", "Dogs", "Earth", "Forests", "Galaxies", "Landmarks", "Mountains", "People", "Roads", "Sports", "Sunsets"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        
        return cell
    }
    

}

