@echo off
setlocal
chcp 65001 >nul

:: Buscar pdflatex en el PATH o en cualquier TeX Live de C:\texlive
set PDFLATEX=
where pdflatex >nul 2>&1
if not errorlevel 1 set PDFLATEX=pdflatex
if not defined PDFLATEX (
    for /f "delims=" %%F in ('dir /b /s /o-n "C:\texlive\pdflatex.exe" 2^>nul') do (
        if not defined PDFLATEX set "PDFLATEX=%%F"
    )
)
if not defined PDFLATEX (
    echo ERROR: No se encontro pdflatex. Instala TeX Live o agrega pdflatex al PATH.
    pause
    exit /b 1
)

echo === Primera compilacion ===
"%PDFLATEX%" -interaction=nonstopmode main.tex
if errorlevel 1 (
    echo.
    echo ERROR en la primera compilacion. Revisa main.log para detalles.
    pause
    exit /b 1
)

echo.
echo === Segunda compilacion (indice y referencias cruzadas) ===
"%PDFLATEX%" -interaction=nonstopmode main.tex
if errorlevel 1 (
    echo.
    echo ERROR en la segunda compilacion.
    pause
    exit /b 1
)

echo.
echo === Compilacion exitosa: main.pdf ===
pause
