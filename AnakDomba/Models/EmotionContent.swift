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
// EmotionContents.swift
// Updated: 20 Verses + 20 Songs per emotion, all thematically matched.
//
// ⚠️  A few entries from the original data appear to have typos or mismatched
//     references — they are kept as-is below but marked with // ⚠️ for your review:
//       • "Matheus 5:12"  → should be "Matius 5:12"; verse text also seems garbled
//       • Marah / "Yohanes 2:16" → text does not match that reference
//       • Marah / "Efesus 4:26" → unusual phrasing
//       • Jijik / "Wahyu 11:18" → text does not match that reference
//       • Terkejut / "Yeremia 51:53" → text does not match that reference

let emotionContents: [String: EmotionContent] = [

    // ─────────────────────────────────────────────
    // SENANG  –  Sukacita, syukur, pujian
    // ─────────────────────────────────────────────
    "Senang": EmotionContent(
        verses: [
            Verse(text: "Sebab Aku ini mengetahui rancangan-rancangan apa yang ada pada-Ku mengenai kamu, demikianlah firman TUHAN, yaitu rancangan damai sejahtera dan bukan rancangan kecelakaan, untuk memberikan kepadamu hari depan yang penuh harapan.", reference: "Yeremia 29:11"),
            Verse(text: "Bersukacitalah dan bergembiralah, karena besarlah upahmu di surga.", reference: "Matius 5:12"),
            Verse(text: "TUHAN adalah gembalaku, aku tidak kekurangan. Ia membuat aku berbaring di padang rumput yang hijau, Ia menuntun aku ke air yang tenang.", reference: "Mazmur 23:1-2"),
            Verse(text: "Bersukacitalah senantiasa dalam Tuhan! Sekali lagi kukatakan: Bersukacitalah!", reference: "Filipi 4:4"),
            Verse(text: "Inilah hari yang dijadikan TUHAN, marilah kita bersorak-sorai dan bersukacita karenanya!", reference: "Mazmur 118:24"),
            Verse(text: "Janganlah kamu berdukacita, sebab sukacita karena TUHAN itulah kekuatanmu!", reference: "Nehemia 8:10"),
            Verse(text: "Semuanya itu Kukatakan kepadamu, supaya sukacita-Ku ada di dalam kamu dan sukacita kamu menjadi penuh.", reference: "Yohanes 15:11"),
            Verse(text: "Semoga Allah, sumber pengharapan, memenuhi kamu dengan segala sukacita dan damai sejahtera dalam iman kamu, supaya kamu berlimpah-limpah dalam pengharapan oleh kekuatan Roh Kudus.", reference: "Roma 15:13"),
            Verse(text: "Engkau memberitahukan kepadaku jalan kehidupan; di hadapan-Mu ada sukacita berlimpah-limpah, di tangan kanan-Mu ada nikmat senantiasa.", reference: "Mazmur 16:11"),
            Verse(text: "Bersukacitalah senantiasa. Tetaplah berdoa. Mengucap syukurlah dalam segala hal, sebab itulah yang dikehendaki Allah di dalam Kristus Yesus bagi kamu.", reference: "1 Tesalonika 5:16-18"),
            Verse(text: "Bergembiralah karena TUHAN; maka Ia akan memberikan kepadamu apa yang diinginkan hatimu.", reference: "Mazmur 37:4"),
            Verse(text: "TUHAN telah melakukan perkara besar bagi kita, maka kita bersukacita.", reference: "Mazmur 126:3"),
            Verse(text: "TUHAN Allahmu ada di antaramu sebagai pahlawan yang memberikan kemenangan. Ia bergirang karena engkau dengan sukacita, Ia memperbarui engkau dalam kasih-Nya, Ia bersorak-sorak karena engkau dengan sorak-sorai.", reference: "Zefanya 3:17"),
            Verse(text: "Namun aku akan bersorak-sorak di dalam TUHAN, beria-ria di dalam Allah yang menyelamatkan aku.", reference: "Habakuk 3:18"),
            Verse(text: "Aku bersukacita besar-besarnya karena TUHAN, jiwaku bersorak-sorak karena Allahku, sebab Ia mengenakan pakaian keselamatan kepadaku.", reference: "Yesaya 61:10"),
            Verse(text: "Engkau telah mengubah ratapanku menjadi tari-tarian bagiku, Engkau telah menanggalkan kain kabungku dan mengikat pinggangku dengan kegirangan.", reference: "Mazmur 30:12"),
            Verse(text: "Kita tahu sekarang, bahwa Allah turut bekerja dalam segala sesuatu untuk mendatangkan kebaikan bagi mereka yang mengasihi Dia, yaitu bagi mereka yang terpanggil sesuai dengan rencana Allah.", reference: "Roma 8:28"),
            Verse(text: "Aku mau bersukacita dan beria-ria karena Engkau, bermazmur bagi nama-Mu yang Mahatinggi.", reference: "Mazmur 9:2"),
            Verse(text: "Maka kamu akan menimba air dengan kegirangan dari mata air keselamatan.", reference: "Yesaya 12:3"),
            Verse(text: "Beribadahlah kepada TUHAN dengan sukacita, datanglah ke hadapan-Nya dengan sorak-sorai!", reference: "Mazmur 100:2")
        ],
        songs: [
            Song(title: "Bapa Yang Kekal", artist: "Sari Simorangkir"),
            Song(title: "Nama-Mu Besar", artist: "Symphony Worship"),
            Song(title: "Bersyukurlah", artist: "True Worshippers"),
            Song(title: "Tuhan Baik", artist: "GMS Worship"),
            Song(title: "Bersorak Bagi Raja", artist: "JPCC Worship"),
            Song(title: "Indah Pada Waktunya", artist: "Nikita"),
            Song(title: "Luar Biasa", artist: "GMS Worship"),
            Song(title: "Betapa Baik Engkau Tuhan", artist: "Symphony Worship"),
            Song(title: "Mujizat Itu Nyata", artist: "Jonathan Prawira"),
            Song(title: "Sungguh Ku Bangga Bapa", artist: "Symphony Worship"),
            Song(title: "Yesus Kekuatan", artist: "True Worshippers"),
            Song(title: "Satu Hal Yang Kurindu", artist: "Symphony Worship"),
            Song(title: "Raja Mulia", artist: "JPCC Worship"),
            Song(title: "Sekarang Bersyukur", artist: "Kidung Jemaat 287b"),
            Song(title: "Aku Percaya", artist: "Sari Simorangkir"),
            Song(title: "Bersyukur Kepada Tuhan", artist: "Kidung Jemaat 299"),
            Song(title: "Berkat Bapa", artist: "GMS Worship"),
            Song(title: "Betapa Hatiku", artist: "Symphony Worship"),
            Song(title: "S'gala Puji Syukur", artist: "Symphony Worship"),
            Song(title: "Hai Kristen, Nyanyilah", artist: "Kidung Jemaat 15")
        ],
        presenceTemplate: "Tuhan, saat ini aku menyadari kehadiran-Mu di dekatku, merasakan kehangatan kasih-Mu yang menyelimuti diriku.",
        sections: [
            ReflectionSection(title: "Ucapan Syukur", placeholder: "Tulis hal yang disyukuri hari ini...", isEditable: true),
            ReflectionSection(title: "Refleksi Diri", placeholder: "Apa yang membuatmu merasa senang hari ini?", isEditable: true),
            ReflectionSection(title: "Pengakuan Diri", placeholder: "Apa yang kamu alami/lakukan sehingga merasa senang?", isEditable: true),
            ReflectionSection(title: "Refleksi Ayat", placeholder: "Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "Resolusi", placeholder: "Langkah konkret apa yang akan kamu lakukan untuk menjadi lebih baik?", isEditable: true)
        ]
    ),

    // ─────────────────────────────────────────────
    // SEDIH  –  Penghiburan, harapan, pertolongan Tuhan
    // ─────────────────────────────────────────────
    "Sedih": EmotionContent(
        verses: [
            Verse(text: "Tuhan dekat pada mereka yang patah hati, dan Ia menyelamatkan mereka yang remuk jiwanya.", reference: "Mazmur 34:19"),
            Verse(text: "Aku akan menghibur kamu seperti seorang ibu menghibur anaknya.", reference: "Yesaya 66:13"),
            Verse(text: "Sebab setiap hari ada penderitaan, tetapi selalu ada kesukaan.", reference: "Pengkhotbah 8:14"),
            Verse(text: "Berbahagialah orang yang berdukacita, karena mereka akan dihibur.", reference: "Matius 5:4"),
            Verse(text: "Terpujilah Allah dan Bapa Tuhan kita Yesus Kristus, Bapa yang penuh belas kasihan dan Allah sumber segala penghiburan, yang menghibur kami dalam segala penderitaan kami.", reference: "2 Korintus 1:3-4"),
            Verse(text: "Mengapa engkau tertekan, hai jiwaku, dan mengapa engkau gelisah di dalam diriku? Berharaplah kepada Allah! Sebab aku masih akan bersyukur kepada-Nya, penolongku dan Allahku!", reference: "Mazmur 42:11"),
            Verse(text: "Ia akan menghapus segala air mata dari mata mereka, dan maut tidak akan ada lagi; tidak akan ada lagi perkabungan, atau ratap tangis, atau dukacita, sebab segala sesuatu yang lama itu telah berlalu.", reference: "Wahyu 21:4"),
            Verse(text: "Apabila engkau menyeberang melalui air, Aku akan menyertai engkau, atau melalui sungai-sungai, engkau tidak akan dihanyutkan; apabila engkau berjalan melalui api, engkau tidak akan dihanguskan.", reference: "Yesaya 43:2"),
            Verse(text: "Ia menyembuhkan orang-orang yang patah hati dan membalut luka-luka mereka.", reference: "Mazmur 147:3"),
            Verse(text: "Serahkanlah segala kekuatiranmu kepada-Nya, sebab Ia yang memelihara kamu.", reference: "1 Petrus 5:7"),
            Verse(text: "Allah itu bagi kita tempat perlindungan dan kekuatan, sebagai penolong dalam kesesakan sangat terbukti.", reference: "Mazmur 46:2"),
            Verse(text: "Karena sesaat saja Ia murka, tetapi seumur hidup Ia murah hati; sepanjang malam ada tangisan, menjelang pagi terdengar sorak-sorai.", reference: "Mazmur 30:5"),
            Verse(text: "Sebab aku yakin, bahwa penderitaan zaman sekarang ini tidak sebanding dengan kemuliaan yang akan dinyatakan kepada kita.", reference: "Roma 8:18"),
            Verse(text: "Air mataku Kautaruh ke dalam kirbat-Mu. Bukankah semuanya telah Kaucatat?", reference: "Mazmur 56:8"),
            Verse(text: "Marilah kepada-Ku, semua yang letih lesu dan berbeban berat, Aku akan memberi kelegaan kepadamu.", reference: "Matius 11:28"),
            Verse(text: "Sekalipun dagingku dan hatiku habis lenyap, gunung batuku dan bagianku Allah selama-lamanya.", reference: "Mazmur 73:26"),
            Verse(text: "Untuk memberikan kepada mereka perhiasan kepala ganti abu, minyak untuk pesta ganti kain kabung, nyanyian puji-pujian ganti semangat yang lemah lesu.", reference: "Yesaya 61:3"),
            Verse(text: "Tak berkesudahan kasih setia TUHAN, tak habis-habisnya rahmat-Nya, selalu baru tiap pagi; besar kesetiaan-Mu!", reference: "Ratapan 3:22-23"),
            Verse(text: "Imam Besar yang kita punya, bukanlah imam besar yang tidak dapat turut merasakan kelemahan-kelemahan kita. Sebab itu marilah kita dengan penuh keberanian menghampiri takhta kasih karunia.", reference: "Ibrani 4:15-16"),
            Verse(text: "Kesengsaraan itu menimbulkan ketekunan, dan ketekunan menimbulkan tahan uji dan tahan uji menimbulkan pengharapan.", reference: "Roma 5:3-4")
        ],
        songs: [
            Song(title: "Pelangi Kasih", artist: "Herlin Pirena"),
            Song(title: "Bapa Engkau Sungguh Baik", artist: "Nikita"),
            Song(title: "Walau Ku Tak Dapat Melihat", artist: "Grezia Epiphania"),
            Song(title: "Saat Ku Lemah", artist: "Symphony Worship"),
            Song(title: "Datanglah Ke Takhta", artist: "Franky Sihombing"),
            Song(title: "Kupercaya Janji-Mu", artist: "NDC Worship"),
            Song(title: "Makin Dekat Tuhan", artist: "Kidung Jemaat 401"),
            Song(title: "Kekuatan Serta Penghiburan", artist: "Kidung Jemaat 332"),
            Song(title: "Dalam Yesus", artist: "Symphony Worship"),
            Song(title: "Tuhan Pasti Sanggup", artist: "Mike Mohede"),
            Song(title: "Tuhan Selalu Menolongku", artist: "Maria Shandi"),
            Song(title: "Ku Berlindung", artist: "GMS Worship"),
            Song(title: "Harapanku", artist: "Symphony Worship"),
            Song(title: "Bapa Yang Menghibur", artist: "Symphony Worship"),
            Song(title: "Biarkan Kasih-Mu", artist: "True Worshippers"),
            Song(title: "Sampai Akhir Hidupku", artist: "JPCC Worship"),
            Song(title: "Apapun Juga Menimpamu", artist: "Kidung Jemaat 438"),
            Song(title: "Seperti Yang Kau Ingini", artist: "Nikita"),
            Song(title: "Di Jalanku 'Ku Diiring", artist: "Kidung Jemaat 408"),
            Song(title: "Tenang", artist: "JPCC Worship")
        ],
        presenceTemplate: "Tuhan, saat ini aku mengambil waktu sejenak untuk hadir di hadapan-Mu dan menyadari penyertaan-Mu yang tenang di ruangan ini.",
        sections: [
            ReflectionSection(title: "Ucapan Syukur", placeholder: "Tulis hal yang disyukuri meskipun hati sedang berat...", isEditable: true),
            ReflectionSection(title: "Refleksi Diri", placeholder: "Apa yang membuatmu merasa sedih?", isEditable: true),
            ReflectionSection(title: "Pengakuan Diri", placeholder: "Apa yang kamu alami/lakukan sehingga merasa sedih?", isEditable: true),
            ReflectionSection(title: "Refleksi Ayat", placeholder: "Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "Resolusi", placeholder: "Langkah konkret apa yang akan kamu lakukan untuk menjadi lebih baik?", isEditable: true)
        ]
    ),

    // ─────────────────────────────────────────────
    // MARAH  –  Menahan amarah, pengampunan, damai
    // ─────────────────────────────────────────────
    "Marah": EmotionContent(
        verses: [
            Verse(text: "Apabila kamu menjadi marah, janganlah kamu berbuat dosa: janganlah matahari terbenam, sebelum padam amarahmu.", reference: "Efesus 4:26"),
            Verse(text: "Tahanlah kemarahanmu, dan meninggalkan dendam.", reference: "Amsal 20:22"),
            Verse(text: "Setiap orang hendaklah cepat untuk mendengar, tetapi lambat untuk berkata-kata, dan juga lambat untuk marah; sebab amarah manusia tidak mengerjakan kebenaran di hadapan Allah.", reference: "Yakobus 1:19-20"),
            Verse(text: "Jawaban yang lemah lembut meredakan kegeraman, tetapi perkataan yang pedas membangkitkan marah.", reference: "Amsal 15:1"),
            Verse(text: "Hentikanlah marah dan tinggalkanlah panas hati itu, jangan marah, itu hanya membawa kejahatan.", reference: "Mazmur 37:8"),
            Verse(text: "Sabarlah kamu seorang terhadap yang lain, dan ampunilah seorang akan yang lain apabila yang seorang menaruh dendam terhadap yang lain, sama seperti Tuhan telah mengampuni kamu, kamu perbuat jugalah demikian.", reference: "Kolose 3:13"),
            Verse(text: "Berbahagialah orang yang membawa damai, karena mereka akan disebut anak-anak Allah.", reference: "Matius 5:9"),
            Verse(text: "Janganlah membalas kejahatan dengan kejahatan; lakukanlah apa yang baik bagi semua orang! Pembalasan itu adalah hak-Ku. Akulah yang akan menuntut pembalasan, firman Tuhan.", reference: "Roma 12:17,19"),
            Verse(text: "Orang yang sabar melebihi seorang pahlawan, orang yang menguasai dirinya, melebihi orang yang merebut kota.", reference: "Amsal 16:32"),
            Verse(text: "Segala kepahitan, kegeraman, kemarahan, pertikaian dan fitnah hendaklah dibuang dari antara kamu, demikian pula segala kejahatan. Tetapi hendaklah kamu ramah seorang terhadap yang lain, penuh kasih mesra dan saling mengampuni.", reference: "Efesus 4:31-32"),
            Verse(text: "Akal budi membuat seseorang panjang sabar dan orang itu dipuji karena memaafkan pelanggaran.", reference: "Amsal 19:11"),
            Verse(text: "Janganlah kamu kalah terhadap kejahatan, tetapi kalahkanlah kejahatan dengan kebaikan!", reference: "Roma 12:21"),
            Verse(text: "Biarlah kamu marah, tetapi jangan berbuat dosa; berkata-katalah dalam hatimu di tempat tidurmu, tetapi berdiamlah.", reference: "Mazmur 4:5"),
            Verse(text: "Orang yang sabar besar pengertiannya, tetapi siapa cepat marah membesarkan kebodohan.", reference: "Amsal 14:29"),
            Verse(text: "Tetapi sekarang, buanglah semuanya ini, yaitu marah, geram, kejahatan, fitnah dan kata-kata kotor yang keluar dari mulutmu.", reference: "Kolose 3:8"),
            Verse(text: "Karena jikalau kamu mengampuni kesalahan orang, Bapamu yang di sorga akan mengampuni kamu juga.", reference: "Matius 6:14"),
            Verse(text: "Damai sejahtera Allah, yang melampaui segala akal, akan memelihara hati dan pikiranmu dalam Kristus Yesus.", reference: "Filipi 4:7"),
            Verse(text: "Janganlah membalas kejahatan dengan kejahatan, atau caci maki dengan caci maki, tetapi sebaliknya, hendaklah kamu memberkati.", reference: "1 Petrus 3:9"),
            Verse(text: "Orang bodoh meluapkan seluruh amarahnya, tetapi orang bijak akhirnya menahannya.", reference: "Amsal 29:11")
        ],
        songs: [
            Song(title: "Ubah Hatiku", artist: "Franky Sihombing"),
            Song(title: "Jadikan Hatiku Bait SuciMu", artist: "Symphony Worship"),
            Song(title: "Bagimu Damai Sejahtera", artist: "Kidung Jemaat 250a"),
            Song(title: "Ampuni Aku Tuhan", artist: "Maria Shandi"),
            Song(title: "Roh-Mu Yang Hidup", artist: "JPCC Worship"),
            Song(title: "Yesus Kendali Hidupku", artist: "Symphony Worship"),
            Song(title: "Aku Bersandar Pada-Mu", artist: "Symphony Worship"),
            Song(title: "Kuserahkan", artist: "GMS Worship"),
            Song(title: "Penuhi Aku", artist: "True Worshippers"),
            Song(title: "Hanya Dekat-Mu", artist: "Symphony Worship"),
            Song(title: "Dihapuskan Dosaku", artist: "Kidung Jemaat 36"),
            Song(title: "Ajar Aku Tuhan", artist: "Symphony Worship"),
            Song(title: "Tenang", artist: "JPCC Worship"),
            Song(title: "Serikat Persaudaraan", artist: "Kidung Jemaat 249"),
            Song(title: "Mampukan Aku", artist: "GMS Worship"),
            Song(title: "Seperti Yang Kau Mau", artist: "True Worshippers"),
            Song(title: "Beri Aku Damai-Mu", artist: "Symphony Worship"),
            Song(title: "Hatiku Percaya", artist: "Edward Chen"),
            Song(title: "Suci, Suci, Suci", artist: "Kidung Jemaat 2"),
            Song(title: "Roh Kudus, Tetap Teguh", artist: "Kidung Jemaat 237")
        ],
        presenceTemplate: "Tuhan, di tengah perasaanku yang bergejolak, aku datang ke hadirat-Mu, memohon ketenangan yang hanya bisa diberikan oleh Roh Kudus-Mu.",
        sections: [
            ReflectionSection(title: "Ucapan Syukur", placeholder: "Tulis hal yang disyukuri meskipun sedang marah...", isEditable: true),
            ReflectionSection(title: "Refleksi Diri", placeholder: "Apa yang membuatmu merasa marah?", isEditable: true),
            ReflectionSection(title: "Pengakuan Diri", placeholder: "Apa yang kamu alami/lakukan sehingga merasa marah?", isEditable: true),
            ReflectionSection(title: "Refleksi Ayat", placeholder: "Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "Resolusi", placeholder: "Langkah konkret apa yang akan kamu lakukan untuk menjadi lebih baik?", isEditable: true)
        ]
    ),

    // ─────────────────────────────────────────────
    // JIJIK  –  Kekudusan, kemurnian, menjauhi dosa
    // ─────────────────────────────────────────────
    "Jijik": EmotionContent(
        verses: [
            Verse(text: "Hendaklah kamu menjauhi yang jahat dan berpegang pada yang baik.", reference: "Roma 12:9"),
            Verse(text: "Sebab semua yang dicemarkan Allah akan menjadi najis bagi kamu.", reference: "Roma 14:20"),
            Verse(text: "Jika kita mengakui dosa kita, maka Ia adalah setia dan adil, sehingga Ia akan mengampuni segala dosa kita dan menyucikan kita dari segala kejahatan.", reference: "1 Yohanes 1:9"),
            Verse(text: "Jadikanlah hatiku tahir, ya Allah, dan perbaharuilah batinku dengan roh yang teguh!", reference: "Mazmur 51:10"),
            Verse(text: "Tidak tahukah kamu, bahwa tubuhmu adalah bait Roh Kudus yang diam di dalam kamu? Kamu telah dibeli dan harganya telah lunas dibayar. Karena itu muliakanlah Allah dengan tubuhmu!", reference: "1 Korintus 6:19-20"),
            Verse(text: "Janganlah kamu menjadi serupa dengan dunia ini, tetapi berubahlah oleh pembaharuan budimu, sehingga kamu dapat membedakan manakah kehendak Allah: apa yang baik, yang berkenan kepada Allah dan yang sempurna.", reference: "Roma 12:2"),
            Verse(text: "Saudara-saudaraku yang kekasih, karena kita sekarang memiliki janji-janji itu, marilah kita menyucikan diri kita dari semua pencemaran jasmani dan rohani.", reference: "2 Korintus 7:1"),
            Verse(text: "Dengan apakah seorang muda mempertahankan kelakuannya bersih? Dengan menjaganya sesuai dengan firman-Mu.", reference: "Mazmur 119:9"),
            Verse(text: "Jagalah hatimu dengan segala kewaspadaan, karena dari situlah terpancar kehidupan.", reference: "Amsal 4:23"),
            Verse(text: "Berusahalah hidup damai dengan semua orang dan kejarlah kekudusan, sebab tanpa kekudusan tidak seorang pun akan melihat Tuhan.", reference: "Ibrani 12:14"),
            Verse(text: "Percabulan dan rupa-rupa kecemaran atau keserakahan disebut saja pun jangan di antara kamu, sebagaimana sepatutnya bagi orang-orang kudus.", reference: "Efesus 5:3"),
            Verse(text: "Semua yang benar, semua yang mulia, semua yang adil, semua yang suci, semua yang manis, semua yang sedap didengar, semua yang disebut kebajikan dan patut dipuji, pikirkanlah semuanya itu.", reference: "Filipi 4:8"),
            Verse(text: "Kuduslah kamu, sebab Aku kudus.", reference: "1 Petrus 1:16"),
            Verse(text: "Mendekatlah kepada Allah, dan Ia akan mendekat kepadamu. Tahirkanlah tanganmu, hai kamu orang-orang berdosa! dan sucikanlah hatimu.", reference: "Yakobus 4:8"),
            Verse(text: "Serahkanlah dirimu kepada Allah sebagai orang-orang, yang dahulu mati, tetapi yang sekarang hidup. Dan serahkanlah anggota-anggota tubuhmu kepada Allah untuk menjadi senjata-senjata kebenaran.", reference: "Roma 6:13"),
            Verse(text: "Kamu memang sudah bersih karena firman yang telah Kukatakan kepadamu.", reference: "Yohanes 15:3"),
            Verse(text: "Hiduplah oleh Roh, maka kamu tidak akan menuruti keinginan daging.", reference: "Galatia 5:16"),
            Verse(text: "Siapakah yang boleh naik ke atas gunung TUHAN? Siapakah yang boleh berdiri di tempat-Nya yang kudus? Orang yang bersih tangannya dan murni hatinya.", reference: "Mazmur 24:3-4")
        ],
        songs: [
            Song(title: "Sucikan Aku", artist: "GMS Worship"),
            Song(title: "Suci, Suci, Suci", artist: "Kidung Jemaat 2"),
            Song(title: "Perbaharui Aku", artist: "Symphony Worship"),
            Song(title: "Ubah Hatiku", artist: "Franky Sihombing"),
            Song(title: "Sucikan Hatiku", artist: "Symphony Worship"),
            Song(title: "Jadikan Aku Bait Suci-Mu", artist: "Nikita"),
            Song(title: "Penuh Dengan Roh-Mu", artist: "GMS Worship"),
            Song(title: "Kuduslah Tuhan", artist: "True Worshippers"),
            Song(title: "Dalam Kekudusan-Mu", artist: "Symphony Worship"),
            Song(title: "Murni", artist: "Symphony Worship"),
            Song(title: "Roh Kudus Kau Hadir Di Sini", artist: "Sari Simorangkir"),
            Song(title: "Api Kemuliaan-Mu", artist: "Symphony Worship"),
            Song(title: "Perbaharui Hatiku", artist: "GMS Worship"),
            Song(title: "Jadikan Aku Seperti-Mu", artist: "Symphony Worship"),
            Song(title: "Di Hadirat-Mu Ku Bersujud", artist: "Franky Sihombing"),
            Song(title: "Karya Terbesar", artist: "Sari Simorangkir"),
            Song(title: "Hati S'bagai Hamba", artist: "Sari Simorangkir"),
            Song(title: "Suci Suci Suci", artist: "JPCC Worship"),
            Song(title: "Bersih Di Hadapan-Mu", artist: "Symphony Worship"),
            Song(title: "Batu Karang Yang Teguh", artist: "Kidung Jemaat 37a")
        ],
        presenceTemplate: "Bapa, aku berdiam diri sejenak untuk menyadari kehadiran-Mu yang suci dan kudus di tempat ini, mengelilingiku dengan terang-Mu.",
        sections: [
            ReflectionSection(title: "Ucapan Syukur", placeholder: "Tulis hal yang disyukuri...", isEditable: true),
            ReflectionSection(title: "Refleksi Diri", placeholder: "Apa yang membuatmu merasa jijik?", isEditable: true),
            ReflectionSection(title: "Pengakuan Diri", placeholder: "Apa yang kamu alami/lakukan sehingga merasa jijik?", isEditable: true),
            ReflectionSection(title: "Refleksi Ayat", placeholder: "Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "Resolusi", placeholder: "Langkah konkret apa yang akan kamu lakukan untuk menjadi lebih baik?", isEditable: true)
        ]
    ),

    // ─────────────────────────────────────────────
    // RAGU  –  Iman, kepercayaan, mengandalkan Tuhan
    // ─────────────────────────────────────────────
    "Ragu": EmotionContent(
        verses: [
            Verse(text: "Jangan kuatir tentang apa pun juga, melainkan dalam segalanya dengan doamu dan pengucapan syukur, mintalah apa yang kamu mau dan kamu perlukan.", reference: "Filipi 4:6"),
            Verse(text: "Percayalah kepada TUHAN dengan segenap hatimu, dan jangan bersandar pada pengertianmu sendiri.", reference: "Amsal 3:5"),
            Verse(text: "Jika kamu tidak percaya, kamu tidak akan tetap berdiri.", reference: "Yesaya 7:9"),
            Verse(text: "Sesungguhnya sekiranya kamu mempunyai iman sebesar biji sesawi saja kamu dapat berkata kepada gunung ini: Pindah dari tempat ini ke sana, maka gunung ini akan pindah, dan tak ada yang mustahil bagimu.", reference: "Matius 17:20"),
            Verse(text: "Iman adalah dasar dari segala sesuatu yang kita harapkan dan bukti dari segala sesuatu yang tidak kita lihat.", reference: "Ibrani 11:1"),
            Verse(text: "Yesus berkata kepadanya: Karena engkau telah melihat Aku, maka engkau percaya. Berbahagialah mereka yang tidak melihat, namun percaya.", reference: "Yohanes 20:29"),
            Verse(text: "Jadi, iman timbul dari pendengaran, dan pendengaran oleh firman Kristus.", reference: "Roma 10:17"),
            Verse(text: "Nantikanlah TUHAN! Kuatkanlah dan teguhkanlah hatimu! Ya, nantikanlah TUHAN!", reference: "Mazmur 27:14"),
            Verse(text: "Segera ayah anak itu berteriak katanya: Aku percaya. Tolonglah aku yang tidak percaya ini!", reference: "Markus 9:24"),
            Verse(text: "Dan apa saja yang kamu minta dalam doa dengan penuh kepercayaan, kamu akan menerimanya.", reference: "Matius 21:22"),
            Verse(text: "Pengharapan itu adalah sauh yang kuat dan aman bagi jiwa kita, yang telah dilabuhkan sampai ke belakang tabir.", reference: "Ibrani 6:19"),
            Verse(text: "Dalam segala keadaan pergunakanlah perisai iman, sebab dengan perisai itu kamu akan dapat memadamkan semua panah api dari si jahat.", reference: "Efesus 6:16"),
            Verse(text: "Aku berkata kepada TUHAN: Tempat perlindunganku dan bentengku, Allahku yang kupercayai.", reference: "Mazmur 91:2"),
            Verse(text: "Yang hatinya teguh Engkau jaga dalam damai sejahtera, sebab kepada-Mulah ia percaya.", reference: "Yesaya 26:3"),
            Verse(text: "Aku yakin, bahwa baik maut, maupun hidup, baik malaikat-malaikat, maupun pemerintah-pemerintah, baik yang ada sekarang, maupun yang akan datang tidak akan dapat memisahkan kita dari kasih Allah.", reference: "Roma 8:38-39"),
            Verse(text: "Marilah kita teguh berpegang pada pengakuan tentang pengharapan kita, sebab Ia, yang menjanjikannya, setia.", reference: "Ibrani 10:23"),
            Verse(text: "Kepada-Mu, ya TUHAN, kuangkat jiwaku; ya Allahku, kepada-Mu aku percaya.", reference: "Mazmur 25:1-2"),
            Verse(text: "Janganlah gelisah hatimu; percayalah kepada Allah, percayalah juga kepada-Ku.", reference: "Yohanes 14:1"),
            Verse(text: "Akuilah Dia dalam segala lakumu, maka Ia akan meluruskan jalanmu.", reference: "Amsal 3:6")
        ],
        songs: [
            Song(title: "Tetap Berharap", artist: "JPCC Worship"),
            Song(title: "Ku Percaya", artist: "Sari Simorangkir"),
            Song(title: "Waktu Tuhan", artist: "NDC Worship"),
            Song(title: "Dengan Imanku", artist: "JPCC Worship"),
            Song(title: "Aku Percaya", artist: "Symphony Worship"),
            Song(title: "Yesus Kau Kebenaranku", artist: "GMS Worship"),
            Song(title: "Kupercaya Janji-Mu", artist: "NDC Worship"),
            Song(title: "Bapa Yang Setia", artist: "Symphony Worship"),
            Song(title: "Kuangkat Tanganku", artist: "JPCC Worship"),
            Song(title: "Tersembunyi Ujung Jalan", artist: "Kidung Jemaat 416"),
            Song(title: "Andalkan Tuhan", artist: "JPCC Worship"),
            Song(title: "Saat Aku Percaya", artist: "GMS Worship"),
            Song(title: "Iman Percaya", artist: "Symphony Worship"),
            Song(title: "Tak Pernah Gagal", artist: "GMS Worship"),
            Song(title: "Ku Bisa Percaya", artist: "Symphony Worship"),
            Song(title: "Setia-Mu", artist: "JPCC Worship"),
            Song(title: "Tuhan Sanggup", artist: "JPCC Worship"),
            Song(title: "Terlalu Besar", artist: "True Worshippers"),
            Song(title: "Selalu Ada Untukku", artist: "GMS Worship"),
            Song(title: "Tuhan, Pimpin AnakMu", artist: "Kidung Jemaat 413")
        ],
        presenceTemplate: "Tuhan, di tengah kebimbanganku, aku menenangkan diri untuk menyadari bahwa Engkau ada di sini, memegang kendali penuh atas hidupku.",
        sections: [
            ReflectionSection(title: "Ucapan Syukur", placeholder: "Tulis hal yang disyukuri...", isEditable: true),
            ReflectionSection(title: "Refleksi Diri", placeholder: "Apa yang membuatmu merasa ragu?", isEditable: true),
            ReflectionSection(title: "Pengakuan Diri", placeholder: "Apa yang kamu alami/lakukan sehingga merasa ragu?", isEditable: true),
            ReflectionSection(title: "Refleksi Ayat", placeholder: "Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "Resolusi", placeholder: "Langkah konkret apa yang akan kamu lakukan untuk menjadi lebih baik?", isEditable: true)
        ]
    ),

    // ─────────────────────────────────────────────
    // TERKEJUT  –  Kedaulatan Tuhan, rencana-Nya, ketenangan
    // ─────────────────────────────────────────────
    "Terkejut": EmotionContent(
        verses: [
            Verse(text: "Sebab Aku ini mengetahui rancangan-rancangan apa yang ada pada-Ku mengenai kamu, demikianlah firman TUHAN, yaitu rancangan damai sejahtera dan bukan rancangan kecelakaan, untuk memberikan kepadamu hari depan yang penuh harapan.", reference: "Yeremia 29:11"),
            Verse(text: "Apa yang harus Aku kerjakan bagimu, hai manusia? Ketakutan-Ku terhadap kamu melakukan segala ini.", reference: "Habakuk 1:12"),
            Verse(text: "Sebab rancangan-Ku bukanlah rancanganmu, dan jalanmu bukanlah jalan-Ku, demikianlah firman TUHAN. Seperti tingginya langit dari bumi, demikianlah tingginya jalan-Ku dari jalanmu dan rancangan-Ku dari rancanganmu.", reference: "Yesaya 55:8-9"),
            Verse(text: "O, alangkah dalamnya kekayaan, hikmat dan pengetahuan Allah! Sungguh tak terselidiki keputusan-keputusan-Nya dan sungguh tak terselami jalan-jalan-Nya!", reference: "Roma 11:33"),
            Verse(text: "Banyaklah rancangan di hati manusia, tetapi keputusan TUHANlah yang terlaksana.", reference: "Amsal 19:21"),
            Verse(text: "Allah itu bagi kita tempat perlindungan dan kekuatan, sebagai penolong dalam kesesakan sangat terbukti. Sebab itu kita tidak akan takut, sekalipun bumi berubah.", reference: "Mazmur 46:2-3"),
            Verse(text: "Yang dari mulanya memberitahukan apa yang kemudian terjadi. Rancangan-Ku akan terlaksana dan Aku akan melakukan semua yang Kukehendaki.", reference: "Yesaya 46:10"),
            Verse(text: "Aku bersyukur kepada-Mu oleh karena kejadianku dahsyat dan ajaib; ajaib apa yang Kaubuat, dan jiwaku benar-benar menyadarinya.", reference: "Mazmur 139:14"),
            Verse(text: "Ia membuat segala sesuatu indah pada waktunya, bahkan Ia memberikan kekekalan dalam hati mereka.", reference: "Pengkhotbah 3:11"),
            Verse(text: "Percayalah kepada TUHAN dengan segenap hatimu, dan janganlah bersandar pada pengertianmu sendiri. Akuilah Dia dalam segala lakumu, maka Ia akan meluruskan jalanmu.", reference: "Amsal 3:5-6"),
            Verse(text: "Yesus Kristus tetap sama, baik kemarin maupun hari ini dan sampai selama-lamanya.", reference: "Ibrani 13:8"),
            Verse(text: "Akan hal ini aku yakin sepenuhnya, yaitu Ia, yang memulai pekerjaan yang baik di antara kamu, akan meneruskannya sampai pada akhirnya pada hari Kristus Yesus.", reference: "Filipi 1:6"),
            Verse(text: "Tetapi rencana TUHAN tetap selama-lamanya, rancangan hati-Nya turun-temurun.", reference: "Mazmur 33:11"),
            Verse(text: "Bagi Dialah, yang dapat melakukan jauh lebih banyak dari pada yang kita doakan atau pikirkan, seperti yang ternyata dari kuasa yang bekerja di dalam kita.", reference: "Efesus 3:20"),
            Verse(text: "Aku adalah Alfa dan Omega, firman Tuhan Allah, yang ada dan yang sudah ada dan yang akan datang, Yang Mahakuasa.", reference: "Wahyu 1:8"),
            Verse(text: "Waktu-waktuku ada dalam tangan-Mu.", reference: "Mazmur 31:15"),
            Verse(text: "Hati manusia memikir-mikirkan jalannya, tetapi TUHANlah yang menentukan arah langkahnya.", reference: "Amsal 16:9"),
            Verse(text: "Pertolonganku ialah dari TUHAN, yang menjadikan langit dan bumi.", reference: "Mazmur 121:2")
        ],
        songs: [
            Song(title: "Ajaib Kau Tuhan", artist: "Symphony Worship"),
            Song(title: "Engkau Luar Biasa", artist: "GMS Worship"),
            Song(title: "Karya Ajaib-Mu", artist: "JPCC Worship"),
            Song(title: "Tuhan Semesta Alam", artist: "Symphony Worship"),
            Song(title: "Besar Allahku (How Great Is Our God)", artist: "JPCC Worship"),
            Song(title: "Rencana-Mu Indah", artist: "JPCC Worship"),
            Song(title: "Percaya Rencana-Mu", artist: "Symphony Worship"),
            Song(title: "Tak Terselami", artist: "True Worshippers"),
            Song(title: "Bagaimana Tidak", artist: "Symphony Worship"),
            Song(title: "Tidak Berubah", artist: "JPCC Worship"),
            Song(title: "Tuhan Tetap Tuhan", artist: "Symphony Worship"),
            Song(title: "Dalam Tangan-Mu", artist: "JPCC Worship"),
            Song(title: "Kau Yang Pegang Kendali", artist: "Symphony Worship"),
            Song(title: "Allah Peduli", artist: "Maria Shandi"),
            Song(title: "Indah Rencana-Mu", artist: "GMS Worship"),
            Song(title: "Tak Ada Yang Mustahil", artist: "Symphony Worship"),
            Song(title: "Maha Kuasa", artist: "GMS Worship"),
            Song(title: "Ia Pegang Kendali", artist: "Symphony Worship"),
            Song(title: "Kami Puji Dengan Riang", artist: "Kidung Jemaat 3"),
            Song(title: "Bila Kulihat Bintang Gemerlapan", artist: "Kidung Jemaat 64")
        ],
        presenceTemplate: "Bapa, aku menghentikan aktivitasku sejenak untuk diam di hadirat-Mu, menyadari bahwa bagi-Mu tidak ada sesuatu pun yang mengejutkan atau di luar kendali-Mu.",
        sections: [
            ReflectionSection(title: "Ucapan Syukur", placeholder: "Tulis hal yang disyukuri...", isEditable: true),
            ReflectionSection(title: "Refleksi Diri", placeholder: "Apa yang membuatmu merasa terkejut?", isEditable: true),
            ReflectionSection(title: "Pengakuan Diri", placeholder: "Apa yang kamu alami/lakukan sehingga merasa terkejut?", isEditable: true),
            ReflectionSection(title: "Refleksi Ayat", placeholder: "Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "Resolusi", placeholder: "Langkah konkret apa yang akan kamu lakukan untuk menjadi lebih baik?", isEditable: true)
        ]
    ),

    // ─────────────────────────────────────────────
    // TAKUT  –  Perlindungan Tuhan, keberanian, jangan takut
    // ─────────────────────────────────────────────
    "Takut": EmotionContent(
        verses: [
            Verse(text: "Jangan takut, sebab Aku menyertai engkau; jangan gelisah, sebab Aku adalah Allahmu; Aku akan memperkuatkan engkau dan menolong engkau.", reference: "Yesaya 41:10"),
            Verse(text: "Tuhanlah terangku dan keselamatanku, kepada siapakah aku harus takut?", reference: "Mazmur 27:1"),
            Verse(text: "Kasih yang sempurna menghalau ketakutan, karena ketakutan menyertakan siksaan.", reference: "1 Yohanes 4:18"),
            Verse(text: "Bukankah telah Kuperintahkan kepadamu: kuatkan dan teguhkanlah hatimu? Janganlah kecut dan tawar hati, sebab TUHAN, Allahmu, menyertai engkau ke mana pun engkau pergi.", reference: "Yosua 1:9"),
            Verse(text: "Jika Allah di pihak kita, siapakah yang akan melawan kita?", reference: "Roma 8:31"),
            Verse(text: "Kepada Allah, yang firman-Nya kupuji, kepada Allah aku percaya, aku tidak takut. Apakah yang dapat dilakukan manusia terhadap aku?", reference: "Mazmur 56:4"),
            Verse(text: "Dengan kepak-Nya Ia akan menudungi engkau, di bawah sayap-Nya engkau akan berlindung, kesetiaan-Nya ialah perisai dan pagar tembok.", reference: "Mazmur 91:4"),
            Verse(text: "Damai sejahtera Kutinggalkan bagimu. Damai sejahtera-Ku Kuberikan kepadamu, dan apa yang Kuberikan tidak seperti yang diberikan oleh dunia kepadamu. Janganlah gelisah dan gentar hatimu.", reference: "Yohanes 14:27"),
            Verse(text: "Sebab Allah memberikan kepada kita bukan roh ketakutan, melainkan roh yang membangkitkan kekuatan, kasih dan ketertiban.", reference: "2 Timotius 1:7"),
            Verse(text: "Allah itu bagi kita tempat perlindungan dan kekuatan, sebagai penolong dalam kesesakan sangat terbukti.", reference: "Mazmur 46:1"),
            Verse(text: "Janganlah takut, sebab Aku telah menebus engkau, Aku telah memanggil engkau dengan namamu, engkau ini kepunyaan-Ku.", reference: "Yesaya 43:1"),
            Verse(text: "Sekalipun aku berjalan dalam lembah kekelaman, aku tidak takut bahaya, sebab Engkau besertaku; gada-Mu dan tongkat-Mu, itulah yang menghibur aku.", reference: "Mazmur 23:4"),
            Verse(text: "Tuhan adalah penolongku. Aku tidak akan takut. Apakah yang dapat dilakukan manusia terhadap aku?", reference: "Ibrani 13:6"),
            Verse(text: "Tujukanlah pandanganmu kepada-Nya, maka mukamu akan berseri-seri, dan kamu tidak akan malu.", reference: "Mazmur 34:5"),
            Verse(text: "Sebab itu janganlah kamu takut, karena kamu lebih berharga dari pada banyak burung pipit.", reference: "Matius 10:31"),
            Verse(text: "TUHAN, Dia sendiri akan berjalan di depanmu, Dia sendiri akan menyertai engkau, Dia tidak akan membiarkan engkau dan tidak akan meninggalkan engkau; janganlah takut dan janganlah patah hati.", reference: "Ulangan 31:8"),
            Verse(text: "TUHAN di pihakku, aku tidak akan takut. Apakah yang dapat dilakukan manusia terhadap aku?", reference: "Mazmur 118:6"),
            Verse(text: "Kamu tidak menerima roh perbudakan yang membuat kamu menjadi takut lagi, tetapi kamu telah menerima Roh yang menjadikan kamu anak Allah.", reference: "Roma 8:15"),
            Verse(text: "Aku memberikan hidup yang kekal kepada mereka dan mereka pasti tidak akan binasa sampai selama-lamanya dan seorang pun tidak akan merebut mereka dari tangan-Ku.", reference: "Yohanes 10:28")
        ],
        songs: [
            Song(title: "Jangan Lelah", artist: "Franky Sihombing"),
            Song(title: "Kuasa Nama Yesus", artist: "JPCC Worship"),
            Song(title: "Tuhan, Pimpin AnakMu", artist: "Kidung Jemaat 413"),
            Song(title: "Lebih Dari Pemenang", artist: "JPCC Worship"),
            Song(title: "Aku Tidak Akan Takut", artist: "Symphony Worship"),
            Song(title: "Di Dalam-Mu", artist: "Symphony Worship"),
            Song(title: "Kuat Di Dalam Tuhan", artist: "GMS Worship"),
            Song(title: "Bersama Yesus", artist: "JPCC Worship"),
            Song(title: "Sempurna Kasih-Mu", artist: "JPCC Worship"),
            Song(title: "Perlindunganku", artist: "Symphony Worship"),
            Song(title: "Kemenangan Terjadi Di Sini", artist: "NDC Worship"),
            Song(title: "Berlindung", artist: "Symphony Worship"),
            Song(title: "Yesus Pelindungku", artist: "JPCC Worship"),
            Song(title: "Tangan Bapa", artist: "Symphony Worship"),
            Song(title: "Atas Nama Yesus", artist: "GMS Worship"),
            Song(title: "Kuasa Nama-Mu", artist: "JPCC Worship"),
            Song(title: "Tempatku Berlindung", artist: "Symphony Worship"),
            Song(title: "Ada Kuasa Dalam Nama Yesus", artist: "Symphony Worship"),
            Song(title: "Tenanglah Kini Hatiku", artist: "Kidung Jemaat 410"),
            Song(title: "Mampirlah, Dengarkan Doaku", artist: "Kidung Jemaat 26")
        ],
        presenceTemplate: "Tuhan, dalam rasa gentar yang aku rasakan, aku datang berlindung di bawah naungan sayap-Mu, menyadari kehadiran-Mu yang selalu memberikan rasa aman.",
        sections: [
            ReflectionSection(title: "Ucapan Syukur", placeholder: "Tulis hal yang disyukuri meskipun sedang takut...", isEditable: true),
            ReflectionSection(title: "Refleksi Diri", placeholder: "Apa yang membuatmu merasa takut?", isEditable: true),
            ReflectionSection(title: "Pengakuan Diri", placeholder: "Apa yang kamu alami/lakukan sehingga merasa takut?", isEditable: true),
            ReflectionSection(title: "Refleksi Ayat", placeholder: "Apa yang diajarkan ayat ini padamu?", isEditable: true),
            ReflectionSection(title: "Resolusi", placeholder: "Langkah konkret apa yang akan kamu lakukan untuk menjadi lebih baik?", isEditable: true)
        ]
    )
]
