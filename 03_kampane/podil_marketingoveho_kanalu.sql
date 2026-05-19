-- PODÍL OBJEDNÁVEK V KAMPANI PODLE MARKETINGOVÉHO KANÁLU
-- Jaký podíl kampanových objednávek připadá na jednotlivé marketingové kanály?
-- Počítáme pouze objednávky, které proběhly v rámci kampaně.
-- Metriky: počet objednávek a procentuální podíl podle kanálu

WITH kampan_objednavky AS (
    SELECT
        kanal,
        COUNT(DISTINCT id_objednavky) AS pocet_objednavek
    FROM `fiktivnidata.01.denormalizovany_dataset`
    WHERE kampan_flag = 1
    GROUP BY kanal
)

SELECT
    kanal,
    pocet_objednavek,
    ROUND(
        pocet_objednavek * 100.0
        / SUM(pocet_objednavek) OVER (),
        2
    ) AS podil_pct
FROM kampan_objednavky
ORDER BY pocet_objednavek DESC;

Výsledek:
kanal       pocet_objednavek   podil_pct
Google      854                37.99
PPC         714                31.76
Facebook    456                20.28
Email       224                9.96

-- Největší podíl kampanových objednávek pochází z kanálu Google.
-- Druhým nejsilnějším kanálem je PPC, následovaný Facebookem.
-- Email tvoří nejmenší část kampanových objednávek.
-- Tento výstup ukazuje rozložení kampanových objednávek podle kanálu, nikoli efektivitu jednotlivých kanálů.
