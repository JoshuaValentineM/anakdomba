//
//  ReflectionPadLayout.swift
//  AnakDomba
//
//  Created by OpenAI on 30/05/26.
//

import SwiftUI

struct ReflectionPadLayout: View {
    let emotion: Emotion
    let selectedVerse: Verse?
    let songs: [Song]
    
    @Binding var presenceText: String
    @Binding var gratitudeText: String
    @Binding var reviewText: String
    @Binding var verseReflectionText: String
    @Binding var actionText: String
    let accentColor: Color
    
    @Binding var currentStep: Int
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var emotionSections: [ReflectionSection] {
        emotionContents[emotion.label]?.sections ?? []
    }
    
    private var displayedSections: [ReflectionSection] {
        emotionSections.filter { $0.title != "Pengakuan Diri" }
    }
    
    private var stepTitles: [String] {
        ["Saat Teduh"] + displayedSections.map(\.title)
    }
    
    private func placeholder(forSectionAt index: Int, fallback: String) -> String {
        guard displayedSections.indices.contains(index) else {
            return fallback
        }
        
        let placeholder = displayedSections[index].placeholder.trimmingCharacters(in: .whitespacesAndNewlines)
        return placeholder.isEmpty ? fallback : placeholder
    }
    
    private func title(for step: Int) -> String {
        guard stepTitles.indices.contains(step) else {
            return stepTitles.first ?? ""
        }
        
        return stepTitles[step]
    }
    
    private func binding(for step: Int) -> Binding<String> {
        switch step {
        case 1:
            return $gratitudeText
        case 2:
            return $reviewText
        case 3:
            return $verseReflectionText
        case 4:
            return $actionText
        default:
            return .constant("")
        }
    }
    
    private func placeholder(for step: Int) -> String {
        switch step {
        case 1:
            return placeholder(forSectionAt: 0, fallback: "Tulis hal yang disyukuri...")
        case 2:
            return placeholder(forSectionAt: 1, fallback: "Apa yang membuatmu merasa \(emotion.label.lowercased())?")
        case 3:
            return placeholder(forSectionAt: 2, fallback: "Apa yang diajarkan ayat ini padamu?")
        case 4:
            return placeholder(forSectionAt: 3, fallback: "Langkah konkret apa yang akan kamu lakukan?")
        default:
            return ""
        }
    }
    
    private func selectStep(_ step: Int) {
        withAnimation(.easeInOut(duration: 0.2)) {
            currentStep = step
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let columnSpacing: CGFloat = 24
            let leftColumnWidth = min(max(geometry.size.width * 0.34, 320), 440)
            let editorHeight = max(geometry.size.height - 260, 320)
            
            HStack(alignment: .top, spacing: columnSpacing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Refleksi atas Perasaan \(emotion.label)ku")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("Mode iPad dibuat lebih lega supaya menulis dengan Apple Pencil terasa natural.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                        
                        if let verse = selectedVerse {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Ayat Alkitab")
                                    .font(.title2)
                                    .bold()
                                VerseCard(verse: verse, accentColor: accentColor)
                            }
                        }
                        
                        if !songs.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Lagu Rohani")
                                    .font(.title2)
                                    .bold()
                                SongCarousel(songs: songs, accentColor: accentColor)
                                    .frame(height: 120)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(24)
                }
                .frame(width: leftColumnWidth)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(AppTheme.cardElevatedBackground(for: colorScheme))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
                )
                
                VStack(alignment: .leading, spacing: 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Array(stepTitles.enumerated()), id: \.offset) { index, stepTitle in
                                Button {
                                    selectStep(index)
                                } label: {
                                    Text(stepTitle)
                                        .font(.headline)
                                        .foregroundStyle(index == currentStep ? AppTheme.inverseText(for: colorScheme) : .primary)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 12)
                                        .background(
                                            Capsule()
                                                .fill(index == currentStep ? accentColor : AppTheme.cardBackground(for: colorScheme))
                                        )
                                        .overlay(
                                            Capsule()
                                                .stroke(index == currentStep ? accentColor : AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 2)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text(title(for: currentStep))
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                            
                            Text("\(currentStep + 1) / \(stepTitles.count)")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                        }
                        
                        if currentStep == 0 {
                            Text(presenceText)
                                .font(.body)
                                .fontDesign(.serif)
                                .frame(maxWidth: .infinity, minHeight: editorHeight, alignment: .topLeading)
                                .padding(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(AppTheme.cardBackground(for: colorScheme))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
                                )
                        } else {
                            WizardTextEditor(
                                text: binding(for: currentStep),
                                placeholder: placeholder(for: currentStep),
                                accentColor: accentColor,
                                minimumHeight: editorHeight,
                                showsPencilHint: true
                            )
                        }
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(AppTheme.cardElevatedBackground(for: colorScheme))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
                    )
                    
                    HStack(spacing: 16) {
                        Button("Sebelumnya") {
                            guard currentStep > 0 else { return }
                            selectStep(currentStep - 1)
                        }
                        .disabled(currentStep == 0)
                        
                        Spacer()
                        
                        Button(currentStep == stepTitles.count - 1 ? "Selesai Menulis" : "Selanjutnya") {
                            guard currentStep < stepTitles.count - 1 else { return }
                            selectStep(currentStep + 1)
                        }
                        .disabled(currentStep == stepTitles.count - 1)
                    }
                    .font(.headline)
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .padding(24)
        }
    }
}
