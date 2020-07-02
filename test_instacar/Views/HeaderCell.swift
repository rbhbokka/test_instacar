//
//  HeaderCell.swift
//  test_instacar
//
//  Created by Kirill Emelyanenko on 7/1/20.
//  Copyright © 2020 bokka. All rights reserved.
//

import Foundation
import UIKit

class HeaderCell: UIView {
    
    let carousel = AACarousel(frame: .zero)

    let price = UILabel()
    let title = UILabel()
    let trim = UILabel()
    let year = UILabel()
    let mileage = UILabel()
    let zip = UILabel()
    let history = UITextView()
    let shareButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        for el in [price, title, trim, year, mileage, zip, history, shareButton] {
            el.translatesAutoresizingMaskIntoConstraints = false
            addSubview(el)
            
        }
        
        addSubview(carousel)
        carousel.backgroundColor = .white
        carousel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: topAnchor),
            carousel.leftAnchor.constraint(equalTo: leftAnchor),
            carousel.rightAnchor.constraint(equalTo: rightAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 200),
            
            price.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            price.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 15),
            shareButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            shareButton.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 15),
            title.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 15),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            trim.leftAnchor.constraint(equalTo: title.rightAnchor, constant: 5),
            trim.firstBaselineAnchor.constraint(equalTo: title.firstBaselineAnchor),
            year.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            year.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            mileage.firstBaselineAnchor.constraint(equalTo: year.firstBaselineAnchor),
            mileage.leftAnchor.constraint(equalTo: year.rightAnchor, constant: 10),
            zip.firstBaselineAnchor.constraint(equalTo: mileage.firstBaselineAnchor),
            zip.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            history.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            history.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 15),
            history.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
        
        year.layer.borderWidth = 1
        year.layer.cornerRadius = 2
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
    }
    
    func update(data: DetailsViewModel) {
        price.text = data.price
        title.text = data.title
        trim.text = data.trim
        year.text = data.year
        mileage.text = data.mileage
        zip.text = data.zip
        history.text = "History not available"
        
        guard let images = data.images?.compactMap({ $0.uri?.absoluteString })
            else { return }
        
        
        carousel.delegate = self
        carousel.setCarouselData(paths: images,  describedTitle: [], isAutoScroll: false, timer: nil, defaultImage: "stub")
        //optional method
        carousel.setCarouselOpaque(layer: false, describedTitle: false, pageIndicator: true)
        carousel.setCarouselLayout(displayStyle: 0, pageIndicatorPositon: 2, pageIndicatorColor: .white, describedTitleColor: .clear, layerColor: .clear)
    }

}

extension HeaderCell: AACarouselDelegate {
    func downloadImages(_ url: String, _ index: Int) {
        guard let url = URL(string: url) else {
            return
            
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.carousel.images[index] = image
            }

        }.resume()
    }
}

