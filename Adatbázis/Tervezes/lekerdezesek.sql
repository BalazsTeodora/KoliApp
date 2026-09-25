USE koli_app;

-- 1. EMELET
-- a) Az összes emelet listázása
SELECT * FROM emelet;

-- b) Az 1. emeletnél magasabb emeletek
SELECT megnevezes, szam FROM emelet WHERE szam > 1;

-- c) Emeletek száma
SELECT COUNT(*) AS emeletek_szama FROM emelet;

-- d) Emeletek csökkenő sorrendben
SELECT * FROM emelet ORDER BY szam DESC;

-- e) Emeletek és a rajtuk lévő szobák
SELECT e.megnevezes, s.szobaszam, s.ferohely
FROM emelet e
INNER JOIN szoba s ON e.id = s.emelet_id
ORDER BY e.szam;


-- 2. SZOBA
-- a) Az összes szoba listázása
SELECT * FROM szoba;

-- b) Szobák, amikben legalább 3 fő fér el
SELECT szobaszam, ferohely FROM szoba WHERE ferohely >= 3;

-- c) Szobák száma
SELECT COUNT(*) AS szobak_szama FROM szoba;

-- d) Átlagos férőhely szobánként
SELECT AVG(ferohely) AS atlagos_ferohely FROM szoba;

-- e) Szobák a hozzájuk tartozó emelet nevével
SELECT s.szobaszam, s.ferohely, e.megnevezes AS emelet
FROM szoba s
INNER JOIN emelet e ON s.emelet_id = e.id;


-- 3. FELHASZNALO
-- a) Az összes felhasználó listázása
SELECT * FROM felhasznalo;

-- b) Csak a diákok neve és emailje
SELECT nev, email FROM felhasznalo WHERE szerepkor = 'diak';

-- c) Diákok száma
SELECT COUNT(*) AS diakok_szama FROM felhasznalo WHERE szerepkor = 'diak';

-- d) Aktív regisztrációjú felhasználók név szerint rendezve
SELECT nev, regisztracio_allapota FROM felhasznalo WHERE regisztracio_allapota = 'aktiv' ORDER BY nev;

-- e) Felhasználók a szobájuk számával (akiknek van szobájuk)
SELECT f.nev, s.szobaszam
FROM felhasznalo f
INNER JOIN szoba s ON f.szoba_id = s.id;


-- 4. PROGRAM
-- a) Az összes program listázása
SELECT * FROM program;

-- b) Szórakozás típusú programok
SELECT cim, kezdes FROM program WHERE tipus = 'szorakozas';

-- c) Aktív állapotú programok száma
SELECT COUNT(*) AS aktiv_programok FROM program WHERE allapot = 'aktiv';

-- d) Programok maximális létszám szerint csökkenő sorrendben
SELECT cim, maximalis_letszam FROM program ORDER BY maximalis_letszam DESC;

-- e) Programok és a rájuk jelentkezett felhasználók
SELECT p.cim, f.nev
FROM program p
INNER JOIN jelentkezes j ON p.id = j.program_id
INNER JOIN felhasznalo f ON j.felhasznalo_id = f.id
ORDER BY p.cim;


-- 5. JELENTKEZES
-- a) Az összes jelentkezés listázása
SELECT * FROM jelentkezes;

-- b) Az 1. programra érkezett jelentkezések
SELECT * FROM jelentkezes WHERE program_id = 1;

-- c) Jelentkezések teljes száma
SELECT COUNT(*) AS jelentkezesek_szama FROM jelentkezes;

-- d) Jelentkezők száma programonként
SELECT program_id, COUNT(*) AS jelentkezok_szama
FROM jelentkezes
GROUP BY program_id;

-- e) Melyik felhasználó melyik programra jelentkezett
SELECT f.nev, p.cim
FROM jelentkezes j
INNER JOIN felhasznalo f ON j.felhasznalo_id = f.id
INNER JOIN program p ON j.program_id = p.id;


-- 6. KERELEM
-- a) Az összes kérelem listázása
SELECT * FROM kerelem;

-- b) Elbírálásra váró (függőben lévő) kérelmek
SELECT * FROM kerelem WHERE allapot = 'fuggoben';

-- c) Szobaváltási kérelmek száma
SELECT COUNT(*) AS szobavaltasok_szama FROM kerelem WHERE tipus = 'szobavaltas';

-- d) Kérelmek száma típusonként
SELECT tipus, COUNT(*) AS db FROM kerelem GROUP BY tipus;

-- e) Kérelmező és elbíráló neve egy sorban
SELECT k.tipus, k.allapot, f.nev AS kerelmezo, a.nev AS elbiralo
FROM kerelem k
INNER JOIN felhasznalo f ON k.felhasznalo_id = f.id
INNER JOIN felhasznalo a ON k.elbiralo_id = a.id;


-- 7. HIBABEJELENTES
-- a) Az összes hibabejelentés listázása
SELECT * FROM hibabejelentes;

-- b) Nyitott állapotú hibabejelentések
SELECT * FROM hibabejelentes WHERE allapot = 'nyitott';

-- c) Hibabejelentések teljes száma
SELECT COUNT(*) AS hibak_szama FROM hibabejelentes;

-- d) Hibabejelentések száma típusonként
SELECT tipus, COUNT(*) AS db FROM hibabejelentes GROUP BY tipus;

-- e) Hibabejelentések a bejelentő nevével
SELECT h.tipus, h.leiras, h.allapot, f.nev AS bejelento
FROM hibabejelentes h
INNER JOIN felhasznalo f ON h.felhasznalo_id = f.id;


-- 8. KONDITEREM_IDOPONT
-- a) Az összes időpont listázása
SELECT * FROM konditerem_idopont;

-- b) Legalább 10 fős maximális létszámú időpontok
SELECT * FROM konditerem_idopont WHERE maximalis_letszam >= 10;

-- c) Időpontok száma
SELECT COUNT(*) AS idopontok_szama FROM konditerem_idopont;

-- d) Időpontok kezdés szerint rendezve
SELECT * FROM konditerem_idopont ORDER BY kezdes;

-- e) Időpontok, és hogy kik foglaltak rájuk
SELECT k.kezdes, k.vege, f.nev
FROM konditerem_idopont k
INNER JOIN foglalas fo ON k.id = fo.idopont_id
INNER JOIN felhasznalo f ON fo.felhasznalo_id = f.id
ORDER BY k.kezdes;


-- 9. FOGLALAS
-- a) Az összes foglalás listázása
SELECT * FROM foglalas;

-- b) Aktív (nem lemondott) foglalások
SELECT * FROM foglalas WHERE allapot = 'aktiv';

-- c) Lemondott foglalások száma
SELECT COUNT(*) AS lemondott_foglalasok FROM foglalas WHERE allapot = 'lemondva';

-- d) Foglalások száma időpontonként
SELECT idopont_id, COUNT(*) AS foglalasok_szama FROM foglalas GROUP BY idopont_id;

-- e) Ki, mikorra foglalt a kondiszobába
SELECT f.nev, fo.foglalas_datuma, fo.allapot, k.kezdes, k.vege
FROM foglalas fo
INNER JOIN felhasznalo f ON fo.felhasznalo_id = f.id
INNER JOIN konditerem_idopont k ON fo.idopont_id = k.id
ORDER BY k.kezdes;


-- 10. HIR
-- a) Az összes hír listázása
SELECT * FROM hir;

-- b) A 3 legutóbb közzétett hír címe
SELECT cim FROM hir ORDER BY id DESC LIMIT 3;

-- c) Hírek száma
SELECT COUNT(*) AS hirek_szama FROM hir;

-- d) Azok a hírek, amiknek a címében szerepel a "buli" szó
SELECT cim, tartalom FROM hir WHERE cim LIKE '%buli%';

-- e) Hírek a szerzőjük nevével
SELECT h.cim, f.nev AS szerzo
FROM hir h
INNER JOIN felhasznalo f ON h.szerzo_id = f.id;


-- 11. TAKARITAS
-- a) Az összes takarítás listázása
SELECT * FROM takaritas;

-- b) 2026.10.01 utáni takarítások
SELECT * FROM takaritas WHERE datum >= '2026-10-01';

-- c) Takarítások száma
SELECT COUNT(*) AS takaritasok_szama FROM takaritas;

-- d) Takarítások száma szobánként
SELECT szoba_id, COUNT(*) AS db FROM takaritas GROUP BY szoba_id;

-- e) Takarítási dátumok a szobaszámmal
SELECT t.datum, s.szobaszam
FROM takaritas t
INNER JOIN szoba s ON t.szoba_id = s.id
ORDER BY t.datum;


-- 12. SZILENCIUM
-- a) Az összes szilencium listázása
SELECT * FROM szilencium;

-- b) 2026.10.01 utáni szilenciumok
SELECT * FROM szilencium WHERE kezdes >= '2026-10-01';

-- c) Szilenciumok száma
SELECT COUNT(*) AS szilenciumok_szama FROM szilencium;

-- d) Szilenciumok leírása kezdés szerint rendezve
SELECT leiras FROM szilencium ORDER BY kezdes;

-- e) A szilencium időszaka egybevág a programok időszakával
SELECT sz.leiras AS szilencium, p.cim AS program, p.kezdes, p.vege
FROM szilencium sz
INNER JOIN program p ON p.kezdes < sz.vege AND p.vege > sz.kezdes;
