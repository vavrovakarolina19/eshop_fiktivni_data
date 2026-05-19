-- PRŮMĚRNÁ ŠÍŘE KOŠÍKU
-- Kolik různých produktů je průměrně v košíku zákazníka?
-- Liší se to mezi věrnými, příležitostními a jednorázovými zákazníky?
-- Šíře košíku = počet unikátních produktů na zákazníka
 
-- Část 1: Průměrná šíře košíku podle segmentu
WITH kosik AS (
    SELECT
        id_zakaznik,
        typ_zakaznik,
        COUNT(DISTINCT nazev) AS sirka_kosiku
    FROM `fiktivnidata.01.denormalizovany_dataset`
    GROUP BY id_zakaznik, typ_zakaznik
)
SELECT
    typ_zakaznik,
    ROUND(AVG(sirka_kosiku), 2) AS prumerna_sirka_kosiku
FROM kosik
GROUP BY typ_zakaznik
ORDER BY prumerna_sirka_kosiku DESC;
 
-- Výsledek:
-- typ_zakaznik	prumerna_sirka_kosiku
-- verny		5.41
-- prilezitostny	2.99
-- jednorazovy	1.92
 
-- Věrný zákazník má průměrně 5.41 různých produktů v košíku.
-- Jednorázový zákazník má průměrně 1.92 různých produktů v košíku.
-- Rozdíl: věrný zákazník má 2.8x širší košík.
 
-- Část 2: Průměrná šíře košíku celkem
WITH kosik AS (
    SELECT
        id_zakaznik,
        COUNT(DISTINCT nazev) AS sirka_kosiku
    FROM `fiktivnidata.01.denormalizovany_dataset`
    GROUP BY id_zakaznik
)
SELECT
    ROUND(AVG(sirka_kosiku), 2) AS prumerna_sirka_kosiku_celkem
FROM kosik;
 
-- Průměrný košík obsahuje 3.58 různých produktů.
 
