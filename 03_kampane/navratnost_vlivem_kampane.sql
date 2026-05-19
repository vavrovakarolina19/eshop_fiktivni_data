-- VLIV KAMPANĚ NA NÁVRATNOST ZÁKAZNÍKŮ
-- Jak kampaně ovlivňují, zda se zákazník vrátí na další nákup?
-- Porovnání: zákazníci, kteří začali s kampaní vs. bez kampaně
-- Metriky: počet zákazníků, počet těch, kteří se vrátili, retence %
 
WITH objednavky AS (
  SELECT
    id_zakaznik,
    id_objednavky,
    datum,
    MAX(kampan_flag) AS kampan_flag
  FROM `fiktivnidata.01.denormalizovany_dataset`
  GROUP BY id_zakaznik, id_objednavky, datum
),

prvni_objednavka AS (
  SELECT
    id_zakaznik,
    kampan_flag,
    ROW_NUMBER() OVER (
      PARTITION BY id_zakaznik
      ORDER BY datum, id_objednavky
    ) AS rn
  FROM objednavky
),

retence AS (
  SELECT
    id_zakaznik,
    COUNT(DISTINCT id_objednavky) AS pocet_objednavek
  FROM objednavky
  GROUP BY id_zakaznik
)

SELECT
  CASE
    WHEN p.kampan_flag = 1 THEN 'S kampani'
    ELSE 'Bez kampane'
  END AS prvni_nakup,
  COUNT(*) AS pocet_zakazniku,
  COUNTIF(r.pocet_objednavek > 1) AS vratili_se,
  ROUND(
    COUNTIF(r.pocet_objednavek > 1) * 100.0 / COUNT(*),
    2
  ) AS navratnost
FROM prvni_objednavka p
JOIN retence r
  ON p.id_zakaznik = r.id_zakaznik
WHERE p.rn = 1
GROUP BY prvni_nakup
ORDER BY navratnost DESC;
 
Výsledek:
prvni_nakup		pocet_zakazniku	vratili_se	navratnost
S kampani		    794				      560			       70.53
Bez kampane		  4070			      3221		       79.14
 
 
-- Zákazníci, jejichž první nákup proběhl bez kampaně, mají vyšší návratnost, než zákazníci získaní přes kampaň.
-- Kampaně jsou v tomto datasetu spojeny s nižší návratností, nelze z toho ale vyvozovat přímý kauzální vliv kampaně.
