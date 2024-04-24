//
//  ApiCreds.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-23.
//

import Foundation

struct ApiCreds {
    static var key: String? {
        if let filePath = Bundle.main.path(forResource: "Config", ofType: "plist") {
            let plist = NSDictionary(contentsOfFile: filePath)
            return plist?.object(forKey: "API_KEY") as? String
        }
        return nil
    }
}
