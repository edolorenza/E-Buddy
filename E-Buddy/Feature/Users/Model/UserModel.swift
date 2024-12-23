//
//  UserModel.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import Foundation

struct UserJson: Codable, Identifiable {
    let id = UUID()
    let uid: String
    let name: String?
    let price: Double?
    let rating: Double?
    let totalRating: Int?
    let isOnline: Bool
    let email: String
    let phoneNumber: String
    let gender: Int
    let profileImage: String?
    var genderEnum: GenderEnum? {
        guard let theGender = GenderEnum(rawValue: gender) else {
            return nil
        }
        return theGender
    }
    
    enum CodingKeys: String, CodingKey {
        case uid
        case email
        case name
        case price
        case rating
        case totalRating = "total_rating"
        case isOnline = "is_online"
        case phoneNumber = "phone_number"
        case gender = "ge"
        case profileImage = "profile_image"
    }
    
    var genderDescription: String {
        switch genderEnum {
        case .female:
            return "Female"
        case .male:
            return "Male"
        case nil:
            return ""
        }
    }
    
    var priceNominal: String {
        return "\(price ?? 0)".components(separatedBy: ".").first ?? ""
    }
    
    var priceDecimal: String {
        return "\(price ?? 0)".components(separatedBy: ".").last ?? ""
    }
}

enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}
