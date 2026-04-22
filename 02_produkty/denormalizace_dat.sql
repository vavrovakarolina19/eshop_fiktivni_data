-- Pro další analýzu bylo potřeba pracovat s více než jednou tabulkou. 
-- Aby byla optimalizována performance SQL dotazů a zjednodušena následná analýza, 
-- vytvořila jsem v BigQuery denormalizovanou tabulku spojením objednavky → polozky → varianty → produkty → zakaznici. 
-- Tabulka obsahuje všechny údaje potřebné pro analýzu kapitoly 02 a je připravena k dalšímu procesování.

CREATE TABLE `zakaznici-493506.02.denormalizovana_data_02_produkty` AS
SELECT 
  po.id_polozky,
  o.id_objednavky, 
  o.datum, 
  o.zpusob_platby, 
  o.store_typ as typ_nakupu, 
  z.id_zakaznik, 
  z.typ_zakaznik,
  p.id_produktu, 
  p.nazev AS nazev_produktu, 
  p.technika, 
  p.druh, 
  v.velikost,
  po.mnozstvi, 
  po.cena_polozka, 
  ROW_NUMBER() OVER (PARTITION BY z.id_zakaznik ORDER BY o.datum) AS order_sequence
FROM `zakaznici-493506.02.polozky` po
JOIN `zakaznici-493506.zakaznici.objednavky` o ON po.id_objednavky = o.id_objednavky
JOIN `zakaznici-493506.02.varianty` v ON v.id_varianty = po.id_varianty
JOIN `zakaznici-493506.02.produkty` p ON p.id_produktu = v.id_produktu
JOIN `zakaznici-493506.02.zakaznici_seg` z ON z.id_zakaznik = o.id_zakaznik;
