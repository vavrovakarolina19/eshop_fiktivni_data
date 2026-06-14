-- CELOŽIVOTNÍ HODNOTA ZÁKAZNÍKA (LTV)

-- Kolik peněz nám každý zákazník přinese za dobu, co u nás kupuje? A liší se to mezi našimi segmenty?
-- Průměrná objednávka × počet objednávek


-- Část 1: LTV pro každý segment

with zakladni_data as (SELECT id_zakaznik , AVG(cena_celkem) as prumerna_objednavka, COUNT(id_objednavky) as pocet_objednavek, 
MIN(datum) as prvni_nakup,
MAX(datum) as posledni_nakup,
FROM `fiktivnidata.01.objednavky50`
GROUP BY id_zakaznik
),
ltv_zakaznik as (SELECT id_zakaznik, (prumerna_objednavka * pocet_objednavek)  as ltv, CASE 
    WHEN pocet_objednavek = 1 THEN 'jednorázový'
    WHEN pocet_objednavek <= 3 THEN 'příležitostný'
    ELSE 'věrný'
END as typ_zakaznik
FROM zakladni_data)

SELECT typ_zakaznik, AVG(ltv) AS prumerna_ltv
FROM ltv_zakaznik
GROUP BY typ_zakaznik
ORDER BY prumerna_ltv DESC;

1	věrný	50914.147521160827
2	příležitostný	24702.46826516221
3	jednorázový	11700.23084025854

-- Věrný zákazník nám přinese 4,3x víc peněz než jednorázový.




-- Část 2: Průměr pro všechny zákazníky dohromady

with zakladni_data as (SELECT id_zakaznik, AVG(cena_celkem) as prumerna_objednavka, COUNT(id_objednavky) as pocet_objednavek, 
MIN(datum) as prvni_nakup,
MAX(datum) as posledni_nakup,
FROM `fiktivnidata.01.objednavky50`
GROUP BY id_zakaznik
),

ltv_zakaznik as (SELECT id_zakaznik, (prumerna_objednavka * pocet_objednavek)  as ltv 
from zakladni_data)

SELECT AVG(ltv) AS prumerna_ltv
FROM ltv_zakaznik;

-- Průměrný zákazník utratí 30 720 Kč.
