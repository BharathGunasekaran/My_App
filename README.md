# 🎵 Music Player (Flutter)

A simple cross-platform **music player app** built with **Flutter**. Pick songs from your
device and play them with standard playback controls.

## Features

- 📂 Pick audio files from device storage
- ▶️ Play and pause, and skip to the previous or next song
- 📋 Song list screen and a dedicated player screen
- 📱 Runs on Android, iOS, web and desktop (one Flutter codebase)

## Tech stack

- Flutter, Dart
- [`just_audio`](https://pub.dev/packages/just_audio) and [`audioplayers`](https://pub.dev/packages/audioplayers) for playback
- [`file_picker`](https://pub.dev/packages/file_picker) for choosing songs

## Getting started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)

### Run the app
```bash
flutter pub get
flutter run
```

## Project structure

```text
lib/
├── main.dart     # App entry point
├── songs.dart    # Song list screen
└── player.dart   # Player screen and playback controls
```
