-- CELOŽIVOTNÍ HODNOTA ZÁKAZNÍKA (LTV)

-- Kolik peněz nám každý zákazník přinese za dobu, co u nás kupuje? A liší se to mezi našimi segmenty?
-- Průměrná objednávka × počet objednávek


-- Část 1: LTV pro každý segment

with zakladni_data as (SELECT id_zakaznik , AVG(cena_celkem) as prumerna_objednavka, COUNT(id_objednavky) as pocet_objednavek, 
MIN(PARSE_DATE('%d.%m.%Y', datum)) as prvni_nakup,
MAX(PARSE_DATE('%d.%m.%Y', datum)) as posledni_nakup,
FROM `zakaznici-493506.zakaznici.objednavky`
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

-- Věrný zákazník nám přinese 4,3x víc peněz než jednorázový.




-- Část 2: Průměr pro všechny zákazníky dohromady

with zakladni_data as (SELECT id_zakaznik , AVG(cena_celkem) as prumerna_objednavka, COUNT(id_objednavky) as pocet_objednavek, 
MIN(PARSE_DATE('%d.%m.%Y', datum)) as prvni_nakup,
MAX(PARSE_DATE('%d.%m.%Y', datum)) as posledni_nakup,
FROM `zakaznici-493506.zakaznici.objednavky`
GROUP BY id_zakaznik
),
ltv_zakaznik as (SELECT id_zakaznik, (prumerna_objednavka * pocet_objednavek)  as ltv, CASE 
    WHEN pocet_objednavek = 1 THEN 'jednorázový'
    WHEN pocet_objednavek <= 3 THEN 'příležitostný'
    ELSE 'věrný'
END as typ_zakaznik
FROM zakladni_data)

SELECT AVG(ltv) AS prumerna_ltv
FROM ltv_zakaznik;

-- Průměrný zákazník utratí 14 546 Kč.
