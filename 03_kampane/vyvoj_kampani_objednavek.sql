-- SROVNÁNÍ VÝVOJE KAMPANÍ A CELKOVÝCH OBJEDNÁVEK
-- Jak se v čase mění počet všech objednávek a objednávek v kampani?
-- Sledujeme roční vývoj celkových objednávek, kampanových objednávek
-- a podíl kampanových objednávek na celkovém počtu objednávek.

SELECT
    EXTRACT(YEAR FROM datum) AS rok,
    COUNT(DISTINCT id_objednavky) AS vsechny_objednavky,
    COUNT(DISTINCT CASE 
        WHEN kampan_flag = 1 THEN id_objednavky 
    END) AS kampan_objednavky,
    ROUND(
        COUNT(DISTINCT CASE 
            WHEN kampan_flag = 1 THEN id_objednavky 
        END) * 100.0
        / COUNT(DISTINCT id_objednavky),
        2
    ) AS podil_kampan_objednavek_pct
FROM `fiktivnidata.01.denormalizovany_dataset`
GROUP BY rok
ORDER BY rok;

Výsledek:
rok    vsechny_objednavky   kampan_objednavky   podil_kampan_objednavek_pct
2015   621                  112                 18.04
2016   931                  143                 15.36
2017   1242                 181                 14.57
2018   1552                 258                 16.62
2019   1863                 286                 15.35
2020   1871                 291                 15.55
2021   1336                 192                 14.37
2022   1361                 210                 15.43
2023   1275                 183                 14.35
2024   1303                 190                 14.58
2025   1315                 202                 15.36

-- Počet kampanových objednávek se v čase vyvíjí podobně jako celkový počet objednávek.
-- Podíl kampanových objednávek se většinu let pohybuje přibližně kolem 14–16 %.
-- Kampaně tedy tvoří stabilní menší část objednávek, ale nejsou hlavním zdrojem celkového objemu objednávek.
