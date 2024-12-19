//
//  Pet.swift
//  Wooof
//
//  Created by STUDENT on 12/19/24.
//

import Foundation
struct Pet: Identifiable, Codable {
    let id: Int // or UUID based on your API
    let name: String
    let breed: String
    let description: String?
    let imageURL: String? // Add this property for the image
}

