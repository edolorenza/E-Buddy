//
//  FirebaseServices.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseStorage

final class FirebaseServices {
    
    private static let database = Firestore.firestore().collection("USERS")
    private let storage = Storage.storage()
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
    
    func uploadImageUser(uid: String, image: UIImage) -> AnyPublisher<URL, Error> {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return Fail(error: NSError(
                domain: "ImageError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid image data."]
            )).eraseToAnyPublisher()
        }
        
        let storageRef = storage.reference().child("profile_images/\(uid).jpg")
        
        return Future<URL, Error> { promise in
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                storageRef.downloadURL { url, error in
                    if let error = error {
                        promise(.failure(error))
                    } else if let url = url {
                        promise(.success(url))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func updateUserProfileImageURL(userID: String, url: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            FirebaseServices.database.document(userID).updateData(["profile_image": url]) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}
