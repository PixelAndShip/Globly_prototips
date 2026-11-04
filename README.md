# Globly prototype

A minimal Flutter desktop (Windows and Linux) prototype of the **Globly** geospatial
social media app, based on *Sistēmas projektējums* (SP). It is built in parts,
one commit per part:

1. Authentication/registration frontend
2. Authentication/registration backend (users saved in the local `data/` folder)
3. Create post frontend
4. Create post backend
5. Associate post with user
6. User can edit their posts
7. Post rating
8. Map integration
9. User interface animations

## Setup

Flutter 3.32 or newer (Dart 3.8+). Check your setup with `flutter doctor`.

**Windows**

1. Install Flutter: https://docs.flutter.dev/get-started/install/windows/desktop
   (unzip it, for example to `C:\src\flutter`, and add `C:\src\flutter\bin` to PATH).
2. Install **Visual Studio 2022** (not VS Code) with the
   **"Desktop development with C++"** workload. Flutter uses it to build the Windows app.
3. Enable Developer Mode if `flutter` asks for it (Settings → System → For developers).

**Linux**

```bash
# Flutter SDK, e.g. in ~/development/flutter
echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc
sudo apt install clang cmake ninja-build libgtk-3-dev
```

## Running

```bash
cd app
flutter run -d windows   # on Windows
flutter run -d linux     # on Linux
```

## Testing

Automated tests (they run without Visual Studio or the Linux build tools), all in
`app/test/app_test.dart`:

```bash
cd app
flutter test
```

Manual check of part 1 (`flutter run -d windows` or `-d linux`):

1. Press **Ievadīt** with empty fields: both fields show "Obligāts lauks".
2. Switch to **Reģistrēties**: the button text changes to "Reģistrēties".
3. Enter any username and password and submit: the home screen opens with
   your username in the top bar. No account is checked yet (that is part 2).
4. Press the logout icon: you are back on the login screen.
