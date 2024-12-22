//
//  FirebaseServices.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import Foundation
import Combine
import FirebaseFirestore

final class FirebaseServices {
    
    private static let database = Firestore.firestore().collection("USERS")
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUsers(with query: Query = FirebaseServices.database) -> AnyPublisher<[UserJson], Error> {
        Future<[UserJson], Error> { promise in
            query.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    promise(.success([]))
                    return
                }
                
                do {
                    let users = try documents.map { try $0.data(as: UserJson.self) }
                    promise(.success(users))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
