//
//  UserListView.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var userVM = UserViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.vertical) {
                ForEach(userVM.userData){ item in
                    VStack(alignment: .leading, spacing: 16){
                        HStack(alignment: .top){
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                            VStack(alignment: .leading, spacing: 4){
                                Text(item.uid)
                                    .foregroundColor(.black)
                                Text(item.genderDescription)
                                    .foregroundColor(.black)
                                Text(item.phoneNumber)
                                    .foregroundColor(.black)
                                Text(item.email)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
        .padding(.top, 16)
        .onAppear {
            self.userVM.fetchUsers()
        }
    }
}
