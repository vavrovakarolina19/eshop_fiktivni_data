-- NEJPRODÁVANĚJŠÍ PRODUKTY PODLE POŘADÍ OBJEDNÁVKY
-- Které produkty se kupují v 1., 2., 3., 4. nákupu?
-- Jak se liší produkty mezi věrnými, příležitostními a jednorázovými zákazníky?
-- Počet objednávek produktu v každém pořadí nákupu per segment
 
WITH produkty_poradi AS (
    SELECT
        nazev,
        typ_zakaznik,
        poradi_objednavky,
        COUNT(*) AS pocet_objednavek,
        ROW_NUMBER() OVER (PARTITION BY typ_zakaznik, poradi_objednavky ORDER BY COUNT(*) DESC) AS pozice
    FROM `fiktivnidata.01.denormalizovany_dataset`
    WHERE poradi_objednavky <= 4
    GROUP BY nazev, typ_zakaznik, poradi_objednavky
)
SELECT
    typ_zakaznik,
    poradi_objednavky,
    nazev,
    pocet_objednavek
FROM produkty_poradi
WHERE pozice <= 2
ORDER BY typ_zakaznik, poradi_objednavky, pocet_objednavek DESC;
 
Výsledek:
typ_zakaznik	poradi_objednavky	nazev					pocet_objednavek
jednorazovy	  1					šaty					        259
jednorazovy	  1					svetr					        234
prilezitostny	1					kalhoty softshell			295
prilezitostny	1					svetr					        278
verny		      1					šaty				        	290
verny	      	1					svetr				        	187
prilezitostny	2					kalhoty softshell			324
prilezitostny	2					svetr				        	253
verny		      2					šaty				        	262
verny	      	2					svetr					        168
prilezitostny	3					svetr				        	163
prilezitostny	3					šaty				        	136
verny	      	3					šaty				        	263
verny		      3					svetr					        182
verny		      4					šaty				        	275
verny		      4					svetr				        	172
 
-- Jednorázoví zákazníci: kupují pouze v 1. nákupu - šaty (259) a svetr (234).
-- Příležitostní zákazníci: kupují až do 3. nákupu - v 1. a 2. nákupu dominují kalhoty softshell, v 3. nákupu svetr.
-- Věrní zákazníci: kupují až do 4. nákupu - šaty a svetr se střídají, věrní zákazníci vracejí i na 4. nákup.

-- Stejné produkty (šaty, svetr) kupují všechny segmenty v 1. nákupu.
-- Rozdíl mezi věrnými a jednorázovými není v TYP PRODUKTU, ale v POČTU NÁKUPŮ.
-- Žádný produkt sám o sobě není driver věrnosti - věrnost se buduje postupně přes více nákupů.
