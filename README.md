# 🎬 IMDb App (Work In Progress)

A Flutter application replicating core functionalities of the IMDb app. Data is fetched from The Movie Database (TMDB) API.

---

## 📸 Screenshots

Below are some screenshots showcasing the app’s UI in various sections:

### Home Screen

<img src="https://github.com/user-attachments/assets/38cbace7-4041-4c4c-8370-7445892e1791" width="217" />

### Search Screen

<p float="left">
  <img src="https://github.com/user-attachments/assets/1d7183aa-c60c-4ca3-bfc2-2d4e04781664" width="217" />
  <img src="https://github.com/user-attachments/assets/e77d99b1-e0e6-484a-810c-eab886156c9d" width="217" />
</p>

### Movie Details

<p float="left">
  <img src="https://github.com/user-attachments/assets/c2870a93-d598-4c14-9156-2a9cfc430b63" width="217" />
  <img src="https://github.com/user-attachments/assets/51cbc3f6-953e-4beb-8da2-41466a134e4c" width="217" />
</p>

### People Details

<img src="https://github.com/user-attachments/assets/f79b8234-2baa-410f-8ebd-41f5ba9f9417" width="217" />

### TV Series Details

<p float="left">
  <img src="https://github.com/user-attachments/assets/2f21ef6d-7bc7-441b-b965-28e81a7e3fe0" width="217" />
  <img src="https://github.com/user-attachments/assets/1b993866-c028-4288-aa48-28e1172fc2a6" width="217" />
  <img src="https://github.com/user-attachments/assets/b9abef2f-c8fc-44d7-826a-c2a1094f6b3b" width="217" />
</p>

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

