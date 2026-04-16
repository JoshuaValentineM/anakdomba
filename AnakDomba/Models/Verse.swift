//
//  Verse.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 17/04/26.
//

import Foundation

struct Verse: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let reference: String
}