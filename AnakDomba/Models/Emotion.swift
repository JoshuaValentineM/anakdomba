//
//  Emotion.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI

struct Emotion: Identifiable, Equatable, Hashable {
    let id = UUID()
    let emoji: String
    let label: String
    let color: Color
    
    static func == (lhs: Emotion, rhs: Emotion) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
