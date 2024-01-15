//
//  Font+.swift
//  Vollmed
//
//  Created by Felipe Assis on 15/01/24.
//

import SwiftUI

extension Font {
    
    enum FontType: String {
        case inter = "Inter"
    }

    enum FontStyle: String {
        case bold = "-Bold"
        case medium = "-Medium"
        case regular = "-Regular"
        case semiBold = "-SemiBold"
    }
    
    static func customFont2(type: FontType, style: FontStyle, size: CGFloat, isScaled: Bool = true) -> Font {
        let fontName: String = type.rawValue + style.rawValue
        return Font.custom(fontName, size: size)
    }
}
