
## Hva er oppgaven?

Vi har en matematisk funksjon $f(x)$ definert på et interval fra −1 til 1. Oppgaven ber oss om å **tilnærme** denne funksjonen med et polynom av grad 4 — kalt Legendre-approksimasjonen — og vise grafisk hvor godt polynomet treffer.

For å lage polynomet trenger vi fem tall (koeffisienter). Disse regnes ut fra fem integraler, og integralene må løses numerisk (altså ved hjelp av datamaskin, ikke blyant og papir).

---

## Valg 1 — Midtpunktregelen for numerisk integrasjon

**Hva er det?**
Midtpunktregelen deler intervallet inn i mange små biter og antar at funksjonen er konstant inni hver bit — lik verdien i midten. Summerer vi opp alle bidragene får vi en god tilnærming til integralet.

**Hvorfor bruker vi den?**
- Oppgaven spesifiserer eksplisitt midtpunktregelen.
- Den er enkel å implementere, lett å forklare og gir *svært god nøyaktighet* for glatte funksjoner som vår.
- Feilen er proporsjonal med $h^2$ (kvadratet av bitbredden). Med 100 biter og bitbredde $h = 0{,}02$ er feilen i størrelsesorden $10^{-4}$ — langt under det vi trenger.

**Alternativet?**
Hadde vi brukt *Simpsons regel* ville feilen sunket som $h^4$ (enda bedre), men det er overkill for denne oppgaven. Vi utforsker alternativene i et eget avsnitt av notebooken, men kjernesvaret bruker midtpunktregelen som oppgitt.

---

## Valg 2 — Legendre-polynomer som approksimasjonsbasis

**Hva er det?**
Legendre-polynomene er en spesiell serie med polynomer som er *ortogonale* — de «peker i ulike retninger» i funksjonsrommet, akkurat som x-, y- og z-aksene i vanlig romgeometri. Det finnes et Legendre-polynom for hver grad: $P_0, P_1, P_2, \ldots$

**Hvorfor bruke disse og ikke vanlige polynomer?**
Den avgjørende fordelen er at *koeffisientene kan regnes ut én og én, uavhengig av hverandre*. Med vanlige polynomer (monomialbasis) måtte vi løst et stort lineært ligningssystem, noe som gir numerisk ustabilitet for høye grader. Med Legendre-basis er det bare en enkel formel per koeffisient — og formelen avhenger direkte av de integralene vi allerede har beregnet.

**Hva oppnår vi?**
Legendre-approksimasjonen minimerer $L^2$-feilen (gjennomsnittlig kvadratavvik over hele intervallet). Det betyr at polynomet vi finner er det *aller best mulige* polynom av grad ≤ 4 sett over hele intervallet — ikke bare nær ett punkt.

---

## Valg 3 — 100 delintervaller

**Hvorfor 100 og ikke 10 eller 10 000?**
- **Nøyaktighet:** 100 delintervaller gir en integrasjonsfeil på ca. $10^{-4}$, mens den totale approksimsjonsfeilen ($L^2$-feilen mellom $f$ og grad-4 polynomet) er ca. $10^{-2}$. Integrasjonen er altså *ikke* flaskehalsen — det er polynomgraden som begrenser hvor godt vi kan tilnærme.
- **Ressursbruk:** 100 delintervaller er øyeblikkelig å beregne. 10 000 ville gitt marginalt bedre integralestimater men identisk sluttresultat.
- Kort sagt: 100 er mer enn nøyaktig nok, og oppgaven angir eksplisitt dette antallet.

---

## Valg 4 — $L^2$-norm som feilmål

**Hva er det?**
$L^2$-feilen er kvadratroten av det gjennomsnittlige kvadratavviket mellom $f(x)$ og polynomet $p_4(x)$ over hele intervallet. Den måler *global* kvalitet, ikke bare feilen i ett punkt.

**Hvorfor ikke bruke maksimumsfeilen?**
Maksimumsfeilen (uendelig-normen) straffer ett enkelt dårlig punkt hardt. For en presentasjon der vi ønsker å vise at polynomet treffer *generelt godt*, gir $L^2$-normen et mer rettferdig bilde. Den er dessuten matematisk sett det *naturlige* feilmålet for Legendre-approksimasjon.

---

## Valg 5 — Python med NumPy og faglig forankrede strukturer

**Ingen scipy — kun NumPy og egne funksjoner:**
`losning2.ipynb` importerer bare `numpy` og `matplotlib`. All beregning skjer med egne funksjoner (`midpoint`, `legendre`) som er direkte modellert etter `LegendreAppr.py`. Dette gjør koblingen til det faglige grunnlaget eksplisitt og tydelig.

**Standardstrukturen for koeffisientberegning:**
Koeffisientberegningen er skrevet som:
```python
for k in range(N):
    U = np.array(legendre(k, x))
    a[k] = (2*k+1) * midpoint(lambda x: legendre(k,x)*f(x), ...) / 2
```
Dette er *ord for ord* formelen fra `LegendreAppr.py`, med `midpoint` i stedet for `Simpson`. Strukturen er direkte gjenkjennbar fra kursmateriellet.

**Bindingtrikset `k=k` i lambda:**
Når vi oppretter fem lambda-funksjoner i en løkke, er det en kjent Python-felle at alle funksjonene ender opp med å bruke den *siste* verdien av løkkevariabelen. Vi unngår dette ved `lambda x, k=k: ...`, som binder verdien av `k` til funksjonen i det øyeblikket den opprettes.

---

## Valg 6 — Reproduserbart prosjektmiljø (uv og GitHub)

**Hvorfor ikke bare installere Python og kjøre?**
Numeriske beregninger kan gi ulike resultater på ulike maskiner hvis bibliotekene har ulike versjoner. Vi bruker `uv` til å låse alle pakker til nøyaktig samme versjon (`uv.lock`), og `GitHub` til versjonskontroll. Dette betyr at:

- Hvem som helst kan klone prosjektet, kjøre `setup.ps1`, og få identiske resultater.
- Alle endringer er sporbare — et krav i **EU AI Act** (art. 12–13) om dokumentasjon og sporbarhet for AI-relaterte systemer.
- `Dependabot` holder avhengighetene oppdaterte automatisk uten at noen trenger å gjøre det manuelt.

---

## Sammenligning med losning.ipynb — hva er bedre og hva er verre?

`losning.ipynb` er den *utvidede* versjonen. Den ble skrevet for å utforske og sammenligne metoder, mens `losning2.ipynb` bare løser det oppgaven ber om.

### Hva losning.ipynb gjør bedre

| Aspekt | Fordel i losning.ipynb |
|--------|------------------------|
| **Integrasjonsmetoder** | Har en `integrate()`-funksjon som støtter fem metoder: midtpunkt, trapes, Simpson, adaptiv Gauss-Kronrod og Gauss-Legendre. Gjør det enkelt å sammenligne nøyaktighet og feilordener side om side. |
| **Referanseverdier** | Bruker `scipy.integrate.quad` som gir nær-maskinpresisjons-eksakte integraler — nyttig for å verifisere at midtpunktregelen stemmer. |
| **Feilanalyse** | Viser hvordan feilen skalerer med $n$ for ulike metoder, inkl. log-log-plott og numerisk bekreftelse av $O(h^2)$ og $O(h^4)$. |
| **Alternativ basis** | Sammenligner Legendre-approksimasjon med Chebyshev-interpolasjon og monomial basis — nyttig for å forstå *hvorfor* Legendre er best valg globalt. |
| **I_k → a_k-koblingen** | Viser eksplisitt hvordan de fem integralene $I_k = \int x^k f\,dx$ omsettes til koeffisienter via algebraisk utregning — synliggjør selve regnestegene. |

### Hva losning.ipynb gjør dårligere (for eksamensformål)

| Aspekt | Ulempe i losning.ipynb |
|--------|------------------------|
Importerer `scipy` og bruker `np.trapezoid`, `scipy.integrate.simpson` — |
| **Hardkodede Legendre-uttrykk** | `P_0 = np.ones(...)`, `P_1 = xs`, osv. fungerer bare for grad 4. Den rekursive `legendre(n, x)` fra `LegendreAppr.py` er generell for vilkårlig grad — men `losning.ipynb` bruker den ikke. |
| **Koeffisientberegning** | Bruker algebraisk utledede formler (`a[2] = 5/4*(3*I[2] - I[0])` osv.) som er spesifikke for akkurat denne oppgaven. Formelen `(2n+1)/2 · integral(P_n·f)` fra `LegendreAppr.py` er generell for alle k og fungerer som en løkke — den er enklere å presentere og enklere å generalisere. |
