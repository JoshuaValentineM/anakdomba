# AnakDomba - Project Context

## Overview
- **Project Name**: AnakDomba
- **Type**: SwiftUI iOS App (iOS 17+)
- **Purpose**: Christian daily reflection and mood-tracking app
- **Language**: Swift
- **Architecture**: MVVM with SwiftData

## Updated File Structure (April 2026)

```
AnakDomba/
├── AnakDombaApp.swift              # App entry point with SwiftData container
├── Models/
│   ├── Emotion.swift              # Emotion data model
│   ├── Verse.swift              # Bible verse model
│   ├── Song.swift              # Song model
│   ├── EmotionContent.swift     # Content data (verses, songs, prompts)
│   └── Reflection.swift         # SwiftData model for persistence (@Model)
├── ViewModels/
│   ├── SelectEmotionViewModel.swift  # Emotion selection logic
│   ├── ReflectionViewModel.swift  # Reflection logic
│   └── HistoryViewModel.swift    # History load/filter/delete
├── Views/
│   ├── ContentView.swift         # Main TabView
│   ├── Home/
│   │   └── SelectEmotionView.swift
│   └── History/
│       └── HistoryView.swift
├── Components/
│   └── PrimaryButton.swift
├── Resources/
│   └── EmotionKeywords.swift   # Keyword dictionary for emotion matching (135+ keywords)
└── Assets.xcassets/
```

---

## Features Implemented

### 1. Emotion Selection (SelectEmotionView)
- 7 emotions with emojis: Senang, Sedih, Marah, Jijik, Ragu, Terkejut, Takut
- Grid layout with color-coded boxes
- **NEW**: "Tidak yakin" (❓) 8th card for confused users
- "Mulai" button (enabled when emotion selected)
- Loading animation before navigation

### 2. "Tidak yakin" Feature (Confused Users)
User flow when confused about their emotion:
1. Tap "Tidak yakin" → Opens full-screen sheet
2. "Apa yang sedang terjadi?" → User writes what happened
3. Keywords analyzed → Shows 2-3 suggested emotions as tappable chips
4. User taps suggestion → Goes directly to Reflection with that emotion
   OR taps "Pilih sendiri" → Returns to emotion grid to pick manually

**Keyword Matching**: ~135 Indonesian keywords across 7 emotions:
- "gagal", "ditinggalkan", "menangis" → Sedih
- "marah", "kecewa", "kesal" → Marah
- "takut", "cemas", "khawatir" → Takut
- etc.

### 3. Reflection Screen (ReflectionView)
- **Dynamic Content**: Each emotion has:
  - 3 random Bible verses
  - 3 random songs
  - 1 journaling prompt template
- Background color changes based on selected emotion
- **VerseCard**: Displays verse with reference
- **SongCarousel**: Horizontal scrollable songs with dot indicators
- **ReflectionInputBox**: Tap to write in full-screen sheet
- **Discard Alert**: "Apakah kamu yakin ingin kembali?" when leaving with unsaved changes
- **Custom Back Button**: "Kembali" with confirmation dialog
- **Save Button**: "Simpan" - saves to SwiftData

### 4. Save Feature (SwiftData)
- "Simpan" button saves reflection to SwiftData
- Saves: emotionLabel, emotionEmoji, verseReference, verseText, songTitle, songArtist, userText, createdAt
- Shows "Tersimpan!" success alert
- Auto-navigates back after save

### 5. History View
- Shows all saved reflections (most recent first)
- **Filter Chips**: Semua, Senang, Sedih, Marah, Jijik, Ragu, Terkejut, Takut
- **History Card**: Shows emoji, emotion label, date, verse preview, "Baca →" indicator
- Tap card → Opens full detail view
- **Context Menu**: Long press → Delete option

---

## Core Navigation Flow
```
ContentView (TabView)
├── HomeView → PlusButton ��� SelectEmotionView → ReflectionView → Simpan
│                              ↓ (saved to SwiftData)
└── HistoryView (saved reflections with filters)
```

---

## SwiftData Model
```swift
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
}
```

---

## UI Components
- Dark mode enforced (.preferredColorScheme(.dark))
- TabView with Home and History tabs
- NavigationStack for screen navigation
- Material effects (.thinMaterial, .ultraThinMaterial)
- Glass effect for Plus button

---

## Known Issues / Notes
- Tab bar may have animation delay when navigating back from SelectEmotionView
- History card colors are currently blue (not emotion-specific yet - TODO)
- No swipe-to-delete (use long-press context menu instead)
- "Tidak yakin" flow passes context text to ReflectionView as "Before you begin..." section

---

## Future Development Ideas
1. Emotion-specific card colors in History (color based on emotion)
2. Swipe-to-delete on History cards
3. More verses/songs per emotion (expand from 3 to 10+)
4. User can customize verses and songs
5. Audio playback for songs
6. Share reflection feature
7. Edit saved reflections
8. Splash screen with app animation

---

## Build & Run
1. Open `AnakDomba.xcodeproj` in Xcode
2. Select an iOS Simulator (iPhone 16 Pro recommended)
3. Press Cmd+R to run

---

## Developer Notes

### To add new verses/songs:
Edit `Models/EmotionContent.swift` - add new Verse/Song objects to each emotion's arrays.

### To modify prompt templates:
Edit the `prompt` string in each EmotionContent entry. Use `[Ayat]` as placeholder.

### To add new emotions:
1. Add to `emotions` array in ViewModels/SelectEmotionViewModel.swift
2. Add corresponding entry in Models/EmotionContent.swift
3. Add keywords to Resources/EmotionKeywords.swift

### To add new emotion keywords:
Edit `Resources/EmotionKeywords.swift` - add Indonesian keywords to the emotion arrays.

---

*Last updated: April 18, 2026*
*Project context preserved for continuity*