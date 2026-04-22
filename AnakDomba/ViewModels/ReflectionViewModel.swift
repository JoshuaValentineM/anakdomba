//
//  ReflectionViewModel.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 17/04/26.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
class ReflectionViewModel: ObservableObject {
    @Published var reflectionText: String = ""
    @Published var selectedVerse: Verse?
    @Published var songs: [Song] = []
    @Published var currentPrompt: String = ""
    @Published var isSaved: Bool = false
    
    let selectedEmotion: Emotion
    let beforeYouBeginText: String?
    var modelContext: ModelContext?
    
    init(selectedEmotion: Emotion, beforeYouBeginText: String? = nil) {
        self.selectedEmotion = selectedEmotion
        self.beforeYouBeginText = beforeYouBeginText
    }
    
    var backgroundColor: Color {
        switch selectedEmotion.label {
        case "Senang": return .yellow.opacity(0.15)
        case "Sedih": return .blue.opacity(0.15)
        case "Marah": return .red.opacity(0.15)
        case "Jijik": return .green.opacity(0.15)
        case "Ragu": return .purple.opacity(0.15)
        case "Terkejut": return .orange.opacity(0.15)
        case "Takut": return .teal.opacity(0.15)
        default: return .black
        }
    }
    
    func loadContent() {
        if let content = emotionContents[selectedEmotion.label] {
            selectedVerse = content.verses.randomElement()
            songs = content.songs
            
            if let verse = selectedVerse {
                currentPrompt = content.getPresenceText()
            }
        }
    }
    
    func saveReflection() {
        guard let verse = selectedVerse,
              let song = songs.first else { return }
        
        let reflection = UserReflection(
            emotionLabel: selectedEmotion.label,
            emotionEmoji: selectedEmotion.emoji,
            verseReference: verse.reference,
            verseText: verse.text,
            songTitle: song.title,
            songArtist: song.artist,
            presenceText: "",
            gratitudeText: reflectionText,
            reviewText: "",
            verseReflectionText: "",
            songReflectionText: "",
            actionText: ""
        )
        
        if let context = modelContext {
            context.insert(reflection)
            do {
                try context.save()
                isSaved = true
            } catch {
                print("Failed to save reflection: \(error)")
            }
        }
    }
}