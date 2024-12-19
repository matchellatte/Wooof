//
//  PetResponse.swift
//  Wooof
//
//  Created by STUDENT on 12/19/24.
//

import Foundation
// Pet API Response
struct PetResponse: Codable {
    let animals: [Animal]
}

struct Animal: Codable {
    let id: Int
    let name: String
    let description: String?
    let breeds: Breeds
    let photos: [Photo] // Ensure this field is included
}

struct Breeds: Codable {
    let primary: String
}

struct Photo: Codable {
    let medium: String // Add `medium` or any other size key the API provides
}

