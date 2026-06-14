-- Denormalizace relačního modelu do analytické tabulky v BigQuery
-- Výsledná tabulka slouží jako základ pro navazující SQL analýzy a Power BI výstupy.
-- Granularita výsledné tabulky: 1 řádek = 1 položka objednávky.
-- Součástí dotazu je výpočet pořadí objednávky zákazníka pomocí ROW_NUMBER(). 
CREATE OR REPLACE TABLE `fiktivnidata.01.denormalizovany_dataset` AS.

WITH objednavky_s_poradim AS (
  SELECT
    o.id_objednavky,
    o.datum,
    o.zpusob_platby,
    o.id_pobocky,
    o.typ_nakupu,
    CAST(o.id_kampane AS STRING) AS id_kampane,
    o.typ_zakaznik,
    o.id_zakaznik,
    ROW_NUMBER() OVER (
      PARTITION BY o.id_zakaznik
      ORDER BY o.datum, o.id_objednavky
    ) AS poradi_objednavky
  FROM `fiktivnidata.01.objednavky50` o
)

SELECT
  -- objednávky
  o.id_objednavky,
  o.datum,
  o.zpusob_platby,
  o.id_pobocky,
  o.typ_nakupu,
  o.id_kampane,
  o.typ_zakaznik,
  o.id_zakaznik,
  o.poradi_objednavky,

  -- zákazník
  z.pohlavi,

  -- položky
  p.id_polozky,
  p.cena_polozka,
  p.mnozstvi,

  -- varianty
  v.id_varianty,
  v.velikost,
  v.naklad,

  -- produkty
  pr.id_produktu,
  pr.nazev,
  pr.technika,
  pr.druh,

  -- kampaně
  k.kampan_flag,
  k.kampan_nazev,
  CAST(k.start_datum AS DATE) AS start_datum,
  CAST(k.konec_datum AS DATE) AS konec_datum,
  k.rozpocet_kampan,
  k.kanal,
  k.vyse_slevy
 


FROM objednavky_s_poradim o

JOIN `fiktivnidata.01.polozky` p
  ON o.id_objednavky = p.id_objednavky

JOIN `fiktivnidata.01.varianty` v
  ON p.id_varianty = v.id_varianty

JOIN `fiktivnidata.01.produkty` pr
  ON v.id_produktu = pr.id_produktu

JOIN `fiktivnidata.01.zakaznici` z
  ON o.id_zakaznik = z.id_zakaznik

LEFT JOIN `fiktivnidata.01.kampane` k
  ON o.id_kampane = k.id_kampane;




-- Kontrola počtu řádků:
-- denormalizovaná tabulka by měla mít stejný počet řádků jako tabulka položek

SELECT
  (SELECT COUNT(*) FROM `fiktivnidata.01.polozky`) AS pocet_radku_polozky,
  (SELECT COUNT(*) FROM `fiktivnidata.01.denormalizovany_dataset`) AS pocet_radku_denormalizovany_dataset;


  -- Kontrola, zda se žádná položka objednávky po JOINech neznásobila

SELECT
  COUNT(*) AS pocet_radku,
  COUNT(DISTINCT id_polozky) AS pocet_unikatnich_polozek,
  COUNT(*) - COUNT(DISTINCT id_polozky) AS rozdil
FROM `fiktivnidata.01.denormalizovany_dataset`;


-- Kontrola NULL hodnot v klíčových sloupcích

SELECT
  COUNTIF(id_objednavky IS NULL) AS null_objednavky,
  COUNTIF(id_zakaznik IS NULL) AS null_zakaznici,
  COUNTIF(id_polozky IS NULL) AS null_polozky,
  COUNTIF(id_varianty IS NULL) AS null_varianty,
  COUNTIF(id_produktu IS NULL) AS null_produkty
FROM `fiktivnidata.01.denormalizovany_dataset`;


-- Kontrola objednávek s kampaní, které se nepodařilo napojit na detail kampaně.

WITH objednavky_s_kampani AS (
  SELECT DISTINCT
    CAST(id_kampane AS STRING) AS id_kampane
  FROM `fiktivnidata.01.objednavky50`
  WHERE id_kampane IS NOT NULL
)

SELECT
  COUNT(*) AS kampane_bez_detailu
FROM objednavky_s_kampani o
LEFT JOIN `fiktivnidata.01.kampane` k
  ON o.id_kampane = CAST(k.id_kampane AS STRING)
WHERE k.id_kampane IS NULL;


-- Očekávaný výsledek kontrol:
-- 1) počet řádků denormalizované tabulky odpovídá počtu řádků v tabulce položek,
-- 2) rozdíl mezi počtem řádků a počtem unikátních položek je 0,
-- 3) klíčové sloupce neobsahují NULL hodnoty,
-- 4) všechny kampaně použité v objednávkách mají odpovídající detail v tabulce kampaní.