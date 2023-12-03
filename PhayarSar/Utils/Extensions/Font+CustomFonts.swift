//
//  Font+CustomFonts.swift
//  PhayarSar
//
//  Created by Kyaw Zay Ya Lin Tun on 03/12/2023.
//

import SwiftUI

extension Font {
    static func dmSerif(_ size: CGFloat) -> Font {
        .custom("DMSerifDisplay-Regular", size: size)
    }
    
    static func qsR(_ size: CGFloat) -> Font {
        return .custom("Quicksand-Regular", size: size)
    }
    
    static func qsSb(_ size: CGFloat) -> Font {
        return .custom("Quicksand-SemiBold", size: size)
    }
    
    static func qsB(_ size: CGFloat) -> Font {
        return .custom("Quicksand-Bold", size: size)
    }
}
