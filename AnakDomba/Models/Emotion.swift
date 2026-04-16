//
//  Emotion.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 10/04/26.
//

import SwiftUI

struct Emotion: Identifiable, Equatable {
    let id = UUID()
    let emoji: String
    let label: String
    let color: Color
}