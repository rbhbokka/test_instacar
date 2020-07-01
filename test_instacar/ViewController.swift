//
//  ViewController.swift
//  test_instacar
//
//  Created by Kirill Emelyanenko on 7/1/20.
//  Copyright © 2020 bokka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var cars = [Car]()
    let tableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        loadJson()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configureSubviews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadJson() {
        if let path = Bundle.main.path(forResource: "listings-temp", ofType: "json") {
                let jsonDecoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                cars = try jsonDecoder.decode([Car].self, from: data)
            }
            catch {
                assertionFailure()
            }
        }
    }
    
}

    extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let model = cars[indexPath.row]
            let secondViewController = DetailsViewController(with: model)
            self.present(secondViewController, animated: true, completion: nil)
        }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = cars[indexPath.row].title
        return cell
    }
    
    
}

