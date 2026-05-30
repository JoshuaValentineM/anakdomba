//
//  HistoryView.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 18/04/26.
//

import SwiftUI
import SwiftData

private func emotionColor(for label: String) -> Color {
    switch label {
    case "Senang": return .yellow
    case "Sedih": return .blue
    case "Marah": return .red
    case "Jijik": return .green
    case "Ragu": return .purple
    case "Terkejut": return .orange
    case "Takut": return .teal
    default: return .blue
    }
}

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @State private var reflections: [UserReflection] = []
    @State private var selectedFilter: String? = nil
    @State private var selectedReflection: UserReflection?
    @State private var navigateToReflection = false
    @State private var reflectionToDelete: UserReflection?
    @State private var showDeleteAlert = false
    
    func deleteReflection(_ reflection: UserReflection) {
        reflectionToDelete = reflection
        showDeleteAlert = true
    }
    
    func loadReflections() {
        do {
            let descriptor = FetchDescriptor<UserReflection>(
                sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
            )
            reflections = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load reflections: \(error)")
        }
    }
    
    func confirmDelete() {
        guard let reflection = reflectionToDelete else { return }
        modelContext.delete(reflection)
        do {
            try modelContext.save()
            loadReflections()
        } catch {
            print("Failed to delete: \(error)")
        }
        reflectionToDelete = nil
    }
    
    var body: some View {
        VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(label: "Semua", isSelected: selectedFilter == nil, accentColor: .blue) {
                            selectedFilter = nil
                        }
                        
                        ForEach(["Senang", "Sedih", "Marah", "Jijik", "Ragu", "Terkejut", "Takut"], id: \.self) { emotion in
                            FilterChip(
                                label: emotion,
                                isSelected: selectedFilter == emotion,
                                accentColor: emotionColor(for: emotion)
                            ) {
                                selectedFilter = emotion
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                
                if reflectionsToShow.isEmpty {
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
        .background(AppTheme.baseBackground(for: colorScheme))
        .navigationTitle("Riwayat")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadReflections()
        }
        .onReceive(NotificationCenter.default.publisher(for: .reflectionDidSave)) { _ in
            loadReflections()
        }
        .navigationDestination(isPresented: $navigateToReflection) {
            if let reflection = selectedReflection {
                ReflectionView(
                    selectedEmotion: Emotion(
                        emoji: reflection.emotionEmoji,
                        label: reflection.emotionLabel,
                        color: emotionColor(for: reflection.emotionLabel)
                    ),
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
    
    var reflectionsToShow: [UserReflection] {
        if let filter = selectedFilter {
            return reflections.filter { $0.emotionLabel == filter }
        }
        return reflections
    }
}

struct FilterChip: View {
    @Environment(\.colorScheme) private var colorScheme
    let label: String
    let isSelected: Bool
    let accentColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? AppTheme.inverseText(for: colorScheme) : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? AppTheme.chipSelectedBackground(accentColor: accentColor, scheme: colorScheme) : AppTheme.chipBackground(for: colorScheme))
                .cornerRadius(20)
        }
    }
}

struct HistoryCardView: View {
    @Environment(\.colorScheme) private var colorScheme
    let reflection: UserReflection
    
    var cardColor: Color {
        switch reflection.emotionLabel {
        case "Senang": return AppTheme.historyCardTint(accentColor: .yellow, scheme: colorScheme)
        case "Sedih": return AppTheme.historyCardTint(accentColor: .blue, scheme: colorScheme)
        case "Marah": return AppTheme.historyCardTint(accentColor: .red, scheme: colorScheme)
        case "Jijik": return AppTheme.historyCardTint(accentColor: .green, scheme: colorScheme)
        case "Ragu": return AppTheme.historyCardTint(accentColor: .purple, scheme: colorScheme)
        case "Terkejut": return AppTheme.historyCardTint(accentColor: .orange, scheme: colorScheme)
        case "Takut": return AppTheme.historyCardTint(accentColor: .teal, scheme: colorScheme)
        default: return AppTheme.historyCardTint(accentColor: .blue, scheme: colorScheme)
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
                Text("Baca →").font(.caption).foregroundColor(.secondary)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.historyCardBase(for: colorScheme))
            RoundedRectangle(cornerRadius: 16)
                .fill(cardColor)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
        )
    }
}

struct DetailView: View {
    @Environment(\.colorScheme) private var colorScheme
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
                .padding()
                .background(AppTheme.cardElevatedBackground(for: colorScheme))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.cardStroke(for: colorScheme), lineWidth: 1)
                )
                .cornerRadius(12)
                
                Spacer()
            }
            .padding()
        }
        .background(AppTheme.baseBackground(for: colorScheme))
        .navigationTitle("Refleksi")
        .navigationBarTitleDisplayMode(.inline)
    }
}
