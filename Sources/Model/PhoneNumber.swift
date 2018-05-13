//
//  PhoneNumber.swift
//  PerfectCURD
//
//  Created by Alif on 13/05/2018.
//

import Foundation
import PerfectCRUD

struct PhoneNumber: Codable {
    let personId: UUID
    let planetCode: Int
    let number: String
}
