# Soul EV Diagnostics – projektmemória

Ez a könyvtár Obsidian vaultként is megnyitható. A jegyzetek közönséges,
verziókövetett Markdown-fájlok, ezért GitHubon és bármely szerkesztőben is
olvashatók.

## Belépési pontok

- [[01-fejlesztoi-kornyezet]] – telepítés és napi parancsok
- [[02-baseline-jelentes]] – a 0. fázis eredménye és fennmaradó kockázatai
- [[03-utemezes]] – a specifikációból levezetett fázisok
- [[decisions/0001-projektmemoria]] – mi kerül Obsidianba, `AGENTS.md`-be és Gitbe

## Rövid projektazonosító

- Upstream: `langemand/SoulEVSpy`
- Kiinduló commit: `0a1cafb93a65d17e0c7e1bb3ad2bc9cb965d02a7`
- Aktív baseline ág: `modernize/build-baseline`
- Ideiglenes fejlesztési név: Soul EV Diagnostics
- Jelenlegi Android application ID: `com.evranger.soulevspy` (az átnevezés az 1. fázis része)

## Adatbiztonság

Nyers felhasználói napló csak anonimizálás után kerülhet a repóba. Legalább a
VIN-t, GPS-koordinátákat, adaptersorozatszámot és más személyes adatot el kell
távolítani. Az alkalmazás járműoldali működése read-only marad.
