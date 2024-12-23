//
//  UserItemView.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 23/12/24.
//

import SwiftUI

struct UserItemView: View {
    
    let item: UserJson
    
    var body: some View {
        HStack(alignment: .top, spacing: 16){
            if let profileImage = item.profileImage {
                AsyncImage(url: URL(string: profileImage)) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
            } else {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
            }
            
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
