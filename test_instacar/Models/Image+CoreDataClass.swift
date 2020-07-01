//
//  Image+CoreDataClass.swift
//  github_users_d
//
//  Created by Kirill Emelyanenko on 6/30/20.
//  Copyright © 2020 rbhbokka. All rights reserved.
//
//

import Foundation

public class Image: Decodable {
    
    var id: String?
    var uri: URL?
    var image: NSData?
    
    enum Keys: String, CodingKey {
        case id
        case uri
    }
    
    public required init(from decoder: Decoder) throws {
               let container = try decoder.container(keyedBy: Keys.self)
        if let url = try container.decodeIfPresent(String.self, forKey: .uri) {
               uri =  URL(string: url)
        }
               id = try container.decode(String.self, forKey: .id)
    }
}
