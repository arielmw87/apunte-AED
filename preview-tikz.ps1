# Preview de diagramas TikZ del Apunte AED II y III
# Compila _preview.tex (cada diagrama de tikz/ en su propia pagina) y abre el PDF.
# Ejecutar parado en la carpeta latex/.

# Buscar pdflatex
$pdflatex = $null
if (Get-Command pdflatex -ErrorAction SilentlyContinue) {
    $pdflatex = "pdflatex"
} elseif ($tl = Get-ChildItem "C:\texlive\*\bin\*\pdflatex.exe" -ErrorAction SilentlyContinue |
               Sort-Object FullName -Descending | Select-Object -First 1) {
    # TeX Live instalado pero fuera del PATH: usa la version mas nueva
    $pdflatex = $tl.FullName
} else {
    Write-Error "No se encontro pdflatex. Instala TeX Live y verifica el PATH."
    exit 1
}

Write-Host ""
Write-Host "=== Compilando preview de TikZ ===" -ForegroundColor Cyan
& $pdflatex -interaction=nonstopmode _preview.tex
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR al compilar _preview.tex. Revisa _preview.log para detalles." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=== Preview listo: _preview.pdf ===" -ForegroundColor Green
