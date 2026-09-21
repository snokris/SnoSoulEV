# SnoSoulEV tesztelési itiner

Ez az ellenőrzőlista az APK előállításától a valós, álló járművel végzett
Bluetooth/OBD füsttesztig vezet. Az első futás célja nem a teljes
funkcionális minősítés, hanem annak igazolása, hogy az 1. fázis után az
alkalmazás települ, elindul, navigálható és read-only módon kapcsolódik.

## 0. Biztonsági és adatvédelmi szabályok

- [ ] A teljes tesztet parkoló, biztonságosan rögzített járműben végzem.
- [ ] Vezetés közben nem kezelem a telefont és nem futtatok tesztlépést.
- [ ] Nem indítok ECU-írást, kódolást, vezérlést vagy hibakódtörlést.
- [ ] Az OBD adaptert a teszt végén eltávolítom, hogy ne merítse a 12 V-os
  akkumulátort.
- [ ] VIN-t, GPS-koordinátát, adapterazonosítót és nyers naplót nem töltök
  fel GitHubra és nem osztok meg anonimizálás nélkül.
- [ ] Ha az autó vagy az adapter rendellenesen viselkedik, megszakítom a
  tesztet, bezárom az alkalmazást és kihúzom az adaptert.

## 1. Szükséges eszközök

- macOS fejlesztőgép a repóval;
- JDK 17 és Android SDK 35;
- adatátvitelre alkalmas USB-kábel;
- Android telefon, elsődlegesen Android 12 vagy újabb rendszerrel;
- a telefonhoz az Android beállításaiban előre párosított Bluetooth OBD-II
  adapter;
- töltött telefon és megfelelően feltöltött 12 V-os járműakkumulátor;
- jegyzet a telefon Android-verziójáról, a jármű típusáról/évjáratáról
  és az adapter típusáról.

## 2. Forráskód és környezet ellenőrzése

A repó kanonikus helyi gyökere: `/Users/jamborkrisztian/Projects/Kia`.
A teszt indításakor:

```bash
cd /Users/jamborkrisztian/Projects/Kia
git status --short --branch
git log -1 --oneline
scripts/android-env.sh java -version
scripts/android-env.sh adb version
```

Elvárt eredmény:

- [ ] A megfelelő ágon vagyok, és nincs ismeretlen helyi módosítás.
- [ ] A Java főverziója 17.
- [ ] Az `adb` elindul.

Ha hiányzik a környezet, kövesd a
[[01-fejlesztoi-kornyezet|fejlesztői környezet]] telepítési lépéseit.

## 3. Teljes automatizált build

```bash
scripts/verify-baseline.sh
```

Ez egymás után futtatja a host unit-test taskot, elkészíti a debug APK-t és
az instrumentációs teszt-APK-t, majd lefuttatja a lintet. A verziófájl nem
változhat meg.

Elvárt eredmény:

- [ ] A parancs `BUILD SUCCESSFUL` eredménnyel zárul.
- [ ] Megjelenik a `Baseline verification completed without modifying
  app/version.properties.` üzenet.
- [ ] A lint nem jelez új problémát. Az ismert örökölt hibákat a
  `app/lint-baseline.xml` tartalmazza.

Megjegyzés: a `testDebugUnitTest` jelenleg `NO-SOURCE` lehet. Ez nem azt
jelenti, hogy eszközös tesztek futottak; az instrumentációs APK elkészítése
csak fordítási ellenőrzés.

## 4. Az APK azonosítása és ellenőrzése

```bash
ls -lh app/build/outputs/apk/debug/
shasum -a 256 app/build/outputs/apk/debug/SnoSoulEV-0.1.6-5275-debug.apk
/opt/homebrew/share/android-commandlinetools/build-tools/35.0.0/aapt2 \
  dump permissions \
  app/build/outputs/apk/debug/SnoSoulEV-0.1.6-5275-debug.apk
```

Ha a verziószám később változik, a ténylegesen létrejött
`SnoSoulEV-*-debug.apk` fájlnevet kell használni.

Elvárt eredmény:

- [ ] Az APK neve `SnoSoulEV-...-debug.apk`.
- [ ] A package `hu.snokris.snosoulev`.
- [ ] Láthatók a hely- és Bluetooth-jogosultságok.
- [ ] Nincs `android.permission.INTERNET` jogosultság.
- [ ] A SHA-256 értéket feljegyeztem a tesztjegyzőkönyvbe.

## 5. A telefon előkészítése

1. Nyisd meg a telefon **Beállítások / A telefonról** oldalát.
2. Érintsd meg hétszer a buildszámot a fejlesztői beállítások
   engedélyezéséhez.
3. Kapcsold be az **USB-hibakeresést**.
4. Csatlakoztasd a telefont USB-n, oldd fel a kijelzőt, majd fogadd el a gép
   RSA-kulcsát.
5. Az Android Bluetooth-beállításaiban párosítsd az OBD-II adaptert. Ha PIN
   kell, csak az adapter saját dokumentációjában szereplő kódot használd.

Kapcsolat ellenőrzése:

```bash
scripts/android-env.sh adb devices -l
```

Elvárt eredmény:

- [ ] Pontosan a teszttelefon látszik `device` állapotban.
- [ ] Nem `unauthorized`, `offline` vagy üres a lista.

## 6. APK telepítése

```bash
scripts/android-env.sh adb install -r \
  app/build/outputs/apk/debug/SnoSoulEV-0.1.6-5275-debug.apk
```

Elvárt eredmény: `Success`.

Ha egy korábbi, nem kompatibilis aláírású SnoSoulEV-példány miatt a
telepítés meghiúsul, előbb mentsd, amit meg kell őrizni, majd távolítsd el
az alkalmazást a telefon beállításaiból. Az eltávolítás az alkalmazás helyi
adatait is törli.

Az alkalmazás parancssoros indítása:

```bash
scripts/android-env.sh adb shell am start \
  -n hu.snokris.snosoulev/com.evranger.soulevspy.activity.MainActivity
```

## 7. Első indítás és jogosultságok

- [ ] Az ikon és az alkalmazásnév **SnoSoulEV**.
- [ ] Az alkalmazás összeomlás nélkül elindul.
- [ ] Android 12+ rendszeren megjelenik a Közeli eszközök/Bluetooth
  engedélykérés.
- [ ] A pontos hely engedélykérése érthetően kezelhető.
- [ ] Elutasított Bluetooth-jogosultságnál az app nem omlik össze, és nem
  próbál jogosulatlanul kapcsolódni.
- [ ] Az engedély későbbi megadása után a párosított adapter kiválasztható.

Az elutasítási próba után a telefon alkalmazásbeállításaiban add meg a
teszt további részéhez szükséges jogosultságokat.

## 8. Offline és navigációs füstteszt autó nélkül

1. Kapcsold be a repülőgépes módot, majd külön kapcsold vissza a
   Bluetooth-t.
2. Indítsd újra a SnoSoulEV-et.
3. Nyisd meg egymás után az összes elérhető menüpontot.

Ellenőrzési lista:

- [ ] Energia – ez az alapértelmezett kezdőnézet.
- [ ] Akkumulátorcellák.
- [ ] Akkumulátor/BMS.
- [ ] Járműinformáció.
- [ ] Motorvezérlés/VMCU.
- [ ] Fedélzeti töltő/OBC.
- [ ] LDC 12 V.
- [ ] Gumiabroncsok.
- [ ] GPS.
- [ ] Beállítások.
- [ ] Demó visszajátszás.
- [ ] Adatvédelmi tájékoztató internet nélkül is megnyílik.
- [ ] Nincs töltőállomás- vagy felhőfeltöltési menüpont.
- [ ] Nincs összeomlás, üres fehér oldal vagy hibás ikon.

Külső felhasználói kézikönyv-link repülőgépes módban természetesen
nem töltődik be; ez nem alkalmazáshiba.

## 9. Jármű- és adapterkonfiguráció

A jármű maradjon parkoló állapotban.

1. Csatlakoztasd az OBD-II adaptert.
2. Ellenőrizd, hogy a telefon továbbra is párosítva van vele.
3. A SnoSoulEV beállításaiban válaszd ki a pontos járműprofilt.
4. Válaszd ki a párosított Bluetooth adaptert.
5. Hagyd az automatikus újracsatlakozást első körben kikapcsolva, hogy minden
   próba egyértelműen kézi legyen.

Jegyezd fel a tesztjegyzőkönyvbe:

- Android verzió és telefonmodell;
- járműmodell, évjárat és 27/30 kWh-s akkumulátorváltozat;
- adapter gyártója és modellje, de ne az egyedi sorozatszáma;
- SnoSoulEV verzió és APK SHA-256.

## 10. Álló járműves Bluetooth/OBD füstteszt

1. A telefon legyen feloldva, a SnoSoulEV legyen előtérben.
2. Kapcsold a járművet a gyártó szerinti normál **READY** állapotba, de ne
   indulj el vele.
3. A navigációs fiókban kapcsold be a Bluetooth-kapcsolatot.
4. Várj legalább egy teljes adatfrissítési ciklust.

Elvárt eredmény:

- [ ] A státusz a kapcsolódási folyamat után kapcsolódott állapotot jelez.
- [ ] Nem jelenik meg ismétlődő engedélyhiba vagy azonnali szétkapcsolás.
- [ ] Az Energia nézetben érkeznek frissülő, hihető értékek.
- [ ] A BMS- és cellanézet adatai a kiválasztott járműprofilnak megfelelnek.
- [ ] Az OBC, VMCU, LDC és kerékadat oldalak nem omlanak össze akkor sem,
  ha egy adott PID nem érhető el.
- [ ] A GPS nézet a megadott jogosultság mellett frissül.
- [ ] A telefon háttérbe küldése és visszahozása nem okoz összeomlást.

Ne az egyes mért értékek abszolút pontosságát minősítsd ebben a
körben; először az adatfolyam stabilitását és a nyilvánvalóan hibás
profilválasztást keressük.

## 11. Kapcsolat megszakítása és alap recovery-próba

1. Kapcsold ki a SnoSoulEV Bluetooth-kapcsolóját.
2. Ellenőrizd, hogy az app kapcsolata megszűnik, de az app nem omlik össze.
3. Kapcsold vissza, és ellenőrizd az egyszeri újracsatlakozást.
4. Kapcsolódott állapotban állítsd le a járművet a normál kezelőszervvel.
5. Figyeld meg legfeljebb 60 másodpercig, hogy az app hogyan jelzi az ECU-k
   elalvását vagy a kapcsolat megszűnését.

- [ ] Kézi szétkapcsolás rendben.
- [ ] Kézi újracsatlakozás rendben.
- [ ] `READY → OFF` után nincs alkalmazásösszeomlás vagy kezelhetetlen
  végtelen hurok.
- [ ] A megfigyelt késleltetést és üzenetet feljegyeztem.

Ebben a fázisban a timeout/reconnect viselkedést még csak dokumentáljuk. A
protokollfolyam javítása a log-replay regressziós tesztek után következik.

## 12. Hibakeresési napló rögzítése

Naplót csak hiba reprodukálásához rögzíts. Kezdés előtt:

```bash
scripts/android-env.sh adb logcat -c
scripts/android-env.sh adb shell am force-stop hu.snokris.snosoulev
scripts/android-env.sh adb shell am start \
  -n hu.snokris.snosoulev/com.evranger.soulevspy.activity.MainActivity
```

A hiba reprodukálása után a terminálban:

```bash
scripts/android-env.sh adb logcat -d > /tmp/snosoulev-logcat.txt
```

A `/tmp/snosoulev-logcat.txt` fájlt megosztás előtt kötelező átvizsgálni és
anonimizálni. Töröld vagy helyettesítsd legalább a következőket:

- VIN;
- GPS-koordináták és helynevek;
- Bluetooth MAC-cím, adapter- vagy telefonsorozatszám;
- személyes fájlútvonalak és fiókazonosítók.

A nyers fájlt ne másold a repóba. Az anonimizált változatot is előbb külön
ellenőrizni kell.

## 13. Tesztjegyzőkönyv-sablon

```text
Dátum/idő:
Tesztelő:
SnoSoulEV verzió / commit:
APK SHA-256:
Telefonmodell / Android-verzió:
Járműmodell / évjárat / akkumulátor:
OBD adaptermodell:

Build: PASS / FAIL
Telepítés: PASS / FAIL
Jogosultságok: PASS / FAIL
Offline indulás: PASS / FAIL
Navigáció: PASS / FAIL
Bluetooth párosítás: PASS / FAIL
OBD kapcsolat: PASS / FAIL
Adatfrissítés: PASS / FAIL
Kézi reconnect: PASS / FAIL
READY → OFF: PASS / FAIL

Megfigyelt hiba:
Reprodukció pontos lépései:
Elvárt viselkedés:
Tényleges viselkedés:
Anonimizált képernyőkép/napló elérése:
```

## 14. Elfogadási feltételek

Az 1. fázis eszközös füsttesztje akkor tekinthető lezártnak, ha:

- [ ] a teljes automatizált build sikeres;
- [ ] a debug APK települ egy Android 12+ valós eszközre;
- [ ] a jogosultságok megadása és elutasítása nem okoz összeomlást;
- [ ] minden aktív nézet megnyitható;
- [ ] a helyi adatvédelmi oldal offline is olvasható;
- [ ] a kiválasztott adapterrel legalább egy teljes olvasási ciklus lefut;
- [ ] kézi szétkapcsolás és újracsatlakozás után az app használható;
- [ ] a `READY → OFF` próba eredménye dokumentált;
- [ ] minden megosztott bizonyíték anonimizált;
- [ ] a blokkoló hibákhoz pontos reprodukció tartozik.

Sikeres füstteszt után kezdhető a 2. fázis log-replay tesztkerete. A valós
teszt eredményét a projektmemóriában kell rögzíteni, de személyes vagy nyers
járműadat nélkül.
