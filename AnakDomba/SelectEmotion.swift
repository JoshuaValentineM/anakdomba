//
//  SelectEmotion.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI

struct SelectEmotion: View {
    // MARK: - State
    @State private var selectedEmotion: UUID?
    @State private var navigateToReflection = false
    
    // MARK: - Grid Layout
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Data
    let emotions: [Emotion] = [
        Emotion(emoji: "😊", label: "Senang"),
        Emotion(emoji: "☹️", label: "Sedih"),
        Emotion(emoji: "😡", label: "Marah"),
        Emotion(emoji: "🤢", label: "Jijik"),
        Emotion(emoji: "🤔", label: "Ragu"),
        Emotion(emoji: "😲", label: "Terkejut"),
        Emotion(emoji: "😰", label: "Takut")
    ]
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 16) {
                
                // Title
                Text("Bagaimana wajahmu saat ini?")
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(emotions) { emotion in
                            emotionBox(emotion)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
                .frame(maxHeight: 600)
                
                Spacer()
                
                // Mulai Button
                Button(action: {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    navigateToReflection = true
                }) {
                    Text("Mulai")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(selectedEmotion != nil ? Color.blue : Color.gray.opacity(0.4))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }
                .disabled(selectedEmotion == nil)
                .padding(.bottom, 8)
            }
            .padding()
            .toolbar(.hidden, for: .tabBar)
            .navigationDestination(isPresented: $navigateToReflection) {
                if let emotion = getSelectedEmotion() {
                    ReflectionView(selectedEmotion: emotion)
                }
            }
        }
    }
    
    // MARK: - Emotion Box Component
    func emotionBox(_ emotion: Emotion) -> some View {
        VStack {
            //            Spacer()
            
            Text(emotion.emoji)
                .font(.system(size: 64))
            
            Text(emotion.label)
                .font(.system(size: 14))
                .foregroundColor(.white)
            
            //            Spacer()
        }
        .frame(width: 150, height: 150)
        .background(
            selectedEmotion == emotion.id
            ? Color.blue.opacity(0.3)
            : Color.gray.opacity(0.2)
        )
        .cornerRadius(12)
        .onTapGesture {
            selectedEmotion = emotion.id
        }
        .animation(.easeInOut, value: selectedEmotion)
    }
    
    func getSelectedEmotion() -> Emotion? {
        return emotions.first { $0.id == selectedEmotion }
    }
    
}

#Preview {
    SelectEmotion().preferredColorScheme(.dark)
}
