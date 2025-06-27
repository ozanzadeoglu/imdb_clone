# 🎬 IMDb App (Work In Progress)

A Flutter application replicating core functionalities of the IMDb app. Data is fetched from The Movie Database (TMDB) API.

---

## 📸 Screenshots

Below are some screenshots showcasing the app’s UI in various sections:

### Home Screen


### Search Screen



### Movie Details



### People Details



### TV Series Details

---

## ✨ Features

- **🔝 Browse Popular Content:** View trending, popular, and top-rated media.
- **🎥 Movie, 📺 TV Show & 🎭 Actor Details:** Access detailed information for any title, including synopsis, cast, crew, and ratings.
- **🔍 Powerful Search:** Quickly search for movies, TV shows, and actors.
- **📜 Search History:** Save previous searches to a local database.
- **⚡ Caching:** Cache images and TV series episodes to reduce network requests and improve UX.
- **📱 Responsive UI:** A clean and intuitive interface that adapts to different device sizes.

---

## 🛠️ Technologies Used

- **Architecture:** MVVM (Model-View-ViewModel)
- **State Management & DI:** Provider
- **Networking:** Dio
- **Local Storage:** Hive
- **Navigation:** Go Router


---

## 📁 Folder Structure

```
lib/
├── api_keys/           # TMDB API key storage (ignored in .gitignore)
├── components/         # Shared reusable widgets
├── constants/          # App-wide constants (colors, Hive adapter IDs, etc.)
├── enums/              # Enumerations (media types, padding values, etc.)
├── extensions/         # Dart extension methods
├── models/             # Data classes
├── services/           # API communication (Dio client)
├── utility/            # Utility functions and helpers
└── views/              # Views, ViewModels, and UI widgets
```

---

## ⏳ Upcoming Features

- 🌐 Localization (multiple languages)
- 🖼️ Splash Screen
- ⭐ Bookmarking all media and people.

---

## 🚀 Run Locally

A TMDB API key is required to run this project locally:

1. Create an `api_keys` folder under `lib/`.

2. Inside it, create a file named `api_keys.dart`.

3. Add the following code (replace `YOUR_API_KEY` with your TMDB API key):

   ```dart
   class ApiKeys {
     static const String tmdb = 'YOUR_API_KEY';
   }
   ```

4. Install dependencies and run:

   ```bash
   flutter pub get
   flutter run
   ```

---

