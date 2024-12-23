//
//  UserViewModel.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import Combine
import SwiftUI

class UserViewModel: ObservableObject {
    
    @Published var userData: [UserJson] = []
    @Published var errorMessage: String? = nil
    @Published var sortOption: SortOption = .lastActive {
            didSet { fetchUsers() }
    }
    @Published var filterByGender: Bool = false {
            didSet { fetchUsers() }
    }

    private let firebaseService: FirebaseServices
    private var cancellables = Set<AnyCancellable>()
    
    init(firebaseService: FirebaseServices = FirebaseServices()) {
        self.firebaseService = firebaseService
    }
    
    func fetchUsers() {
        firebaseService.fetchOrderedUsers(sortOption: self.sortOption, filterByFemale: self.filterByGender)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] users in
                self?.userData = users
            })
            .store(in: &cancellables)
    }
    
    func uploadImage(uid: String, image: UIImage) {
        firebaseService.uploadImageUser(uid: uid, image: image)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] url in
                self?.updateProfileImageURL(userID: uid, imageURL: url.absoluteString)
            })
            .store(in: &cancellables)
    }
    
    func updateProfileImageURL(userID: String, imageURL: String) {
        firebaseService.updateUserProfileImageURL(userID: userID, url: imageURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] resp in
                self?.fetchUsers()
            })
            .store(in: &cancellables)
    }
}
