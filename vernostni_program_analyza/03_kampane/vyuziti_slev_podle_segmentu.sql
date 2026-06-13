-- VYUŽITÍ SLEV PODLE SEGMENTU
-- Jaké slevové hladiny využívají jednotlivé zákaznické segmenty?
-- Rozdělení objednávek podle výše slevy a typu zákazníka
-- Metriky: počet zákazníků, počet objednávek, průměrná sleva a podíl objednávek v rámci segmentu

WITH slevy_segment AS (
    SELECT
        typ_zakaznik,
        CASE 
            WHEN vyse_slevy IS NULL OR vyse_slevy = 0 THEN 'Bez slevy'
            WHEN vyse_slevy <= 10 THEN '1-10%'
            WHEN vyse_slevy <= 20 THEN '11-20%'
            WHEN vyse_slevy > 20 THEN '20%+'
        END AS kategorie_slevy,
        COUNT(DISTINCT id_zakaznik) AS pocet_zakazniku,
        COUNT(DISTINCT id_objednavky) AS pocet_objednavek,
        ROUND(AVG(vyse_slevy), 2) AS prumerna_sleva_pct
    FROM `fiktivnidata.01.denormalizovany_dataset`
    GROUP BY typ_zakaznik, kategorie_slevy
)

SELECT
    typ_zakaznik,
    kategorie_slevy,
    pocet_zakazniku,
    pocet_objednavek,
    prumerna_sleva_pct,
    ROUND(
        pocet_objednavek * 100.0
        / SUM(pocet_objednavek) OVER (PARTITION BY typ_zakaznik),
        2
    ) AS podil_pct
FROM slevy_segment
ORDER BY
    typ_zakaznik,
    CASE
        WHEN kategorie_slevy = 'Bez slevy' THEN 1
        WHEN kategorie_slevy = '1-10%' THEN 2
        WHEN kategorie_slevy = '11-20%' THEN 3
        WHEN kategorie_slevy = '20%+' THEN 4
    END;

Výsledek:
typ_zakaznik     kategorie_slevy   pocet_zakazniku   pocet_objednavek   prumerna_sleva_pct   podil_pct
jednorazovy      Bez slevy         849               849                null                 78.39
jednorazovy      1-10%             26                26                 10.00                2.40
jednorazovy      11-20%            186               186                16.76                17.17
jednorazovy      20%+              22                22                 30.00                2.03
prilezitostny    Bez slevy         2089              4545               null                 84.59
prilezitostny    1-10%             74                74                 10.00                1.38
prilezitostny    11-20%            612               668                16.76                12.43
prilezitostny    20%+              85                86                 30.00                1.60
verny            Bez slevy         1654              7028               null                 85.56
verny            1-10%             121               124                10.00                1.51
verny            11-20%            721               950                16.85                11.57
verny            20%+              108               112                30.00                1.36


-- Ve všech segmentech převažují objednávky bez slevy.
-- Nejvyšší podíl slevových objednávek mají jednorázoví zákazníci.
-- Věrní zákazníci využívají slevy méně často, což naznačuje, že sleva není hlavním faktorem jejich opakovaného nákupu.

