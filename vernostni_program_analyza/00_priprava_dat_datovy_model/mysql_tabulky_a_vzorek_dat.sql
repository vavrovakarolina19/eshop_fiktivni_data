-- Ukázka tvorby zdrojových tabulek a vložení dat v MySQL
-- Soubor slouží jako zkrácený ilustrační vzorek původního postupu.
-- Kompletní INSERT příkazy nejsou součástí repozitáře kvůli rozsahu datasetu.
-- Cílem ukázky je demonstrovat strukturu tabulek, použité datové typy a základní logiku naplnění dat pro fiktivní e-shop.



-- Tabulka: kraje
-- Číselník krajů a států.
-- Slouží k přiřazení geografické oblasti k zákazníkům a pobočkám.
CREATE TABLE kraje (
    id_kraj INT PRIMARY KEY,
    stat VARCHAR (50),
    nazev_kraj VARCHAR (50)
  );

INSERT INTO kraje (id_kraj,stat,nazev_kraj) VALUES
(1, 'CZ', 'Praha'),
(2, 'CZ', 'Středočeský'),
(3, 'CZ', 'Jihočeský'),
(4, 'CZ', 'Plzeňský'),
(5, 'CZ', 'Karlovarský');


-- Tabulka: pobocky
-- Číselník poboček.
-- Každá pobočka je přiřazena ke konkrétnímu kraji.
  CREATE TABLE pobocky (
    id_pobocky INT PRIMARY KEY,
    nazev_pobocky VARCHAR (50),
    id_kraj INT
  );

    INSERT INTO pobocky (id_pobocky,nazev_pobocky,id_kraj) VALUES
  
(1, 'Praha-Vinohrady', 1),
(2, 'Brno-Centrum', 11),
(3, 'Ostrava-City', 14),
(4, 'Plzeň-Střed', 4),
(5, 'Liberec-Město', 7);


-- Tabulka: produkty
-- Základní číselník produktů.
-- Obsahuje název produktu, použitou techniku a druh produktu.
  CREATE TABLE produkty (
    id_produktu INT PRIMARY KEY,
    nazev VARCHAR(50),
    technika  VARCHAR(50),
    druh VARCHAR(50)
);

INSERT INTO produkty (id_produktu, nazev, technika, druh) VALUES

(1, 'svetr basic', 'pletený', 'oblečení'),
(2, 'čepice', 'pletený', 'doplněk'),
(3, 'medvídek', 'háčkovaný', 'hračka'),
(4, 'zajíček', 'háčkovaný', 'hračka'),
(5, 'deka', 'háčkovaný', 'doplněk');


-- Tabulka: varianty
-- Varianty jednotlivých produktů.
-- Varianta rozšiřuje produkt o cenu, velikost, barvu a náklad.
CREATE TABLE varianty (
    id_varianty INT PRIMARY KEY,
    cena INT,
    velikost VARCHAR (50),
    id_produktu INT,
    barva VARCHAR (50),
    naklad INT,
    FOREIGN KEY (id_produktu) REFERENCES produkty(id_produktu)
);

INSERT INTO varianty (id_varianty,cena,velikost,id_produktu,barva,naklad) VALUES

(1, 1400, '122', 1, 'červená', 840),
(2, 1400, '122', 1, 'zelená', 840),
(3, 1400, '122', 1, 'modrá', 840),
(4, 1400, '122', 1, 'žlutá', 840),
(5, 1400, '122', 1, 'černá', 840);


-- Tabulka: zakaznici
-- Základní informace o zákaznících.
-- Každý zákazník je přiřazen ke kraji.
CREATE TABLE zakaznici (
    id_zakaznik INT PRIMARY KEY,
    pohlavi VARCHAR (50),
    id_kraj INT,
    FOREIGN KEY (id_kraj) REFERENCES kraje(id_kraj));

    INSERT INTO zakaznici (id_zakaznik,pohlavi,id_kraj) VALUES
(1, 'F', 5),
(2, 'F', 8),
(3, 'F', 16),
(4, 'F', 12),
(5, 'F', 4);


-- Tabulka: objednavky
-- Hlavičky objednávek.
-- Obsahují zákazníka, datum objednávky, celkovou cenu,
-- způsob platby, typ nákupu a případnou pobočku.
CREATE TABLE objednavky (
    id_objednavky INT PRIMARY KEY,
    id_zakaznik INT,
    datum DATE,
    cena_celkem INT,
    zpusob_platby VARCHAR(50),
    typ_nakupu VARCHAR(50),
    id_pobocky INT,
    FOREIGN KEY (id_zakaznik) REFERENCES zakaznici(id_zakaznik),
    FOREIGN KEY (id_pobocky) REFERENCES pobocky(id_pobocky)
);

INSERT INTO objednavky (id_objednavky,id_zakaznik,datum,cena_celkem,zpusob_platby,typ_nakupu,id_pobocky) VALUES

(1, 332, '2015-01-01', 2800, 'karta', 'online',0),
(2, 2446, '2015-01-02', 2400, 'dobirka', 'online',0),
(3, 6130, '2015-01-03', 8100, 'dobirka', 'online',0),
(4, 1116, '2015-01-03', 4800, 'karta', 'online',0),
(5, 43, '2015-01-03', 16250, 'dobirka', 'online',0);

-- Tabulka: polozky
-- Položky jednotlivých objednávek.
-- Tato tabulka pracuje na granularitě jedné položky objednávky.
-- Jedna objednávka může obsahovat více položek.
CREATE TABLE polozky (
    id_polozky INT PRIMARY KEY,
    id_objednavky INT,
    id_varianty INT,
    mnozstvi INT,
    cena_polozka INT,
    FOREIGN KEY (id_objednavky) REFERENCES objednavky(id_objednavky),
    FOREIGN KEY (id_varianty) REFERENCES varianty(id_varianty)
);


INSERT INTO polozky (id_polozky,id_objednavky,id_varianty,mnozstvi,cena_polozka) VALUES

(1, 1, '152', 2, '1400'),
(2, 2, '975', 2, '1200'),
(3, 3, '1004', 3, '2700'),
(4, 4, '433', 4, '1200'),
(5, 5, '1471', 5, '3250');

-- Tabulka: kampane
-- Marketingové kampaně.
-- Obsahují název kampaně, použitý kanál, období kampaně a rozpočet.
CREATE TABLE kampane (
    id_kampane INT PRIMARY KEY,
    kampan_nazev VARCHAR (50),
    kanal VARCHAR (50),
    start_datum DATE,
    konec_datum DATE,
    rozpocet VARCHAR (50));

INSERT INTO kampane (id_kampane,kampan_nazev,kanal,start_datum,konec_datum,rozpocet) VALUES
    
(1, 'New Year Sale 2015', 'Email', '2015-01-02', '2015-01-12', 25000),
(2, 'Spring Promo 2015', 'Facebook', '2015-04-01', '2015-04-15', 30000),
(3, 'Summer Sale 2015', 'Google', '2015-06-10', '2015-06-25', 35000),
(4, 'Back to School 2015', 'PPC', '2015-08-15', '2015-08-31', 25000),
(5, 'Black Friday 2015', 'Google', '2015-11-21', '2015-11-30', 60000);

