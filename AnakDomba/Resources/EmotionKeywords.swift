//
//  EmotionKeywords.swift
//  AnakDomba
//
//  Created by Joshua Valentine Manik on 16/04/26.
//

import Foundation

enum EmotionKeywords {
    static let keywords: [String: [String]] = [
        "Sedih": [
            // Original
            "ditinggalkan", "kesakitan", "menangis", "kehilangan", "patah hati",
            "sedih", "duka", "pilu", "putus asa", "kecewa", "hati hancur",
            "kesedihan", "gagal", "tidak lolos", "menyesal", "salah",
            "tidak berhasil", "kesepian", "lelah", "bosan", "tertekan",
            "depresi", "berduka", "mengingat", "melankolis",
            // Additions: Slang, deep emotions, physical reactions
            "hampa", "merana", "nelangsa", "murung", "suram", "ambyar",
            "galau", "nyesek", "meratap", "pedih", "perih", "tersakiti",
            "terpuruk", "hancur", "menangis tersedu", "duka cita", "belasungkawa",
            "merindukan", "kangen", "air mata", "gloomy", "sad", "broken heart",
            "down", "hopeless", "sendiri", "tersisih"
        ],
        "Marah": [
            // Original
            "marah", "meradang", "kesal", "jengkel", "geram", "benci",
            "dongkel", "tidak adil", "dendam", "marah besar", "frustrasi", "frustasi",
            "sebal", "naik darah", "emosi", "kesal hati", "sakit hati",
            "membenci", "kemarahan", "protes", "komplain", "kebersalahan",
            // Additions: Slang, expressions of anger, common English
            "ngamuk", "murka", "berang", "sewot", "gondok", "bete", "bad mood",
            "muak", "mendidih", "tersinggung", "mengumpat", "berteriak",
            "dendam kesumat", "memuncak", "toxic", "mad", "angry", "pissed off",
            "emosian", "darah tinggi", "mengamuk", "ngeselin"
        ],
        "Takut": [
            // Original
            "takut", "cemas", "khawatir", "gugup", "panik", "ngeri",
            "was-was", "kecil hati", "terror", "horor", "bahaya", "mengancam",
            "insecure", "minder", "tidak berani", "takut kehilangan", "paranoid",
            "stress", "overthinking", "harapan", "uncertainty",
            // Additions: Physical responses, phobias, strong fears
            "gemetar", "merinding", "gentar", "parno", "fobia", "trauma",
            "ketakutan", "berdebar", "deg-degan", "keringat dingin", "takut mati",
            "kengerian", "seram", "menakutkan", "ciut", "nyali", "anxious",
            "phobia", "creepy", "scary", "traumatis", "ancaman"
        ],
        "Ragu": [
            // Original
            "bingung", "ragu", "bimbang", "gelisah", "tidak tahu", "tidak yakin",
            "between", "gamang", "fluctuate", "bingung pikiran", "tidak decide",
            "wait and see", "pending", "wait", "suspense", "stuck", "ambigu",
            // Additions: Indecision, mental fog, dilemmas
            "linglung", "pusing", "mumet", "ruwet", "plin-plan", "abu-abu",
            "tidak jelas", "mikir dua kali", "serba salah", "dilema", "ragu-ragu",
            "buntu", "confused", "clueless", "overthink", "galau", "buntu",
            "gatau", "ntahlah", "entahlah"
        ],
        "Jijik": [
            // Original
            "jijik", "mual", "kotor", "najis", "haram", "jorok",
            "menjijikkan", "bau", "tidak bersih", "vomit", "enek", "sumbang",
            "urais", "hygiene", "kekotoran", "kuman",
            // Additions: Slang, sensory reactions, disgust
            "ilfeel", "geli", "muak", "eneg", "kumuh", "jorok sekali",
            "bau menyengat", "tengik", "busuk", "berlendir", "kotoran",
            "amis", "anyir", "gross", "disgusting", "yuck", "eww", "ih", "menjijikan"
        ],
        "Terkejut": [
            // Original
            "terkejut", "shock", "heran", "takjub", "terbelalak",
            "tidak percaya", "wow", "gablek", "kaget", "tercengang",
            "terpesona", "surprise", "unexpected", "disbelief", "terharu",
            "melihat",
            // Additions: Exclamations, suddenness, disbelief
            "astaga", "ya ampun", "hah", "melongo", "terkesiap", "di luar nurul",
            "di luar nalar", "speechless", "tak terduga", "mendadak", "tiba-tiba",
            "syok", "shook", "mindblowing", "tak disangka", "kaget banget", "speechless"
        ],
        "Senang": [
            // Original
            "senang", "gembira", "bahagia", "suka", "bergembira", "teruja",
            "senyum", "ketawa", "ceria", "bersyukur", "excited", "entusiastis",
            "cinta", "sayang", "sukacita", "euphoria", "delighted", "satisfied",
            "proud", "bangga", "sukses", "berhasil", "menang",
            // Additions: Relief, modern slang, positive expressions
            "asyik", "mantap", "seru", "berseri-seri", "riang", "gembira ria",
            "lega", "hoki", "beruntung", "puji tuhan", "alhamdulillah",
            "full senyum", "berbunga-bunga", "jatuh cinta", "kasmaran",
            "happy", "blessed", "joy", "thrilled", "fun", "enjoy", "lega rasanya"
        ]
    ]
}
