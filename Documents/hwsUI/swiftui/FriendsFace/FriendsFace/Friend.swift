//
//  Friend.swift
//  FriendsFace
//
//  Created by COBE on 03/05/2021.
//

import Foundation

//As you can see, there is an array of people, and each person has an ID, name, age, email address, and more. They also have an array of tag strings, and an array of friends, where each friend has a name and ID.

struct User: Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tag: [String]
    let friends: [Friend]
}
struct Friend: Codable {
    let id: String
    let name: String
}
