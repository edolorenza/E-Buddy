//
//  UserItemView.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 23/12/24.
//

import SwiftUI

struct UserItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    let item: UserJson
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            self.headerView
            
            ZStack(alignment: .bottomTrailing) {
                ZStack(alignment: .bottomLeading){
                    self.profileImageView
                    
                    self.gameSectionView
                }
                
                self.voiceSectionView
            }
            .padding(.bottom, 24)
            
            VStack(alignment: .leading,  spacing: 8) {
                self.ratingView
                
                self.manaView
            }
            .padding(.top, 8)
        }
        .padding(.all, 8)
        .background(colorScheme == .dark ? .black : .white)
        .cornerRadius(16)
        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) :  Color.black.opacity(0.3), radius: 5, x: 0, y: 1)
    }
}


extension UserItemView {
    private var headerView: some View {
        HStack {
            HStack(spacing: 8){
                Text(self.item.name ?? "")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.mainFontColor)
                Circle()
                    .fill(self.item.isOnline ? Color.green : Color.red)
                    .frame(width: 10, height: 10)
            }
            Spacer()
            
            Image.icVerified
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
            
            Image.icInstagram
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
        }
    }
    
    @ViewBuilder private var profileImageView: some View {
        if let profileImage = item.profileImage {
               AsyncImage(url: URL(string: profileImage)) { image in
                   image
                       .resizable()
                       .centerCropped()
                       .frame(height:  UIScreen.main.bounds.size.width/2, alignment: .center)
                       .cornerRadius(16)
                       .overlay(
                        ZStack{
                            
                            HStack {
                                Image.icLightning
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 14, height: 14)
                                    
                                Text("Available today!")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                            }
                            .padding(.all, 8)
                            .background(
                                BlurView()
                            )
                            .clipShape(Capsule())
                            .padding(8)
                        }
                          ,
                           alignment: .top
                       )
               } placeholder: {
                   ZStack{
                       RoundedRectangle(cornerRadius: 16)
                           .frame(height: UIScreen.main.bounds.size.width/2, alignment: .center)
                           .foregroundColor(.gray)
                       
                       ProgressView()
                   }
               }
               
           } else {
               RoundedRectangle(cornerRadius: 16)
                   .frame(height:  UIScreen.main.bounds.size.width/2, alignment: .center)
                   .foregroundColor(.gray)
           }

    }
    
    private var gameSectionView: some View {
        HStack(spacing: -10) {
            Image.imgCallOfDuty
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Image.imgMobileLegend
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
                .overlay(
                    ZStack {
                        Circle()
                            .fill(colorScheme == .dark ?  Color.white .opacity(0.5) :  Color.black.opacity(0.5))
                            .overlay(
                                Circle()
                                    .stroke(colorScheme == .dark ? Color.black : Color.white, lineWidth: 1)
                            )
                        Text("+3")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14))
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                    }
                )
            
            Spacer()
        }
        .padding(.leading, 8)
        .offset(y: 28)
    }
    
    private var voiceSectionView: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [.purple, .pink, .orange]), startPoint: .bottomLeading, endPoint: .topTrailing)
                )
                .frame(width: 36, height: 36)
                
            Image.icVoice
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(colorScheme == .dark ? Color.black : Color.white)
                .frame(width: 18, height: 18)
        }
        .padding(.trailing, 8)
        .offset(y: 18)
    }
    
    @ViewBuilder private var ratingView: some View {
        if let rating = item.rating, let totalRating = item.totalRating {
            HStack {
                Image.icStar
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                Text(String(format: "%.2f", rating))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.mainFontColor)
                
                Text("(\(totalRating))")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
    }
    
    @ViewBuilder private var manaView: some View {
        if self.item.price != nil {
            HStack {
                Image.icMana
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                
                HStack(alignment: .bottom, spacing: 0) {
                    Text(self.item.priceNominal)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.mainFontColor)
                    
                    Text(".\(self.item.priceDecimal)/1Hr")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.mainFontColor)
                }
            }
        }
    }
}
