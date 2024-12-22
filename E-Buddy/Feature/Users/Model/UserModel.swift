//
//  UserModel.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import Foundation

struct UserJson: Codable, Identifiable {
    let id = UUID()
    var uid: String
    var email: String
    var phoneNumber: String
    var gender: Int
    var genderEnum: GenderEnum? {
        guard let theGender = GenderEnum(rawValue: gender) else {
            return nil
        }
        return theGender
    }
    
    enum CodingKeys: String, CodingKey {
        case uid
        case email
        case phoneNumber = "phone_number"
        case gender = "ge"
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
}

enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}
