//
//  User.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-18.
//

import Foundation

struct Location: Identifiable, Hashable, Decodable {
    let id: String // default value for now, is changed later
    let name: String
    let address: String
    let desc: String?
    let rating: Double?
    let googleMapsUri: String
    let priceLevel: String?
    let userRatingCount: Int?
    var profileImageURLs = [String]()
    
    private enum CodingKeys: String, CodingKey {
        case id, displayName, rating, googleMapsUri, priceLevel, userRatingCount, photos
        case summary = "editorialSummary"
        case address = "shortFormattedAddress"

        enum Summary: String, CodingKey {
            case text
        }
        
        enum DisplayName: String, CodingKey {
            case name = "text"
        }
        
        enum Photos: String, CodingKey {
            case authorAttr = "authorAttributions"
            enum AuthorAttr: String, CodingKey {
                case photoUri
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try mainContainer.decode(String.self, forKey: .id)
        self.address = try mainContainer.decode(String.self, forKey: .address)
        self.rating = try? mainContainer.decode(Double.self, forKey: .rating)
        self.googleMapsUri = try mainContainer.decode(String.self, forKey: .googleMapsUri)
        
        self.priceLevel = try? mainContainer.decode(String.self, forKey: .priceLevel)

        self.userRatingCount = try? mainContainer.decode(Int.self, forKey: .userRatingCount)
        
        print("DEBUG: REACH1")
        
        let nameContainer = try mainContainer.nestedContainer(keyedBy: CodingKeys.DisplayName.self, forKey: .displayName)
        self.name = try nameContainer.decode(String.self, forKey: .name)
        
        print("DEBUG: REACH2")
        
        do {
            let descContainer = try mainContainer.nestedContainer(keyedBy: CodingKeys.Summary.self, forKey: .summary)
            self.desc = try descContainer.decode(String.self, forKey: .text)
        } catch {
            self.desc = "A funfilled place!"
        }
                
        print("DEBUG: BEFORE PARSING IMAGE URLS")
        
        self.profileImageURLs.reserveCapacity(3)
        var photosContainer = try mainContainer.nestedUnkeyedContainer(forKey: .photos)
        for _ in 0...2 {
            let nestedContainer = try photosContainer.nestedContainer(keyedBy: CodingKeys.Photos.self)
            var authorAttrContainer = try nestedContainer.nestedUnkeyedContainer(forKey: .authorAttr)
            let firstAuthorAttrContainer = try authorAttrContainer.nestedContainer(keyedBy: CodingKeys.Photos.AuthorAttr.self)
            self.profileImageURLs.append(try firstAuthorAttrContainer.decode(String.self, forKey: .photoUri))
        }
     }
    
    // override is only used for testing purposes
    init() {
        self.id = NSUUID().uuidString
        self.name = "TEST NAME"
        self.address = "TEST ADDRESS"
        self.rating = 5
        self.googleMapsUri = "TEST URL"
        self.priceLevel = "TEST PRICE LEVEL"
        self.userRatingCount = 432
        self.profileImageURLs = ["clawAndKitty-2"]
        self.desc = "TEST INPUT"
    }
}

