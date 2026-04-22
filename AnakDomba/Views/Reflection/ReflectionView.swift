//
//  ReflectionView.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI
import SwiftData

private let emotionsList: [Emotion] = [
    Emotion(emoji: "😡", label: "Marah", color: .red),
    Emotion(emoji: "🤔", label: "Ragu", color: .purple),
    Emotion(emoji: "😰", label: "Takut", color: .teal),
    Emotion(emoji: "☹️", label: "Sedih", color: .blue),
    Emotion(emoji: "😊", label: "Senang", color: .yellow),
    Emotion(emoji: "🤢", label: "Jijik", color: .green),
    Emotion(emoji: "😲", label: "Terkejut", color: .orange)
]

struct ReflectionView: View {
    let selectedEmotion: Emotion
    var existingReflection: UserReflection? = nil
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var presenceText: String = ""
    @State private var gratitudeText: String = ""
    @State private var reviewText: String = ""
    @State private var verseReflectionText: String = ""
    @State private var songReflectionText: String = ""
    @State private var actionText: String = ""
    
    @State private var selectedVerse: Verse?
    @State private var songs: [Song] = []
    @State private var showDiscardAlert = false
    @State private var showSaveModal = false
    @State private var savedReflection: UserReflection?
    @State private var isEditingMode: Bool = false
    @State private var currentStep: Int = 0
    
    private var hasChanges: Bool {
        !gratitudeText.isEmpty || !reviewText.isEmpty || !verseReflectionText.isEmpty || !songReflectionText.isEmpty || !actionText.isEmpty
    }
    
    private func saveReflection() {
        guard let verse = selectedVerse,
              let song = songs.first else { return }
        
        if isEditingMode, let existing = savedReflection {
            existing.gratitudeText = gratitudeText
            existing.reviewText = reviewText
            existing.verseReflectionText = verseReflectionText
            existing.songReflectionText = songReflectionText
            existing.actionText = actionText
            do {
                try modelContext.save()
                showSaveModal = true
            } catch {
                print("Failed to update: \(error)")
            }
        } else {
            let reflection = UserReflection(
                emotionLabel: selectedEmotion.label,
                emotionEmoji: selectedEmotion.emoji,
                verseReference: verse.reference,
                verseText: verse.text,
                songTitle: song.title,
                songArtist: song.artist,
                presenceText: presenceText,
                gratitudeText: gratitudeText,
                reviewText: reviewText,
                verseReflectionText: verseReflectionText,
                songReflectionText: songReflectionText,
                actionText: actionText
            )
            modelContext.insert(reflection)
            do {
                try modelContext.save()
                showSaveModal = true
            } catch {
                print("Failed to save: \(error)")
            }
        }
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
    
    var body: some View {
        VStack(spacing: 0) {
            
            ScrollView{
                // Verse & Song - Always visible
                VStack(spacing: 16) {
                    if let verse = selectedVerse {
                        VerseCard(verse: verse)
                    }
                    if !songs.isEmpty {
                        SongCarousel(songs: songs)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                
                
                // Title & Pagination
                HStack {
                    Text("Refleksi atas Perasaan " + selectedEmotion.label + "ku")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text("\(currentStep + 1)/6")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                // Wizard Steps
                ScrollView {
                    VStack(spacing: 24) {
                        WizardStepView(
                            step: currentStep,
                            emotion: selectedEmotion,
                            presenceText: $presenceText,
                            gratitudeText: $gratitudeText,
                            reviewText: $reviewText,
                            verseReflectionText: $verseReflectionText,
                            songReflectionText: $songReflectionText,
                            actionText: $actionText,
                            currentStep: $currentStep,
                            onSave: { saveReflection() }
                        )
                    }
                    .padding(.horizontal)
                }
            }
            
            
        }
        .background(backgroundColor)
        .navigationTitle("Refleksi")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    showDiscardAlert = true
                }) {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Simpan") {
                    saveReflection()
                }
            }
        }
        .alert("Apakah kamu yakin ingin keluar?", isPresented: $showDiscardAlert) {
            Button("Tidak", role: .cancel) {}
            Button("Keluar", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("Perubahan kamu tidak akan tersimpan jika kamu keluar sebelum menyimpan data.")
        }
        .sheet(isPresented: $showSaveModal) {
            VStack(spacing: 20) {
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 56))
                    .foregroundColor(.green)
                
                Text("Tersimpan!")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Refleksi kamu telah disimpan ke riwayat.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                
                Spacer()
                
                VStack(spacing: 12) {
                    PrimaryButton(title: "Tutup Refleksi", isEnabled: true, color: .blue) {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button("Lanjutkan Refleksi") {
                        showSaveModal = false
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.vertical, 12)
                }
                .padding(.horizontal)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            if let existing = existingReflection {
                isEditingMode = true
                presenceText = existing.presenceText
                gratitudeText = existing.gratitudeText
                reviewText = existing.reviewText
                verseReflectionText = existing.verseReflectionText
                songReflectionText = existing.songReflectionText
                actionText = existing.actionText
                savedReflection = existing
                
                if let matchedEmotion = emotionsList.first(where: { $0.label == existing.emotionLabel }) {
                    let content = emotionContents[matchedEmotion.label]
                    selectedVerse = content?.verses.first { $0.reference == existing.verseReference } ?? content?.verses.randomElement()
                    songs = content?.songs ?? []
                }
            } else {
                let content = emotionContents[selectedEmotion.label]!
                selectedVerse = content.verses.randomElement()
                songs = content.songs
                presenceText = content.getPresenceText()
            }
        }
    }
}

// MARK: - Subcomponents

struct VerseCard: View {
    let verse: Verse
    
    var body: some View {
        return VStack(alignment: .leading, spacing: 8) {
            Text(verse.reference)
                .font(.system(size: 28, weight: .semibold))
            
            Text("\"\(verse.text)\"")
                .font(.body)
                .fontDesign(.serif)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .cornerRadius(16)
    }
}

struct SongCard: View {
    let song: Song
    
    var body: some View {
        return HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 50, height: 50)
                .overlay(Image(systemName: "music.note").foregroundColor(.white))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(song.title)
                    .font(.headline)
                Text(song.artist)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(16)
    }
}

struct SongCarousel: View {
    let songs: [Song]
    
    var body: some View {
        TabView {
            ForEach(Array(songs.enumerated()), id: \.offset) { index, song in
                SongCard(song: song)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .frame(height: 100)
    }
}

struct WizardStepView: View {
    let step: Int
    let emotion: Emotion
    
    @Binding var presenceText: String
    @Binding var gratitudeText: String
    @Binding var reviewText: String
    @Binding var verseReflectionText: String
    @Binding var songReflectionText: String
    @Binding var actionText: String
    
    @Binding var currentStep: Int
    let onSave: () -> Void
    
    private let stepTitles = ["Kehadiran", "Syukur", "Refleksi", "Pengajaran", "Ajakan", "Tindakan"]
    
    var body: some View {
        VStack(spacing: 12) {
            // Step Title (no animation)
            HStack {
                Spacer()
                Text("\(stepTitles[step])")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
            }
            
            // Section Divider
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
            
            stepContent
            
            navigationButtons
        }
        .padding()
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
        
    }
    
    @ViewBuilder
    var stepContent: some View {
        switch step {
        case 0: // Kehadiran (Display only - Template)
            VStack(alignment: .leading, spacing: 8) {
                Text(presenceText.isEmpty ? "Tuhan, saat ini aku mengambil waktu sejenak untuk hadir di hadapan-Mu dan menyadari kehadiran-Mu yang tenang di ruangan ini." : presenceText)
                    .font(.body)
                    .fontDesign(.serif)
                    .foregroundColor(.primary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(12)
            }
            
        case 1: // SYUKUR
            WizardTextEditor(
                text: $gratitudeText,
                placeholder: "Tulis hal yang disyukuri..."
            )
            
        case 2: // RENUNGAN
            WizardTextEditor(
                text: $reviewText,
                placeholder: "Apa yang membuatmu merasa \(emotion.label.lowercased())?"
            )
            
        case 3: // PENGAJARAN
            WizardTextEditor(
                text: $verseReflectionText,
                placeholder: "Apa yang diajarkan ayat ini padamu?"
            )
            
        case 4: // AJAKAN
            WizardTextEditor(
                text: $songReflectionText,
                placeholder: "Respons apa yang kamu Undangan kepada Tuhan?"
            )
            
        case 5: // TINDAKAN
            WizardTextEditor(
                text: $actionText,
                placeholder: "Langkah konkret apa yang akan kamu lakukan?"
            )
            
        default:
            EmptyView()
        }
    }
    
    var navigationButtons: some View {
        HStack(spacing: 16) {
            // Back Button - Same style as next
            if step > 0 {
                Button {
                    currentStep -= 1
                } label: {
                    Text("Sebelumnya")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .glassEffect()
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            // Next Button - Glass effect (no Simpan, already in toolbar)
            if step < 5 {
                Button {
                    currentStep += 1
                } label: {
                    Text("Selanjutnya")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .glassEffect()
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.top, 8)
    }
}

struct WizardTextEditor: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .font(.body)
                .fontDesign(.serif)
                .frame(minHeight: 150)
                .padding(8)
                .background(Color.black.opacity(0.3))
                .cornerRadius(12)
                .overlay(
                    Group {
                        if text.isEmpty {
                            Text(placeholder)
                                .font(.body)
                                .fontDesign(.serif)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 16)
                                .allowsHitTesting(false)
                        }
                    },
                    alignment: .topLeading
                )
        }
    }
}

struct ReflectionInputBox: View {
    let emotion: Emotion
    let verseReference: String
    
    @Binding var presenceText: String
    @Binding var gratitudeText: String
    @Binding var reviewText: String
    @Binding var verseReflectionText: String
    @Binding var songReflectionText: String
    @Binding var actionText: String
    
    @State private var editingSection: Int? = nil
    
    var body: some View {
        let emotionLabel = emotion.label
        let content = emotionContents[emotionLabel]
        let presenceTemplate = content?.getPresenceText() ?? ""
        let sections = content?.sections ?? []
        
        VStack(alignment: .leading, spacing: 24) {
            Text("Refleksi atas Perasaan " + emotionLabel + "ku")
                .font(.system(size: 24, weight: .semibold))
            
            // Section 1: Kehadiran (Display only - no box)
            Text(presenceText.isEmpty ? presenceTemplate : presenceText)
                .font(.body)
                .fontDesign(.serif)
                .foregroundColor(.secondary)
                .padding(.vertical, 8)
            
            // Sections 2-6: Editable fields with boxes
            ReflectionSectionField(
                title: sections.count > 0 ? sections[0].title : "SYUKUR",
                placeholder: sections.count > 0 ? sections[0].placeholder : "Tulis...",
                text: $gratitudeText,
                isEditing: editingSection == 1,
                onTap: { editingSection = 1 }
            )
            
            ReflectionSectionField(
                title: sections.count > 1 ? sections[1].title : "RENUNGAN",
                placeholder: sections.count > 1 ? sections[1].placeholder : "Tulis...",
                text: $reviewText,
                isEditing: editingSection == 2,
                onTap: { editingSection = 2 }
            )
            
            ReflectionSectionField(
                title: sections.count > 2 ? sections[2].title : "PENGAJARAN",
                placeholder: sections.count > 2 ? sections[2].placeholder : "Tulis...",
                text: $verseReflectionText,
                isEditing: editingSection == 3,
                onTap: { editingSection = 3 }
            )
            
            ReflectionSectionField(
                title: sections.count > 3 ? sections[3].title : "AJAKAN",
                placeholder: sections.count > 3 ? sections[3].placeholder : "Tulis...",
                text: $songReflectionText,
                isEditing: editingSection == 4,
                onTap: { editingSection = 4 }
            )
            
            ReflectionSectionField(
                title: sections.count > 4 ? sections[4].title : "TINDAKAN",
                placeholder: sections.count > 4 ? sections[4].placeholder : "Tulis...",
                text: $actionText,
                isEditing: editingSection == 5,
                onTap: { editingSection = 5 }
            )
        }
        .onAppear {
            if presenceText.isEmpty {
                presenceText = presenceTemplate
            }
        }
    }
}

struct ReflectionSectionField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let isEditing: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
            
            if isEditing {
                VStack(spacing: 0) {
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .font(.body)
                        .fontDesign(.serif)
                        .frame(minHeight: 100)
                        .padding(8)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(12)
                }
            } else {
                ZStack(alignment: .topLeading) {
                    ScrollView {
                        Text(text.isEmpty ? placeholder : text)
                            .font(.body)
                            .fontDesign(.serif)
                            .foregroundColor(text.isEmpty ? .secondary : .primary)
                            .multilineTextAlignment(.leading)
                            .padding(12)
                    }
                    .frame(minHeight: 80)
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }
                .onTapGesture(perform: onTap)
            }
        }
    }
}

struct DraftAndSaveButton: View {
    let reflectionText: String
    let selectedEmotion: Emotion
    let selectedVerse: Verse?
    let songs: [Song]
    let modelContext: ModelContext
    let onSave: () -> Void
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Spacer()
            
            PrimaryButton(title: "Simpan", isEnabled: true) {
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
                
                modelContext.insert(reflection)
                do {
                    try modelContext.save()
                    onSave()
                    isPresented = true
                } catch {
                    print("Failed to save: \(error)")
                }
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        ReflectionView(selectedEmotion: Emotion(emoji: "😡", label: "Marah", color: .red))
            .preferredColorScheme(.dark)
    }
}
