# SnoSoulEV

Androidos, read-only járműdiagnosztikai alkalmazás Kia és Hyundai elektromos
autókhoz. A SnoSoulEV a
[Soul EV Spy](https://github.com/langemand/SoulEVSpy) független modernizációs
forkja: megőrzi az eredeti projekt történetét és szerzői attribúcióját,
miközben korszerűsíti az Android-platformot, a tesztelhetőséget és a
kommunikáció megbízhatóságát.

> [!WARNING]
> Ez kísérleti diagnosztikai szoftver. Vezetés közben ne kezeld a telefont,
> és ne hagyatkozz az alkalmazás adataira biztonságkritikus döntésnél.
> A használat saját felelősségre történik.

## Jelenlegi állapot

Az alap build és az 1. modernizációs fázis elkészült.

- alkalmazásnév: **SnoSoulEV**;
- Android application ID: `hu.snokris.snosoulev`;
- `compileSdk 35`, `targetSdk 35`, `minSdk 16`;
- Android 12+ Bluetooth runtime jogosultságkezelés;
- offline-first működés, Android `INTERNET` jogosultság nélkül;
- nincs felhőfeltöltés vagy beépített töltőállomás-szolgáltatás;
- helyi adatvédelmi tájékoztató;
- reprodukálható JDK 17 / Gradle 8.13 / AGP 8.13.2 build;
- debug APK, instrumentációs teszt-APK és lintellenőrzés előáll.

A következő fejlesztési lépés az anonimizált log-replay tesztkörnyezet.
A részletes terv a [projekt ütemezésében](docs/03-utemezes.md) olvasható.

## Mit tud az alkalmazás?

A telefonhoz párosított Bluetooth OBD-II adapteren keresztül olvas
diagnosztikai adatokat, majd többek között az energia-, akkumulátor-,
cellafeszültség-, fedélzeti töltő-, motorvezérlés-, keréknyomás- és
GPS-nézetekben jeleníti meg azokat.

A kódbázis a következő örökölt járműprofilokat tartalmazza:

- Kia Soul EV 2015–2019;
- Kia Ray EV;
- Kia e-Niro;
- Kia e-Soul 2020–;
- Hyundai BlueOn EV;
- Hyundai Ioniq EV;
- Hyundai Kona EV;
- monitor mód.

Ezek nem mindegyike rendelkezik azonos lefedettségű, valós hardveren
ellenőrzött támogatással. Az elsődleges cél a 27 és 30 kWh-s Kia Soul EV
profilok megbízható elkülönítése.

## Adatvédelem és biztonság

- A járműkommunikáció read-only marad: nincs ECU-írás, kódolás,
  vezérlés vagy hibakódtörlés.
- Az alkalmazás nem kér internet-hozzáférést, és nem továbbít
  jármű-, Bluetooth- vagy helyadatot online szolgáltatásnak.
- VIN, GPS-koordináta, adapterazonosító vagy nyers felhasználói napló nem
  kerülhet a repóba. Tesztadat csak anonimizálva használható.

## Fejlesztői környezet

macOS/Homebrew esetén:

```bash
brew install openjdk@17 android-commandlinetools
JAVA_HOME=/opt/homebrew/opt/openjdk@17 sdkmanager --licenses
JAVA_HOME=/opt/homebrew/opt/openjdk@17 sdkmanager \
  'platform-tools' 'platforms;android-35' 'build-tools;35.0.0'
```

A repó klónozása után a teljes automatizált ellenőrzés:

```bash
scripts/verify-baseline.sh
```

Csak a debug APK elkészítése:

```bash
scripts/android-env.sh ./gradlew --no-daemon :app:assembleDebug
```

Az APK az `app/build/outputs/apk/debug/` könyvtárba kerül. Az
instrumentációs tesztek lefordítása nem jelenti azok futtatását; ehhez valós
Android-eszköz vagy emulátor szükséges.

Részletes telepítési jegyzet:
[docs/01-fejlesztoi-kornyezet.md](docs/01-fejlesztoi-kornyezet.md).

## Projektmemória

A `docs/` könyvtár közvetlenül megnyitható Obsidian vaultként. Tartalmazza
a fejlesztési ütemezést, a baseline jelentést és az architekturális döntési
naplókat. Belépési pont: [docs/README.md](docs/README.md).

## Fejlesztési szabályok

- A változtatások legyenek kicsik, ellenőrizhetők és fázisonként
  elkülönítettek.
- Build jellegű változtatás után fusson a `scripts/verify-baseline.sh`.
- A README és a `docs/` projektmemória minden felhasználót vagy
  fejlesztőt érintő változással együtt frissítendő.
- A licencet és az upstream attribúciót meg kell őrizni.

## Licenc és attribúció

A projekt az eredeti Soul EV Spy munkájára épül, és az Apache License 2.0
feltételei szerint használható. Lásd a [LICENSE](LICENSE) fájlt és az
upstream projekt szerzői előzményeit.
