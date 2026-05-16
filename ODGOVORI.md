

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