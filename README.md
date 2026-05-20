# Data Analytics Portfolio

Toto portfolio vzniklo jako praktická ukázka práce s datovou analytikou, business analytikou a interpretací dat pomocí SQL, Pythonu a Power BI. Hlavním cílem projektu není vytvoření produkční analytické studie, ale demonstrace analytického workflow — od práce s daty a datových transformací přes statistické ověřování až po business interpretaci výsledků.

Hlavní část portfolia tvoří případová studie zaměřená na vytvoření analytických podkladů pro rozhodnutí, zda by měl pro fiktivní e-shop smysl věrnostní program a jaké faktory mohou ovlivňovat návratnost zákazníků.

Téma bylo zvoleno záměrně, protože je mi blízké propojení businessu, marketingu, zákaznického chování a datové analytiky.

Projekt se zaměřuje nejen na samotnou vizualizaci dat, ale také na formulaci analytických otázek, práci s granularitou dat, interpretaci výsledků a kritické zhodnocení limitací analýzy.

---

# Důležité upozornění k datům

Veškerá data použitá v projektu jsou **fiktivní** a byla vytvořena mnou výhradně pro účely tohoto portfolia. Dataset neslouží jako realistický model konkrétní firmy ani jako finální podklad pro reálné business rozhodování.

Cílem datasetu bylo vytvořit konzistentní prostředí pro demonstraci analytických postupů, práce s daty a interpretace výsledků. Téma i struktura dat však vycházejí z problematiky, která odpovídá reálným otázkám z oblasti e-commerce, marketingu a zákaznické analytiky.

Přestože jsou data fiktivní, jednotlivé analytické postupy, SQL dotazy, Python notebooky i dashboardingové principy byly navrženy tak, aby byly snadno přenositelné i na reálná e-commerce data. Po úpravě názvů tabulek, sloupců a případném rozšíření datasetu lze stejné principy využít i při analýze existujícího e-shopu nebo reálného zákaznického datasetu.

Projekt zároveň nepředstavuje kompletní analytickou studii. Pro reálné nasazení by bylo potřeba výrazně rozsáhlejší množství dat, detailnější zákaznické informace, pokročilejší statistické modely, experimentální data a širší business kontext. Výsledky je proto nutné chápat především jako ukázku analytického přístupu, práce s daty a schopnosti interpretace výsledků.

---

# Struktura projektu

## 01 Analýza návratnosti a celoživotní hodnoty zákazníků  
### *„Má to pro naše zákazníky smysl?“*

První část projektu se zaměřuje na návratnost zákazníků, zákaznickou segmentaci a celoživotní hodnotu zákazníka (LTV). Analýza pracuje s časovým zkreslením zákaznického chování a ověřuje, zda mají jednotlivé segmenty statisticky odlišné chování.

**Použité technologie:**
- SQL
- Python
- Power BI
- ANOVA test

**Hlavní témata:**
- zákaznické segmenty,
- návratnost zákazníků,
- LTV,
- retence,
- časové zkreslení dat.

---

## 02 Analýza produktového chování zákazníků  
### *„Co stojí za návratem zákazníků?“*

Druhá část projektu analyzuje produktové chování zákazníků a hledá možné produktové „drivery“ věrnosti. Analýza se zaměřuje na produktové preference, pořadí objednávek, produktovou diverzitu a šíři košíku.

Součástí je také doplňkové statistické ověření v Pythonu pomocí χ² testu a Cramér’s V.

**Použité technologie:**
- SQL
- Python
- Power BI
- χ² test

**Hlavní témata:**
- produktové preference,
- produktová diverzita,
- šíře košíku,
- opakované nákupy,
- vztah mezi produkty a návratností zákazníků.

---

## 03 Analýza vlivu kampaní na chování zákazníků  
### *„Jaký vliv mají kampaně na chování zákazníků?“*

Třetí část projektu se zaměřuje na marketingové kampaně, slevy a jejich vztah k návratnosti zákazníků. Analýza porovnává zákazníky získané přes kampaně a mimo ně, sleduje podíl marketingových kanálů a vývoj kampanových objednávek v čase.

Součástí projektu je také AI-assisted notebook vytvořený pomocí prompt engineeringu a následně manuálně validovaný z pohledu granularit dat, agregací a interpretace výsledků.

**Použité technologie:**
- SQL
- Python
- Power BI
- AI-assisted analytický workflow

**Hlavní témata:**
- kampaně,
- marketingové kanály,
- slevy,
- návratnost zákazníků,
- AI-assisted analytika.

---

# Použité technologie

- SQL (BigQuery)
- Python
  - pandas
  - scipy
  - matplotlib
  - seaborn
- Power BI
- Git / GitHub

---

# Zaměření portfolia

Portfolio je zaměřeno především na ukázku:
- práce s SQL,
- datových transformací,
- analytického myšlení,
- práce s granularitou dat,
- dashboardingu v Power BI,
- statistického ověřování hypotéz,
- interpretace business výsledků,
- práce v Pythonu,
- a moderního AI-assisted workflow.

Vedle technické části projektu byl důraz kladen také na schopnost interpretovat výsledky v business kontextu, formulovat limitace analýzy a kriticky pracovat s daty.
