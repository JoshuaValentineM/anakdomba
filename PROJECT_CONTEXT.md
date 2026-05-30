# AnakDomba - Project Context

## Project Summary
- Project: `AnakDomba`
- Platform: iOS app built with SwiftUI
- Persistence: SwiftData
- App purpose: emotion-based Christian reflection flow with verse/song guidance and saved reflection history
- Current main flow:
  - `ContentView` -> `HomeView` -> `SelectEmotionView` -> `ReflectionView`
  - Saved reflections are shown in `HistoryView`

## Important Files
- [AnakDombaApp.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/AnakDombaApp.swift)
  - App entry point
  - Provides `.modelContainer(for: UserReflection.self)`
- [ContentView.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/Views/ContentView.swift)
  - Main tab structure for Home and History
- [SelectEmotionView.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/Views/Home/SelectEmotionView.swift)
  - Emotion selection UI
  - Includes `Tidak yakin` helper flow
- [ReflectionView.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/Views/Reflection/ReflectionView.swift)
  - Reflection screen with verse, song, step flow, save flow
- [HistoryView.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/Views/History/HistoryView.swift)
  - Reflection history list and navigation back into saved reflections
- [PrimaryButton.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/Components/PrimaryButton.swift)
  - Reusable button with glass effect
- [Reflection.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/Models/Reflection.swift)
  - SwiftData `@Model` for saved reflections
- [EmotionKeywords.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/Resources/EmotionKeywords.swift)
  - Keyword matching source for `Tidak yakin`

## Data Model
- Persisted model: `UserReflection`
- Stores:
  - emotion label + emoji
  - verse reference + verse text
  - song title + artist
  - presence / gratitude / review / verseReflection / songReflection / action text
  - created / updated timestamps

## Emotion System
- Main emotion cards:
  - `Marah` -> red
  - `Ragu` -> purple
  - `Takut` -> teal
  - `Sedih` -> blue
  - `Senang` -> yellow
  - `Jijik` -> green
  - `Terkejut` -> orange
  - `Tidak yakin` -> gray

## Current UX Decisions

### Select Emotion Screen
- Keep `Bagaimana wajahmu saat ini?` as the navigation title only
- Subtitle/helper text under it:
  - `Pilih yang sesuai dengan perasaanmu.`
  - `Tahan untuk melihat detail perasaan.`
- Page uses a subtle top tint based on the selected emotion
- `Mulai` button uses a softened tint derived from the selected emotion, not the raw bright emotion color
- Emotion cards:
  - Front side should stay visually simple: emoji + emotion label only
  - Long press flips card to detail side
  - Tap selects the emotion
  - Only one card should be flipped at a time
  - Selecting another emotion should reset any flipped card
- `Tidak yakin` card opens a helper sheet

### Reflection Screen
- Emotion color is used as subtle accent, not as an overwhelming full-screen fill
- Section labels were intentionally added for harmony:
  - `Ayat Alkitab`
  - `Lagu Rohani`
  - `Refleksi atas Perasaan ...ku`
- Title-to-content spacing was normalized
- Song carousel top alignment was fixed so its gap matches other sections
- Reflection step area uses a progress bar instead of a simple divider
- Reflection text editor is fixed-height and scrolls internally
- Reflection card height was reduced from the earlier larger version

### History Screen
- History cards use emotion-based color tint by saved emotion label
- Opening a saved reflection should restore the correct emotion color
- `Ragu` must reopen purple, not blue

## `Tidak yakin` Sheet Behavior
- The sheet is a multi-step helper flow:
  1. User writes what happened
  2. App suggests possible emotions
  3. User either picks a suggestion or goes back to manual choice
- Sheet styling:
  - Uses material/glass-like background, not an opaque dark block
  - Input area is glass-style too
- Suggestion step behavior:
  - If no suggestions are found:
    - Do not show `Berdasarkan tulisanmu, mungkin kamu merasa:`
    - Show a proper empty state message
    - Show button text: `Kembali pilih perasaan`
  - If suggestions are found:
    - Show `Berdasarkan tulisanmu, mungkin kamu merasa:`
    - Center results if count is 1 or 2
    - Use grid if count is 3+
    - Show `Atau`
    - Then show `Kembali ke pilih perasaan`

## Navigation / Save Behavior
- After tapping `Simpan` in `ReflectionView`, save success modal appears
- Tapping `Tutup Refleksi` should return user to Home, not stop on `SelectEmotionView`
- This was implemented using notifications between `ReflectionView` and `SelectEmotionView`
- Saved reflections should appear in `HistoryView`

## Session Work Completed

### ReflectionView work
- Added section titles above verse card and song carousel
- Normalized spacing between titles and content
- Fixed song carousel top gap issue caused by `TabView`
- Reworked emotion color usage to be more subtle and component-based
- Made reflection screen more adaptive for light/dark surfaces
- Removed excessive borders after testing
- Replaced divider with progress bar
- Made step content area constrained and scrollable
- Made text editor fixed-height so it scrolls instead of expanding
- Tuned reflection card and spacing to feel more compact
- Back toolbar button hit area was expanded to full usable tap target

### History / navigation work
- History cards reopen reflections with the correct emotion color
- Return-to-home flow after save was implemented
- History refresh logic was reworked multiple times due debugging

### SelectEmotionView work
- Added subtle selected-emotion page tint
- Tuned `Mulai` button tint to match selected emotion more softly
- Added helper subtitle lines below the nav title
- Tried multiple card-detail interaction patterns:
  - info icon flip
  - long press flip
- Final intended direction:
  - no visible info icon clutter
  - long press anywhere on card for detail
  - tap anywhere on card to select
  - only one flipped card at a time
- `Tidak yakin` suggestion and empty-state flow was refined
- Bottom `Mulai` area was iterated between floating / glass / block styles

## Current Known Fragile Area
- The most fragile part of the code right now is `SelectEmotionView` gesture handling on emotion cards.
- There have been several iterations around:
  - tap to select
  - long press to flip
  - preventing long press release from also triggering tap
  - ensuring the whole card is tappable, not only the emoji/text area
- If future chats touch `SelectEmotionView`, this is the first thing to verify in simulator:
  1. tap anywhere on card selects
  2. long press anywhere flips
  3. long press again while flipped flips back
  4. selecting another emotion resets the previously flipped card

## Current Known Styling Intent
- The app should feel calm, soft, and emotionally guided
- Reflection screen is currently the strongest visual reference for “good color usage”
- Select emotion screen should not feel flat, but also should not feel over-designed
- The user prefers:
  - subtle tinted surfaces
  - simple card faces
  - minimal extra icons
  - no repeated titles

## Practical Notes For Future Chats
- Read [SelectEmotionView.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/Views/Home/SelectEmotionView.swift) first if the task is about:
  - card interaction
  - `Tidak yakin` flow
  - `Mulai` button layout
- Read [ReflectionView.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/Views/Reflection/ReflectionView.swift) first if the task is about:
  - color harmony
  - spacing
  - progress flow
  - save behavior
- Read [HistoryView.swift](/Users/joshua/Projects/AnakDomba/AnakDomba/Views/History/HistoryView.swift) first if the task is about:
  - saved items not appearing
  - wrong emotion color when reopening

## Open Follow-up Areas
- Re-verify `SelectEmotionView` card gestures in simulator after any future edits
- Re-verify `Tidak yakin` helper sheet spacing and centering on smaller devices
- Re-verify history persistence after bigger SwiftData/model changes
