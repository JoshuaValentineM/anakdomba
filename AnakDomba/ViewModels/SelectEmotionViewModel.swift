//
//  SelectEmotionViewModel.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 17/04/26.
//

import SwiftUI
import Combine

@MainActor
class SelectEmotionViewModel: ObservableObject {
    @Published var selectedEmotion: UUID?
    @Published var navigateToReflection = false
    @Published var isLoading = false
    
    // Confused flow state
    @Published var showingConfusedSheet = false
    @Published var confusedInput = ""
    @Published var confusedStep: Int = 0
    @Published var suggestedEmotions: [Emotion] = []
    @Published var beforeYouBeginText: String?
    
    let emotions: [Emotion] = [
        Emotion(emoji: "😊", label: "Senang", color: .yellow),
        Emotion(emoji: "☹️", label: "Sedih", color: .blue),
        Emotion(emoji: "😡", label: "Marah", color: .red),
        Emotion(emoji: "🤢", label: "Jijik", color: .green),
        Emotion(emoji: "🤔", label: "Ragu", color: .purple),
        Emotion(emoji: "😲", label: "Terkejut", color: .orange),
        Emotion(emoji: "😰", label: "Takut", color: .teal),
        Emotion(emoji: "❓", label: "Tidak yakin", color: .gray)
    ]
    
    private let emotionKeywords = EmotionKeywords.keywords
    
    func getSelectedEmotion() -> Emotion? {
        return emotions.first { $0.id == selectedEmotion }
    }
    
    func handleEmotionTap(_ emotion: Emotion) {
        if emotion.label == "Tidak yakin" {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            showingConfusedSheet = true
        } else {
            selectedEmotion = emotion.id
        }
    }
    
    func submitConfusedInput() {
        guard !confusedInput.isEmpty else { return }
        beforeYouBeginText = confusedInput
        suggestedEmotions = getSuggestedEmotions(from: confusedInput)
        confusedStep = 1
    }
    
    func selectSuggestedEmotion(_ emotion: Emotion) {
        selectedEmotion = emotion.id
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigateToReflection = true
            self.isLoading = false
            self.resetConfusedFlow()
        }
    }
    
    func resetConfusedFlow() {
        showingConfusedSheet = false
        confusedStep = 0
        confusedInput = ""
        beforeYouBeginText = nil
    }
    
    func navigateToReflectionFlow(completion: @escaping () -> Void) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.navigateToReflection = true
            self.isLoading = false
            completion()
        }
    }
    
    private func getSuggestedEmotions(from text: String) -> [Emotion] {
        let lowercasedText = text.lowercased()
        var matchedEmotions: [(Emotion, Int)] = []
        
        for emotion in emotions where emotion.label != "Tidak yakin" {
            let keywords = emotionKeywords[emotion.label] ?? []
            var matchCount = 0
            
            for keyword in keywords {
                if lowercasedText.contains(keyword.lowercased()) {
                    matchCount += 1
                }
            }
            
            if matchCount > 0 {
                matchedEmotions.append((emotion, matchCount))
            }
        }
        
        matchedEmotions.sort { $0.1 > $1.1 }
        return Array(matchedEmotions.prefix(3).map { $0.0 })
    }
}