//
//  UserDetailView.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 23/12/24.
//

import SwiftUI

struct UserDetailView: View {
    
    @EnvironmentObject private var userVM: UserViewModel
    @State private var showImagePicker: Bool = false
    @State private var profileImage: UIImage?
    let item: UserJson
    
    var body: some View {
        VStack(alignment: .center, spacing: 16){
            
            if let profileImage = item.profileImage {
                AsyncImage(url: URL(string: profileImage)) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
            } else {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading, spacing: 8){
                Text(item.uid)
                    .foregroundColor(.black)
                Text(item.genderDescription)
                    .foregroundColor(.black)
                Text(item.phoneNumber)
                    .foregroundColor(.black)
                Text(item.email)
                    .foregroundColor(.black)
            }
            Button(action: {
                self.showImagePicker = true
            }, label: {
                Text("Upload Profile Image")
            })
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $profileImage)
        }
        .onChange(of: profileImage) { uploadImage in
            if let image = uploadImage {
                self.userVM.uploadImage(uid: item.uid, image: image)
            }
        }
    }
}
