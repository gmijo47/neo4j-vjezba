

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

//Završni zadatak

CREATE (:Zanr {naziv: 'EDM'});
CREATE (:Zanr {naziv: 'Pop'});
CREATE (:Zanr {naziv: 'House'});
CREATE (:Zanr {naziv: 'Trance'});
CREATE (:Zanr {naziv: 'Future Bass'});

CREATE (:Izvodac {ime: 'Avicii', drzava: 'Svedska', godina_osnivanja: 2006});
CREATE (:Izvodac {ime: 'Martin Garrix', drzava: 'Nizozemska', godina_osnivanja: 2012});
CREATE (:Izvodac {ime: 'Calvin Harris', drzava: 'Velika Britanija', godina_osnivanja: 2002});
CREATE (:Izvodac {ime: 'Kygo', drzava: 'Norveska', godina_osnivanja: 2012});
CREATE (:Izvodac {ime: 'Marshmello', drzava: 'SAD', godina_osnivanja: 2015});
CREATE (:Izvodac {ime: 'Zedd', drzava: 'Njemacka', godina_osnivanja: 2010});

CREATE (:Album {naziv: 'True', godina: 2013, ocjena: 8.9});
CREATE (:Album {naziv: 'Stories', godina: 2015, ocjena: 8.7});
CREATE (:Album {naziv: 'TIM', godina: 2019, ocjena: 8.5});
CREATE (:Album {naziv: 'Funk Wav Bounces Vol. 1', godina: 2017, ocjena: 8.4});
CREATE (:Album {naziv: 'Funk Wav Bounces Vol. 2', godina: 2022, ocjena: 8.1});
CREATE (:Album {naziv: 'Motion', godina: 2014, ocjena: 8.3});
CREATE (:Album {naziv: 'Stardust', godina: 2017, ocjena: 8.6});
CREATE (:Album {naziv: 'Golden Hour', godina: 2019, ocjena: 8.2});
CREATE (:Album {naziv: 'Shockwave', godina: 2023, ocjena: 7.9});
CREATE (:Album {naziv: 'Clarity', godina: 2012, ocjena: 8.4});
CREATE (:Album {naziv: 'True Colors', godina: 2016, ocjena: 8.0});
CREATE (:Album {naziv: 'ZEDD Mix Rush', godina: 2013, ocjena: 7.8});

MATCH (i:Izvodac {ime: 'Avicii'}), (a:Album {naziv: 'True'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Avicii'}), (a:Album {naziv: 'Stories'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Avicii'}), (a:Album {naziv: 'TIM'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Calvin Harris'}), (a:Album {naziv: 'Funk Wav Bounces Vol. 1'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Calvin Harris'}), (a:Album {naziv: 'Funk Wav Bounces Vol. 2'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Calvin Harris'}), (a:Album {naziv: 'Motion'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Kygo'}), (a:Album {naziv: 'Stardust'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Kygo'}), (a:Album {naziv: 'Golden Hour'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Marshmello'}), (a:Album {naziv: 'Shockwave'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Zedd'}), (a:Album {naziv: 'Clarity'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Zedd'}), (a:Album {naziv: 'True Colors'}) CREATE (i)-[:OBJAVIO]->(a);
MATCH (i:Izvodac {ime: 'Zedd'}), (a:Album {naziv: 'ZEDD Mix Rush'}) CREATE (i)-[:OBJAVIO]->(a);

MATCH (a:Album {naziv: 'True'}), (z:Zanr {naziv: 'EDM'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Stories'}), (z:Zanr {naziv: 'EDM'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'TIM'}), (z:Zanr {naziv: 'EDM'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Funk Wav Bounces Vol. 1'}), (z:Zanr {naziv: 'Pop'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Funk Wav Bounces Vol. 2'}), (z:Zanr {naziv: 'Pop'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Motion'}), (z:Zanr {naziv: 'House'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Stardust'}), (z:Zanr {naziv: 'Future Bass'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Golden Hour'}), (z:Zanr {naziv: 'Future Bass'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Shockwave'}), (z:Zanr {naziv: 'House'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'Clarity'}), (z:Zanr {naziv: 'Trance'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'True Colors'}), (z:Zanr {naziv: 'Trance'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);
MATCH (a:Album {naziv: 'ZEDD Mix Rush'}), (z:Zanr {naziv: 'EDM'}) CREATE (a)-[:PRIPADA_ZANRU]->(z);

MATCH (a:Izvodac {ime: 'Avicii'}), (b:Izvodac {ime: 'Kygo'}) CREATE (a)-[:SLICAN]->(b);
MATCH (a:Izvodac {ime: 'Martin Garrix'}), (b:Izvodac {ime: 'Zedd'}) CREATE (a)-[:SLICAN]->(b);
MATCH (a:Izvodac {ime: 'Marshmello'}), (b:Izvodac {ime: 'Martin Garrix'}) CREATE (a)-[:SLICAN]->(b);
MATCH (a:Izvodac {ime: 'Calvin Harris'}), (b:Izvodac {ime: 'Avicii'}) CREATE (a)-[:SLICAN]->(b);
MATCH (a:Izvodac {ime: 'Zedd'}), (b:Izvodac {ime: 'Marshmello'}) CREATE (a)-[:SLICAN]->(b);

MATCH (a:Izvodac {ime: 'Avicii'}), (b:Izvodac {ime: 'Martin Garrix'}) CREATE (a)-[:SURADIVAO_S]->(b);
MATCH (a:Izvodac {ime: 'Calvin Harris'}), (b:Izvodac {ime: 'Kygo'}) CREATE (a)-[:SURADIVAO_S]->(b);

CREATE CONSTRAINT izvodac_ime_unique FOR (i:Izvodac) REQUIRE i.ime IS UNIQUE;
CREATE INDEX album_ocjena FOR (a:Album) ON (a.ocjena);



MATCH (i:Izvodac {ime: 'Avicii'})-[:OBJAVIO]->(a:Album)
RETURN a.naziv AS album, a.godina AS godina, a.ocjena AS ocjena
ORDER BY a.godina ASC;

MATCH (i:Izvodac)-[:OBJAVIO]->(a:Album)
WHERE a.ocjena > 8.0
RETURN i.ime AS izvodac, a.naziv AS album, a.ocjena AS ocjena
ORDER BY a.ocjena DESC;

MATCH (i:Izvodac)
OPTIONAL MATCH (i)-[:OBJAVIO]->(a:Album)
RETURN i.ime AS izvodac, count(a) AS broj_albuma
ORDER BY broj_albuma DESC;

MATCH p = shortestPath(
  (a:Izvodac {ime: 'Marshmello'}) -[:SLICAN|SURADIVAO_S*..10]- (b:Izvodac {ime: 'Avicii'})
)
RETURN p, length(p) AS duljina_puta;

MATCH (a:Album)-[:PRIPADA_ZANRU]->(z:Zanr)
WITH z.naziv AS zanr, count(a) AS broj_albuma, avg(a.ocjena) AS prosjecna_ocjena
WHERE prosjecna_ocjena > 7.5
RETURN zanr, broj_albuma, round(prosjecna_ocjena * 10) / 10 AS prosjecna_ocjena
ORDER BY prosjecna_ocjena DESC;
