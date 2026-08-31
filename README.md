# 💇‍♀️ GlowUp Salon App

A modern salon booking app built with **Flutter**, following **Clean Architecture** principles for a scalable, testable, and maintainable codebase.

<!-- Optional: add screenshots once you have them
<p align="center">
  <img src="screenshots/home.png" width="200" />
  <img src="screenshots/booking.png" width="200" />
  <img src="screenshots/bookings.png" width="200" />
</p>
-->

## ✨ Features

- 🔍 **Browse services** — search and filter by category (Hair, Nails, Skin, Spa)
- 📅 **Book appointments** — pick a stylist, date, and time in a few taps
- 🗂️ **Manage bookings** — view all upcoming appointments, cancel anytime
- 💾 **Persistent storage** — bookings are saved on-device and survive app restarts
- 🎨 **Clean, warm UI** — Material 3 design with a custom terracotta theme

## 🏗️ Architecture

This project follows **Clean Architecture**, organized by feature, with a strict one-way dependency rule: `presentation → domain ← data`.

```
lib/
├── main.dart                    # App entry point & dependency wiring
├── core/
│   ├── di/                      # Dependency injection (get_it)
│   ├── theme/                   # App-wide colors & ThemeData
│   └── utils/                   # Shared helpers
└── features/
    ├── services/
    │   ├── domain/               # Entities, repository interfaces, use cases
    │   ├── data/                 # Models, data sources, repository impl
    │   └── presentation/         # Providers, pages, widgets
    └── booking/
        ├── domain/
        ├── data/
        └── presentation/
```

| Layer | Responsibility | Depends on |
|---|---|---|
| **Domain** | Business entities & rules — pure Dart, no Flutter imports | Nothing |
| **Data** | Models, local/remote data sources, repository implementations | Domain |
| **Presentation** | UI, state management (Providers), navigation | Domain (via use cases) |

This separation means storage (e.g. swapping `shared_preferences` for `sqflite` or a REST API) can change without touching business logic or UI.

## 🛠️ Tech Stack

- **[Flutter](https://flutter.dev)** — UI toolkit
- **[Provider](https://pub.dev/packages/provider)** — state management
- **[get_it](https://pub.dev/packages/get_it)** — dependency injection / service locator
- **[shared_preferences](https://pub.dev/packages/shared_preferences)** — local persistence for bookings
- **[intl](https://pub.dev/packages/intl)** — date/time formatting
- **[uuid](https://pub.dev/packages/uuid)** — unique booking IDs

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- Android Studio / Xcode set up for your target platform

### Setup

```bash
# 1. Clone the repo
git clone https://github.com/AnuradhaB1710/GlowUpSalonApp.git
cd GlowUpSalonApp

# 2. Generate platform folders (android/ios), if not already present
flutter create --platforms=android,ios .

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

## 📂 Project Structure Notes

- **Services & stylists** are static demo data (`ServiceLocalDataSourceImpl`) — swap for an API when ready.
- **Bookings** persist via `shared_preferences`, serialized as JSON, until the user explicitly deletes one.
- To move to a database or backend later, only the `data/` layer for that feature needs to change — see inline comments in each `*_local_datasource.dart` file.

## 🗺️ Roadmap Ideas

- [ ] Push notification reminders before appointments
- [ ] Stylist availability calendar
- [ ] Online payment integration
- [ ] User accounts & booking history sync across devices

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you'd like to change.

## 📄 License

This project is open source. Add a license (e.g. MIT) here if you plan to share it publicly.