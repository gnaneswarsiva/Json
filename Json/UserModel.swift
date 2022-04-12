//
//  UserModel.swift
//  Json
//
//  Created by lakshmi Raghavendra on 27/03/22.
//

import Foundation

struct UserModel: Decodable {
    let userID, id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id,title,completed
    }
}
