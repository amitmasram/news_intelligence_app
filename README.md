
# Mini News Intelligence App

---

## Project Overview

This project demonstrates:

* Clean architecture
* Scalable folder structure
* State management using Riverpod
* API integration
* Local persistence using Hive
* Error handling and UI state management

---

## Features

### Authentication

* Mock login screen
* Persistent login state
* Automatic navigation based on auth status

### News Feed

* Business news from public API
* Category-based filtering
* Pagination
* Pull-to-refresh

### Search

* Search articles via API
* Debounced input
* Efficient filtering

### Article Detail

* Full article view (title, image, description, content)
* Save articles as favorites

### Favorites

* Add/remove favorites
* Offline storage using Hive
* Dedicated favorites screen

---

## Screenshots

(Add your screenshots here)

| Login                  | Feed                  | Detail                  | Favorites                  |
| ---------------------- | --------------------- | ----------------------- | -------------------------- |
| ![](screens/login.png) | ![](screens/feed.png) | ![](screens/detail.png) | ![](screens/favorites.png) |

---

## Architecture

The app follows clean architecture with clear separation of concerns:

```plaintext
lib/
├── core/
│   ├── constants/
│   ├── error/
│   ├── network/
├── features/
│   ├── auth/
│   ├── news/
├── shared/
│   ├── widgets/
├── main.dart
```

---

## Data Flow

```plaintext
Presentation (UI)
    ↓
Riverpod Provider
    ↓
Use Case (Domain)
    ↓
Repository
    ↓
Data Source (API / Hive)
```

---

## Tech Stack

* Flutter 3+
* Dart (null safety)
* Riverpod
* Hive
* REST API (newsapi.org)

---

## Packages

* flutter_riverpod
* hive, hive_flutter
* dio
* url_launcher
* dartz
* equatable

---

## Local Persistence

Hive is used to store login state and favorite articles for offline access.

---

## API Integration

The app uses News API to fetch headlines, perform search, and handle pagination.

---

## Error Handling

* Network errors handled via API client
* Domain-level error models
* UI handles loading, error, and empty states with retry support

---

## Key Decisions

Riverpod provides scalable and testable state management with clear separation from UI.

Hive is lightweight, fast, and suitable for offline storage.

Clean architecture improves maintainability and scalability by separating concerns.

---

## API Key Setup

1. Get API key from [https://newsapi.org](https://newsapi.org)
2. Add it in:


## Setup

```bash
git clone <your-repo-link>
cd news_intelligence_app
flutter pub get
flutter run
```

---

## Assumptions

* Authentication is mocked
* Internet required for news fetching
* Favorites stored locally

---
