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
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    func uploadImageUser(uid: String, image: UIImage) -> AnyPublisher<URL, Error> {
        beginBackgroundTask()
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            endBackgroundTask()
            return Fail(error: NSError(
                domain: "ImageError",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid image data."]
            )).eraseToAnyPublisher()
        }
        
        let storageRef = storage.reference().child("profile_images/\(uid).jpg")
        
        return Future<URL, Error> { [weak self] promise in
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    self?.endBackgroundTask()
                    promise(.failure(error))
                    return
                }
                
                storageRef.downloadURL { url, error in
                    self?.endBackgroundTask()
                    if let error = error {
                        promise(.failure(error))
                    } else if let url = url {
                        promise(.success(url))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
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
    
    func fetchOrderedUsers(sortOption: SortOption, filterByFemale: Bool) -> AnyPublisher<[UserJson], Never> {
        var query: Query = FirebaseServices.database
        
        if filterByFemale {
            query = query.whereField("ge", isEqualTo: 0)
        }
        
        switch sortOption {
        case .lastActive:
            query = query.order(by: "last_active", descending: true)
        case .rating:
            query = query.order(by: "rating", descending: true)
        case .price:
            query = query.order(by: "price", descending: false)
        }
        
        return Future<[UserJson], Never> { promise in
            query.getDocuments { snapshot, error in
                if let error = error {
                    print("Firestore query error: \(error.localizedDescription)")
                    promise(.success([]))
                    return
                }
                
                guard let snapshot = snapshot else {
                    promise(.success([]))
                    return
                }
                
                let users = snapshot.documents.compactMap { doc -> UserJson? in
                    try? doc.data(as: UserJson.self)
                }
                promise(.success(users))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func beginBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "FirebaseUpload") {
            UIApplication.shared.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = .invalid
        }
    }
    
    private func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
    
}
