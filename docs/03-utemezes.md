# Ütemezés

## 0. fázis – baseline és reprodukálhatóság

Státusz: kész. A debug és teszt-APK előáll, a host unit task és a lint fut,
az örökölt lint-adósság baseline-ban rögzített, és a build nem módosítja a
verziófájlt. Az instrumentációs tesztek tényleges futtatásához még eszköz vagy
emulátor kell.

## 1. fázis – saját identitás és platformmodernizálás

Státusz: folyamatban.

- [x] saját appnév, ikon és application ID;
- [x] `targetSdk 35`, modern Bluetooth- és storage-engedélyek;
- töltőállomás/felhő funkció végleges izolálása vagy eltávolítása;
- régi UI-függőségek kontrollált frissítése;
- kommunikációs viselkedés változatlanul hagyása.

Az identitás- és engedélydöntések: [[decisions/0002-sajat-identitas-es-engedelyek]].

## 2. fázis – anonimizált log-replay

- egészséges session, READY → OFF és alvó ECU fixture;
- késői prompt, részleges ISO-TP, `STOPPED`, `NO DATA`, EOF és timeout;
- hardver nélkül futó regressziós tesztek.

## 3. fázis – protokoll és recovery

- egyetlen reader és egyidejűleg egy parancs;
- parancsonkénti deadline és session/generation védelem;
- első releváns timeoutnál scanmegszakítás;
- `VEHICLE_ASLEEP`, reconnect és backoff;
- csak teljes scan publikálhat új snapshotot.

## 4. fázis – OBDLink LX profil

- ELM-kompatibilis alapútvonal;
- opcionális `STDI`/`STI`/`STIX` capability detection;
- adapter/firmware diagnosztika és hosszú hardvertesztek.

## 5. fázis – 27/30 kWh és SOH modell

- külön 96 és 100 cellás profil;
- nyers BMS, BMS-reported SOH és becsült kapacitás külön típusként;
- forrás- és bizonytalansági metadata;
- részleges `2105` nem választhat téves profilt.
