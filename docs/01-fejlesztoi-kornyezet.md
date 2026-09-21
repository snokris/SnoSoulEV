# Fejlesztői környezet

## Projekt helye

A kanonikus helyi repógyökér:

```text
/Users/jamborkrisztian/Projects/Kia
```

Minden alábbi parancs előtt lépj ebbe a könyvtárba:

```bash
cd /Users/jamborkrisztian/Projects/Kia
```

## Rögzített baseline

- JDK: 17
- Gradle Wrapper: 8.13
- Android Gradle Plugin: 8.13.2
- compile SDK: 35
- build tools: 35.0.0
- min SDK: 16
- target SDK: 28 (viselkedési migráció nélkül hagyva a baseline-ban)

## macOS telepítés

```bash
brew install openjdk@17 android-commandlinetools
JAVA_HOME=/opt/homebrew/opt/openjdk@17 sdkmanager --licenses
JAVA_HOME=/opt/homebrew/opt/openjdk@17 sdkmanager \
  'platform-tools' 'platforms;android-35' 'build-tools;35.0.0'
```

A repó scriptje a Homebrew alapértelmezett útvonalait használja, de tiszteletben
tartja a már beállított `JAVA_HOME`, `ANDROID_HOME` és `ANDROID_SDK_ROOT`
változókat.

## Napi parancsok

Teljes baseline ellenőrzés:

```bash
scripts/verify-baseline.sh
```

Csak debug APK:

```bash
scripts/android-env.sh ./gradlew --no-daemon :app:assembleDebug
```

Az APK helye:

```text
app/build/outputs/apk/debug/
```

Az instrumentációs tesztek fordítása nem azonos a futtatásukkal. A futtatáshoz
Android-eszköz vagy emulátor szükséges; ez külön hardverteszt-lépés.
