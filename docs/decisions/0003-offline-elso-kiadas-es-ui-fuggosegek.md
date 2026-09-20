# 0003 – Offline első kiadás és UI-függőségek

Dátum: 2026-09-20  
Státusz: elfogadva

## Helyzet

Az upstream alkalmazás egy statikus koppenhágai töltőpont-adatbázist, egy
opcionális GoingElectric API-klienst és felhő/tárhely-beállítások maradványait
tartalmazta. Ezek nem részei a SnoSoulEV első kiadásának, miközben az
`INTERNET` engedély és a Volley függőség növelte a támadási felületet.

A MaterialDrawer 4.3.1 és Iconics 1.x korszakból származó UI-réteg régi
AndroidX-verziókat húzott be. A projekt ugyanakkor továbbra is támogatja az
Android API 16-ot.

## Döntés

- Eltávolítjuk a töltőállomás-modult, annak statikus adatállományát, a
  Volley klienst, a nem működő felhő/tárhely-beállításokat és az
  `INTERNET` engedélyt.
- Az adatvédelmi tájékoztató az APK-ba csomagolt helyi HTML-oldal lesz.
- Az első képernyő az Energia nézet lesz.
- A MaterialDrawer 6.1.2, az Iconics betűkészletek 3.x/5.x, az AppCompat
  1.6.1 és a RecyclerView 1.3.2 verziókra frissülnek.
- Nem emeljük a `minSdk 16` értéket. Az AppCompat 1.7-es vonala a build
  metadata alapján API 21-et igényel, ezért a kompatibilis 1.6.1 marad.
- Az OBD/ELM327 kommunikációs réteg ebben a változtatásban nem módosul.

## Következmények

Az alkalmazás alapműködéséhez nincs hálózati jogosultság vagy API-kulcs.
A külső felhasználói kézikönyv továbbra is a felhasználó által választott
külső alkalmazásban nyílik meg. A töltőpontkeresés csak későbbi, külön
adatvédelmi és termékdöntéssel kerülhet vissza.

A build- és lintellenőrzés automatizálható; a navigáció vizuális ellenőrzése
és a Bluetooth/OBD adapteres próba valós eszközt igényel.
