//
//  AppFonts.swift
//  tymex
//
//  Created by Thu Trang on 1/3/25.
//

import Foundation
import SwiftUI

class AppFonts {
    private static let _fontFamily = "Open Sans"
    static let textFont = Font.custom(_fontFamily, size: 16)
    static let textBold =  Font.custom(_fontFamily, size: 20)
    static let descFont =  Font.custom(_fontFamily, size: 12)
}
