//
//  UserListView.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import SwiftUI

struct UserListView: View {

    @EnvironmentObject private var userVM: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.vertical) {
                ForEach(userVM.userData){ item in
                    VStack(alignment: .leading, spacing: 16){
                        NavigationLink(destination: UserDetailView(item: item)) {
                            UserItemView(item: item)
                        }
                    }
                }
            }
        }
        .padding(.top, 16)
    }
}
