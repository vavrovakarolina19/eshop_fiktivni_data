-- PRŮMĚRNÁ ŠÍŘE KOŠÍKU
-- Kolik různých produktů je průměrně v jedné objednávce?
-- Liší se šíře košíku mezi věrnými, příležitostními a jednorázovými zákazníky?
-- Šíře košíku = počet unikátních produktů v jedné objednávce

-- Průměrná šíře košíku podle segmentu

WITH kosik_objednavka AS (
    SELECT
        id_objednavky,
        typ_zakaznik,
        COUNT(DISTINCT id_produktu) AS sirka_kosiku
    FROM `fiktivnidata.01.denormalizovany_dataset`
    GROUP BY id_objednavky, typ_zakaznik
)
SELECT
    typ_zakaznik,
    ROUND(AVG(sirka_kosiku), 2) AS prumerna_sirka_kosiku
FROM kosik_objednavka
GROUP BY typ_zakaznik
ORDER BY prumerna_sirka_kosiku DESC;

Výsledek:
typ_zakaznik      prumerna_sirka_kosiku
jednorazovy       1.94
verny             1.27
prilezitostny     1.25

-- Průměrná šíře košíku celkem

WITH kosik_objednavka AS (
    SELECT
        id_objednavky,
        COUNT(DISTINCT id_produktu) AS sirka_kosiku
    FROM `fiktivnidata.01.denormalizovany_dataset`
    GROUP BY id_objednavky
)

SELECT
    ROUND(AVG(sirka_kosiku), 2) AS prumerna_sirka_kosiku_celkem
FROM kosik_objednavka;

Výsledek:
prumerna_sirka_kosiku_celkem
1.31

-- Průměrná objednávka obsahuje 1.31 unikátních produktů.
-- Jednorázoví zákazníci mají nejširší košík v jedné objednávce.
-- Věrní a příležitostní zákazníci nakupují užší košíky, ale opakovaně.
