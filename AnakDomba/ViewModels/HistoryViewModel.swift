//
//  HistoryViewModel.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 18/04/26.
//

import SwiftUI
import SwiftData
import Combine

@MainActor
class HistoryViewModel: ObservableObject {
    @Published var reflections: [UserReflection] = []
    @Published var selectedFilter: String? = nil
    
    private var modelContext: ModelContext?
    
    let allEmotions = ["Senang", "Sedih", "Marah", "Jijik", "Ragu", "Terkejut", "Takut"]
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    func loadReflections() {
        guard let context = modelContext else { return }
        
        do {
            let descriptor = FetchDescriptor<UserReflection>(
                sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
            )
            reflections = try context.fetch(descriptor)
        } catch {
            print("Failed to load reflections: \(error)")
        }
    }
    
    func delete(id: UUID) {
        guard let context = modelContext else { return }
        
        if let reflection = reflections.first(where: { $0.id == id }) {
            context.delete(reflection)
            do {
                try context.save()
                loadReflections()
            } catch {
                print("Failed to delete: \(error)")
            }
        }
    }
    
    func filterReflections() -> [UserReflection] {
        if let filter = selectedFilter {
            return reflections.filter { $0.emotionLabel == filter }
        }
        return reflections
    }
    
    func getEmotionColor(_ label: String) -> Color {
        switch label {
        case "Senang": return .yellow.opacity(0.15)
        case "Sedih": return .blue.opacity(0.15)
        case "Marah": return .red.opacity(0.15)
        case "Jijik": return .green.opacity(0.15)
        case "Ragu": return .purple.opacity(0.15)
        case "Terkejut": return .orange.opacity(0.15)
        case "Takut": return .teal.opacity(0.15)
        default: return .black
        }
    }
}