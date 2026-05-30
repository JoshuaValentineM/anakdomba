//
//  AppTheme.swift
//  AnakDomba
//
//  Created by OpenAI on 27/04/26.
//

import SwiftUI

struct AppTheme {
    static func baseBackground(for scheme: ColorScheme) -> Color {
        Color(uiColor: .systemBackground)
    }
    
    static func secondaryBackground(for scheme: ColorScheme) -> Color {
        Color(uiColor: .secondarySystemBackground)
    }
    
    static func tertiaryBackground(for scheme: ColorScheme) -> Color {
        Color(uiColor: .tertiarySystemBackground)
    }
    
    static func cardBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.white.opacity(0.06) : secondaryBackground(for: scheme)
    }
    
    static func cardElevatedBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.white.opacity(0.09) : tertiaryBackground(for: scheme)
    }
    
    static func glassFallbackBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.white.opacity(0.08) : Color.white.opacity(0.72)
    }
    
    static func cardStroke(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.white.opacity(0.08) : Color.black.opacity(0.08)
    }
    
    static func softShadow(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.black.opacity(0.32) : Color.black.opacity(0.10)
    }
    
    static func scrim(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.black.opacity(0.42) : Color.black.opacity(0.18)
    }
    
    static func inverseText(for scheme: ColorScheme) -> Color {
        .white
    }
    
    static func secondaryInverseText(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.white.opacity(0.78) : Color.white.opacity(0.90)
    }
    
    static func screenTintOpacity(for scheme: ColorScheme, emphasized: Bool = false) -> Double {
        switch (scheme, emphasized) {
        case (.dark, false): return 0.16
        case (.dark, true): return 0.32
        case (.light, false): return 0.06
        case (.light, true): return 0.10
        @unknown default: return 0.08
        }
    }
    
    static func emotionCardFill(accentColor: Color, isSelected: Bool, scheme: ColorScheme) -> Color {
        switch (scheme, isSelected) {
        case (.dark, true): return accentColor.opacity(0.46)
        case (.dark, false): return accentColor.opacity(0.22)
        case (.light, true): return accentColor.opacity(0.24)
        case (.light, false): return accentColor.opacity(0.11)
        @unknown default: return accentColor.opacity(isSelected ? 0.24 : 0.11)
        }
    }
    
    static func emotionCardStroke(accentColor: Color, isSelected: Bool, scheme: ColorScheme) -> Color {
        isSelected ? accentColor.opacity(scheme == .dark ? 0.74 : 0.58) : cardStroke(for: scheme)
    }
    
    static func emotionCardShadow(accentColor: Color, isSelected: Bool, scheme: ColorScheme) -> Color {
        isSelected ? accentColor.opacity(scheme == .dark ? 0.28 : 0.14) : .clear
    }
    
    static func emotionAccentTint(accentColor: Color, scheme: ColorScheme) -> Color {
        accentColor.opacity(scheme == .dark ? 0.12 : 0.09)
    }
    
    static func chipBackground(for scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.white.opacity(0.10) : tertiaryBackground(for: scheme)
    }
    
    static func chipSelectedBackground(accentColor: Color, scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return accentColor.opacity(0.85)
        case .light:
            return accentColor.opacity(0.92)
        @unknown default:
            return accentColor.opacity(0.90)
        }
    }
    
    static func historyCardBase(for scheme: ColorScheme) -> Color {
        cardElevatedBackground(for: scheme)
    }
    
    static func historyCardTint(accentColor: Color, scheme: ColorScheme) -> Color {
        accentColor.opacity(scheme == .dark ? 0.18 : 0.14)
    }
    
    static func suggestionFill(accentColor: Color, scheme: ColorScheme) -> Color {
        accentColor.opacity(scheme == .dark ? 0.54 : 0.72)
    }
    
    static func suggestionStroke(accentColor: Color, scheme: ColorScheme) -> Color {
        accentColor.opacity(scheme == .dark ? 0.85 : 0.95)
    }
    
    static func primaryButtonTint(for emotion: Emotion?, scheme: ColorScheme) -> Color {
        guard let emotion else {
            return scheme == .dark ? .blue.opacity(0.75) : .blue.opacity(0.92)
        }
        
        switch emotion.label {
        case "Senang":
            return scheme == .dark ? Color.orange.opacity(0.82) : Color.orange
        case "Takut":
            return scheme == .dark ? Color.teal.opacity(0.78) : Color.teal.opacity(0.95)
        case "Jijik":
            return scheme == .dark ? Color.green.opacity(0.78) : Color.green.opacity(0.96)
        case "Ragu":
            return scheme == .dark ? Color.purple.opacity(0.78) : Color.purple.opacity(0.95)
        case "Sedih":
            return scheme == .dark ? Color.blue.opacity(0.78) : Color.blue.opacity(0.95)
        case "Marah":
            return scheme == .dark ? Color.red.opacity(0.80) : Color.red.opacity(0.96)
        case "Terkejut":
            return scheme == .dark ? Color.orange.opacity(0.78) : Color.orange.opacity(0.95)
        default:
            return scheme == .dark ? emotion.color.opacity(0.78) : emotion.color.opacity(0.94)
        }
    }
}
