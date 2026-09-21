# 0001 – Projektmemória és Obsidian

Státusz: elfogadva a baseline-ban.

## Döntés

A `docs/` könyvtár a felhasználó által karbantartható, Obsidian-kompatibilis
projektmemória. A lényeges döntések, állapotjelentések, hardverteszt-jegyzőkönyvek
és anonimizált fixture-leírások verziókövetetten ide kerülnek.

A kötelező fejlesztési szabályok rövid változata a repó gyökerében lévő
`AGENTS.md` fájlban marad, mert ezt a Codex új projektszálakban automatikusan
betöltheti. A `docs/` nem rejtett agent-konfiguráció: ember és agent számára
egyaránt olvasható tudástár.

## Következmények

- A kanonikus helyi repógyökér `/Users/jamborkrisztian/Projects/Kia`.
- Obsidianban a `/Users/jamborkrisztian/Projects/Kia/docs` mappa külön
  vaultként megnyitható.
- A `.obsidian/` felhasználói beállításait egyelőre nem verziókövetjük.
- Titok, VIN, GPS vagy nyers személyes log nem kerül a tudástárba.
- A Codex saját generált memóriatárát nem szerkesztjük kézzel; a projekt igaz
  forrása Gitben marad.
