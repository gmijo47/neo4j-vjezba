

// Zadatak 1
RETURN 'Neo4j radi!' AS poruka;

//Korak 2

CREATE (f1:Film {naslov: 'Inception', godina: 2010, ocjena: 8.8, zanr: 'sci-fi'});
CREATE (f2:Film {naslov: 'The Dark Knight', godina: 2008, ocjena: 9.0, zanr: 'akcija'});
CREATE (f3:Film {naslov: 'Interstellar', godina: 2014, ocjena: 8.6, zanr: 'sci-fi'});
CREATE (f4:Film {naslov: 'Parasite', godina: 2019, ocjena: 8.6, zanr: 'triler'});
CREATE (f5:Film {naslov: 'The Godfather', godina: 1972, ocjena: 9.2, zanr: 'drama'});
CREATE (f6:Film {naslov: 'Memento', godina: 2000, ocjena: 8.4, zanr: 'triler'});


CREATE (o1:Osoba {ime: 'Christopher Nolan', dob: 54});
CREATE (o2:Osoba {ime: 'Bong Joon-ho', dob: 55});
CREATE (o3:Osoba {ime: 'Francis Ford Coppola', dob: 85});
CREATE (o4:Osoba {ime: 'Leonardo DiCaprio', dob: 50});
CREATE (o5:Osoba {ime: 'Christian Bale', dob: 50});


CREATE (g1:Grad {naziv: 'Los Angeles'});
CREATE (g2:Grad {naziv: 'London'});
CREATE (g3:Grad {naziv: 'Seoul'});


MATCH (n) RETURN labels(n) AS label, count(*) AS broj;

//Zadatak 2

MATCH (n) RETURN count(n) AS ukupno_cvorova;

CREATE (o6:Osoba {ime: 'Petar Perić', dob: 83});
CREATE (o7:Osoba {ime: 'Miro Mirić', dob: 80});

CREATE (g4:Grad {naziv: 'Mostar'});

//Zadatak 3

MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Inception'})
CREATE (o)-[:REZIRAO]->(f);
MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'The Dark Knight'})
CREATE (o)-[:REZIRAO]->(f);
MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Interstellar'})
CREATE (o)-[:REZIRAO]->(f);
MATCH (o:Osoba {ime: 'Christopher Nolan'}), (f:Film {naslov: 'Memento'})
CREATE (o)-[:REZIRAO]->(f);
MATCH (o:Osoba {ime: 'Bong Joon-ho'}), (f:Film {naslov: 'Parasite'})
CREATE (o)-[:REZIRAO]->(f);
MATCH (o:Osoba {ime: 'Francis Ford Coppola'}), (f:Film {naslov: 'The Godfather'})
CREATE (o)-[:REZIRAO]->(f);

MATCH (o:Osoba {ime: 'Leonardo DiCaprio'}), (f:Film {naslov: 'Inception'})
CREATE (o)-[:GLUMIO_U]->(f);
MATCH (o:Osoba {ime: 'Christian Bale'}), (f:Film {naslov: 'The Dark Knight'})
CREATE (o)-[:GLUMIO_U]->(f);
MATCH (o:Osoba {ime: 'Christian Bale'}), (f:Film {naslov: 'The Dark Knight'})
MERGE (o)-[:GLUMIO_U]->(f);   // MERGE - ne kreira duplikat ako vec postoji


MATCH (o:Osoba {ime: 'Christopher Nolan'}), (g:Grad {naziv: 'London'})
CREATE (o)-[:ZIVI_U]->(g);
MATCH (o:Osoba {ime: 'Leonardo DiCaprio'}), (g:Grad {naziv: 'Los Angeles'})
CREATE (o)-[:ZIVI_U]->(g);
MATCH (o:Osoba {ime: 'Bong Joon-ho'}), (g:Grad {naziv: 'Seoul'})
CREATE (o)-[:ZIVI_U]->(g);

MATCH (a:Osoba {ime: 'Christopher Nolan'}), (b:Osoba {ime: 'Christian Bale'})
CREATE (a)-[:PRIJATELJ {od: 2000}]->(b);
MATCH (a:Osoba {ime: 'Leonardo DiCaprio'}), (b:Osoba {ime: 'Christopher Nolan'})
CREATE (a)-[:PRIJATELJ {od: 2010}]->(b);

MATCH (n)-[r]->(m) RETURN n, r, m

MATCH (o:Osoba {ime: 'Petar Perić'}), (f:Film {naslov: 'The Godfather'})
CREATE (o)-[:GLUMIO_U]->(f);
MATCH (o:Osoba {ime: 'Miro Mirić'}), (f:Film {naslov: 'Memento'})
CREATE (o)-[:GLUMIO_U]->(f);

MATCH ()-[r]->() RETURN type(r) AS tip, count(*) AS broj ORDER BY broj DESC;


//Zadatak 4

MATCH (f:Film)
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.ocjena DESC;

MATCH (f:Film)
WHERE f.ocjena > 8.7
RETURN f.naslov, f.ocjena
ORDER BY f.ocjena DESC;

MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WHERE o.ime = 'Christopher Nolan'
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.godina;

MATCH (o:Osoba)-[:GLUMIO_U]->(f:Film)
WHERE f.zanr = 'sci-fi'
RETURN o.ime AS glumac, f.naslov AS film;

MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
RETURN o.ime AS redatelj, collect(f.naslov) AS filmovi
ORDER BY redatelj;

MATCH (o:Osoba)
OPTIONAL MATCH (o)-[:REZIRAO]->(f:Film)
RETURN o.ime, count(f) AS broj_reziranih_filmova
ORDER BY broj_reziranih_filmova DESC;

MATCH (f:Film)
WHERE f.zanr = 'triler'
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.godina ASC;

MATCH (o:Osoba)-[:REZIRAO]->(:Film)
MATCH (o)-[:ZIVI_U]->(g:Grad)
RETURN DISTINCT o.ime AS redatelj, g.naziv AS grad;

MATCH (f:Film)
WHERE f.godina >= 2008 AND f.godina <= 2015
RETURN f.naslov, f.godina, f.ocjena
ORDER BY f.godina;

MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WITH o.ime AS redatelj, count(f) AS broj_filmova, collect(f.naslov) AS naslovi
WHERE broj_filmova > 1
RETURN redatelj, broj_filmova, naslovi
ORDER BY broj_filmova DESC;

//Zadatak 5

MATCH (f:Film {naslov: 'Inception'})-[*1..2]-(n)
RETURN DISTINCT labels(n) AS tip, n.naslov AS naslov, n.ime AS ime

MATCH p = shortestPath(
  (a:Osoba {ime: 'Christopher Nolan'})
  -[*]-
  (b:Osoba {ime: 'Bong Joon-ho'})
)
RETURN p, length(p) AS duljina_puta;

MATCH p = shortestPath(
  (a:Osoba {ime: 'Christopher Nolan'})
  -[*]-
  (b:Osoba {ime: 'Bong Joon-ho'})
)
RETURN p, length(p) AS duljina_puta

MATCH p = (a:Osoba {ime: 'Leonardo DiCaprio'})
          -[*1..4]-
          (b:Osoba {ime: 'Bong Joon-ho'})
RETURN p, length(p) AS duljina
ORDER BY duljina
LIMIT 5;

MATCH p = shortestPath(
  (a:Osoba {ime: 'Leonardo DiCaprio'}) -[*]- (b:Osoba {ime: 'Bong Joon-ho'})
)
RETURN p, length(p) AS duljina_puta;

MATCH (g:Grad {naziv: 'London'})-[*1..2]-(n)
RETURN DISTINCT labels(n) AS tip, n.naziv AS naziv, n.ime AS ime, n.naslov AS naslov;

MATCH (a:Osoba {ime: 'Francis Ford Coppola'}), (b:Osoba {ime: 'Leonardo DiCaprio'})
RETURN EXISTS { MATCH (a)-[*1..4]-(b) } AS povezani_u_4_koraka;


//Zadatak 6

MATCH (f:Film)
RETURN f.zanr AS zanr, count(f) AS broj_filmova
ORDER BY broj_filmova DESC;

MATCH (f:Film)
WITH f.zanr AS zanr, count(f) AS broj, avg(f.ocjena) AS prosjecna_ocjena
WHERE broj > 1
RETURN zanr, broj, round(prosjecna_ocjena * 10) / 10 AS ocjena
ORDER BY prosjecna_ocjena DESC;

MATCH (o:Osoba)-[:REZIRAO]->(f:Film)
WITH o.ime AS redatelj, count(f) AS filmova, collect(f.naslov) AS naslovi
RETURN redatelj, filmova, naslovi
ORDER BY filmova DESC;

MATCH (f:Film)
WITH f.zanr AS zanr, f
ORDER BY f.ocjena DESC
WITH zanr, collect(f)[0..3] AS top_filmovi
RETURN zanr,
       [film IN top_filmovi | film.naslov + ' (' + toString(film.ocjena) + ')']
       AS top3;

MATCH (f:Film)
RETURN count(f) AS ukupno_filmova, round(avg(f.ocjena) * 10) / 10 AS prosjecna_ocjena;

MATCH (f:Film)
WITH f.zanr AS zanr, count(f) AS broj_filmova, max(f.ocjena) AS max_ocjena
RETURN zanr, broj_filmova, max_ocjena
ORDER BY max_ocjena DESC;


MATCH (o:Osoba)-[:ZIVI_U]->(g:Grad)
WITH g, count(o) AS broj_osoba
ORDER BY broj_osoba DESC
LIMIT 1
MATCH (o:Osoba)-[:ZIVI_U]->(g)
RETURN o.ime AS osoba, g.naziv AS grad;


MATCH (o:Osoba)-[:GLUMIO_U]->(f:Film)
WITH f.naslov AS film, collect(o.ime) AS glumci
RETURN film, glumci
ORDER BY film;

//Zadatak 7

CREATE INDEX film_ocjena FOR (f:Film) ON (f.ocjena);
CREATE INDEX film_naslov FOR (f:Film) ON (f.naslov);
CREATE INDEX osoba_ime FOR (o:Osoba) ON (o.ime);

CREATE CONSTRAINT film_naslov_unique
FOR (f:Film) REQUIRE f.naslov IS UNIQUE;

CREATE CONSTRAINT film_naslov_nn
FOR (f:Film) REQUIRE f.naslov IS NOT NULL;

SHOW INDEXES;
SHOW CONSTRAINTS;

// Ovo ce baciti gresku jer Inception vec postoji (UNIQUE constraint)
CREATE (f:Film {naslov: 'Inception', godina: 2025, ocjena: 5.0})

// MERGE ce pronaci postojeci film umjesto kreiranja duplikata:
MERGE (f:Film {naslov: 'Inception'})
ON MATCH SET f.opis = 'Klasik Christophera Nolana'
ON CREATE SET f.godina = 2010, f.ocjena = 8.8
RETURN f
