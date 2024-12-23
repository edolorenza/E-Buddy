//
//  ContentView.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var userVM = UserViewModel()
    
    var body: some View {
        NavigationView {
            UserListView()
                .navigationTitle("E-Buddy")
        }
        .environmentObject(self.userVM)
        .onAppear  {
            self.userVM.fetchUsers()
        }
    }
}

#Preview {
    ContentView()
}
