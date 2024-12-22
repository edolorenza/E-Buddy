//
//  ContentView.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 22/12/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            UserListView()
                .navigationTitle("E-Buddy")
        }
    }
}

#Preview {
    ContentView()
}
