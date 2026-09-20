# Baseline jelentés

## Kiinduló állapot

A repó a rögzített `0a1cafb93a65d17e0c7e1bb3ad2bc9cb965d02a7`
commitból indult. Az eredeti Gradle 5.4.1 build JDK 17 alatt már a konfiguráció
betöltésekor összeomlott (`Groovy Java7` inicializálási hiba). Emellett a build:

- JCentert használt;
- privát `google-services.json` és `secrets.xml` fájlokat várt;
- elavult Firebase/Crashlytics plugineket és SDK-kat töltött;
- minden konfiguráláskor módosította az `app/version.properties` fájlt;
- csak felhős Firebase Test Lab CI-ben futtatta az instrumentációs teszteket.

## Elvégzett baseline-változtatások

- Gradle 8.13, AGP 8.13.2 és JDK 17 alapú build.
- Maven Central és Google repository; JCenter eltávolítva.
- Firebase Analytics és Crashlytics teljes buildfüggősége eltávolítva.
- A privát töltőállomás API-kulcs helyett üres publikus alapérték van; ilyen
  esetben a távoli frissítés nem indul el, a csomagolt offline adat megmarad.
- A privát titkokat és Firebase Test Labot igénylő, elavult CircleCI workflow
  eltávolításra került; a reprodukálható helyi ellenőrzés az elsődleges baseline.
- A verziófájl build közben csak olvasható.
- Az app és az instrumentációs teszt APK hardver nélkül is lefordítható.
- Az OBD/ELM327 parancsok, timeoutok és protokollfolyam nem változtak.

## Ellenőrzési eredmények

- `:app:assembleDebug`: sikeres.
- `:app:assembleDebugAndroidTest`: sikeres.
- `testDebugUnitTest`: sikeres, de `NO-SOURCE`; a meglévő tesztek az
  `androidTest` forráskészletben vannak.
- `lintDebug`: a modern lint 17 örökölt hibát és 144 figyelmeztetést talált.
  Ezeket verziókövetett baseline rögzíti, így új lint hiba már blokkolja a
  buildet. A legfontosabb meglévő kategóriák: modern Bluetooth-engedélyek,
  gyanús behúzás és egy hibásnak látszó layout-részlet.
- Eszközös teszt: még nem futott, mert nincs konfigurált eszköz/emulátor.

Előállított fájlok:

- `app/build/outputs/apk/debug/SoulEVSpy-0.1.6-5275-debug.apk`
- `app/build/outputs/apk/androidTest/debug/SoulEVSpy-0.1.6-5275-debug-androidTest.apk`

## Fennmaradó technikai adósság

- A régi MaterialDrawer/typeface csomagok elavult AndroidX tranzitív
  függőségeket hoznak és namespace figyelmeztetéseket adnak.
- Az Android SDK eszközök XML-verzió figyelmeztetése külön toolchain-takarítást
  igényelhet, de a fordítást nem blokkolja.
- A target SDK továbbra is 28; a modern Bluetooth- és storage-engedélyek az
  1. fázis részei.
- Az instrumentációs tesztek nem futnak host JVM-en, ezért emulátor vagy
  fokozatos log-replay/unit-test migráció szükséges.
- Az alkalmazás saját neve és application ID-ja még nincs átvezetve.

## Következő javasolt scope

Az 1. fázist külön változtatássorban érdemes kezdeni: saját név/package,
Bluetooth runtime permission és target SDK migráció, majd a régi UI-könyvtárak
frissítése. A 2. fázis első szelete ezután egy tisztán host JVM-en futó
log-replay tesztkeret legyen, kezdetben egy egészséges és egy alvó-ECU
fixture-rel.
