# Smart Mirror Flutter Demo

A lightweight, responsive smart-mirror dashboard built with Flutter.

This repository is intentionally a **generic public demo** designed to showcase clean Flutter UI, responsive layouts, lightweight architecture, and device-friendly widgets without exposing private product concepts or proprietary LAYC research.

## What it demonstrates

- Responsive layout for portrait and wide displays
- Live clock and date
- Weather presentation card with demo data
- Daily agenda card
- Device/system status card
- Full-screen dark interface for mirror-style displays
- Minimal dependency footprint
- Basic widget smoke test
- CI checks for analysis and tests

## Efficiency goals

This demo is intentionally small.

- No runtime third-party packages for the dashboard UI
- No polling or background network services
- Local rendering first
- Small widget tree
- No image assets required
- Designed to remain practical on modest Android and desktop hardware

## Quick start

### Option A — one-command bootstrap on Windows

Clone the repository, open PowerShell in the project folder, then run:

```powershell
.\bootstrap.ps1
flutter run
```

The bootstrap script creates Android, Windows, and Web platform folders when needed, runs `flutter pub get`, and checks the project with `flutter analyze`.

### Option B — standard Flutter setup

```bash
flutter create . --platforms=android,windows,web
flutter pub get
flutter analyze
flutter test
flutter run
```

## Project structure

```text
lib/
└── main.dart

test/
└── widget_test.dart

.github/
└── workflows/
    └── flutter.yml

docs/
└── ARCHITECTURE.md
```

## Tech

- Flutter
- Dart
- Material 3

## Status

Public demo / portfolio project.

The current weather and agenda entries are intentionally demo data. Future improvements may add optional live data while keeping the app local-first and lightweight.

## Privacy

This repository does **not** contain private LAYC product designs, credentials, production infrastructure, proprietary hardware designs, or confidential research.

## License

MIT.
