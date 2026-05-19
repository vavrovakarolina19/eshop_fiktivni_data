-- PRODUKTY SE MEZI SEGMENTY VÝRAZNĚ NELIŠÍ
-- Které produkty jsou nejprodávanější v každém segmentu?
-- Liší se preference produktů mezi věrnými, příležitostními a jednorázovými zákazníky?
-- Top 3 nejprodávanější produkty v každém segmentu
 
WITH produkty_segment AS (
    SELECT
        typ_zakaznik,
        nazev,
        COUNT(*) AS pocet_objednavek,
        ROW_NUMBER() OVER (PARTITION BY typ_zakaznik ORDER BY COUNT(*) DESC) AS pozice
    FROM `fiktivnidata.01.denormalizovany_dataset`
    GROUP BY typ_zakaznik, nazev
)
SELECT
    typ_zakaznik,
    nazev,
    pocet_objednavek
FROM produkty_segment
WHERE pozice <= 3
ORDER BY typ_zakaznik, pocet_objednavek DESC;
 
Výsledek:
typ_zakaznik	  nazev			        	pocet_objednavek
jednorazovy	    šaty				        274
jednorazovy	    svetr				        242
jednorazovy	    čepice			       	160
prilezitostny	  kalhoty softshell		731
prilezitostny	  svetr				        592
prilezitostny	  šaty				        704
verny		        šaty			        	1370
verny		        kalhoty softshell		861
verny		        svetr				        756
 
-- Všechny segmenty kupují stejné produkty: šaty, svetr.
-- Věrní zákazníci kupují více kusů stejných produktů, ne jiné produkty.
 
-- Jednorázoví zákazníci kupují čepice (160), což je produkt, který se v top 3 u příležitostných ani věrných zákazníků neobjevuje.
-- Naopak věrní a příležitostní řadí kalhoty softshell do top 3, zatímco jednorázoví ne.
-- Jednorázoví tedy preferují čepice, ostatní segmenty preferují kalhoty softshell.
