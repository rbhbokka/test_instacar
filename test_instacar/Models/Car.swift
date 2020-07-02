//
//  Car+CoreDataClass.swift
//  github_users_d
//
//  Created by Kirill Emelyanenko on 6/30/20.
//  Copyright © 2020 rbhbokka. All rights reserved.
//
//

import Foundation

public class Car: Decodable {
    
    public var id: String?
        public var vin: String?
        public var license_plate: String?
        public var license_plate_state: String?
        public var mileage: Int32
        public var phone: String?
        public var price: Double
        public var short_url: URL?
        public var created_at: String?
        public var updated_at: String?
        public var transmission: String?
        public var title: String?
        //public var progress: Int16
        public var make: String?
        public var model: String?
        public var year: Int16
        public var trim: String?
        public var images: [Image]?
        public var owner: Owner?
        public var addresses: [Address]?
    
  enum Keys: String, CodingKey {
            case id
            case vin
            case license_plate
            case license_plate_state
            case mileage
            case phone
            case price
            case short_url
            case created_at
            case updated_at
            case transmission
            case title
            case progress
            case images
            case owner
            case addresses
            case make
            case model
            case year
            case trim
        }


        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            id = try container.decode(String.self, forKey: .id)
            vin = try container.decode(String?.self, forKey: .vin)
            license_plate = try container.decodeIfPresent(String?.self, forKey: .license_plate) ?? nil
            license_plate_state = try container.decodeIfPresent(String?.self, forKey: .license_plate_state) ?? nil
            mileage = try container.decode(Int32.self, forKey: .mileage)
            phone = try container.decode(String?.self, forKey: .phone)
            price = try container.decode(Double.self, forKey: .price)
            short_url = try container.decodeIfPresent(URL?.self, forKey: .short_url) ?? nil
            created_at = try container.decode(String?.self, forKey: .created_at)
            updated_at = try container.decode(String?.self, forKey: .updated_at)
            transmission = try container.decode(String?.self, forKey: .transmission)
            title = try container.decode(String?.self, forKey: .title)
            //progress = try container.decode([String: Int16], forKey: .progress)
            make = try container.decodeIfPresent(String.self, forKey: .make)
            model = try container.decodeIfPresent(String.self, forKey: .model)
            year = try container.decodeIfPresent(Int16.self, forKey: .year)!
            images = try container.decodeIfPresent([Image].self, forKey: .images)!
            owner = try container.decodeIfPresent(Owner.self, forKey: .owner)
            addresses = try container.decodeIfPresent([Address].self, forKey: .addresses)
        }
}
