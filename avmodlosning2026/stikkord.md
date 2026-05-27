# Stikkord — presentasjon

## Del 1: Midtpunkt
- 100 delintervaller
- h = 0.02
- midtpunkt i hvert delintervall
- sum h·f(m_i)
- feilorden O(h²)

## Del 2: Legendre
- indreprodukt = integral av f·g
- ortogonal = indreprodukt 0 ; ortogonal: ⟨Pⱼ, Pₖ⟩ = 0 når j≠k
- ||P_k||² = 2/(2k+1)
- ta indreprodukt med P_k → alle j≠k forsvinner
- a_k = (2k+1)/2 · integral f·P_k
- P_k er polynom → integral = lineærkombinasjon av I_k
- a_2 = 5/4·(3I₂ − I₀)   ← vis for hånd

## Del 3: Plott
- f og p_4 nær hverandre globalt
- L²-feil ≈ 1e-2
- minimerer L²-norm (ikke lokalt som Taylor)
- høyere grad → feil → 0




## Forventede spørsmål

### «Hva om vi bruker p₃ i stedet for p₄?» (−1 Legendre-ledd)
- fjerner a₄·P₄(x) — ett ledd i summen
- a_k er ortogonale: fjerner vi P₄ endres ikke a₀..a₃
- L²-feil øker: vi mister den beste grad-4-tilnærmingen
- p₃ er optimal innenfor grad 3, men grad 4 er alltid bedre eller lik

### «Hva om vi bytter midtpunkt med trapesregelen?»
- begge har feilorden O(h²) — samme konvergensrate
- halvere h gir feil/4 for begge
- midtpunkt har litt bedre feilkonstant (~faktor 2) enn trapes
- koeffisientene a_k og L²-feilen blir tilnærmet identiske

### «Hva om vi bruker Simpsons regel i stedet?»
- Simpson gir O(h⁴) — mye mer nøyaktig integrasjon
- Med h=0.02: midtpunktfeil ~h²=4·10⁻⁴, Simpsonfeil ~h⁴=1.6·10⁻⁷
- Men L²-feilen på approksimasjonen er ~1e-2 — langt større
- Flaskehalsen er avkorting av Legendre-rekken ved grad 4, ikke integrasjonsfeilen
- Bedre integrasjon endrer a_k i sjette desimalplass — L²-feilen er uendret

### Andre vanlige spørsmål
- halvere h → feil / 4  (O(h²))
- Taylor: minimerer feil nær ett punkt; Legendre: minimerer L²-feil globalt
- ortogonalitet: hvert a_k bestemmes uavhengig — kan legge til/fjerne ledd uten å reberegne de andre

### «Hva er ortogonalitet?»
Ortogonalitet for funksjoner er det samme som vinkelrett for vektorer.
To vektorer er vinkelrette når prikkproduktet er null.
To funksjoner er ortogonale når integralet av produktet er null: ∫f·g dx = 0.

Legendre-polynomene er bygd slik at ∫Pⱼ·Pₖ dx = 0 for alle j≠k.
Det betyr at de «peker i helt forskjellige retninger» i funksjonsrommet.

Derfor kan vi beregne hver koeffisient a_k helt uavhengig:
  a_k = (2k+1)/2 · ∫f·Pₖ dx
Ingen av de andre leddene forstyrrer — akkurat som når man projiserer en vektor
på én akse uten at de andre aksene blander seg inn.

Praktisk konsekvens: legger vi til P₅ endres ikke a₀..a₄.
Fjerner vi a₄P₄ er p₃ fremdeles den beste grad-3-approksimasjonen.