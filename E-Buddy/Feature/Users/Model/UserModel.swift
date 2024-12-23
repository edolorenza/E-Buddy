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
}

enum GenderEnum: Int, Codable {
    case female = 0
    case male = 1
}
