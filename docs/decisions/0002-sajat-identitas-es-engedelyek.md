# 0002 – Saját identitás és modern Android-engedélyek

Dátum: 2026-09-20  
Állapot: elfogadva

## Döntés

- Az alkalmazás neve `SnoSoulEV`, application ID-ja `hu.snokris.snosoulev`.
- A meglévő `com.evranger.soulevspy` namespace és Java package-ek egyelőre
  változatlanok. Ezek tömeges átnevezése nem ad felhasználói értéket, viszont
  indokolatlanul nagy diffet okozna a kommunikációs kódban.
- A cél-SDK 35. Android 12-től futásidőben kérjük a
  `BLUETOOTH_CONNECT` és `BLUETOOTH_SCAN` engedélyt; Android 11-ig a régi
  Bluetooth-engedélyek maradnak érvényben.
- A helyadat külön engedélykérés marad, mert a GPS- és töltőállomás-funkció
  ténylegesen használ helyzetet.
- A széles `WRITE_EXTERNAL_STORAGE` engedélyt eltávolítjuk. A jelenlegi Lite
  működés nem készít menetnaplót, a töltőállomás-cache az alkalmazás belső
  tárhelyén marad. A használaton kívüli, nyilvános Downloads könyvtárba író
  tesztkódot töröljük.
- Az app-adatok biztonsági mentése és eszközök közti átvitele tiltott marad.

## Korlát

Ez a változás nem módosítja az ELM327 parancsokat, a scan sorrendjét, az
időzítéseket vagy a járműről olvasott értékek értelmezését. A Bluetooth-réteg
csak érvényes rendszerengedély birtokában indul el.

## Ellenőrzés

- `scripts/verify-baseline.sh`
- az APK manifestjében az application ID és a cél-SDK ellenőrzése
- valódi Android 12+ készüléken a párosított adapter listázása és kapcsolódás
  még hardvertesztet igényel
