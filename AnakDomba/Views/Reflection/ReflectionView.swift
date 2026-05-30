//
//  ReflectionView.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI
import SwiftData

extension Notification.Name {
    static let reflectionDidSave = Notification.Name("reflectionDidSave")
}

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
    var onCloseToHome: (() -> Void)? = nil
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
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
    
    private func displayedSongs(from allSongs: [Song], preferredSong: Song? = nil) -> [Song] {
        guard !allSongs.isEmpty else { return [] }
        
        if let preferredSong {
            let remainingSongs = allSongs.filter { $0 != preferredSong }.shuffled()
            return [preferredSong] + Array(remainingSongs.prefix(2))
        }
        
        return Array(allSongs.shuffled().prefix(3))
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
                NotificationCenter.default.post(name: .reflectionDidSave, object: nil)
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
                savedReflection = reflection
                isEditingMode = true
                NotificationCenter.default.post(name: .reflectionDidSave, object: nil)
                showSaveModal = true
            } catch {
                print("Failed to save: \(error)")
            }
        }
    }
    
    private func closeToHome() {
        showSaveModal = false
        if let onCloseToHome {
            DispatchQueue.main.async {
                onCloseToHome()
            }
        } else {
            dismiss()
        }
    }
    
    private var emotionAccent: Color {
        selectedEmotion.color
    }
    
    private var pageTintOpacity: Double {
        colorScheme == .dark ? 0.5 : 0.2
    }

    private var usesExpandedLayout: Bool {
        horizontalSizeClass == .regular
    }
    
    var body: some View {
        Group {
            if usesExpandedLayout {
                ReflectionPadLayout(
                    emotion: selectedEmotion,
                    selectedVerse: selectedVerse,
                    songs: songs,
                    presenceText: $presenceText,
                    gratitudeText: $gratitudeText,
                    reviewText: $reviewText,
                    verseReflectionText: $verseReflectionText,
                    actionText: $actionText,
                    accentColor: emotionAccent,
                    currentStep: $currentStep
                )
            } else {
                compactLayout
            }
        }
        .background {
            ZStack {
                Color(uiColor: .systemBackground)
                LinearGradient(
                    colors: [
                        emotionAccent.opacity(pageTintOpacity),
                        Color.clear
                    ],
                    startPoint: .top,
                    endPoint: .center
                )
            }
            .ignoresSafeArea()
        }
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
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
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
                    PrimaryButton(
                        title: "Tutup Refleksi",
                        isEnabled: true,
                        color: AppTheme.primaryButtonTint(for: selectedEmotion, scheme: colorScheme)
                    ) {
                        closeToHome()
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button("Lanjutkan Refleksi") {
                        showSaveModal = false
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 12)
                }
                .padding(.horizontal)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppTheme.baseBackground(for: colorScheme))
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
                    
                    let savedSong = content?.songs.first {
                        $0.title == existing.songTitle && $0.artist == existing.songArtist
                    } ?? Song(title: existing.songTitle, artist: existing.songArtist)
                    
                    songs = displayedSongs(from: content?.songs ?? [], preferredSong: savedSong)
                }
            } else {
                let content = emotionContents[selectedEmotion.label]!
                selectedVerse = content.verses.randomElement()
                songs = displayedSongs(from: content.songs)
                presenceText = content.getPresenceText()
            }
        }
    }

    private var compactLayout: some View {
        let sectionTitleContentSpacing: CGFloat = 12
        let sectionBlockSpacing: CGFloat = 16
        
        return VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: sectionBlockSpacing) {
                    if let verse = selectedVerse {
                        VStack(alignment: .leading, spacing: sectionTitleContentSpacing) {
                            Text("Ayat Alkitab")
                                .font(.title2)
                                .bold()
                            VerseCard(verse: verse, accentColor: emotionAccent)
                        }
                    }
                    
                    if !songs.isEmpty {
                        VStack(alignment: .leading, spacing: sectionTitleContentSpacing) {
                            Text("Lagu Rohani")
                                .font(.title2)
                                .bold()
                            SongCarousel(songs: songs, accentColor: emotionAccent)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: sectionTitleContentSpacing) {
                        HStack {
                            Text("Refleksi atas Perasaan " + selectedEmotion.label + "ku")
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                        }
                        
                        WizardStepView(
                            step: currentStep,
                            emotion: selectedEmotion,
                            presenceText: $presenceText,
                            gratitudeText: $gratitudeText,
                            reviewText: $reviewText,
                            verseReflectionText: $verseReflectionText,
                            songReflectionText: $songReflectionText,
                            actionText: $actionText,
                            accentColor: emotionAccent,
                            currentStep: $currentStep,
                            onSave: { saveReflection() }
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
        }
    }
}

// MARK: - Subcomponents

struct VerseCard: View {
    let verse: Verse
    let accentColor: Color
    
    @Environment(\.colorScheme) private var colorScheme
    
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
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardBackground(for: colorScheme))
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.emotionAccentTint(accentColor: accentColor, scheme: colorScheme))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
        )
    }
}

struct SongCard: View {
    let song: Song
    let accentColor: Color
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        return HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 8)
                .fill(colorScheme == .dark ? accentColor.opacity(0.35) : accentColor.opacity(0.28))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "music.note")
                        .foregroundStyle(colorScheme == .dark ? Color.white : Color.primary)
                )
            
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
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardBackground(for: colorScheme))
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.emotionAccentTint(accentColor: accentColor, scheme: colorScheme))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
        )
    }
}

struct SongCarousel: View {
    let songs: [Song]
    let accentColor: Color
    
    var body: some View {
        TabView {
            ForEach(Array(songs.enumerated()), id: \.offset) { _, song in
                VStack(spacing: 0) {
                    SongCard(song: song, accentColor: accentColor)
                    Spacer(minLength: 0)
                }
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
    let accentColor: Color
    
    @Environment(\.colorScheme) private var colorScheme
    @ScaledMetric(relativeTo: .body) private var stepContentMinHeight: CGFloat = 150
    @ScaledMetric(relativeTo: .body) private var stepContentMaxHeight: CGFloat = 150
    
    @Binding var currentStep: Int
    let onSave: () -> Void
    
    private let swipeThreshold: CGFloat = 50
    
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
    
    private var stepProgress: Double {
        guard !stepTitles.isEmpty else { return 0 }
        return Double(step + 1) / Double(stepTitles.count)
    }
    
    private func handleSwipe(_ value: DragGesture.Value) {
        let horizontalDistance = value.translation.width
        let verticalDistance = value.translation.height
        
        guard abs(horizontalDistance) > abs(verticalDistance),
              abs(horizontalDistance) > swipeThreshold else {
            return
        }
        
        if horizontalDistance < 0, currentStep < stepTitles.count - 1 {
            withAnimation(.easeInOut(duration: 0.2)) {
                currentStep += 1
            }
        } else if horizontalDistance > 0, currentStep > 0 {
            withAnimation(.easeInOut(duration: 0.2)) {
                currentStep -= 1
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 12) {
            // Step Title (no animation)
            HStack {
                Spacer()
                Text("\(stepTitles[step])")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
            }
            
            // Step Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(AppTheme.cardStroke(for: colorScheme))
                    
                    Capsule()
                        .fill(accentColor.opacity(0.9))
                        .frame(width: geometry.size.width * stepProgress)
                }
            }
            .frame(height: 8)
            .accessibilityLabel("Progress refleksi")
            .accessibilityValue("\(step + 1) dari \(stepTitles.count)")
            
            ScrollView(.vertical, showsIndicators: true) {
                stepContent
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .frame(
                minHeight: stepContentMinHeight,
                maxHeight: stepContentMaxHeight,
                alignment: .top
            )
            .scrollBounceBehavior(.basedOnSize)
            
            navigationButtons
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.cardElevatedBackground(for: colorScheme))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
        )
        .contentShape(RoundedRectangle(cornerRadius: 12))
        .simultaneousGesture(
            DragGesture(minimumDistance: 20)
                .onEnded(handleSwipe)
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
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(AppTheme.cardBackground(for: colorScheme))
                    )
            }
            
        case 1: // SYUKUR
            WizardTextEditor(
                text: $gratitudeText,
                placeholder: placeholder(forSectionAt: 0, fallback: "Tulis hal yang disyukuri..."),
                accentColor: accentColor
            )
            
        case 2: // Refleksi Diri
            WizardTextEditor(
                text: $reviewText,
                placeholder: placeholder(forSectionAt: 1, fallback: "Apa yang membuatmu merasa \(emotion.label.lowercased())?"),
                accentColor: accentColor
            )
            
        case 3: // Refleksi Ayat
            WizardTextEditor(
                text: $verseReflectionText,
                placeholder: placeholder(forSectionAt: 2, fallback: "Apa yang diajarkan ayat ini padamu?"),
                accentColor: accentColor
            )
            
        case 4: // Resolusi
            WizardTextEditor(
                text: $actionText,
                placeholder: placeholder(forSectionAt: 3, fallback: "Langkah konkret apa yang akan kamu lakukan?"),
                accentColor: accentColor
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
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
            
            // Next Button - Glass effect (no Simpan, already in toolbar)
            if step < stepTitles.count - 1 {
                Button {
                    currentStep += 1
                } label: {
                    Text("Selanjutnya")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .glassEffect()
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.top, 4)
    }
}

struct WizardTextEditor: View {
    @Binding var text: String
    let placeholder: String
    let accentColor: Color
    var minimumHeight: CGFloat? = nil
    var showsPencilHint = false
    
    @Environment(\.colorScheme) private var colorScheme
    @ScaledMetric(relativeTo: .body) private var editorHeight: CGFloat = 150
    
    private var resolvedHeight: CGFloat {
        max(editorHeight, minimumHeight ?? 0)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if showsPencilHint {
                Label("Tulis dengan Apple Pencil atau keyboard.", systemImage: "applepencil.tip")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .font(.body)
                .fontDesign(.serif)
                .textInputAutocapitalization(.sentences)
                .frame(minHeight: resolvedHeight, alignment: .top)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppTheme.cardBackground(for: colorScheme))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
                )
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
    
    @Environment(\.colorScheme) private var colorScheme
    
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
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colorScheme == .dark ? Color.white.opacity(0.05) : Color.black.opacity(0.03))
                        )
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
