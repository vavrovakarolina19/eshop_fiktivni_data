-- Celková míra návratnosti (Cumulative Retention Rate)
-- Otázka: Kolik % zákazníků nakoupilo alespoň dvakrát za celou dobu existence e-shopu?
-- Výsledek: 74,1 % 
-- Interpretace: 3 ze 4 zákazníků se vrátilo pro další nákup.

with prvni_objednavka as (
    select id_zakaznik, min(PARSE_DATE('%d.%m.%Y', datum)) as prvni_den
    from `zakaznici-493506.zakaznici.objednavky`
    GROUP BY id_zakaznik
),
znovu_objednavka as (
    select distinct p.id_zakaznik
    from prvni_objednavka p
    join `zakaznici-493506.zakaznici.objednavky` o 
        on o.id_zakaznik = p.id_zakaznik
       and PARSE_DATE('%d.%m.%Y', o.datum) > p.prvni_den
)

select 
    count(DISTINCT z.id_zakaznik) * 100.0 / count(DISTINCT p.id_zakaznik) as celkova_navratnost
from prvni_objednavka p
left join znovu_objednavka z 
    on p.id_zakaznik = z.id_zakaznik;

-- Výsledek: 74,1 % 
-- Interpretace: 3 ze 4 zákazníků se vrátilo pro další nákup.


-- Roční míra návratnosti (dotaz pro rok 2025)
with prvni_objednavka as (
    select id_zakaznik, min(PARSE_DATE('%d.%m.%Y', datum)) as prvni_den
    from `zakaznici-493506.zakaznici.objednavky`
    WHERE EXTRACT(YEAR FROM PARSE_DATE('%d.%m.%Y', datum)) = 2025

    GROUP BY id_zakaznik

),
znovu_objednavka as (
    select distinct p.id_zakaznik
    from prvni_objednavka p
    join `zakaznici-493506.zakaznici.objednavky` o 
        on o.id_zakaznik = p.id_zakaznik
       and PARSE_DATE('%d.%m.%Y', o.datum) > p.prvni_den
     WHERE EXTRACT(YEAR FROM PARSE_DATE('%d.%m.%Y', datum)) = 2025  
)

select 
    count(DISTINCT z.id_zakaznik) * 100.0 / count(DISTINCT p.id_zakaznik) as navratnost_2025
from prvni_objednavka p
left join znovu_objednavka z 
    on p.id_zakaznik = z.id_zakaznik;

-- Následující roky (dotaz ve stejném znění, jen změna let)
2020,10.4
2021,11.2
2022,10.9
2023,26.6
2024,32.4
2025,31.3

-- Interpretace: Ze začátku fungování eshopu nízká, po roce 2023 se zvýšila téměř trojnásobně. Důvodem bylo nejspíš otevření poboček. 


-- Závěr: Míra návratnosti za jednotlivé roky je výrazně nižší, než celková míra návratnosti. 
-- V tomto případě bych nedoporučila zavádět jakýkoliv program v délce trvání 1-2 roky, jelikož zákazníci se vrací po delší době. 

