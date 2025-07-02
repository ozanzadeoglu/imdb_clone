# 🎬 IMDb App (Work In Progress)

A Flutter application replicating core functionalities of the IMDb app. Data is fetched from The Movie Database (TMDB) API.

[Showcase video](https://youtu.be/vVPMlmrifuQ)

---



## ✨ Features

- **🔝 Browse Popular Content:** View trending, popular, and top-rated media.
- **🎥 Movie, 📺 TV Show & 🎭 Actor Details:** Access detailed information for any title, including synopsis, cast, crew, and ratings.
- **🔖 Bookmark & Take Notes:** Save any movie, TV show, or person to your bookmarks. Easily find them again later and add custom notes to any entry.
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
  <img src="https://github.com/user-attachments/assets/1d761e6c-e0b1-4468-b1bd-83a3c45cbbfb" width="217" />
  <img src="https://github.com/user-attachments/assets/f2e5361a-9f5c-412a-a26a-fedd6769c9d9" width="217" />
</p>

### People Details

<p float="left">
  <img src="https://github.com/user-attachments/assets/201d616a-5f81-4891-9f6c-2f74ca60ead2" width="217" />
  <img src="https://github.com/user-attachments/assets/5c720de4-864a-43e1-a1e4-1c88a7d5c0fe" width="217" />
</p>

### TV Series Details

<p float="left">
  <img src="https://github.com/user-attachments/assets/c94efad6-1fd2-4478-8030-cf556bb40702" width="217" />
  <img src="https://github.com/user-attachments/assets/e8660c5e-eef3-4217-a8f5-2930001d53ce" width="217" />
  <img src="https://github.com/user-attachments/assets/b6887c5f-daf0-44a1-bd31-59116d520b82" width="217" />
</p>

### Bookmarks

<p float="left">
  <img src="https://github.com/user-attachments/assets/066fcd7a-a4bb-4772-abef-e9d0a31ef6fc" width="217" />
  <img src="https://github.com/user-attachments/assets/3048cd30-bc57-4094-a435-62dea8ac6e39" width="217" />
  <img src="https://github.com/user-attachments/assets/adfd3052-319c-4828-a5fc-ad431247cf4c" width="217" />
</p>

<p float="left">
  <img src="https://github.com/user-attachments/assets/4d2a0bae-d9e2-4dee-bdbf-e9f7063ee43e" width="217" />
  <img src="https://github.com/user-attachments/assets/00998e6e-3bdb-4728-b5b3-33e9d2b9b70d" width="217" />
  <img src="https://github.com/user-attachments/assets/7a22aa82-7e19-48fe-9c90-ad31335f82b1" width="217" />
</p>



---

