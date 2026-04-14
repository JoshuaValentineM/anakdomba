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
    
    var backgroundColor: Color {
        switch selectedEmotion.label {
        case "Senang": return .yellow.opacity(0.6)
        case "Sedih": return .blue.opacity(0.6)
        case "Marah": return .red.opacity(0.6)
        case "Jijik": return .green.opacity(0.6)
        case "Ragu": return .purple.opacity(0.6)
        case "Terkejut": return .orange.opacity(0.6)
        case "Takut": return .gray.opacity(0.6)
        default: return .black
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // 1. Ayat Emas (Bible Verse) Component
                VerseCard(emotion: selectedEmotion)
                
                // 2. Pujian (Song) Component
                SongCard(emotion: selectedEmotion)
                
                // 3. Reflection Input
                ReflectionInputBox(text: $reflectionText, emotion: selectedEmotion)
                
                DraftAndSaveButton()
                
            }
            .padding()
            .frame(maxHeight: 650)
        }
        .background(backgroundColor)
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
    let prompt: String
}

let emotionContents: [String: EmotionContent] = [
    "Senang": EmotionContent(
        verse: "Sebab Aku ini mengetahui rancangan-rancangan apa yang ada pada-Ku mengenai kamu, demikianlah firman TUHAN, yaitu rancangan damai sejahtera dan bukan rancangan kecelakaan, untuk memberikan kepadamu hari depan yang penuh harapan.",
        verseReference: "Yeremia 29:11",
        songTitle: "Bapa Yang Kekal",
        songArtist: "Symphony Worship",
        prompt: """
        Tuhan, saat ini aku menyadari kehadiran-Mu di dekatku, merasakan kehangatan kasih-Mu yang menyelimuti diriku.
        
        Hatiku meluap dengan rasa syukur, terima kasih karena hari ini Engkau telah memberkatiku melalui [...].
        
        Aku menelusuri hariku, dan sungguh aku merasa [Senang/Bersukacita] hari ini karena [...] dan aku melihat jelas campur tangan-Mu di dalamnya.
        
        Melalui Filipi 4:4, aku disingatkan untuk bersukacita senantiasa di dalam Tuhan, namun aku merefleksikan dan menyadari bahwa di saat-saat senang ini pun aku kadang lupa bersyukur, dan aku memohon ampun untuk [...].
        
        Tuhan, aku mengundang-Mu untuk terus berjalan bersamaku esok hari. Agar sukacita ini tidak berhenti padaku saja dan bisa menjadi berkat bagi orang lain, esok aku akan melakukan [...].
        """
    ),
    "Sedih": EmotionContent(
        verse: "Tuhan dekat pada mereka yang patah hati, dan Ia menyelamatkan mereka yang remuk rukunnya.",
        verseReference: "Mazmur 34:19",
        songTitle: "Sang Raja Agung",
        songArtist: "Betharia Sonatha",
        prompt: """
        Tuhan, saat ini aku mengambil waktu sejenak untuk hadir di hadapan-Mu dan menyadari penyertaan-Mu yang tenang di ruangan ini.
        
        Meskipun hatiku sedang berat, aku ingin tetap berterima kasih kepada-Mu karena hari ini Engkau telah [...].
        
        Namun, aku ingin jujur di hadapan-Mu, hari ini aku merasa [Sedih/Kecewa], karena [...] dan rasanya sangat menyakitkan bagiku.
        
        Melalui Mazmur 118:8, aku seringkau untuk [...], dan aku menyadari bahwa selama ini aku mungkin terlalu [...].
        
        Aku mengundang-Mu untuk menyertai langkahku esok hari, dan sebagai wujud nyataku untuk lebih mengandalkan-Mu. Atas kejadian ini, aku akan melakukan [...] untuk menjaga hatiku tetap teguh di dalam-Mu.
        """
    ),
    "Marah": EmotionContent(
        verse: "Hendaklah kamu masing-masing segera meninggalkan apa yang menyedihkan hati-Mu.",
        verseReference: "Yohanes 2:16",
        songTitle: "Luhur",
        songArtist: "Abbah",
        prompt: """
        Tuhan, di tengah emosiku yang bergejolak, aku datang ke hadirat-Mu, memohon ketenangan yang hanya bisa diberikan oleh Roh Kudus-Mu.
        
        Meskipun hatiku sedang panas, aku memilih untuk tetap bersyukur karena hari ini Engkau masih memberiku kebaikan melalui [...].
        
        Tuhan, aku ingin terbuka pada-Mu, hari ini aku merasa [Marah/Kesal] karena [...], dan hal ini sangat mengusik kedamaian di hatiku.
        
        Melalui Efesus 4:26, aku seringkau agar kemarahanku tidak membawaku pada dosa. Aku menyadari bahwa responsku tadi mungkin berlebihan dan aku telah dikuasai oleh [...].
        
        Aku memohon agar Engkau menyertai hariku esok dan melembutkan hatiku. Sebagai langkah pengampunan dan untuk melepaskan amarah ini, aku akan melakukan [...].
        """
    ),
    "Jijik": EmotionContent(
        verse: "Berbaktilah kepada-Ku dengan kasih-Mu, janganlah menghancurkan orang-orang yang hidup karena Engkaulah yang menghidupkan mereka semua.",
        verseReference: "Wahyu 11:18",
        songTitle: "Hidup Ini Indah",
        songArtist: "Gading Marten",
        prompt: """
        Bapa, aku berdiam diri sejenak untuk menyadari kehadiran-Mu yang suci dan kudus di tempat ini, mengelilingiku dengan terang-Mu
        
        Aku berterima kasih karena di tengah dunia yang penuh kekelaman, Engkau tetap memeliharaku dan hari ini Engkau telah [...].
        
        Namun hari ini aku merasa [Jijik/Muak] terhadap sebuah situasi atau hal, yaitu [...], yang membuat batinku merasa sangat tidak nyaman
        
        Melalui Roma 12:9, aku seringkau untuk menjauhi yang jahat dan berpegang pada yang baik. Melalui hal ini, aku menyadari bahwa aku sendiri pun masih sering kompromi dengan [...].
        
        Tuhan, sertailah langkahku esok hari agar aku tidak terseret dalam hal yang tidak berkenan bagi-Mu. Untuk menjaga kekudusan hidup dan pikirku, aku akan [...].
        """
    ),
    "Ragu": EmotionContent(
        verse: "Jangan kuatir tentang apa pun juga, melainkan dalam segalanya dengan doamu dan pengucapan syukur, mintalah apa yang kamu mau dan kamu perlukan.",
        verseReference: "Filipi 4:6",
        songTitle: "Tetap Berharap",
        songArtist: "Jecko Tambun",
        prompt: """
        Tuhan, di tengah kebimbanganku, aku menenangkan diri untuk menyadari bahwa Engkau ada di sini, memegang kendali penuh atas hidupku.
        
        Aku mengucap syukur kepada-Mu, karena meskipun aku tidak mengerti banyak hal, hari ini Engkau tetap setia memberikan [...].
        
        Saat ini aku harus jujur bahwa aku merasa [Ragu/Bimbang] untuk melangkah atau mengambil keputusan, karena [...], dan rasanya aku kehilangan arah.
        
        Melalui Amsal 3:5-6, aku seringkau untuk percaya kepada-Mu dengan segenap hati. Aku sadar bahwa selama ini keraguanku muncul karena aku terlalu mengandalkan [...] daripada berserah pada hikmat-Mu.
        
        Tuhan, pimpinlah dan sertailah aku menghadapi hari esok. Sebagai langkah imanku untuk menepis keraguan ini, aku akan bertindak dengan [...].
        """
    ),
    "Terkejut": EmotionContent(
        verse: "Tanganku telah mengertakkan seluruh bumi, mereka merobohkan dindingnya dan menewaskan bentengnya.",
        verseReference: "Yeremia 51:53",
        songTitle: "Takkan Ada",
        songArtist: "Natasha",
        prompt: """
        Bapa, aku menghentikan aktivitasku sejenak untuk diam di hadirat-Mu, menyadari bahwa bagi-Mu tidak ada sesuatu pun yang mengejutkan atau di luar kendali-Mu.
        
        Aku bersyukur atas kedaulatan-Mu dalam hidupku, dan terima kasih karena hari ini Engkau telah membekaliku dengan [...].
        
        Hari ini aku merasa sangat [Terkejut/Kaget] karena harus melihat atau mengalami [...], sesuatu yang sama sekali tidak aku duga sebelumnya.
        
        Melalui Yeremia 29:11, aku seringkau bahwa rancangan-Mu selalu keberuntungan kebaikan. Namun, insiden hari ini menyadarkanku bahwa aku sering kurang percaya dan mudah kehilangan damai sejahtera ketika rencanaku [...].
        
        Tuhan, aku mengundang-Mu untuk berjalan di depanku esok hari. Menghadapi segala ketidakpastian ini, aku akan merespons dengan cara [...].
        """
    ),
    "Takut": EmotionContent(
        verse: "Jangan takut, sebab Aku menyertai engkau; jangan gelisah, sebab Aku adalah Allahmu; Aku akan memperkuatkan tanganmu dan melindungi engkau.",
        verseReference: "Yesaya 41:10",
        songTitle: "Engkaulah",
        songArtist: "Novita",
        prompt: """
        Tuhan, dalam rasa gentar yang aku rasakan, aku datang berlindung di bawah naungan sayap-Mu, menyadari kehadiran-Mu yang selalu memberikan rasa aman.
        
        Meski ada kekhawatiran yang besar membayangi pikiranku, aku berterima kasih karena hari ini Engkau nyata menyertaiku dan masih memberikan [...].
        
        Aku membawa ketakutku di hadapan-Mu, hari ini aku merasa [Takut/Khawatir] akan [...], yang membuat hatiku gelisah dan tidurku tidak tenang.
        
        Melalui Yesaya 41:10, aku seringkau agar tidak takut karena Engkau adalah Allahku yang menyertai. Aku sadar bahwa imanku masih lemah karena aku lebih membiarkan diriku dikuasai oleh [...] daripada janji-Mu.
        
        Aku memohon agar Engkau menggenggam tanganku kuat-kuat untuk melangkah esok hari. Untuk menaklukkan rasa takut ini di dalam nama-Mu, aku akan berani melakukan [...].
        """
    )
]

struct VerseCard: View {
    let emotion: Emotion
    
    var body: some View {
        let content = emotionContents[emotion.label]!
        
        return VStack(alignment: .leading, spacing: 8) {
            Text(content.verseReference)
                .font(.system(size: 28, weight: .semibold))
//                .foregroundColor(.white)
            
            Text("\"\(content.verse)\"")
                .font(.body)
                .italic()
        }
        .padding()
        .background(.thinMaterial)
//        .background(Color.gray.opacity(0.15))
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
//                .fill(Color.blue.opacity(1))
                .frame(width: 50, height: 50)
                .overlay(Image(systemName: "music.note").foregroundColor(.white))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(content.songTitle)
                    .font(.headline)
                Text(content.songArtist)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
        }
        .padding()
        .background(.thinMaterial)
//        .background(Color.gray.opacity(0.15))
        .cornerRadius(16)
        
    }
}

struct ReflectionInputBox: View {
    @Binding var text: String
    let emotion: Emotion
    @State private var showSheet = false
    
    var body: some View {
        let emotionLabel = emotion.label
        let content = emotionContents[emotionLabel]
        let prompt = content?.prompt ?? ""
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Refleksi atas Perasaan " + emotionLabel + "ku")
                .font(.system(size: 24, weight: .semibold))
            
            Text("Tap untuk mengisi bagian [...]")
                .font(.caption)
                .foregroundColor(.secondary)
            
            // Preview area - tap to open sheet
            ZStack(alignment: .topLeading) {
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(Color.gray.opacity(0.1))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                    )
                
                ScrollView {
                    Text(text.isEmpty ? prompt : text)
                        .font(.body)
                        .foregroundColor(text.isEmpty ? .secondary : .primary)
                        .multilineTextAlignment(.leading)
                        .padding(12)
                }
                .frame(alignment: .topLeading)
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
                VStack {
                    TextEditor(text: $text)
                        .padding(.top, 8)
                }
                .navigationTitle("Tulis Refleksimu")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Selesai") {
                            showSheet = false
                        }
                    }
                }
            }
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
//            PrimaryButton(title: "Draft", isEnabled: true, color: .gray.opacity(0.5), width: 150)
//            {
//                print("Draft tapped")
//            }
            
//            Spacer()
            
            PrimaryButton(title: "Save", isEnabled: true) {
                print("Save tapped")
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        ReflectionView(selectedEmotion: Emotion(emoji: "😊", label: "Senang", color: .yellow))
//            .preferredColorScheme(.dark)
//            .background(.yellow.opacity(0.6))
    }
}
