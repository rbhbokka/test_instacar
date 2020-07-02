//
//  Address+CoreDataClass.swift
//  github_users_d
//
//  Created by Kirill Emelyanenko on 6/30/20.
//  Copyright © 2020 rbhbokka. All rights reserved.
//
//

import Foundation

public class Address: Decodable {
    
    var city: String?
    var state: String?
    var zipcode: String?
    var latitude: String?
    var longitude: String?
    
    enum Keys: String, CodingKey {

    case city
    case state
    case zipcode
    //case latitude
    //case longitude
    }
    
    public required init(from decoder: Decoder) throws {

               let container = try decoder.container(keyedBy: Keys.self)

               state = try container.decode(String.self, forKey: .state)
        zipcode = try container.decode(String.self, forKey: .zipcode)

        //latitude = try container.decode(String?.self, forKey: .latitude)

        //longitude = try container.decode(String?.self, forKey: .longitude)

    }

}
