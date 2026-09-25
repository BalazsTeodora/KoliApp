-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Sze 25. 20:43
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `koli_app`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `emelet`
--

CREATE DATABASE koli_app;

USE koli_app;


CREATE TABLE `emelet` (
  `id` int(11) NOT NULL,
  `szam` int(11) NOT NULL,
  `megnevezes` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `emelet`
--

INSERT INTO `emelet` (`id`, `szam`, `megnevezes`) VALUES
(1, 0, 'Földszint'),
(2, 1, '1. emelet'),
(3, 2, '2. emelet'),
(4, 3, '3. emelet');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalo`
--

CREATE TABLE `felhasznalo` (
  `id` int(11) NOT NULL,
  `nev` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `jelszo` varchar(100) NOT NULL,
  `szerepkor` varchar(20) NOT NULL,
  `regisztracio_allapota` varchar(20) NOT NULL,
  `szoba_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `felhasznalo`
--

INSERT INTO `felhasznalo` (`id`, `nev`, `email`, `jelszo`, `szerepkor`, `regisztracio_allapota`, `szoba_id`) VALUES
(1, 'Kovács Anna', 'kovacs.anna@kolimail.hu', 'jelszo123', 'diak', 'aktiv', 2),
(2, 'Nagy Péter', 'nagy.peter@kolimail.hu', 'jelszo123', 'diak', 'aktiv', 2),
(3, 'Szabó Eszter', 'szabo.eszter@kolimail.hu', 'jelszo123', 'diak', 'aktiv', 3),
(4, 'Tóth Bence', 'toth.bence@kolimail.hu', 'jelszo123', 'diak', 'fuggoben', 4),
(5, 'Varga Zsófia', 'varga.zsofia@kolimail.hu', 'jelszo123', 'diak', 'aktiv', 5),
(6, 'Kiss Dávid', 'kiss.david@kolimail.hu', 'jelszo123', 'diak', 'aktiv', 6),
(7, 'Horváth Lili', 'horvath.lili@kolimail.hu', 'jelszo123', 'diak', 'elutasitva', NULL),
(8, 'Molnár Gábor', 'molnar.gabor@kolimail.hu', 'jelszo123', 'diak', 'aktiv', 7),
(9, 'Farkas Bori', 'farkas.bori@kolimail.hu', 'jelszo123', 'diak', 'aktiv', 8),
(10, 'Rendszergazda Admin', 'admin@koliapp.hu', 'admin123', 'admin', 'aktiv', NULL),
(11, 'Portás Ildikó', 'portas.ildiko@koliapp.hu', 'admin123', 'admin', 'aktiv', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `foglalas`
--

CREATE TABLE `foglalas` (
  `id` int(11) NOT NULL,
  `foglalas_datuma` date NOT NULL,
  `allapot` varchar(20) NOT NULL,
  `felhasznalo_id` int(11) NOT NULL,
  `idopont_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `foglalas`
--

INSERT INTO `foglalas` (`id`, `foglalas_datuma`, `allapot`, `felhasznalo_id`, `idopont_id`) VALUES
(1, '2026-09-28', 'aktiv', 1, 1),
(2, '2026-09-28', 'aktiv', 2, 1),
(3, '2026-09-29', 'lemondva', 3, 2),
(4, '2026-09-29', 'aktiv', 4, 2),
(5, '2026-09-30', 'aktiv', 5, 3),
(6, '2026-09-30', 'aktiv', 6, 4),
(7, '2026-10-01', 'lemondva', 8, 4),
(8, '2026-10-01', 'aktiv', 9, 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `hibabejelentes`
--

CREATE TABLE `hibabejelentes` (
  `id` int(11) NOT NULL,
  `tipus` varchar(50) NOT NULL,
  `leiras` text DEFAULT NULL,
  `allapot` varchar(20) NOT NULL,
  `felhasznalo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `hibabejelentes`
--

INSERT INTO `hibabejelentes` (`id`, `tipus`, `leiras`, `allapot`, `felhasznalo_id`) VALUES
(1, 'vizvezetek', 'Csöpög a csap a fürdőszobában', 'nyitott', 1),
(2, 'elektromos', 'Nem működik a konnektor', 'javitas_alatt', 3),
(3, 'butor', 'Törött szék az egyik szobában', 'lezart', 5),
(4, 'vizvezetek', 'Eldugult a lefolyó', 'nyitott', 6),
(5, 'elektromos', 'Villog a folyosói lámpa', 'nyitott', 8),
(6, 'butor', 'Nyikorog az ágy', 'lezart', 9);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `hir`
--

CREATE TABLE `hir` (
  `id` int(11) NOT NULL,
  `cim` varchar(100) NOT NULL,
  `tartalom` text DEFAULT NULL,
  `szerzo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `hir`
--

INSERT INTO `hir` (`id`, `cim`, `tartalom`, `szerzo_id`) VALUES
(1, 'Üdvözlünk az új tanévben!', 'Szeretettel köszöntünk mindenkit a koliban, íme a legfontosabb tudnivalók...', 10),
(2, 'Gólyabál - ne maradj le!', 'Idén is megrendezzük a hagyományos gólyabálunkat, jelentkezz gyorsan!', 10),
(3, 'Karbantartási munkálatok', 'A jövő héten vízkorlátozás lesz a 2. emeleten karbantartás miatt.', 11),
(4, 'Kondiszoba nyitvatartás változás', 'Októbertől a kondiszoba reggel 7-től éjjel 21 óráig tart nyitva.', 11),
(5, 'Halloween buli szervezés', 'Jelmezversennyel várunk mindenkit a Halloween bulin!', 10);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jelentkezes`
--

CREATE TABLE `jelentkezes` (
  `id` int(11) NOT NULL,
  `felhasznalo_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `jelentkezes`
--

INSERT INTO `jelentkezes` (`id`, `felhasznalo_id`, `program_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 1, 2),
(5, 4, 2),
(6, 5, 3),
(7, 6, 3),
(8, 2, 4),
(9, 8, 4),
(10, 9, 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kerelem`
--

CREATE TABLE `kerelem` (
  `id` int(11) NOT NULL,
  `tipus` varchar(50) NOT NULL,
  `leiras` text DEFAULT NULL,
  `allapot` varchar(20) NOT NULL,
  `felhasznalo_id` int(11) NOT NULL,
  `elbiralo_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `kerelem`
--

INSERT INTO `kerelem` (`id`, `tipus`, `leiras`, `allapot`, `felhasznalo_id`, `elbiralo_id`) VALUES
(1, 'szobavaltas', 'Zajos szomszéd miatt szeretnék másik szobát', 'elfogadva', 1, 10),
(2, 'kimaradas', 'Hétvégén hazautazom, kimaradási engedélyt kérek', 'elfogadva', 2, 10),
(3, 'vendeglatas', 'Vendéget szeretnék fogadni a szobámban', 'fuggoben', 3, NULL),
(4, 'szobavaltas', 'Allergiám van, szeretnék másik emeletre kerülni', 'elutasitva', 4, 11),
(5, 'kimaradas', 'Egy hetes kimaradást kérek gyakorlat miatt', 'fuggoben', 5, NULL),
(6, 'vendeglatas', 'Családi látogatás hétvégén', 'elfogadva', 6, 11);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `konditerem_idopont`
--

CREATE TABLE `konditerem_idopont` (
  `id` int(11) NOT NULL,
  `kezdes` datetime NOT NULL,
  `vege` datetime NOT NULL,
  `maximalis_letszam` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `konditerem_idopont`
--

INSERT INTO `konditerem_idopont` (`id`, `kezdes`, `vege`, `maximalis_letszam`) VALUES
(1, '2026-10-01 07:00:00', '2026-10-01 08:30:00', 10),
(2, '2026-10-01 18:00:00', '2026-10-01 19:30:00', 10),
(3, '2026-10-02 07:00:00', '2026-10-02 08:30:00', 10),
(4, '2026-10-02 18:00:00', '2026-10-02 19:30:00', 8),
(5, '2026-10-03 18:00:00', '2026-10-03 19:30:00', 10);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `program`
--

CREATE TABLE `program` (
  `id` int(11) NOT NULL,
  `cim` varchar(100) NOT NULL,
  `leiras` text DEFAULT NULL,
  `helyszin` varchar(100) DEFAULT NULL,
  `kezdes` datetime DEFAULT NULL,
  `vege` datetime DEFAULT NULL,
  `tipus` varchar(20) DEFAULT NULL,
  `maximalis_letszam` int(11) DEFAULT NULL,
  `minimalis_letszam` int(11) DEFAULT NULL,
  `allapot` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `program`
--

INSERT INTO `program` (`id`, `cim`, `leiras`, `helyszin`, `kezdes`, `vege`, `tipus`, `maximalis_letszam`, `minimalis_letszam`, `allapot`) VALUES
(1, 'Gólyabál', 'Ismerkedési buli az elsőéveseknek', 'Aula', '2026-09-30 19:00:00', '2026-09-30 23:00:00', 'szorakozas', 200, 20, 'aktiv'),
(2, 'Kvízeste', 'Csapatos kvízjáték', 'Közösségi terem', '2026-10-05 18:00:00', '2026-10-05 20:00:00', 'jatek', 40, 8, 'aktiv'),
(3, 'Filmklub: Sci-fi est', 'Vetítés és beszélgetés', 'Mozi terem', '2026-10-10 19:00:00', '2026-10-10 22:00:00', 'kultura', 30, 5, 'aktiv'),
(4, 'Sportnap', 'Focibajnokság és egyéb sportok', 'Sportpálya', '2026-10-15 10:00:00', '2026-10-15 16:00:00', 'sport', 60, 10, 'aktiv'),
(5, 'Karrier workshop', 'Önéletrajzírás és állásinterjú tippek', 'Konferenciaterem', '2026-10-20 17:00:00', '2026-10-20 19:00:00', 'oktatas', 25, 5, 'lezart'),
(6, 'Halloween buli', 'Jelmezes party', 'Aula', '2026-10-31 20:00:00', '2026-11-01 02:00:00', 'szorakozas', 150, 20, 'tervezett');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szilencium`
--

CREATE TABLE `szilencium` (
  `id` int(11) NOT NULL,
  `leiras` text DEFAULT NULL,
  `kezdes` datetime DEFAULT NULL,
  `vege` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `szilencium`
--

INSERT INTO `szilencium` (`id`, `leiras`, `kezdes`, `vege`) VALUES
(1, 'Hétköznapi esti szilencium', '2026-10-01 22:00:00', '2026-10-02 06:00:00'),
(2, 'Vizsgaidőszaki szilencium', '2026-10-10 20:00:00', '2026-10-11 07:00:00'),
(3, 'Hétvégi szilencium', '2026-10-04 23:00:00', '2026-10-05 08:00:00'),
(4, 'Rendkívüli szilencium javítás miatt', '2026-10-15 21:00:00', '2026-10-16 06:00:00');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szoba`
--

CREATE TABLE `szoba` (
  `id` int(11) NOT NULL,
  `szobaszam` varchar(10) NOT NULL,
  `ferohely` int(11) NOT NULL,
  `emelet_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `szoba`
--

INSERT INTO `szoba` (`id`, `szobaszam`, `ferohely`, `emelet_id`) VALUES
(1, '001', 2, 1),
(2, '101', 3, 2),
(3, '102', 2, 2),
(4, '103', 4, 2),
(5, '201', 3, 3),
(6, '202', 2, 3),
(7, '203', 4, 3),
(8, '301', 3, 4),
(9, '302', 2, 4);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `takaritas`
--

CREATE TABLE `takaritas` (
  `id` int(11) NOT NULL,
  `datum` date NOT NULL,
  `szoba_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `takaritas`
--

INSERT INTO `takaritas` (`id`, `datum`, `szoba_id`) VALUES
(1, '2026-10-01', 2),
(2, '2026-10-01', 3),
(3, '2026-10-02', 4),
(4, '2026-10-02', 5),
(5, '2026-10-03', 6),
(6, '2026-10-03', 7);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `emelet`
--
ALTER TABLE `emelet`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `felhasznalo`
--
ALTER TABLE `felhasznalo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `szoba_id` (`szoba_id`);

--
-- A tábla indexei `foglalas`
--
ALTER TABLE `foglalas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `felhasznalo_id` (`felhasznalo_id`),
  ADD KEY `idopont_id` (`idopont_id`);

--
-- A tábla indexei `hibabejelentes`
--
ALTER TABLE `hibabejelentes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `felhasznalo_id` (`felhasznalo_id`);

--
-- A tábla indexei `hir`
--
ALTER TABLE `hir`
  ADD PRIMARY KEY (`id`),
  ADD KEY `szerzo_id` (`szerzo_id`);

--
-- A tábla indexei `jelentkezes`
--
ALTER TABLE `jelentkezes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `felhasznalo_id` (`felhasznalo_id`),
  ADD KEY `program_id` (`program_id`);

--
-- A tábla indexei `kerelem`
--
ALTER TABLE `kerelem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `felhasznalo_id` (`felhasznalo_id`),
  ADD KEY `elbiralo_id` (`elbiralo_id`);

--
-- A tábla indexei `konditerem_idopont`
--
ALTER TABLE `konditerem_idopont`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `program`
--
ALTER TABLE `program`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `szilencium`
--
ALTER TABLE `szilencium`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `szoba`
--
ALTER TABLE `szoba`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emelet_id` (`emelet_id`);

--
-- A tábla indexei `takaritas`
--
ALTER TABLE `takaritas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `szoba_id` (`szoba_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `emelet`
--
ALTER TABLE `emelet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `felhasznalo`
--
ALTER TABLE `felhasznalo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `foglalas`
--
ALTER TABLE `foglalas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `hibabejelentes`
--
ALTER TABLE `hibabejelentes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `hir`
--
ALTER TABLE `hir`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `jelentkezes`
--
ALTER TABLE `jelentkezes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `kerelem`
--
ALTER TABLE `kerelem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `konditerem_idopont`
--
ALTER TABLE `konditerem_idopont`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `program`
--
ALTER TABLE `program`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `szilencium`
--
ALTER TABLE `szilencium`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `szoba`
--
ALTER TABLE `szoba`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `takaritas`
--
ALTER TABLE `takaritas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `felhasznalo`
--
ALTER TABLE `felhasznalo`
  ADD CONSTRAINT `felhasznalo_ibfk_1` FOREIGN KEY (`szoba_id`) REFERENCES `szoba` (`id`);

--
-- Megkötések a táblához `foglalas`
--
ALTER TABLE `foglalas`
  ADD CONSTRAINT `foglalas_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalo` (`id`),
  ADD CONSTRAINT `foglalas_ibfk_2` FOREIGN KEY (`idopont_id`) REFERENCES `konditerem_idopont` (`id`);

--
-- Megkötések a táblához `hibabejelentes`
--
ALTER TABLE `hibabejelentes`
  ADD CONSTRAINT `hibabejelentes_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalo` (`id`);

--
-- Megkötések a táblához `hir`
--
ALTER TABLE `hir`
  ADD CONSTRAINT `hir_ibfk_1` FOREIGN KEY (`szerzo_id`) REFERENCES `felhasznalo` (`id`);

--
-- Megkötések a táblához `jelentkezes`
--
ALTER TABLE `jelentkezes`
  ADD CONSTRAINT `jelentkezes_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalo` (`id`),
  ADD CONSTRAINT `jelentkezes_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`);

--
-- Megkötések a táblához `kerelem`
--
ALTER TABLE `kerelem`
  ADD CONSTRAINT `kerelem_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalo` (`id`),
  ADD CONSTRAINT `kerelem_ibfk_2` FOREIGN KEY (`elbiralo_id`) REFERENCES `felhasznalo` (`id`);

--
-- Megkötések a táblához `szoba`
--
ALTER TABLE `szoba`
  ADD CONSTRAINT `szoba_ibfk_1` FOREIGN KEY (`emelet_id`) REFERENCES `emelet` (`id`);

--
-- Megkötések a táblához `takaritas`
--
ALTER TABLE `takaritas`
  ADD CONSTRAINT `takaritas_ibfk_1` FOREIGN KEY (`szoba_id`) REFERENCES `szoba` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
