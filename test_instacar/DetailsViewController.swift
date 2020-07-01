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
    
    let carousel = UIScrollView(frame: .zero)
    let pageControl = UIPageControl()
    
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
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: "HeaderCell")
        carousel.delegate = self
        carousel.isPagingEnabled = true
        
        
        configureViews()
        loadImages()
    }
    
    private func configureViews() {
        view.addSubview(carousel)
        view.addSubview(tableView)
    
        carousel.backgroundColor = .white
        carousel.isScrollEnabled = true
        
        carousel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: view.topAnchor),
            carousel.leftAnchor.constraint(equalTo: view.leftAnchor),
            carousel.rightAnchor.constraint(equalTo: view.rightAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 150),
            
            tableView.topAnchor.constraint(equalTo: carousel.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func loadImages() {
        guard let images = carModelVM.images else { return }
        
        for image in images {
            guard let url = image.uri else { continue }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFit
                    self.carousel.addSubview(imageView)
                }
            }.resume()
        }
    }
    
    
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carModelVM.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UITableViewCell()
        cell.textLabel?.text = carModelVM.sections[section].sectionName
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
        cell.configure(data: carModelVM.sections[indexPath.section].rows[indexPath.row])
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return carModelVM.sections.count
    }
    
}

extension DetailsViewController: UITableViewDelegate {
    
    
}

extension DetailsViewController: UIScrollViewDelegate {
    
}
