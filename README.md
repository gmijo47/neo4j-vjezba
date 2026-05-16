# Neo4j Vježba — Graf baze podataka i Cypher query jezik

## Opis

Vježba iz predmeta Baze podataka. Demonstrira rad s Neo4j grafovskom bazom podataka: modeliranje grafa, unos podataka pomoću Cypher naredbi, čitanje, filtriranje, path traversal, agregacije, indeksi i constraints.

Projekt sadrži dvije teme:
- **Filmska baza podataka** (Koraci 1–7 + Zadaci 1–6)
- **Glazbena scena** (Završni zadatak)

---

## Preduvjeti

- [Docker](https://www.docker.com/) i Docker Compose

---

## Pokretanje okruženja

```bash
# Klonirati repozitorij i ući u mapu
git clone <url-repozitorija>
cd neo4j-vjezba

# Pokrenuti Neo4j kontejner u pozadini
docker compose up -d

# Provjera statusa (mora pisati "running")
docker compose ps
```

Neo4j Browser dostupan na: **http://localhost:7474**

Podaci za prijavu:
- Korisničko ime: `neo4j`
- Lozinka: `vjezba2026`

---

## Zaustavljanje okruženja

```bash
docker compose down
```

Podaci su trajno pohranjeni u Docker volumenu `neo4j_data` — neće se izgubiti pri zaustavljanju.

---

## Sadržaj repozitorija

| Datoteka / Mapa | Opis |
|---|---|
| `docker-compose.yml` | Konfiguracija Neo4j kontejnera |
| `queries.cypher` | Svi Cypher upiti iz koraka i zadataka, s komentarima |
| `ODGOVORI.md` | Pisani odgovori na pitanja iz Zadataka 1, 2, 4, 5, 6 i Završnog zadatka |
| `README.md` | Ovaj dokument |
| `screenshots/` | Screenshotovi iz Neo4j Browsera (rezultati zadataka) |

---

## Izvršavanje upita

Sve upite iz datoteke `queries.cypher` izvršavajte u **Neo4j Browser**-u (`http://localhost:7474`) kopiranjem u konzolu.

Preporučeni redosljed izvršavanja:
1. Korak 1 — provjera okruženja
2. Korak 2 + Zadatak 2 — kreiranje čvorova
3. Korak 3 + Zadatak 3 — kreiranje veza
4. Korak 7 — indeksi i constraints (preporučuje se prije masovnog čitanja)
5. Koraci 4–6 + Zadaci 4–6 — upiti za čitanje
6. Završni zadatak — glazbena scena

---

## Struktura grafa

### Filmska baza

**Čvorovi:**
- `Film` — naslov, godina, ocjena, zanr
- `Osoba` — ime, dob
- `Grad` — naziv

**Veze:**
- `(Osoba)-[:REZIRAO]->(Film)`
- `(Osoba)-[:GLUMIO_U]->(Film)`
- `(Osoba)-[:ZIVI_U]->(Grad)`
- `(Osoba)-[:PRIJATELJ {od}]->(Osoba)`

### Glazbena scena

**Čvorovi:**
- `Izvodac` — ime, drzava, godina_osnivanja
- `Album` — naziv, godina, ocjena
- `Zanr` — naziv

**Veze:**
- `(Izvodac)-[:OBJAVIO]->(Album)`
- `(Album)-[:PRIPADA_ZANRU]->(Zanr)`
- `(Izvodac)-[:SLICAN]->(Izvodac)`
- `(Izvodac)-[:SURADIVAO_S]->(Izvodac)`
