//
//  Owner+CoreDataClass.swift
//  github_users_d
//
//  Created by Kirill Emelyanenko on 6/30/20.
//  Copyright © 2020 rbhbokka. All rights reserved.
//
//

import Foundation

public class Owner: Decodable {
    
    var id: String?
    var first_name: String?
    var last_name: String?
    var photo_url: URL?
    var email: String?
    
    enum Keys: String, CodingKey {
        case id
        case first_name
        case last_name
        case photo_url
        case email
    }
    
    public required init(from decoder: Decoder) throws {
               let container = try decoder.container(keyedBy: Keys.self)
        id = try container.decode(String.self, forKey: .id)
        first_name = try container.decode(String.self, forKey: .first_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        photo_url = try container.decodeIfPresent(URL.self, forKey: .photo_url) ?? nil
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? nil

    }
}
