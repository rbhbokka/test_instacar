//
//  DetailsViewModel.swift
//  test_instacar
//
//  Created by Kirill Emelyanenko on 7/1/20.
//  Copyright © 2020 bokka. All rights reserved.
//

import Foundation

struct DetailsViewModel {
    let sections: [DetailsSection]
    let images: [Image]?
    
    struct DetailsSection {
        let sectionName: String
        let rows: [DetailsCell.Pair]
    }
}

typealias P = DetailsCell.Pair

extension Car {
    func toDetailsViewModel() -> DetailsViewModel{
        let listingDetails = DetailsViewModel.DetailsSection(sectionName: "Listing Details", rows: [P(label: "Price", value: NSAttributedString(string: String(price))),
                                                                                                    P(label: "Photos", value: NSAttributedString(string: "\(images?.count ?? 0) Photos"))])
        let vehicleDetails = DetailsViewModel.DetailsSection(sectionName: "Vehicle Details", rows: [P(label: "Trim", value: NSAttributedString(string: trim ?? "")),
        P(label: "Features", value: NSAttributedString(string: "Add features")),
        P(label: "Transmission", value: NSAttributedString(string: transmission!)),
        P(label: "Mileage", value: NSAttributedString(string: String(mileage))),
        P(label: "Zip Code", value: NSAttributedString(string: addresses?.first?.zipcode ?? "N/A")),
        P(label: "Price", value: NSAttributedString(string: String(price))),
        P(label: "Price", value: NSAttributedString(string: String(price)))])
        let contactInfo = DetailsViewModel.DetailsSection(sectionName: "Contact Info", rows: [P(label: "Email", value: NSAttributedString(string: owner?.email ?? "N/A")),
                                                                                              P(label: "Phone", value: NSAttributedString(string: phone ?? "N/A"))])
        
        return DetailsViewModel(sections: [listingDetails, vehicleDetails, contactInfo], images: images)
    }
}
