//
//  SortOption.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 23/12/24.
//

import Foundation

enum SortOption: String, CaseIterable, Identifiable {
    case lastActive = "last_active"
    case rating = "rating"
    case price = "price"

    var id: String { self.rawValue }
}
