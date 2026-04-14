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
        Emotion(emoji: "😊", label: "Senang", color: .yellow),
        Emotion(emoji: "☹️", label: "Sedih", color: .blue),
        Emotion(emoji: "😡", label: "Marah", color: .red),
        Emotion(emoji: "🤢", label: "Jijik", color: .green),
        Emotion(emoji: "🤔", label: "Ragu", color: .purple),
        Emotion(emoji: "😲", label: "Terkejut", color: .orange),
        Emotion(emoji: "😰", label: "Takut", color: .teal)
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
                PrimaryButton(title: "Mulai", isEnabled: selectedEmotion != nil, color: .blue, width: 300) {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    navigateToReflection = true
                }
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
            ? emotion.color.opacity(0.7)
            : emotion.color.opacity(0.2)
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
