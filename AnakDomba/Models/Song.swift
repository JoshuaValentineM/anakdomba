//
//  Song.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 17/04/26.
//

import Foundation

struct Song: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let artist: String
}