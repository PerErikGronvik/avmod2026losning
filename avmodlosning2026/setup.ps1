# Look in README.md for setup instructions before running this script.

# Check if uv is installed
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "uv is not installed!" -ForegroundColor Red
    Write-Host "uv is required to manage Python dependencies." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Install uv by running:" -ForegroundColor Cyan
    Write-Host "  powershell -ExecutionPolicy ByPass -c 'irm https://astral.sh/uv/install.ps1 | iex'" -ForegroundColor White
    Write-Host ""
    $response = Read-Host "Install uv now? (y/n)"
    if ($response -eq 'y' -or $response -eq 'Y') {
        Write-Host "Installing uv..." -ForegroundColor Cyan
        powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
        Write-Host "Please restart your terminal and run this script again." -ForegroundColor Green
        exit 0
    } else {
        Write-Host "Installation cancelled. Please install uv manually and try again." -ForegroundColor Yellow
        exit 1
    }
}

$folderName = Split-Path -Leaf (Get-Location)
$kernelName = "$folderName-venv"

Write-Host "Setting up environment in $folderName..." -ForegroundColor Cyan

# Use uv to sync environment
Write-Host "Running uv sync..." -ForegroundColor Cyan
uv sync

# Register as Jupyter kernel with unique name based on folder
Write-Host "Registering Jupyter kernel '$kernelName'..." -ForegroundColor Cyan
.\.venv\Scripts\python.exe -m ipykernel install --user --name="$kernelName" --display-name="Python 3 ($folderName)"

# Refresh Jupyter kernel list
Write-Host "Refreshing Jupyter kernel list..." -ForegroundColor Cyan
.\.venv\Scripts\jupyter-kernelspec.exe list

Write-Host ""
Write-Host "Done! Now in VS Code:" -ForegroundColor Green
Write-Host "1. Reload VS Code window (Ctrl+Shift+P -> Reload Window)" -ForegroundColor Yellow
Write-Host "2. Open the notebook" -ForegroundColor White
Write-Host "3. Click Select Kernel (top right)" -ForegroundColor White
Write-Host "4. Choose Python 3 ($folderName)" -ForegroundColor White
Write-Host ""
Write-Host "Kernel path: $((Get-Location).Path)\.venv\Scripts\python.exe" -ForegroundColor DarkGray
