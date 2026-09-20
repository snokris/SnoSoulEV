# SnoSoulEV – projektmemória

Ez a könyvtár Obsidian vaultként is megnyitható. A jegyzetek közönséges,
verziókövetett Markdown-fájlok, ezért GitHubon és bármely szerkesztőben is
olvashatók.

## Belépési pontok

- [[01-fejlesztoi-kornyezet]] – telepítés és napi parancsok
- [[02-baseline-jelentes]] – a 0. fázis eredménye és fennmaradó kockázatai
- [[03-utemezes]] – a specifikációból levezetett fázisok
- [[decisions/0001-projektmemoria]] – mi kerül Obsidianba, `AGENTS.md`-be és Gitbe
- [[decisions/0002-sajat-identitas-es-engedelyek]] – appazonosító,
  Bluetooth- és tárhelydöntések
- [[decisions/0003-offline-elso-kiadas-es-ui-fuggosegek]] – a hálózati
  modul eltávolítása és a kompatibilis UI-függőségvonal

## Rövid projektazonosító

- Upstream: `langemand/SoulEVSpy`
- Kiinduló commit: `0a1cafb93a65d17e0c7e1bb3ad2bc9cb965d02a7`
- Baseline ág: `modernize/build-baseline`
- Aktív 1. fázis ág: `modernize/offline-ui-dependencies`
- Alkalmazásnév: SnoSoulEV
- Android application ID: `hu.snokris.snosoulev`
- A Java/Android namespace átmenetileg `com.evranger.soulevspy`, hogy a
  kommunikációs kód átnevezése ne keveredjen a platformmodernizálással.

## Adatbiztonság

Nyers felhasználói napló csak anonimizálás után kerülhet a repóba. Legalább a
VIN-t, GPS-koordinátákat, adaptersorozatszámot és más személyes adatot el kell
távolítani. Az alkalmazás járműoldali működése read-only marad.
