# Setup Instructions — avmodlosning2026

Reusable setup scripts for creating isolated Python environments for Jupyter notebooks.

## Reproduserbarhet og versjonskontroll

| Verktøy | Formål |
|---------|--------|
| **[uv](https://docs.astral.sh/uv/)** | Pakkehåndtering. `uv sync` låser alle avhengigheter til eksakte versjoner i `uv.lock`, slik at alle som kloner repoet får identiske miljøer uavhengig av maskin eller tidspunkt. Installasjonsrekkefølgen er deterministisk — viktig når pakker har implisitte avhengigheter av hverandre. |
| **[GitHub](https://github.com/)** | Versjonskontroll og revisjonsspor. Oppfyller dokumentasjonskravene i **EU AI Act** (Forordning (EU) 2024/1689, art. 12–13) om sporbarhet for AI-relaterte systemer. |
| **[Dependabot](https://docs.github.com/en/code-security/dependabot)** | Automatisk oppdatering av `uv.lock` og `pyproject.toml`. Åpner pull requests ukentlig når nyere pakkeversioner er tilgjengelig — se `.github/dependabot.yml`. Etter å ha merget en Dependabot-PR: kjør `.\setup.ps1` (Windows) eller `./setup.sh` (Linux/Mac). `uv sync` leser den oppdaterte `uv.lock` og installerer de nye versjonene i `.venv`, og kernelen re-registreres automatisk. Ingenting i `.ipynb`-filen trenger endres — notebook-metadata lagrer bare kernel-**navnet**, ikke pakkeversjonene. |

## Quick Start

1. **Rename this folder** to your project name (e.g., `3k`)
2. **Setup dependencies:**
   - Copy your course's `pyproject.toml` here, OR
   - Use `example.pyproject.toml` as a template (last updated 04.02.2026 - check for newer package versions if reading this much later)
   - Rename `example.pyproject.toml` to `pyproject.toml` if using it
   - Edit `pyproject.toml`: update project name, comment out unneeded packages with `#`
3. **Run the setup script:**
   
   **Windows:** `.\setup.ps1`  
   **Linux/Mac:** `chmod +x setup.sh && ./setup.sh`

4. **Reload VS Code:** `Ctrl+Shift+P` → "Reload Window"
5. **Select kernel:** Open notebook → "Select Kernel" → "Python 3 (your-folder-name)"

Done!

## How It Works

- Runs `uv sync` to create `.venv` and install dependencies from `pyproject.toml`
- Registers a Jupyter kernel named after the folder
- Each folder gets its own isolated environment

## Reuse

Copy `setup.ps1`/`setup.sh` and `pyproject.toml` to any new folder, rename the folder, and run the script.


## Troubleshooting

**Kernel not appearing:** Reload VS Code window  
**Script errors:** Check `pyproject.toml` syntax  
**Linux/Mac:** Ensure script is executable: `chmod +x setup.sh`

git clone https://github.com/PerErikGronvik/Goodibag-tipsntricks.git for flere godibag tips og triks