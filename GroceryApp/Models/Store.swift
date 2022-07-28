//
//  Store.swift
//  GroceryApp
//
//  Created by Syed Ghullam Meeran Gillani on 27/07/2022.
//

import Foundation

struct Store: Codable{
    var id : String?
    let name : String
    let address: String
    var items: [String]?
}
