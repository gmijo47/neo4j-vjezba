

## Zadatak 1 

Neo4j eksponira dva porta:

- **7474** — HTTP port za **Neo4j Browser**, web sučelje
- **7687** — **Bolt protokol**, binarni protokol optimiziran za prijenos podataka između aplikacjskih drivera i Neo4j instance
---

## Zadatak 2

`CREATE` uvijek kreira novi čvor ili vezu, bez obzira na to postoji li već identičan čvor ili veza u bazi.

`MERGE` se ponaša kao "pronađi ili kreiraj": Neo4j prvo pretražuje graf tražeći pattern koji odgovara zadanom uzorku, i ako ga pronađe, vraća postojeći čvor/vezu; ako ne pronađe, tek tada ga kreira. Time se sprječava nastanak duplikata.


---

## Zadatak 4

MATCH `je ekvivalent SQL `INNER JOIN` operatora — vraća **samo one redove** za koje postoji odgovarajući pattern u grafu. 

`OPTIONAL MATCH` je ekvivalent SQL `LEFT JOIN` operatora — vraća **sve čvorove** iz prethodnog dijela upita, a za one koji nemaju odgovarajući pattern vraća `null`ž

---

## Zadatak 5

Ako `shortestPath` ne pronađe nikakav put između dva zadana čvora (npr. čvorovi nisu međusobno povezani u grafu), funkcija vraća `null` Da bismo eksplicitno uhvatili slučaj "nema puta", trebali bismo koristiti `OPTIONAL MATCH` u kombinaciji s `shortestPath`.

---

## Završni zadatak

Neo4j bih odabrao umjesto PostgreSQL-a za glazbenu bazu podataka u svim situacijama gdje su ključni **odnosi između entiteta**, a ne sami entiteti izolirano. Konkretno, problem **preporuke sličnih izvođača** ("ako ti se sviđa Avicii, sviđat će ti se i Kygo") prirodno se modelira kao traversal grafa kroz veze `SLICAN` i `SURADIVAO_S`, dok bi u PostgreSQL-u zahtijevao složene JOIN-ove i rekurzivne CTE upite. Pronalaženje **najkraćeg puta** između dva izvođača kroz mrežu suradnji trivijalno je s `shortestPath()` u Cypherju, a u relacijskom modelu zahtijeva višestruke self-JOIN-ove ili proceduralni kod. Veze u Neo4j-u su **građani prvog reda** — imaju vlastite property-e (npr. `od: 2019`) i traversal po njima ne zahtijeva međutablice, za razliku od many-to-many veza u SQL-u koje uvijek uvode join tablicu. Također, **shema glazbene scene je fleksibilna**: izvođač može imati 0 ili 100 albuma, album može biti u više žanrova, a nove vrste veza (npr. `INSPIRIRAO`) dodaju se bez migracije tablica. Ukratko, svaki problem koji uključuje dubinu i gustoću veza — preporuke, otkrivanje zajednica, putovi između entiteta — Neo4j rješava elegantno tamo gdje PostgreSQL postaje neefikasan.

---