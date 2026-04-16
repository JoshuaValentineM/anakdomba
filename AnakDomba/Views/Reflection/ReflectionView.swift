//
//  ReflectionView.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI

struct ReflectionView: View {
    let selectedEmotion: Emotion
    
    @State private var reflectionText: String = ""
    @State private var selectedVerse: Verse?
    @State private var songs: [Song] = []
    
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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // 1. Ayat Emas (Bible Verse) Component
                if let verse = selectedVerse {
                    VerseCard(verse: verse)
                }
                
                // 2. Pujian (Song) Component - Carousel with page control
                if !songs.isEmpty {
                    SongCarousel(songs: songs)
                }
                
                // 3. Reflection Input
                if let verse = selectedVerse {
                    ReflectionInputBox(text: $reflectionText, emotion: selectedEmotion, verseReference: verse.reference)
                }
                
                DraftAndSaveButton()
                
            }
            .padding()
        }
        .background(backgroundColor)
        .navigationTitle("Refleksi")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            let content = emotionContents[selectedEmotion.label]!
            selectedVerse = content.verses.randomElement()
            songs = content.songs
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

struct ReflectionInputBox: View {
    @Binding var text: String
    let emotion: Emotion
    let verseReference: String
    @State private var showSheet = false
    
    var body: some View {
        let emotionLabel = emotion.label
        let content = emotionContents[emotionLabel]
        let prompt = content?.prompt.replacingOccurrences(of: "[Ayat]", with: verseReference) ?? ""
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Refleksi atas Perasaan " + emotionLabel + "ku")
                .font(.system(size: 24, weight: .semibold))
            
            Text("Tap untuk mengisi bagian [...]")
                .font(.caption)
                .foregroundColor(.secondary)
            
            ZStack(alignment: .topLeading) {
                ScrollView {
                    Text(text.isEmpty ? prompt : text)
                        .font(.body)
                        .fontDesign(.serif)
                        .foregroundColor(text.isEmpty ? .secondary : .primary)
                        .multilineTextAlignment(.leading)
                        .padding(12)
                }
                .frame(alignment: .topLeading)
                .frame(maxHeight: 220)
                .background(.thinMaterial)
                .cornerRadius(16)
                
            }
            .onTapGesture {
                if text.isEmpty {
                    text = prompt
                }
                showSheet = true
            }
        }
        .sheet(isPresented: $showSheet) {
            NavigationStack {
                VStack(spacing: 16) {
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .padding(8)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.top, 8)
                }
                .navigationTitle("Tulis Refleksimu")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Selesai") {
                            showSheet = false
                        }
                    }
                }
            }
            .presentationDetents([.medium, .large])
            
            .onAppear {
                if text.isEmpty {
                    text = prompt
                }
            }
        }
    }
}

struct DraftAndSaveButton: View {
    var body: some View {
        HStack(spacing: 8) {
            Spacer()
            
            PrimaryButton(title: "Save", isEnabled: true, width: 150) {
                print("Save tapped")
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