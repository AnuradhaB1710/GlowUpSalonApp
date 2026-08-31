# Bloom Salon — Flutter, Clean Architecture

Same salon booking app as before, restructured into **Clean Architecture**:
domain → data → presentation, per feature, with dependency injection.

## Why this structure

- **Domain** (`domain/`) is pure Dart — entities, repository *interfaces*, and
  use cases. No Flutter import, no knowledge of where data comes from or how
  it's displayed. This is the layer business rules live in and the one that
  changes least often.
- **Data** (`data/`) implements the domain's repository interfaces. It owns
  models (with `fromJson`/`toJson`), and data sources (currently in-memory —
  swap for `sqflite`, `shared_preferences`, or a REST client without touching
  domain or presentation).
- **Presentation** (`presentation/`) is Flutter-only — `ChangeNotifier`
  providers, pages, widgets. Pages talk to providers; providers talk to use
  cases; nothing above the data layer touches a data source directly.

The dependency rule: **inner layers never import outer layers.** Domain
knows nothing about data or presentation. Data knows about domain (it
implements domain contracts) but not presentation. Presentation depends on
domain (via use cases), not on data directly.

## Folder structure

```
lib/
├── main.dart                        # wires DI + providers, launches HomePage
├── core/
│   ├── di/service_locator.dart      # get_it wiring: datasource→repo→usecase→provider
│   ├── theme/app_theme.dart         # colors & ThemeData
│   └── utils/icon_mapper.dart       # maps domain's iconKey string -> IconData
└── features/
    ├── services/
    │   ├── domain/
    │   │   ├── entities/            # ServiceEntity, StylistEntity
    │   │   ├── repositories/        # ServiceRepository (abstract)
    │   │   └── usecases/            # GetServices, GetStylists
    │   ├── data/
    │   │   ├── models/              # ServiceModel, StylistModel (+ JSON)
    │   │   ├── datasources/         # ServiceLocalDataSource (in-memory)
    │   │   └── repositories/        # ServiceRepositoryImpl
    │   └── presentation/
    │       ├── providers/           # ServiceProvider (ChangeNotifier)
    │       ├── pages/               # HomePage
    │       └── widgets/             # ServiceCard
    └── booking/
        ├── domain/
        │   ├── entities/            # BookingEntity
        │   ├── repositories/        # BookingRepository (abstract)
        │   └── usecases/            # CreateBooking, GetBookings, CancelBooking
        ├── data/
        │   ├── models/              # BookingModel (+ JSON)
        │   ├── datasources/         # BookingLocalDataSource (in-memory)
        │   └── repositories/        # BookingRepositoryImpl
        └── presentation/
            ├── providers/           # BookingProvider
            └── pages/               # BookingPage, BookingsListPage
```

## State management & DI

- **provider** (`ChangeNotifier`) — simple, official-recommendation-adjacent
  state management. Each feature has one provider.
- **get_it** — service locator used only in `core/di/service_locator.dart` to
  wire data sources → repositories → use cases → providers. `main.dart`
  never constructs a repository or data source itself.

## Business rule example

`CreateBooking` (domain use case) rejects a booking whose date/time is in
the past, and throws a typed `CreateBookingFailure`. The `BookingProvider`
catches it and exposes `submitError` for the UI — the UI never has to know
the rule exists, just how to react to a failure.

## Swapping the data source later

To move from in-memory to real persistence:
1. Add `sqflite` (or `shared_preferences`, or `dio` for a REST API) to
   `pubspec.yaml`.
2. Create a new class implementing `ServiceLocalDataSource` /
   `BookingLocalDataSource` (or add a `*RemoteDataSource` and combine both
   behind the same repository).
3. Update the two lines in `service_locator.dart` that register the data
   source implementations.

No changes needed in domain, providers, or pages.

## Run it

1. Generate platform folders (not included by default):
   ```bash
   flutter create --platforms=android,ios .
   ```
2. Install packages and run:
   ```bash
   flutter pub get
   flutter run
   ```
