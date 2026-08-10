# Firebase setup for Alfaeq Yemen

This document explains in simple steps how to create a Firebase project and add the generated google-services.json to your Flutter app so that Analytics and Crashlytics work correctly.

1) Create a Firebase project
- Go to https://console.firebase.google.com/
- Click "Add project" and follow the steps. You can name it "alfaeq-yemen".

2) Register your Android app
- In the Firebase project overview, click the Android icon to add an Android app.
- For Android package name, if you don't have one yet, use: com.example.alfaeq_yemen
  (You can change this later in your Android project, but it's best to pick the final name now.)
- Provide an app nickname (optional) and click "Register app".

3) Download google-services.json
- After registering, download the `google-services.json` file and place it in your Flutter project at: `android/app/google-services.json`.

4) Add Firebase Gradle plugins (Android side)
- In `android/build.gradle` (project-level), add the Google services classpath inside `buildscript` -> `dependencies`:

  dependencies {
    classpath 'com.android.tools.build:gradle:7.0.4'
    classpath 'com.google.gms:google-services:4.3.15'
  }

- In `android/app/build.gradle` (module-level), at the bottom add:

  apply plugin: 'com.google.gms.google-services'

5) Add dependencies
- The Flutter side dependencies were already added to `pubspec.yaml`.
- Run:

  flutter pub get

6) Build & Run
- Run the app on a device/emulator:

  flutter run

- In case Crashlytics doesn't show errors immediately, follow Firebase instructions to force a test crash.

7) SHA certificate (optional but useful)
- For some Firebase features (Auth, Dynamic Links) you need to add SHA-1. Generate it with:

  keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

- Copy the SHA-1 and add it in Firebase project settings under your Android app.

If you want, أستطيع أن أشرح كل خطوة بالصور أو أقدّم ملفًا جاهزًا للتعليمات لتنسخه داخل المشروع. بعد أن تضع `google-services.json` في `android/app/` شغّل التطبيق، وسأرشدك كيف تتأكد أن Analytics وCrashlytics يعملان عبر Firebase Console.
