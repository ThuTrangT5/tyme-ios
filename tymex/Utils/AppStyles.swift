//
//  AppStyles.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import Foundation
import SwiftUI

class AppStyles {
    static let labelStyle = LabeldStyle()
}

struct LabeldStyle: ViewModifier {
    var paddingTop: CGFloat = 10
    var fontWeight: Font.Weight = .regular
    var font: Font = AppFonts.textFont
    var textColor: Color?
    
    func body(content: Content) -> some View {
        content
            .padding(.top, paddingTop)
            .font(font)
            .fontWeight(fontWeight)
            .multilineTextAlignment(.leading)
            .foregroundColor(textColor)
    }
}
