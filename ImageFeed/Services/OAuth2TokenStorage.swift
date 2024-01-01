//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 19.12.2023.
//

import Foundation

final class OAuth2TokenStorage {
    
    private let tokenKey = "BearerTokenKey"
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: tokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
}
