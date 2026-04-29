-- Celková míra návratnosti (Cumulative Retention Rate)
-- Otázka: Kolik % zákazníků nakoupilo alespoň dvakrát za celou dobu existence e-shopu?
-- Výsledek: 77,7 % 
-- Interpretace: 3 ze 4 zákazníků se vrátilo pro další nákup.

with prvni_objednavka as (
    select id_zakaznik, min(datum) as prvni_den
    from `fiktivnidata.01.objednavky50`
    GROUP BY id_zakaznik
),
znovu_objednavka as (
    select distinct p.id_zakaznik
    from prvni_objednavka p
    join `fiktivnidata.01.objednavky50` o 
        on o.id_zakaznik = p.id_zakaznik
       and o.datum > p.prvni_den
)

select 
    count(DISTINCT z.id_zakaznik) * 100.0 / count(DISTINCT p.id_zakaznik) as celkova_navratnost
from prvni_objednavka p
left join znovu_objednavka z 
    on p.id_zakaznik = z.id_zakaznik;
-- Výsledek: 77,7 % 
-- Interpretace: 3 ze 4 zákazníků se vrátilo pro další nákup.


-- Roční míra návratnosti (dotaz pro rok 2025)
with prvni_objednavka as (
    select id_zakaznik, min(datum) as prvni_den
    from `fiktivnidata.01.objednavky50`
    WHERE EXTRACT(YEAR FROM datum) = 2025

    GROUP BY id_zakaznik

),
znovu_objednavka as (
    select distinct p.id_zakaznik
    from prvni_objednavka p
    join `fiktivnidata.01.objednavky50` o 
        on o.id_zakaznik = p.id_zakaznik
       and o.datum > p.prvni_den
     WHERE EXTRACT(YEAR FROM datum) = 2025  
)

select 
    count(DISTINCT z.id_zakaznik) * 100.0 / count(DISTINCT p.id_zakaznik) as navratnost_2025
from prvni_objednavka p
left join znovu_objednavka z 
    on p.id_zakaznik = z.id_zakaznik;

-- Následující roky (dotaz ve stejném znění, jen změna let)
2015 4.7
2016 6.7
2017 7.7
2018 9.6
2019 13.5
2020 14.7
2021 16.6
2022 17.3
2023 13.9
2024 15.9
2025 15.8

-- Závěr: Míra návratnosti za jednotlivé roky je výrazně nižší, než celková míra návratnosti. 
-- V tomto případě bych nedoporučila zavádět jakýkoliv program v délce trvání 1-2 roky, jelikož zákazníci se vrací po delší době. 

