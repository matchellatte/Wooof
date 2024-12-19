//
//  AccessTokenResponse.swift
//  Wooof
//
//  Created by STUDENT on 12/19/24.
//

import Foundation
// Access Token Model
struct AccessTokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Int
}
