//
//  CustomButtonView.swift
//  NoteVault-SwiftData-vs-CoreData
//
//  Created by Sachindra Fernando on 2025-07-18.
//

import Foundation
import SwiftUI

struct OutlineBtnStyle: ViewModifier {
    
    var colorBorder: Color = .cyan.opacity(0.7)
    var minWith:CGFloat = 60
    var maxWidth:CGFloat = .infinity
    var minHeight:CGFloat = 50
    var maxHeight:CGFloat = 55
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(colorBorder)
            .frame(minWidth: minWith, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 38)
                    .stroke(colorBorder, lineWidth: 2)
            )
            .cornerRadius(30)
    }
}
