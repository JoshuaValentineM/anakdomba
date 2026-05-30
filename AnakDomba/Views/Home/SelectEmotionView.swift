//
//  SelectEmotion.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI

struct SelectEmotionView: View {
    let onNavigateToReflection: (Emotion) -> Void
    
    // MARK: - State
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var selectedEmotion: UUID?
    @State private var isLoading = false
    @State private var flippedEmotionID: UUID?
    @State private var suppressedTapEmotionID: UUID?
    
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
    
    private var selectedEmotionValue: Emotion? {
        getSelectedEmotion()
    }
    
    private var selectedAccentColor: Color {
        selectedEmotionValue?.color ?? .blue
    }
    
    private var selectedButtonColor: Color {
        AppTheme.primaryButtonTint(for: selectedEmotionValue, scheme: colorScheme)
    }
    
    private var emotionDisplayKeywords: [String: String] {
        [
            "Senang": "Bersyukur, bahagia, terharu",
            "Sedih": "Kecewa, kehilangan, lelah",
            "Marah": "Kesal, sakit hati, geram",
            "Jijik": "Muak, terganggu, tidak nyaman",
            "Ragu": "Bingung, bimbang, tidak yakin",
            "Terkejut": "Kaget, heran, takjub",
            "Takut": "Cemas, khawatir, gugup",
            "Tidak yakin": "Sulit menggambarkan perasaan"
        ]
    }
    
    private var emotionDescriptions: [String: String] {
        [
            "Senang": "Hati terasa ringan, penuh syukur, atau menikmati kebaikan Tuhan.",
            "Sedih": "Hati terasa berat karena kehilangan, kekecewaan, atau luka batin.",
            "Marah": "Ada rasa tidak adil, sakit hati, atau frustrasi yang menggelegak.",
            "Jijik": "Ada sesuatu yang terasa mengganggu, kotor, atau membuatmu menjauh.",
            "Ragu": "Pikiran penuh pertimbangan dan belum yakin harus melangkah ke mana.",
            "Terkejut": "Saat sesuatu datang tiba-tiba dan membuat hati atau pikiran terhenyak.",
            "Takut": "Saat ada rasa cemas, khawatir, atau ancaman yang membuatmu tidak tenang.",
            "Tidak yakin": "Saat perasaanmu campur aduk dan sulit diberi satu nama yang jelas."
        ]
    }
    
    private var pageTintOpacity: Double {
        selectedEmotionValue == nil ? 0 : (colorScheme == .dark ? 0.18 : 0.2)
    }
    
    private func isEmotionFlipped(_ emotion: Emotion) -> Bool {
        flippedEmotionID == emotion.id
    }
    
    private func toggleEmotionCard(_ emotion: Emotion) {
        let animation: Animation? = reduceMotion
            ? .easeInOut(duration: 0.12)
            : .easeInOut(duration: 0.16)
        
        withAnimation(animation) {
            if flippedEmotionID == emotion.id {
                flippedEmotionID = nil
            } else {
                flippedEmotionID = emotion.id
            }
        }
        
        suppressedTapEmotionID = emotion.id
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.07) {
            if suppressedTapEmotionID == emotion.id {
                suppressedTapEmotionID = nil
            }
        }
    }
    
    var body: some View {
        ZStack {
            AppTheme.baseBackground(for: colorScheme)
                .ignoresSafeArea()
            
            LinearGradient(
                colors: [
                    selectedAccentColor.opacity(pageTintOpacity),
                    Color.clear
                ],
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Pilih yang sesuai dengan perasaanmu.")
                        .font(.title2)
                        .foregroundStyle(.primary)
                    
                    Text("Tahan untuk melihat detail perasaan.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
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
                    .padding(.bottom, 110)
                }
            }
            .padding()
            .navigationTitle("Bagaimana wajahmu saat ini?")
            .navigationBarTitleDisplayMode(.inline)
            //            .toolbar(.hidden, for: .tabBar)
            //            .persistentSystemOverlays(.hidden)
            if isLoading {
                LoaderView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: isLoading)
        .safeAreaInset(edge: .bottom) {
                    PrimaryButton(
                        title: "Mulai",
                        isEnabled: selectedEmotion != nil,
                        color: selectedButtonColor,
                        width: 300
                    ) {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        
                        isLoading = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    if let emotion = getSelectedEmotion() {
                        onNavigateToReflection(emotion)
                    }
                    isLoading = false // reset so when coming back it's normal
                }
            }
            .padding(.bottom, 16)
            .background(Color.clear)
        }
        .sheet(isPresented: $showingConfusedSheet) {
            confusedFlowSheet
                .presentationDetents([.medium, .large])
        }
    }
    
    struct LoaderView: View {
        @Environment(\.colorScheme) private var colorScheme
        
        var body: some View {
            ZStack {
                AppTheme.scrim(for: colorScheme)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.5)
                    
                    Text("Menyiapkan refleksimu...")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(AppTheme.cardElevatedBackground(for: colorScheme))
                )
                .glassEffect()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
                )
            }
        }
    }
    
    // MARK: - Emotion Box Component
    func emotionBox(_ emotion: Emotion) -> some View {
        let isSelected = selectedEmotion == emotion.id
        let keywordText = emotionDisplayKeywords[emotion.label] ?? ""
        let descriptionText = emotionDescriptions[emotion.label] ?? ""
        let isFlipped = isEmotionFlipped(emotion)
        
        return ZStack(alignment: .topTrailing) {
            Group {
                if isFlipped {
                    emotionCardBack(
                        emotion: emotion,
                        descriptionText: descriptionText,
                        keywordText: keywordText
                    )
                } else {
                    emotionCardFront(emotion: emotion)
                }
            }
            .rotation3DEffect(
                .degrees(reduceMotion ? 0 : (isFlipped ? 180 : 0)),
                axis: (x: 0, y: 1, z: 0)
            )
        }
        .frame(width: 150, height: 150)
        .background {
            RoundedRectangle(cornerRadius: 18)
                .fill(AppTheme.cardBackground(for: colorScheme))
            RoundedRectangle(cornerRadius: 18)
                .fill(AppTheme.emotionCardFill(accentColor: emotion.color, isSelected: isSelected, scheme: colorScheme))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(AppTheme.emotionCardStroke(accentColor: emotion.color, isSelected: isSelected, scheme: colorScheme), lineWidth: 1.2)
        )
        .shadow(color: AppTheme.emotionCardShadow(accentColor: emotion.color, isSelected: isSelected, scheme: colorScheme), radius: 16, y: 8)
        .scaleEffect(isSelected ? 1.03 : 1.0)
        .contentShape(RoundedRectangle(cornerRadius: 18))
        .onTapGesture {
            if suppressedTapEmotionID == emotion.id || isFlipped {
                return
            }
            
            if emotion.label == "Tidak yakin" {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                flippedEmotionID = nil
                showingConfusedSheet = true
            } else {
                flippedEmotionID = nil
                selectedEmotion = emotion.id
            }
        }
        .onLongPressGesture(minimumDuration: 0.03) {
            toggleEmotionCard(emotion)
        }
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(emotion.label == "Tidak yakin" ? "Memilih bantuan memilih emosi. Tahan untuk melihat detail perasaan." : "Memilih emosi ini. Tahan untuk melihat detail perasaan.")
        .animation(.spring(response: 0.25, dampingFraction: 0.8), value: selectedEmotion)
    }
    
    func emotionCardFront(emotion: Emotion) -> some View {
        VStack(spacing: 12) {
            Spacer(minLength: 0)
            
            Text(emotion.emoji)
                .font(.system(size: 56))
            
            Text(emotion.label)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(colorScheme == .dark ? AppTheme.inverseText(for: colorScheme) : .primary)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func emotionCardBack(emotion: Emotion, descriptionText: String, keywordText: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(emotion.label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(colorScheme == .dark ? AppTheme.inverseText(for: colorScheme) : .primary)
            
            Text(descriptionText)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(colorScheme == .dark ? AppTheme.secondaryInverseText(for: colorScheme) : .secondary)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 0)
            
            Text(keywordText)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(colorScheme == .dark ? Color.white.opacity(0.72) : .secondary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .padding(14)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .rotation3DEffect(
            .degrees(reduceMotion ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
    }
    
    func getSelectedEmotion() -> Emotion? {
        return emotions.first { $0.id == selectedEmotion }
    }
    
    private var confusedSheetBackground: some View {
        ZStack {
            AppTheme.baseBackground(for: colorScheme)
            Rectangle()
                .fill(.ultraThinMaterial)
            LinearGradient(
                colors: [
                    selectedAccentColor.opacity(AppTheme.screenTintOpacity(for: colorScheme, emphasized: true)),
                    Color.clear
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .ignoresSafeArea()
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
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button(action: {
                            showingConfusedSheet = false
                            confusedStep = 0
                            confusedInput = ""
                            beforeYouBeginText = nil
                        }) {
                                Text("Kembali ke pilihan")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(AppTheme.inverseText(for: colorScheme))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(AppTheme.primaryButtonTint(for: nil, scheme: colorScheme))
                                    .cornerRadius(12)
                            }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                    .background(confusedSheetBackground)
                } else if confusedStep == 1 {
                    // Step 2: Suggestions (directly go to reflection or back to grid)
                    VStack(spacing: 24) {
                        if suggestedEmotions.isEmpty {
                            Spacer()
                            
                            VStack(spacing: 14) {
                                Image(systemName: "sparkles.rectangle.stack")
                                    .font(.system(size: 34))
                                    .foregroundStyle(colorScheme == .dark ? Color.white.opacity(0.9) : .primary)
                                
                                Text("Belum ada perasaan yang cukup cocok dari ceritamu.")
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                    .multilineTextAlignment(.center)
                                
                                Text("Coba pilih secara manual supaya kamu tetap bisa mulai refleksi.")
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.horizontal, 24)
                            
                            Button(action: {
                                showingConfusedSheet = false
                                confusedStep = 0
                                confusedInput = ""
                                beforeYouBeginText = nil
                            }) {
                                Text("Kembali pilih perasaan")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(AppTheme.inverseText(for: colorScheme))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(AppTheme.primaryButtonTint(for: nil, scheme: colorScheme))
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal, 24)
                        } else {
                            Text("Berdasarkan tulisanmu,\nmungkin kamu merasa:")
                                .font(.system(size: 20, weight: .medium))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.primary)
                                .padding(.top, 40)
                            
                            if suggestedEmotions.count == 1 {
                                HStack {
                                    Spacer()
                                    suggestionChipLarge(suggestedEmotions[0])
                                        .frame(maxWidth: 140)
                                    Spacer()
                                }
                                .padding(.horizontal, 24)
                            } else if suggestedEmotions.count == 2 {
                                HStack(spacing: 16) {
                                    ForEach(suggestedEmotions) { emotion in
                                        suggestionChipLarge(emotion)
                                            .frame(maxWidth: 140)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.horizontal, 24)
                            } else {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                    ForEach(suggestedEmotions) { emotion in
                                        suggestionChipLarge(emotion)
                                    }
                                }
                                .padding(.horizontal, 24)
                            }
                            
                            Text("Atau")
                                .font(.body)
                                .foregroundStyle(.secondary)
                            
                            Button(action: {
                                beforeYouBeginText = confusedInput
                                showingConfusedSheet = false
                                confusedStep = 0
                                confusedInput = ""
                            }) {
                                Text("Kembali ke pilih perasaan")
                                    .font(.body)
                                    .foregroundColor(AppTheme.primaryButtonTint(for: nil, scheme: colorScheme))
                            }
                        }
                        
                        Spacer()
                    }
                    .background(confusedSheetBackground)
                } else {
                    // Step 1: Input
                    VStack(spacing: 24) {
                        Text("Apa yang sedang terjadi?")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.top, 40)
                        
                        Text("Tuliskan apa yang ada di pikiran dan hatimu")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        
                        TextEditor(text: $confusedInput)
                            .scrollContentBackground(.hidden)
                            .background(AppTheme.cardElevatedBackground(for: colorScheme))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
                            )
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
                                .foregroundColor(confusedInput.isEmpty ? .secondary : AppTheme.inverseText(for: colorScheme))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(confusedInput.isEmpty ? AppTheme.tertiaryBackground(for: colorScheme) : AppTheme.primaryButtonTint(for: nil, scheme: colorScheme))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: confusedInput.isEmpty ? 1 : 0)
                                )
                                .cornerRadius(12)
                        }
                        .disabled(confusedInput.isEmpty)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                    .background(confusedSheetBackground)
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
                .foregroundColor(AppTheme.inverseText(for: colorScheme))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.suggestionFill(accentColor: emotion.color, scheme: colorScheme))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.suggestionStroke(accentColor: emotion.color, scheme: colorScheme), lineWidth: 2)
        )
        .onTapGesture {
            selectedEmotion = emotion.id
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                onNavigateToReflection(emotion)
                isLoading = false
                showingConfusedSheet = false
                confusedStep = 0
                confusedInput = ""
            }
        }
    }
    
}

#Preview {
    SelectEmotionView { _ in }
        .preferredColorScheme(.dark)
}
