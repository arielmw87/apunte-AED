# Compilador del Apunte AED II y III
# Ejecutar con: .\compilar.ps1
# O desde PowerShell: powershell -ExecutionPolicy Bypass -File compilar.ps1

# Buscar pdflatex
$pdflatex = $null
if (Get-Command pdflatex -ErrorAction SilentlyContinue) {
    $pdflatex = "pdflatex"
} elseif (Test-Path "C:\texlive\2022\bin\win32\pdflatex.exe") {
    $pdflatex = "C:\texlive\2022\bin\win32\pdflatex.exe"
} else {
    Write-Error "No se encontro pdflatex. Instala TeX Live y verifica el PATH."
    exit 1
}

function Invoke-Pdflatex {
    param([string]$pass)
    Write-Host ""
    Write-Host "=== $pass ===" -ForegroundColor Cyan
    & $pdflatex -interaction=nonstopmode main.tex
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "ERROR en $pass. Revisa main.log para detalles." -ForegroundColor Red
        exit 1
    }
}

Invoke-Pdflatex "Primera compilacion"
Invoke-Pdflatex "Segunda compilacion (indice y referencias cruzadas)"

Write-Host ""
Write-Host "=== Compilacion exitosa: main.pdf ===" -ForegroundColor Green
