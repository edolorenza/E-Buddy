//
//  ImageExtention.swift
//  E-Buddy
//
//  Created by Edo Lorenza on 23/12/24.
//

import SwiftUI

extension Image {
    static let icVerified = Image("icVerified")
    static let icInstagram = Image("icInstagram")
    static let icLightning = Image("icLightning")
    static let icVoice = Image("icVoice")
    static let icStar = Image("icStar")
    static let imgCallOfDuty = Image("imgCallOfDuty")
    static let icMana = Image("icMana")
    static let imgMobileLegend = Image("imgMobileLegend")
    
    func centerCropped() -> some View {
         GeometryReader { geo in
             self
             .resizable()
             .scaledToFill()
             .frame(width: geo.size.width, height: geo.size.height)
             .clipped()
         }
     }

}

extension Color {
    static let mainFontColor = Color("fontColor")
}

