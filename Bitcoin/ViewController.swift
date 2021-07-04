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
        setUpTable()
        
    }
    
    // Override viewdidlayOut
    override func viewDidLayoutSubviews() {
        // tableView frame
        tableView.frame = view.bounds
        // Show icon
        createTableHeader()
    }
    
    private func createTableHeader() {
        // Header UIView
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.frame.size.width,
                                          height: view.frame.size.width))
        // No overflow
        header.clipsToBounds = true
        // Image view coin logo
        let imageView = UIImageView(image: UIImage(named: "dogecoin"))
        imageView.contentMode = .scaleAspectFit
        // Frame imageView
        let size: CGFloat = view.frame.size.width/2
        // horizonally centered
        imageView.frame = CGRect(x: (view.frame.size.width-size)/2,
                                 y: 10,
                                 width: size,
                                 height: size)
        
        // add image to header
        header.addSubview(imageView)
        // Assigned to the header 
        tableView.tableHeaderView = header
        
    }
    
    // Private func
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
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

