//
//  ContentView.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI
import SwiftData

private let dailyVerses: [(reference: String, text: String)] = [
    ("Mazmur 139:23-24", "Selidikilah aku, ya Allah, dan kenallah hatiku, ujilah aku dan kenallah pikiran-pikiranku; lihatlah, apakah jalanku serong, dan tuntunlah aku di jalan yang kekal!"),
    ("Mazmur 62:8", "Percayalah kepada-Nya setiap waktu, hai umat, curahkanlah terpancar kehidupan."),
    ("Mazmur 42:11", "Mengapa engkau tertekan, hai jiwaku, dan mengapa engkau gelisah di dalam diriku? Berharaplah kepada Allah! Sebab aku bersyukur lagi kepada-Nya, penolongku dan Allahku!"),
    ("Filipi 4:6-7", "Janganlah hendaknya kamu kuatir tentang apapun juga, tetapi nyatakanlah dalam segala hal keinginanmu kepada Allah dalam doa dan permohonan dengan ucapan syukur."),
    ("1 Petrus 5:7", "Serahkanlah segala kekuatiranmu kepada-Nya, pues Ia yang memelihara kamu."),
    ("Mazmur 94:19", "Apabila bertambah banyak pikiran dalam batinku, penghiburan-Mu menyukakan jiwaku."),
    ("Mazmur 34:18", "TUHAN itu dekat kepada orang-orang yang patah hati, dan Ia menyelamatkan orang-orang yang remuk jiwanya."),
    ("Ratapan 3:22-23", "Tak berkesudahan kasih setia TUHAN, tak habis-habisnya rahmat-Mu, selalu baru tiap pagi; besar kesetiaan-Mu!"),
    ("Mazmur 62:8", "Percayalah kepada-Nya setiap waktu, hai umat, curahkanlah isi hatimu di hadapan-Nya; Allah，ialah tempat perlindungan kita.")
]

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Beranda", systemImage: "house")
            }

            HistoryView()
                .tabItem {
                    Label("Riwayat", systemImage: "clock")
                }
        }
        .preferredColorScheme(.dark)
    }
}

struct HomeView: View {
    @State private var dailyVerse: (reference: String, text: String)
    
    init() {
        _dailyVerse = State(initialValue: dailyVerses.randomElement()!)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(.anakDombaHorizontalLogoWhiteV2)
                .resizable()
                .scaledToFit()
                .padding(.trailing)

            VStack(spacing: 12) {
                Spacer()
                
                Spacer()

                NavigationLink(destination: SelectEmotionView()) {
                    PlusButton()
                }
                .buttonStyle(.plain)
                .padding(4)

                Text("Mulai Refleksi")
                    .font(.system(size: 30))
                
                Spacer()
                VStack(spacing: 8) {
                    Text(dailyVerse.reference)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary)
                    
                    Text("\"\(dailyVerse.text)\"")
                        .font(.body)
                        .fontDesign(.serif)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }
                .padding()
                .cornerRadius(16)
                Spacer()
            }
        }
        .padding()
    }
}

struct PlusButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.clear)
                .frame(width: 160, height: 160)
                .glassEffect()
            Text("+")
                .font(.system(size: 90))
        }
    }
}

#Preview {
    ContentView()
}
