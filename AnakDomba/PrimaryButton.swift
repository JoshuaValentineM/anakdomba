//
//  PrimaryButton.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isEnabled: Bool
    var color: Color = .clear
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .frame(width: width, height: height)
                .background(isEnabled ? color : Color.gray.opacity(0.4))
                .background(.ultraThinMaterial)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 4)
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
