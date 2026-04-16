# AnakDomba - Project Context

## Overview
- **Project Name**: AnakDomba
- **Type**: SwiftUI iOS App (iOS 16+)
- **Purpose**: Christian daily reflection and mood-tracking app
- **Language**: Swift

## Architecture
- Single-target app
- No third-party dependencies (pure SwiftUI)
- TabView-based navigation (Home + History)

## File Structure

```
AnakDomba/
├── AnakDombaApp.swift          # App entry point
├── ContentView.swift          # Main TabView (Home + History)
├── SelectEmotionView.swift     # Emotion selection screen
├── ReflectionView.swift       # Reflection/journaling screen
├── PrimaryButton.swift        # Reusable button component
├── Emotion.swift               # Emotion data model
└── Assets.xcassets/            # Images and colors
```

## Key Features Implemented

### 1. Emotion Selection (SelectEmotionView)
- 7 emotions with emojis: Senang, Sedih, Marah, Jijik, Ragu, Terkejut, Takut
- Grid layout with color-coded boxes
- "Mulai" button (disabled until emotion selected)
- Loading animation before navigation (0.8s delay)

### 2. Reflection Screen (ReflectionView)
- **Dynamic Content**: Each emotion has:
  - 3 random Bible verses
  - 3 random songs
  - 1 journaling prompt template
- Background color changes based on selected emotion
- **VerseCard**: Displays random verse with reference
- **SongCarousel**: Horizontal scrollable list of 3 songs with dot indicators
- **ReflectionInputBox**: 
  - Shows prompt template
  - Tap to open full-screen sheet for writing
  - "Selesai" button to close
- **DraftAndSaveButton**: Save functionality placeholder

### 3. Data Structure
- `Verse`: text, reference
- `Song`: title, artist
- `Emotion`: id, emoji, label, color
- `EmotionContent`: verses[], songs[], prompt

### 4. Prompt Template
Each emotion has a journaling prompt that includes:
- Presence (1)
- Gratitude (2)
- Review (3)
- Shortcomings/Correction (4)
- Invite God/Action (5)

The `[Ayat]` placeholder in prompts is dynamically replaced with the actual verse reference.

### 5. UI Components
- Dark mode enforced
- TabView with Home and History tabs
- NavigationStack for navigation between views
- Material effects (.thinMaterial, .ultraThinMaterial)

## Navigation Flow
```
ContentView (TabView)
├── HomeView → PlusButton → SelectEmotionView → ReflectionView
└── HistoryView (placeholder)
```

## Known Issues / Notes
- Tab bar animation delay when navigating back from SelectEmotionView
- No persistence (reflections not saved yet)
- No tests, no CI/CD

## Future Development Ideas
1. Save reflections to local storage or database
2. History view - show past reflections
3. More verses/songs per emotion (10+)
4. User can customize verses and songs
5. Audio playback for songs
6. Share reflection feature
7. Splash screen with animation

## Build & Run
1. Open `AnakDomba.xcodeproj` in Xcode
2. Select an iOS Simulator (iPhone 16 Pro recommended)
3. Press Cmd+R to run

## Key Developer Notes for Future Sessions

### To add new verses/songs:
Edit `emotionContents` dictionary in `ReflectionView.swift`:
- Add new `Verse` objects to the `verses` array
- Add new `Song` objects to the `songs` array

### To modify prompt templates:
Edit the `prompt` string in each `EmotionContent` entry. Use `[Ayat]` as placeholder for verse reference.

### To add new emotions:
1. Add to `emotions` array in SelectEmotionView.swift
2. Add corresponding entry in `emotionContents` dictionary in ReflectionView.swift
3. Update backgroundColor switch in ReflectionView

---
*Last updated: April 2026*
*Project context preserved for continuity*
