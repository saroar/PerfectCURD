//
//  Person.swift
//  PerfectCURD
//
//  Created by Alif on 13/05/2018.
//

import Foundation

// CRUD can work with most Codable types.

struct Person: Codable {
    let id: UUID
    let firstName: String
    let lastName: String
    let phoneNumbers: [PhoneNumber]?
}
