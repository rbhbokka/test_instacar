//
//  DetailsCell.swift
//  test_instacar
//
//  Created by Kirill Emelyanenko on 7/1/20.
//  Copyright © 2020 bokka. All rights reserved.
//

import Foundation
import UIKit

class DetailsCell: UITableViewCell {
    
    let label = UILabel()
    let value = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(label)
        addSubview(value)
        label.translatesAutoresizingMaskIntoConstraints = false
        value.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            value.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            value.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        label.textColor = .darkGray
        value.textColor = .lightGray
        accessoryType = .disclosureIndicator
    }
    
    func configure(data: Pair) {
        label.text = data.label
        value.attributedText = data.value
    }
    
    override func prepareForReuse() {
        label.text = ""
        value.text = ""
    }
    
    struct Pair {
        let label: String
        let value: NSAttributedString
    }
}


