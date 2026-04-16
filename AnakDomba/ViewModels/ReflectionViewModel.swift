//
//  ReflectionViewModel.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 17/04/26.
//

import SwiftUI
import Combine

@MainActor
class ReflectionViewModel: ObservableObject {
    @Published var reflectionText: String = ""
    @Published var selectedVerse: Verse?
    @Published var songs: [Song] = []
    @Published var currentPrompt: String = ""
    
    let selectedEmotion: Emotion
    let beforeYouBeginText: String?
    
    init(selectedEmotion: Emotion, beforeYouBeginText: String? = nil) {
        self.selectedEmotion = selectedEmotion
        self.beforeYouBeginText = beforeYouBeginText
    }
    
    var backgroundColor: Color {
        switch selectedEmotion.label {
        case "Senang": return .yellow.opacity(0.6)
        case "Sedih": return .blue.opacity(0.6)
        case "Marah": return .red.opacity(0.6)
        case "Jijik": return .green.opacity(0.6)
        case "Ragu": return .purple.opacity(0.6)
        case "Terkejut": return .orange.opacity(0.6)
        case "Takut": return .teal.opacity(0.6)
        default: return .black
        }
    }
    
    func loadContent() {
        if let content = emotionContents[selectedEmotion.label] {
            selectedVerse = content.verses.randomElement()
            songs = content.songs
            
            if let verse = selectedVerse {
                currentPrompt = content.prompt.replacingOccurrences(of: "[Ayat]", with: verse.reference)
            }
        }
    }
    
    func saveReflection() {
        print("Saving reflection...")
    }
}