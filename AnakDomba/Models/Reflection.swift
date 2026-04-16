//
//  Reflection.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 17/04/26.
//

import SwiftData
import Foundation

@Model
final class UserReflection {
    var id: UUID
    var emotionLabel: String
    var emotionEmoji: String
    var verseReference: String
    var verseText: String
    var songTitle: String
    var songArtist: String
    var userText: String
    var createdAt: Date
    var updatedAt: Date
    
    init(
        id: UUID = UUID(),
        emotionLabel: String,
        emotionEmoji: String,
        verseReference: String,
        verseText: String,
        songTitle: String,
        songArtist: String,
        userText: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.emotionLabel = emotionLabel
        self.emotionEmoji = emotionEmoji
        self.verseReference = verseReference
        self.verseText = verseText
        self.songTitle = songTitle
        self.songArtist = songArtist
        self.userText = userText
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}