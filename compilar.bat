@echo off
setlocal
chcp 65001 >nul

:: Buscar pdflatex en TeX Live 2022 o en el PATH
set PDFLATEX=pdflatex
where pdflatex >nul 2>&1
if errorlevel 1 (
    if exist "C:\texlive\2022\bin\win32\pdflatex.exe" (
        set PDFLATEX=C:\texlive\2022\bin\win32\pdflatex.exe
    ) else (
        echo ERROR: No se encontro pdflatex. Instala TeX Live o agrega pdflatex al PATH.
        pause
        exit /b 1
    )
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
