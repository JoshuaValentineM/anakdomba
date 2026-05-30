//
//  PrimaryButton.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI

struct PrimaryButton: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    let isEnabled: Bool
    var color: Color = .clear
    var textColor: Color = .white
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    let action: () -> Void
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 12)
        let fillColor = isEnabled ? color : AppTheme.cardElevatedBackground(for: colorScheme)
        
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .frame(width: width, height: height)
                .background(
                    shape.fill(fillColor)
                )
                .overlay(
                    shape
                        .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
                )
                .foregroundColor(isEnabled ? textColor : .secondary)
                .shadow(color: AppTheme.softShadow(for: colorScheme), radius: isEnabled ? 8 : 0, y: 4)
                .opacity(isEnabled ? 1 : 0.6)
        }
        .disabled(!isEnabled)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton(title: "Enabled", isEnabled: true, color: .blue) {}
        PrimaryButton(title: "Disabled", isEnabled: false, color: .gray) {}
    }
    .padding()
    .preferredColorScheme(.dark)
}
