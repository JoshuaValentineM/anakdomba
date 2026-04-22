//
//  SelectEmotion.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI

struct SelectEmotionView: View {
    // MARK: - State
    @State private var selectedEmotion: UUID?
    @State private var navigateToReflection: Bool = false
    @State private var isLoading = false
    
    // MARK: - Confused Flow State
    @State private var showingConfusedSheet = false
    @State private var confusedInput = ""
    @State private var confusedStep: Int = 0 // 0 = input, 1 = suggestions, 2 = confirmation
    @State private var suggestedEmotions: [Emotion] = []
    @State private var beforeYouBeginText: String?
    
    private let emotionKeywords = EmotionKeywords.keywords
    
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
    
    // MARK: - Grid Layout
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Data
    let emotions: [Emotion] = [
        Emotion(emoji: "😡", label: "Marah", color: .red),
        Emotion(emoji: "🤔", label: "Ragu", color: .purple),
        Emotion(emoji: "😰", label: "Takut", color: .teal),
        Emotion(emoji: "☹️", label: "Sedih", color: .blue),
        Emotion(emoji: "😊", label: "Senang", color: .yellow),
        Emotion(emoji: "🤢", label: "Jijik", color: .green),
        Emotion(emoji: "😲", label: "Terkejut", color: .orange),
        Emotion(emoji: "❓", label: "Tidak yakin", color: .gray)
    ]
    
    var body: some View {
        //        NavigationStack{
        ZStack{
            VStack(spacing: 16) {
                
                // Title
                //                Text("Bagaimana wajahmu saat ini?")
                //                    .font(.system(size: 24, weight: .bold))
                //                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
                    
                    isLoading = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        navigateToReflection = true
                        isLoading = false // reset so when coming back it's normal
                    }
                }
                .padding(.bottom, 8)
            }
            .padding()
            .navigationTitle("Bagaimana wajahmu saat ini?")
            .navigationBarTitleDisplayMode(.inline)
            //            .toolbar(.hidden, for: .tabBar)
            //            .persistentSystemOverlays(.hidden)
            .navigationDestination(isPresented: $navigateToReflection) {
                if let emotion = getSelectedEmotion() {
                    ReflectionView(selectedEmotion: emotion)
                }
            }
            //        }
            if isLoading {
                LoaderView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: isLoading)
        .sheet(isPresented: $showingConfusedSheet) {
            confusedFlowSheet
                .presentationDetents([.medium, .large])
        }
    }
    
    struct LoaderView: View {
        var body: some View {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.5)
                    
                    Text("Menyiapkan refleksimu...")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(24)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
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
            ? emotion.color.opacity(0.8)
            : emotion.color.opacity(0.5)
        )
        .cornerRadius(12)
        .onTapGesture {
            if emotion.label == "Tidak yakin" {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                showingConfusedSheet = true
            } else {
                selectedEmotion = emotion.id
            }
        }
        .animation(.easeInOut, value: selectedEmotion)
    }
    
    func getSelectedEmotion() -> Emotion? {
        return emotions.first { $0.id == selectedEmotion }
    }
    
    // MARK: - Confused Flow Sheet
    var confusedFlowSheet: some View {
        NavigationStack {
            ZStack {
                if confusedStep == 2 {
                    // Step 3: Confirmation
                    VStack(spacing: 24) {
                        Spacer()
                        
                        Text("🤔")
                            .font(.system(size: 80))
                        
                        Text("Dari apa yang telah terjadi ini,\njadi apa yang kamu rasakan?")
                            .font(.system(size: 20, weight: .medium))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            showingConfusedSheet = false
                            confusedStep = 0
                            confusedInput = ""
                            beforeYouBeginText = nil
                        }) {
                            Text("Kembali ke pilihan")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                    .background(Color.black.opacity(0.9))
                } else if confusedStep == 1 {
                    // Step 2: Suggestions (directly go to reflection or back to grid)
                    VStack(spacing: 24) {
                        Text("Berdasarkan tulisanmu,\nmungkin kamu merasa:")
                            .font(.system(size: 20, weight: .medium))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.top, 40)
                        
                        if suggestedEmotions.isEmpty {
                            // No suggestions - go directly to grid
                            Button(action: {
                                showingConfusedSheet = false
                                confusedStep = 0
                                confusedInput = ""
                                beforeYouBeginText = nil
                            }) {
                                Text("Pilih emosi")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal, 24)
                        } else {
                            // Show suggestion chips in a 3-column grid
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(suggestedEmotions) { emotion in
                                    suggestionChipLarge(emotion)
                                }
                            }
                            .padding(.horizontal, 24)
                            
                            Button(action: {
                                beforeYouBeginText = confusedInput
                                showingConfusedSheet = false
                                confusedStep = 0
                                confusedInput = ""
                            }) {
                                Text("Lainnya")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding(.top, 24)
                            }
                        }
                        
                        Spacer()
                    }
                    .background(Color.black.opacity(0.9))
                } else {
                    // Step 1: Input
                    VStack(spacing: 24) {
                        Text("Apa yang sedang terjadi?")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top, 40)
                        
                        Text("Tuliskan apa yang ada di pikiran dan hatimu")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        TextEditor(text: $confusedInput)
                            .scrollContentBackground(.hidden)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                            .frame(maxHeight: 300)
                        
                        Spacer()
                        
                        Button(action: {
                            if !confusedInput.isEmpty {
                                beforeYouBeginText = confusedInput
                                suggestedEmotions = getSuggestedEmotions(from: confusedInput)
                                confusedStep = 1
                            }
                        }) {
                            Text("Lanjutkan")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(confusedInput.isEmpty ? Color.gray : Color.blue)
                                .cornerRadius(12)
                        }
                        .disabled(confusedInput.isEmpty)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                    .background(Color.black.opacity(0.9))
                }
            }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
    
    // MARK: - Suggestion Chip - Large and Prominent
    func suggestionChipLarge(_ emotion: Emotion) -> some View {
        VStack(spacing: 8) {
            Text(emotion.emoji)
                .font(.system(size: 40))
            
            Text(emotion.label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(emotion.color.opacity(0.5))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(emotion.color.opacity(0.8), lineWidth: 2)
        )
        .onTapGesture {
            selectedEmotion = emotion.id
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                navigateToReflection = true
                isLoading = false
                showingConfusedSheet = false
                confusedStep = 0
                confusedInput = ""
            }
        }
    }
    
}

#Preview {
    SelectEmotionView().preferredColorScheme(.dark)
}
