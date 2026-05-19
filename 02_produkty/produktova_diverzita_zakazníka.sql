-- PRODUKTOVÁ DIVERZITA ZÁKAZNÍKŮ
-- Kolik druhů produktů nakupují naši zákazníci? Liší se to mezi segmenty?
-- Počet unikátních produktů na zákazníka
-- Část 1: Diverzita pro každý segment

WITH produkty_zakaznik AS (
    SELECT
        id_zakaznik,
        typ_zakaznik,
        COUNT(DISTINCT id_produktu) AS pocet_unikatnich_produktu
    FROM `fiktivnidata.01.denormalizovany_dataset`
    GROUP BY id_zakaznik, typ_zakaznik
)
SELECT
    typ_zakaznik AS segment,
    ROUND(AVG(pocet_unikatnich_produktu), 2) AS prumer
FROM produkty_zakaznik
GROUP BY typ_zakaznik
ORDER BY prumer DESC;
 
Výsledek:
segment		průměr
věrný		5.65
příležitostný	3.03
jednorázový		1.94
 
-- Věrný zákazník nakupuje průměrně 5.65 unikátních produktů.
-- Jednorázový zákazník nakupuje průměrně 1.94 produktů.
-- Věrní zákazníci nakupují přibližně 2,9× širší produktové portfolio než jednorázoví zákazníci.
-- Vyšší produktová diverzita je spojena s věrnějším zákaznickým chováním.
 
-- Část 2: Průměr pro všechny zákazníky dohromady
WITH produkty_zakaznik AS (
    SELECT
        id_zakaznik,
        COUNT(DISTINCT id_produktu) AS pocet_unikatnich_produktu
    FROM `fiktivnidata.01.denormalizovany_dataset`
    GROUP BY id_zakaznik
)
SELECT
    ROUND(AVG(pocet_unikatnich_produktu), 2) AS prumer_celkem
FROM produkty_zakaznik;
 
-- Průměrný zákazník nakupuje 3.68 unikátních produktů.
