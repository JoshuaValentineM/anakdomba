//
//  EmotionContent.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 17/04/26.
//

import SwiftUI

struct ReflectionSection {
    let title: String
    let placeholder: String
    let isEditable: Bool
}

struct EmotionContent: Identifiable {
    let id = UUID()
    let verses: [Verse]
    let songs: [Song]
    let presenceTemplate: String
    let sections: [ReflectionSection]
    
    var randomVerse: Verse {
        verses.randomElement()!
    }
    
    var randomSong: Song {
        songs.randomElement()!
    }
    
    func getPresenceText() -> String {
        let randomRef = randomVerse.reference
        return presenceTemplate.replacingOccurrences(of: "[Ayat]", with: randomRef)
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
        presenceTemplate: "Tuhan, saat ini aku menyadari kehadiran-Mu di dekatku, merasakan kehangatan kasih-Mu yang menyelimuti diriku.",
        sections: [
            ReflectionSection(title: "SYUKUR", placeholder: "Tulis hal yang disyukuri hari ini...", isEditable: true),
            ReflectionSection(title: "RENUNGAN", placeholder: "Apa yang membuatmu merasa senang hari ini?", isEditable: true),
            ReflectionSection(title: "PENGAJARAN", placeholder: "Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "AJAKAN", placeholder: "Respons apa yang kamu Undangan kepada Tuhan?", isEditable: true),
            ReflectionSection(title: "TINDAKAN", placeholder: "Langkah konkret apa yang akan kamu lakukan esok?", isEditable: true)
        ]
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
        presenceTemplate: "Tuhan, saat ini aku mengambil waktu sejenak untuk hadir di hadapan-Mu dan menyadari penyertaan-Mu yang tenang di ruangan ini.",
        sections: [
            ReflectionSection(title: "SYUKUR", placeholder: "Tulis hal yang disyukuri meskipun hati sedang berat...", isEditable: true),
            ReflectionSection(title: "RENUNGAN", placeholder: "Apa yang membuatmu merasa sedih?", isEditable: true),
            ReflectionSection(title: "PENGAJARAN", placeholder: " Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "AJAKAN", placeholder: "Respons apa yang kamu Undangan kepada Tuhan?", isEditable: true),
            ReflectionSection(title: "TINDAKAN", placeholder: "Langkah konkret apa yang akan kamu lakukan esok?", isEditable: true)
        ]
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
        presenceTemplate: "Tuhan, di tengah emosiku yang bergejolak, aku datang ke hadirat-Mu, memohon ketenangan yang hanya bisa diberikan oleh Roh Kudus-Mu.",
        sections: [
            ReflectionSection(title: "SYUKUR", placeholder: "Tulis hal yang disyukuri meskipun sedang marah...", isEditable: true),
            ReflectionSection(title: "RENUNGAN", placeholder: "Apa yang membuatmu merasa marah?", isEditable: true),
            ReflectionSection(title: "PENGAJARAN", placeholder: " Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "AJAKAN", placeholder: "Respons apa yang kamu Undangan kepada Tuhan?", isEditable: true),
            ReflectionSection(title: "TINDAKAN", placeholder: "Langkah konkret apa yang akan kamu lakukan esok?", isEditable: true)
        ]
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
        presenceTemplate: "Bapa, aku berdiam diri sejenak untuk menyadari kehadiran-Mu yang suci dan kudus di tempat ini, mengelilingiku dengan terang-Mu.",
        sections: [
            ReflectionSection(title: "SYUKUR", placeholder: "Tulis hal yang disyukuri...", isEditable: true),
            ReflectionSection(title: "RENUNGAN", placeholder: "Apa yang membuatmu merasa jijik?", isEditable: true),
            ReflectionSection(title: "PENGAJARAN", placeholder: " Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "AJAKAN", placeholder: "Respons apa yang kamu Undangan kepada Tuhan?", isEditable: true),
            ReflectionSection(title: "TINDAKAN", placeholder: "Langkah konkret apa yang akan kamu lakukan esok?", isEditable: true)
        ]
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
        presenceTemplate: "Tuhan, di tengah kebimbanganku, aku menenangkan diri untuk menyadari bahwa Engkau ada di sini, memegang kendali penuh atas hidupku.",
        sections: [
            ReflectionSection(title: "SYUKUR", placeholder: "Tulis hal yang disyukuri...", isEditable: true),
            ReflectionSection(title: "RENUNGAN", placeholder: "Apa yang membuatmu merasa ragu?", isEditable: true),
            ReflectionSection(title: "PENGAJARAN", placeholder: " Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "AJAKAN", placeholder: "Respons apa yang kamu Undangan kepada Tuhan?", isEditable: true),
            ReflectionSection(title: "TINDAKAN", placeholder: "Langkah konkret apa yang akan kamu lakukan esok?", isEditable: true)
        ]
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
        presenceTemplate: "Bapa, aku menghentikan aktivitasku sejenak untuk diam di hadirat-Mu, menyadari bahwa bagi-Mu tidak ada sesuatu pun yang mengejutkan atau di luar kendali-Mu.",
        sections: [
            ReflectionSection(title: "SYUKUR", placeholder: "Tulis hal yang disyukuri...", isEditable: true),
            ReflectionSection(title: "RENUNGAN", placeholder: "Apa yang membuatmu merasa terkejut?", isEditable: true),
            ReflectionSection(title: "PENGAJARAN", placeholder: " Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "AJAKAN", placeholder: "Respons apa yang kamu Undangan kepada Tuhan?", isEditable: true),
            ReflectionSection(title: "TINDAKAN", placeholder: "Langkah konkret apa yang akan kamu lakukan esok?", isEditable: true)
        ]
    ),
    "Takut": EmotionContent(
        verses: [
            Verse(text: "Jangan takut, sebab Aku menyertai engkau; jangan gelisah, sebab Aku adalah Allahmu; Aku akan memperkuatkan tanganmu dan melindungi engenicar.", reference: "Yesaya 41:10"),
            Verse(text: "Tuhanlah terangku dan seletamatanku, kepada siapakah aku harus takut?", reference: "Mazmur 27:1"),
            Verse(text: "Cinta yang sempurna menghalau ketakutan, karena ketakutan menyertakan siksaan.", reference: "1 Yohanes 4:18")
        ],
        songs: [
            Song(title: "Engkaulah", artist: "Novita"),
            Song(title: "Pergi Bukan Berarti", artist: "Firman"),
            Song(title: "Kuat-Ku", artist: "GMS Worship")
        ],
        presenceTemplate: "Tuhan, dalam rasa gentar yang aku rasakan, aku datang berlindung di bawah naungan sayap-Mu, menyadari kehadiran-Mu yang selalu memberikan rasa aman.",
        sections: [
            ReflectionSection(title: "SYUKUR", placeholder: "Tulis hal yang disyukuri meskipun sedang takut...", isEditable: true),
            ReflectionSection(title: "RENUNGAN", placeholder: "Apa yang membuatmu merasa takut?", isEditable: true),
            ReflectionSection(title: "PENGAJARAN", placeholder: " Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "AJAKAN", placeholder: "Respons apa yang kamu Undangan kepada Tuhan?", isEditable: true),
            ReflectionSection(title: "TINDAKAN", placeholder: "Langkah konkret apa yang akan kamu lakukan esok?", isEditable: true)
        ]
    )
]
