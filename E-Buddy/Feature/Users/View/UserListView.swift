//
//  UserListView.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import SwiftUI

struct UserListView: View {
    
    @EnvironmentObject private var userVM: UserViewModel
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)
    
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 8){
                    ForEach(userVM.userData){ item in
                        NavigationLink(destination: UserDetailView(item: item)) {
                            UserItemView(item: item)
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.top, 16)
            }
        }
    }
}
