//
//  ViewController.swift
//  Bitcoin
//
//  Created by Daval Cato on 6/27/21.
//

import UIKit

// UI
// MVVM
// API Call
// Pull to Refresh



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Create tableview fetch data
    private let tableView: UITableView = {
        let table = UITableView()
        // Register
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DogeCoin"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // Override viewdidlayOut
    override func viewDidLayoutSubviews() {
        // tableView frame
        tableView.frame = view.bounds
    }
    
    // Required methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Dogecoin"
        
        return cell
    }


}

