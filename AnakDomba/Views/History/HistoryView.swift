//
//  HistoryView.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 18/04/26.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = HistoryViewModel()
    @State private var selectedReflection: UserReflection?
    @State private var navigateToReflection = false
    @State private var reflectionToDelete: UserReflection?
    @State private var showDeleteAlert = false
    
    func deleteReflection(_ reflection: UserReflection) {
        reflectionToDelete = reflection
        showDeleteAlert = true
    }
    
    func confirmDelete() {
        guard let reflection = reflectionToDelete else { return }
        modelContext.delete(reflection)
        do {
            try modelContext.save()
            viewModel.loadReflections()
        } catch {
            print("Failed to delete: \(error)")
        }
        reflectionToDelete = nil
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(label: "Semua", isSelected: viewModel.selectedFilter == nil) {
                            viewModel.selectedFilter = nil
                        }
                        
                        ForEach(["Senang", "Sedih", "Marah", "Jijik", "Ragu", "Terkejut", "Takut"], id: \.self) { emotion in
                            FilterChip(label: emotion, isSelected: viewModel.selectedFilter == emotion) {
                                viewModel.selectedFilter = emotion
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                
                if viewModel.reflections.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()
                        Image(systemName: "clock")
                            .font(.system(size: 48))
                            .foregroundColor(.secondary)
                        Text("Belum ada refleksi")
                            .font(.headline)
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(reflectionsToShow) { reflection in
                            HistoryCardView(reflection: reflection)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    Button {
                                        selectedReflection = reflection
                                        navigateToReflection = true
                                    } label: {
                                        Label("Lihat", systemImage: "eye")
                                    }
                                    .tint(.blue)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        deleteReflection(reflection)
                                    } label: {
                                        Label("Hapus", systemImage: "trash")
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedReflection = reflection
                                    navigateToReflection = true
                                }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                }
            }
            .background(Color.black.opacity(0.95))
            .navigationTitle("Riwayat")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.setModelContext(modelContext)
                viewModel.loadReflections()
            }
            .navigationDestination(isPresented: $navigateToReflection) {
                if let reflection = selectedReflection {
                    ReflectionView(
                        selectedEmotion: Emotion(emoji: reflection.emotionEmoji, label: reflection.emotionLabel, color: .blue),
                        existingReflection: reflection
                    )
                }
            }
            .alert("Hapus Refleksi?", isPresented: $showDeleteAlert) {
                Button("Batal", role: .cancel) {
                    reflectionToDelete = nil
                }
                Button("Hapus", role: .destructive) {
                    confirmDelete()
                }
            } message: {
                Text("Refleksi ini akan dihapus secara permanen.")
            }
        }
    }
    
    var reflectionsToShow: [UserReflection] {
        if let filter = viewModel.selectedFilter {
            return viewModel.reflections.filter { $0.emotionLabel == filter }
        }
        return viewModel.reflections
    }
}

struct FilterChip: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.white.opacity(0.1))
                .cornerRadius(20)
        }
    }
}

struct HistoryCardView: View {
    let reflection: UserReflection
    
    var cardColor: Color {
        switch reflection.emotionLabel {
        case "Senang": return .yellow.opacity(0.15)
        case "Sedih": return .blue.opacity(0.15)
        case "Marah": return .red.opacity(0.15)
        case "Jijik": return .green.opacity(0.15)
        case "Ragu": return .purple.opacity(0.15)
        case "Terkejut": return .orange.opacity(0.15)
        case "Takut": return .teal.opacity(0.15)
        default: return .blue.opacity(0.15)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(reflection.emotionEmoji)
                    .font(.system(size: 20))
                Text(reflection.emotionLabel)
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Text(reflection.createdAt.formatted(date: .abbreviated, time: .omitted))
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            
            Text(reflection.verseText.prefix(80) + "...")
                .font(.body)
                .lineLimit(2)
            
            Text("- \(reflection.verseReference)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                Spacer()
                Text("Baca →").font(.caption).foregroundColor(.white.opacity(0.7))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardColor)
        .cornerRadius(16)
    }
}

struct DetailView: View {
    let reflection: UserReflection
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(reflection.emotionEmoji).font(.system(size: 40))
                    VStack(alignment: .leading) {
                        Text(reflection.emotionLabel).font(.title2).fontWeight(.bold)
                        Text(reflection.createdAt.formatted(date: .long, time: .shortened))
                            .font(.caption).foregroundColor(.secondary)
                    }
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ayat").font(.headline).foregroundColor(.secondary)
                    Text(reflection.verseReference).font(.title3).fontWeight(.semibold)
                    Text("\"\(reflection.verseText)\"").font(.body).fontDesign(.serif)
                }
                .padding().background(.thinMaterial).cornerRadius(12)
                
                Spacer()
            }
            .padding()
        }
        .background(Color.black.opacity(0.9))
        .navigationTitle("Refleksi")
        .navigationBarTitleDisplayMode(.inline)
    }
}
