//
//  ContentView.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack{
                HomeView()
            }
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
        }
        .preferredColorScheme(.dark)
    }
}

struct HomeView: View {
//    @State private var showSelectEmotion = false
    
    var body: some View {
        VStack(spacing: 16) {
//            Text("[Logo]")
//                .font(.system(size: 36))
//                .bold()
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.leading, 16)
            Image(.anakDombaHorizontalLogoWhiteV2)
                .resizable()
                .scaledToFit()
                .padding(.trailing)

//            Spacer()

            VStack(spacing: 12) {
                Spacer()
                
//                Button(action: {
//                    print("Plus gas")
//                }) {
//                    PlusButton()
//                }
//                
                    NavigationLink(destination: SelectEmotionView()){
                        PlusButton()
                    }
                
//                Button {
//                    showSelectEmotion = true;
//                } label: {
//                    PlusButton()
//                }
//                .fullScreenCover(isPresented: $showSelectEmotion){
//                    SelectEmotion()
//                }
                    
                .buttonStyle(.plain)
                .padding(4)
                
                Text("Mulai Refleksi")
                    .font(.system(size: 30))
                Spacer()
                Spacer()
                
            }
        }
        .padding()
//        .background(.red)
    }
}

struct HistoryView: View {
    var body: some View {
        Text("History")
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
