//
//  Users.swift
//  axon_test
//
//  Created by Serhii PERKHUN on 12/5/18.
//  Copyright © 2018 Serhii PERKHUN. All rights reserved.
//

import Foundation

struct  Users: Decodable {
    enum CodingKeys: String, CodingKey {
        case results
    }
    let results: [Results]
}

struct Results: Decodable {
    let gender: String
    let name: Name
    let dob: Dob
    let picture: Picture
    let phone: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case dob
        case picture
        case phone
        case email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.gender = try container.decode(String.self, forKey: .gender)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.name = try container.decode(Name.self, forKey: .name)
        self.dob = try container.decode(Dob.self, forKey: .dob)
        self.picture = try container.decode(Picture.self, forKey: .picture)
        self.email = try container.decode(String.self, forKey: .email)
    }
}

struct Dob: Codable {
    let date: Date
}

struct Name: Codable {
    let first, last: String
}

struct Picture: Codable {
    let large: String
}
