//
//  UserListView.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import SwiftUI

struct UserListView: View {
    
    @EnvironmentObject private var userVM: UserViewModel
    @Environment(\.colorScheme) var colorScheme
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 2)
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Picker("Sort by", selection: $userVM.sortOption) {
                    Text("Last Active").tag(SortOption.lastActive)
                    Text("Rating").tag(SortOption.rating)
                    Text("Price").tag(SortOption.price)
                }
                .pickerStyle(SegmentedPickerStyle())
                
            }
            .padding(.leading, 16)
            .padding(.top, 8)
            
            Toggle("isFemale", isOn: $userVM.filterByGender)
                .font(.system(size: 14, weight: .bold))
                .padding(.leading, 16)
            
            
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
