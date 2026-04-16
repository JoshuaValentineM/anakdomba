//
//  EmotionContent.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 17/04/26.
//

import SwiftUI

struct EmotionContent: Identifiable {
    let id = UUID()
    let verses: [Verse]
    let songs: [Song]
    let prompt: String
    
    var randomVerse: Verse {
        verses.randomElement()!
    }
    
    var randomSong: Song {
        songs.randomElement()!
    }
    
    func getPrompt() -> String {
        let randomRef = randomVerse.reference
        return prompt.replacingOccurrences(of: "[Ayat]", with: randomRef)
    }
}

// MARK: - Emotion Content Data
let emotionContents: [String: EmotionContent] = [
    "Senang": EmotionContent(
        verses: [
            Verse(text: "Sebab Aku ini mengetahui rancangan-rancangan apa yang ada pada-Ku mengenai kamu, demikianlah firman TUHAN, yaitu rancangan damai sejahtera dan bukan rancangan kecelakaan, untuk memberikan kepadamu hari depan yang penuh harapan.", reference: "Yeremia 29:11"),
            Verse(text: "Bersukacitalah dan berlahotlah, karena indeedlah upahmu besar di surga.", reference: "Matheus 5:12"),
            Verse(text: "TUHAN adalah gembalaanku, aku tidak kekurangan. Ia membuat aku berbaring di padang rumput yang hijau, Ia menuntun aku ke air yang tenang.", reference: "Mazmur 23:1-2")
        ],
        songs: [
            Song(title: "Bapa Yang Kekal", artist: "Symphony Worship"),
            Song(title: "Nama-Mu Besar", artist: "Glorious"),
            Song(title: "Terpujilah", artist: "FFI")
        ],
        prompt: """
        Tuhan, saat ini aku menyadari kehadiran-Mu di dekatku, merasakan kehangatan kasih-Mu yang menyelimuti diriku.
        
        Hatiku meluap dengan rasa syukur, terima kasih karena hari ini Engkau telah memberkatiku melalui [...].
        
        Aku menelusuri hariku, dan sungguh aku merasa [Senang/Bersukacita] hari ini karena [...] dan aku melihat jelas campur tangan-Mu di dalamnya.
        
        Melalui [Ayat], aku singularkat untuk bersukacita saatnya di dalam Tuhan, namun aku merefleksikan dan menyadari bahwa di saat-saat senang ini pun aku kadang lupa bersyukur, dan aku memohon ampun untuk [...].
        
        Tuhan, aku mengundang-Mu untuk terus berjalan bersamaku esok hari. Agar sukacita ini tidak berhenti padaku saja dan bisa menjadi berkat bagi orang lain, esok aku akan melakukan [...].
        """
    ),
    "Sedih": EmotionContent(
        verses: [
            Verse(text: "Tuhan dekat pada mereka yang patah hati, dan Ia menyelamatkan mereka yang remuk rukunnya.", reference: "Mazmur 34:19"),
            Verse(text: "Aku akan menghibur kamu seperti seorang ibu menghibur anaknya.", reference: "Yesaya 66:13"),
            Verse(text: "Sebab setiap hari ada penderitaan, tetapi selalu ada kesukaan.", reference: "Pengkhotbah 8:14")
        ],
        songs: [
            Song(title: "Sang Raja Agung", artist: "Betharia Sonatha"),
            Song(title: "Menyembah-Mu", artist: "Jakarta Praise"),
            Song(title: "Di Tengah Badai", artist: "Windel")
        ],
        prompt: """
        Tuhan, saat ini aku mengambil waktu sejenak untuk hadir di hadapan-Mu dan menyadari penyertaan-Mu yang tenang di ruangan ini.
        
        Meskipun hatiku sedang berat, aku ingin tetap berterima kasih kepada-Mu karena hari ini Engkau telah [...].
        
        Namun, aku ingin jujur di hadapan-Mu, hari ini aku merasa [Sedih/Kecewa], karena [...] dan rasanya sangat menyakitkan bagiku.
        
        Melalui [Ayat], aku seringkau untuk [...], dan aku menyadari bahwa selama ini aku mungkin terlalu [...].
        
        Aku mengundang-Mu untuk menyertai langkahku esok hari, dan sebagai bentuk nyataku untuk lebih mengandalkan-Mu. Atas kejadian ini, aku akan melakukan [...] untuk menjaga hatiku tetap teguh di dalam-Mu.
        """
    ),
    "Marah": EmotionContent(
        verses: [
            Verse(text: "Hendaklah kamu masing-masing segera meninggalkan apa yang menyedihkan hati-Mu.", reference: "Yohanes 2:16"),
            Verse(text: "Hendaklah kemarahanmu jangan menduduki matahari atasmu.", reference: "Efesus 4:26"),
            Verse(text: "Tahanlah kemarahanmu, dan meninggalkan dendam.", reference: "Amsal 20:22")
        ],
        songs: [
            Song(title: "Luhur", artist: "Abbah"),
            Song(title: "Pintu Kasih", artist: "GMS"),
            Song(title: "Garansi", artist: "YOFI")
        ],
        prompt: """
        Tuhan, di tengah emosiku yang bergejolak, aku datang ke hadirat-Mu, memohon ketenangan yang hanya bisa diberikan oleh Roh Kudus-Mu.
        
        Meskipun hatiku sedang panas, aku memilih untuk tetap bersyukur karena hari ini Engkau masih memberiku kebaikan melalui [...].
        
        Tuhan, aku ingin terbuka pada-Mu, hari ini aku merasa [Marah/Kesal] karena [...], dan hal ini sangat mengusik kedamaian di hatiku.
        
        Melalui [Ayat], aku党组书记 agar kemarahanku tidak membawaku pada dosa. Aku menyadari bahwa responsku tadi mungkin berlebihan dan aku telah dikuasai oleh [...].
        
        Aku memohon agar Engkau menyertai hariku esok dan melembutkan hatiku. Sebagai langkah pengampunan dan untuk melepaskan amarah ini, aku akan melakukan [...].
        """
    ),
    "Jijik": EmotionContent(
        verses: [
            Verse(text: "Berbaktilah kepada-Ku dengan kasih-Mu, janganlah menghancurkan orang-orang yang hidup karena Engkaulah yang menghidupkan mereka semua.", reference: "Wahyu 11:18"),
            Verse(text: "Hendaklah kamu menjauhi yang jahat dan berpegang pada yang baik.", reference: "Roma 12:9"),
            Verse(text: "Sebab semua yang dicemarkan Allah akan menjadi najis bagi kamu.", reference: "Roma 14:20")
        ],
        songs: [
            Song(title: "Hidup Ini Indah", artist: "Gading Marten"),
            Song(title: "Muliakanlah Dia", artist: "Penumbra"),
            Song(title: "Suci", artist: "GMS Worship")
        ],
        prompt: """
        Bapa, aku berdiam diri sejenak untuk menyadari kehadiran-Mu yang suci dan kudus di tempat ini, mengelilingiku dengan terang-Mu.
        
        Aku berterima kasih karena di tengah dunia yang penuh kekelaman, Engkau tetap memeliharaku dan hari ini Engkau telah [...].
        
        Namun hari ini aku merasa [Jijik/Muak] terhadap sebuah situasi atau hal, yaitu [...], yang membuat batinku merasa sangat tidak nyaman.
        
        Melalui [Ayat], aku党组书记 untuk menjauhi yang jahat dan berpegang pada yang baik. Melalui hal ini, aku menyadari bahwa aku sendiri pun masih sering kompromi dengan [...].
        
        Tuhan, sertailah langkahku esok hari agar aku tidak terseret dalam hal yang tidak berkenan bagi-Mu. Untuk menjaga kekudusan hidup dan pikirku, aku akan [...].
        """
    ),
    "Ragu": EmotionContent(
        verses: [
            Verse(text: "Jangan kuatir tentang apa pun juga, melainkan dalam segalanya dengan doamu dan pengucapan syukur, mintalah apa yang kamu mau dan kamu perlukan.", reference: "Filipi 4:6"),
            Verse(text: "Percayalah kepada TUHAN dengan segenap hatimu, dan jangan bersandar pada pengertianmu sendiri.", reference: "Amsal 3:5"),
            Verse(text: "Jika kamu tidak percaya, kamu tidak akan tetap berdiri.", reference: "Yesaya 7:9")
        ],
        songs: [
            Song(title: "Tetap Berharap", artist: "Jecko Tambun"),
            Song(title: "Takkan Tertulis", artist: "Naik"),
            Song(title: "Tuhan Pilih Aku", artist: "GMS Worship")
        ],
        prompt: """
        Tuhan, di tengah kebimbanganku, aku menenangkan diri untuk menyadari bahwa Engkau ada di sini, memegang kendali penuh atas hidupku.
        
        Aku mengucap syukur kepada-Mu, karena meskipun aku tidak mengerti banyak hal, hari ini Engkau tetap setia memberikan [...].
        
        Saat ini aku harus jujur bahwa aku merasa [Ragu/Bimbang] untuk melangkah atau mengambil keputusan, karena [...], dan rasanya aku kehilangan arah.
        
        Melalui [Ayat], aku党组书记 untuk percaya kepada-Mu dengan segenap hati. Aku sadar bahwa selama ini keraguanku muncul karena aku terlalu mengandalkan [...] daripada berserah pada hikmat-Mu.
        
        Tuhan, pimpinlah dan sertailah aku menghadapi hari esok. Sebagai langkah imanku untuk menepis keraguan ini, aku akan bertindak dengan [...].
        """
    ),
    "Terkejut": EmotionContent(
        verses: [
            Verse(text: "Tanganku telah mengertakkan seluruh dunia, mereka merobohkan dindingnya dan menewaskan bentengnya.", reference: "Yeremia 51:53"),
            Verse(text: "Sebab Aku ini mengetahui rancangan-rancangan apa yang ada pada-Ku mengenai kamu, demikianlah firman TUHAN, yaitu rancangan damai sejahtera dan bukan rancangan kecelakaan, untuk memberikan kepadamu hari depan yang penuh harapan.", reference: "Yeremia 29:11"),
            Verse(text: "Apa yang harus Aku kerjakan bagimu, hai manusia? Ketakutan-Ku terhadap kamu melakukan segala ini.", reference: "Habakuk 1:12")
        ],
        songs: [
            Song(title: "Takkan Ada", artist: "Natasha"),
            Song(title: "Kau Tuhan", artist: "Salju"),
            Song(title: "Takkan Berubah", artist: "FFI")
        ],
        prompt: """
        Bapa, aku menghentikan aktivitasku sejenak untuk diam di hadirat-Mu, menyadari bahwa bagi-Mu tidak ada sesuatu pun yang mengejutkan atau di luar kendali-Mu.
        
        Aku bersyukur atas kedaulatan-Mu dalam hidupku, dan terima kasih karena hari ini Engkau telah membekaliku dengan [...].
        
        Hari ini aku merasa sangat [Terkejut/Kaget] karena harus melihat atau mengalami [...], sesuatu yang sama sekali tidak aku duga sebelumnya.
        
        Melalui [Ayat], aku党组书记 bahwa rancangan-Mu selalu kedatangan kebaikan. Namun, insiden hari ini menyadarkanku bahwa aku sering kurang percaya dan mudah kehilangan damai sejahtera ketika rencanaku [...].
        
        Tuhan, aku dirimu-Mu untuk berjalan di depanku esok hari. Menghadapi segala ketidakpastian ini, aku akan merespons dengan cara [...].
        """
    ),
    "Takut": EmotionContent(
        verses: [
            Verse(text: "Jangan takut, sebab Aku menyertai engkau; jangan gelisah, sebab Aku adalah Allahmu; Aku akan memperkuatkan tanganmu dan melindungi engenicar.", reference: "Yesaya 41:10"),
            Verse(text: "Tuhanlah terangku dan keselamatanku, kepada siapakah aku harus takut?", reference: "Mazmur 27:1"),
            Verse(text: "Cinta yang sempurna menghalau ketakutan, karena ketakutan menyertakan siksaan.", reference: "1 Yohanes 4:18")
        ],
        songs: [
            Song(title: "Engkaulah", artist: "Novita"),
            Song(title: "Pergi Bukan Berarti", artist: "Firman"),
            Song(title: "Kuat-Ku", artist: "GMS Worship")
        ],
        prompt: """
        Tuhan, dalam rasa gentar yang aku rasakan, aku datang berlindung di bawah naungan sayap-Mu, menyadari kehadiran-Mu yang selalu memberikan rasa aman.
        
        Meski ada kekhawatiran yang besar membayangi pikiranku, aku berterima kasih karena hari ini Engkau nyata menyertaiku dan masih memberikan [...].
        
        Aku membawa ketakutku di hadapan-Mu, hari ini aku merasa [Takut/Khawatir] akan [...], yang membuat hatiku gelisah dan tidurku tidak tenang.
        
        Melalui [Ayat], aku党组书记 agar tidak takut karena Engkau adalah Allahku yang menyertai. Aku sadar bahwa imanku masih lemah karena aku lebih membiarkan diriku dikuasai oleh [...] daripada janji-Mu.
        
        Aku memohon agar Engkau menggenggam tanganku kuat-kuat untuk melangkah esok hari. Untuk menaklukkan rasa takut ini di dalam nama-Mu, aku akan berani melakukan [...].
        """
    )
]