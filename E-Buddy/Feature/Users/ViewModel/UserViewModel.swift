//
//  UserViewModel.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import Combine
import Foundation

class UserViewModel: ObservableObject {
    
    @Published var userData: [UserJson] = []
    @Published var errorMessage: String? = nil

    private let firebaseService: FirebaseServices
    private var cancellables = Set<AnyCancellable>()

    init(firebaseService: FirebaseServices = FirebaseServices()) {
        self.firebaseService = firebaseService
    }

    func fetchUsers() {
        firebaseService.fetchUsers()
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
}
