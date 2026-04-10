//
//  ReflectionView.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI

struct ReflectionView: View {
    // @State is used here because the text the user types will change over time,
    // and SwiftUI needs to watch this variable to update the UI.
    let selectedEmotion: Emotion
    
    @State private var reflectionText: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // 1. Ayat Emas (Bible Verse) Component
                VerseCard(emotion: selectedEmotion)
                
                // 2. Pujian (Song) Component
                SongCard(emotion: selectedEmotion)
                
                // 3. Reflection Input
                ReflectionInputBox(text: $reflectionText)
                
            }
            .padding()
        }
        .navigationTitle("Refleksi")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Subcomponents
// Extracting these makes your main view clean and easy to read!

// MARK: - Content Data
struct EmotionContent {
    let verse: String
    let verseReference: String
    let songTitle: String
    let songArtist: String
}

let emotionContents: [String: EmotionContent] = [
    "Senang": EmotionContent(
        verse: "Sebab Aku ini mengetahui rancangan-rancangan apa yang ada pada-Ku mengenai kamu, demikianlah firman TUHAN, yaitu rancangan damai sejahtera dan bukan rancangan kecelakaan, untuk memberikan kepadamu hari depan yang penuh harapan.",
        verseReference: "Yeremia 29:11",
        songTitle: "Bapa Yang Kekal",
        songArtist: "Symphony Worship"
    ),
    "Sedih": EmotionContent(
        verse: "Tuhan dekat pada mereka yang patah hati, dan Ia menyelamatkan mereka yang remuk rukunnya.",
        verseReference: "Mazmur 34:19",
        songTitle: "Sang Raja Agung",
        songArtist: "Betharia Sonatha"
    ),
    "Marah": EmotionContent(
        verse: "Hendaklah kamu masing-masing segera meninggalkan apa yang menyedihkan hati-Mu.",
        verseReference: "Yohanes 2:16",
        songTitle: "Luhur",
        songArtist: "Abbah"
    ),
    "Jijik": EmotionContent(
        verse: "Berbaktilah kepada-Ku dengan kasih-Mu, janganlah menghancurkan orang-orang yang hidup karena Engkaulah yang menghidupkan mereka semua.",
        verseReference: "Wahyu 11:18",
        songTitle: "Hidup Ini Indah",
        songArtist: "Gading Marten"
    ),
    "Ragu": EmotionContent(
        verse: "Jangan kuatir tentang apa pun juga, melainkan dalam segalanya dengan doamu dan pengucapan syukur, mintalah apa yang kamu mau dan kamu perlukan.",
        verseReference: "Filipi 4:6",
        songTitle: "Tetap Berharap",
        songArtist: "Jecko Tambun"
    ),
    "Terkejut": EmotionContent(
        verse: "Tanganku telah mengertakkan seluruh bumi, mereka merobohkan dindingnya dan menewaskan bentengnya.",
        verseReference: "Yeremia 51:53",
        songTitle: "Takkan Ada",
        songArtist: "Natasha"
    ),
    "Takut": EmotionContent(
        verse: "Jangan takut, sebab Aku menyertai engka; jangan gelisah, sebab Aku adalah Allahmu; Aku akan memperkuatkan tanganmu dan melindungi engka.",
        verseReference: "Yesaya 41:10",
        songTitle: "Engkaulah",
        songArtist: "Novita"
    )
]

struct VerseCard: View {
    let emotion: Emotion
    
    var body: some View {
        let content = emotionContents[emotion.label]!
        
        return VStack(alignment: .leading, spacing: 8) {
            Text("Ayat Emas")
                .font(.headline)
                .foregroundColor(.blue)
            
            Text("\"\(content.verse)\"")
                .font(.body)
                .italic()
            
            Text(content.verseReference)
                .font(.caption)
                .bold()
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(16)
    }
}

struct SongCard: View {
    let emotion: Emotion
    
    var body: some View {
        let content = emotionContents[emotion.label]!
        
        return HStack(spacing: 16) {
            // Placeholder for Album Art
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.3))
                .frame(width: 60, height: 60)
                .overlay(Image(systemName: "music.note").foregroundColor(.white))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(content.songTitle)
                    .font(.headline)
                Text(content.songArtist)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "play.circle.fill")
                .font(.system(size: 32))
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(16)
    }
}

struct ReflectionInputBox: View {
    // We use @Binding here because this view doesn't "own" the data.
    // It's just modifying the 'reflectionText' that lives in the parent ReflectionView.
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Berceritalah...")
                .font(.headline)
            
            // TextEditor provides multi-line text input natively in SwiftUI
            TextEditor(text: $text)
                .frame(minHeight: 150)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                // Adds a subtle border
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

#Preview {
    NavigationStack {
        ReflectionView(selectedEmotion: Emotion(emoji: "😊", label: "Senang"))
            .preferredColorScheme(.dark)
    }
}