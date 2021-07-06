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
        // Cells have a background with style grouped
        let table = UITableView(frame: .zero, style: .grouped)
        // Register
        table.register(DogeTableViewCell.self, forCellReuseIdentifier: DogeTableViewCell.identifier)
        
        return table
    }()
    
    // Array of viewModels
    private var viewModels = [DogeTableViewCellViewModel]()
    
    // Formatter
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        
        return formatter
        
    }()
    
    // Dogecoin data
    private var data: DogeCoinData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DogeCoin"
        // Call API
        fetchData()
    }
    
    // Override viewdidlayOut
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // tableView frame
        tableView.frame = view.bounds
        
    }
    private func fetchData() {
        APICaller.shared.getDogeCoinData { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                
                // Main thread update tableview create view model
                DispatchQueue.main.async {
                    // Perform setUpViewModel
                    self?.setUpViewModels()
                }
//                print("Success: \(data)")
            case .failure(let error):
                print(error)
            }
        }
    }
    private func setUpViewModels() {
        guard let model = data else {
            
            return
        }
        // Call createTableHeader
        setUpTable()
        
        // Setup viewModels
        viewModels = [
            DogeTableViewCellViewModel(
                title: "Name",
                value: model.name
            ),
            DogeTableViewCellViewModel(
                title: "Symbol",
                value: model.symbol
            ),
            DogeTableViewCellViewModel(
                title: "Identifier",
                value: String(model.id)
            ),
            DogeTableViewCellViewModel(
                title: "Date Added",
                value: model.date_added
            ),
            DogeTableViewCellViewModel(
                title: "Total Supply",
                value: String(model.total_supply)
            ),
            
        ]
        
    }
    
    // Private func
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        createTableHeader()
    }
    
    private func createTableHeader() {
        guard let price = data?.quote["USD"]?.price else {
            // Make sure we have price for label
            return
            
        }
        
        
        // Header UIView
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.frame.size.width,
                                          height: view.frame.size.width/1.5))
        // No overflow
        header.clipsToBounds = true
        // Image view coin logo
        let imageView = UIImageView(image: UIImage(named: "dogecoin"))
        imageView.contentMode = .scaleAspectFit
        // Frame imageView
        let size: CGFloat = view.frame.size.width/4
        // horizonally centered
        imageView.frame = CGRect(x: (view.frame.size.width-size)/2,
                                 y: 10,
                                 width: size,
                                 height: size)
        
        // add image to header
        header.addSubview(imageView)
        
        // Price label
        let number = NSNumber(value: price)
        
        // Capital Self because its static
        let string = Self.formatter.string(from: number)
        
        
        // Format Price
        
        
        let label = UILabel()
        label.text = string
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 42, weight: .medium)
        label.frame = CGRect(
            x: 10,
            y: 20+size,
            width: view.frame.size.width-20,
            height: 200)
        header.addSubview(label)
        
        
        // Assigned to the header
        tableView.tableHeaderView = header
        
    }
    
    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Drive the numbers of cells
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DogeTableViewCell.identifier, for: indexPath
           
            // Down cast
        ) as? DogeTableViewCell else {
            fatalError()
            
        }
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }


}

