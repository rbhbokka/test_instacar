//
//  DetailsViewController.swift
//  test_instacar
//
//  Created by Kirill Emelyanenko on 7/1/20.
//  Copyright © 2020 bokka. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    private let carModelVM: DetailsViewModel
        
    let tableView = UITableView(frame: .zero)
    
    init(with model: Car) {
        carModelVM = model.toDetailsViewModel()

        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailsCell.self, forCellReuseIdentifier: "DetailsCell")
        
        configureViews()
    }
    
    private func configureViews() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        let headerCell = HeaderCell(frame: .zero)
        headerCell.frame.size.height = 350
        headerCell.update(data: carModelVM)
        tableView.tableHeaderView = headerCell
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carModelVM.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
        cell.configure(data: carModelVM.sections[indexPath.section].rows[indexPath.row])
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return carModelVM.sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(45)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UITableViewCell()
        cell.textLabel?.text = carModelVM.sections[section].sectionName
        cell.textLabel?.font = .systemFont(ofSize: 13)
        cell.backgroundColor = .lightGray
        return cell
    }
}
