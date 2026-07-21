# Apunte AED II y III

Apuntes de Aplicaciones de Electrónica Digital II y III — EEST N° 1, Vicente López.

## Dependencias

### TeX Live

Instalar [TeX Live](https://www.tug.org/texlive/) (recomendado: instalación completa).

En Windows el instalador se descarga desde: https://www.tug.org/texlive/acquire-netinstall.html

Verificar que `pdflatex` esté en el PATH o instalado en `C:\texlive\2022\bin\win32\`.

> No se requiere Python ni ninguna dependencia extra — solo TeX Live.

### Paquetes LaTeX utilizados

Todos incluidos en TeX Live. Los más importantes:

| Paquete | Función |
|---|---|
| `circuitikz` | Circuitos lógicos (latches, flip-flops) |
| `tikz-timing` | Diagramas de tiempo de señales digitales |
| `tikz` + `automata` | Diagramas de estados (FSM) |
| `listings` | Bloques de código C con resaltado Atom One Light |
| `tcolorbox` | Cajas de notas, advertencias, importante |
| `babel` (español) | Tipografía e idioma |
| `fancyhdr` | Encabezado y pie de página institucionales |
| `booktabs` | Tablas profesionales |
| `hyperref` | Referencias e índice clickeables en el PDF |

---

## Compilación

### Opción 1 — Doble clic (recomendado)

Desde el Explorador de Windows, doble clic en:
```
compilar.bat
```

### Opción 2 — PowerShell

```powershell
powershell -ExecutionPolicy Bypass -File compilar.ps1
```

### Opción 3 — Manual

El documento requiere **dos pasadas** para el índice y las referencias cruzadas.

```
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
```

### Opción 4 — latexmk (determina las pasadas automáticamente)

```
latexmk -pdf main.tex
```

---

## Compilar un solo capítulo (más rápido al editar)

Descomentar la línea `\includeonly{}` correspondiente en `main.tex` antes de compilar:

```latex
% Descomentar UNA de estas líneas:
\includeonly{capitulo1}   % Lógica Secuencial
\includeonly{capitulo2}   % Memorias
\includeonly{capitulo3}   % Sistemas Microprogramables
\includeonly{capitulo4}   % Algoritmos y Diagramas de Flujo
\includeonly{capitulo5}   % Introducción a C
\includeonly{capitulo6}   % C Embebido ATmega328
```

El PDF resultante incluye solo ese capítulo pero mantiene la numeración correcta de páginas y referencias.

---

## Estructura de archivos

```
latex/
├── main.tex          <- documento principal (compilar aquí)
├── capitulo1.tex     <- Lógica Secuencial
├── capitulo2.tex     <- Memorias Digitales
├── capitulo3.tex     <- Sistemas Microprogramables
├── capitulo4.tex     <- Pensamiento Computacional y Algoritmos
├── capitulo5.tex     <- Introducción al Lenguaje C
├── capitulo6.tex     <- C Embebido ATmega328
├── imagenes/
│   └── logo.png      <- logo institucional (usado en encabezado y portada)
├── compilar.bat      <- script Windows (doble clic)
├── compilar.ps1      <- script PowerShell
└── README.md         <- este archivo
```

---

## Diagramas pendientes / en revisión

Los diagramas generados en CircuiTikZ o TikZ tienen un **banner amarillo** visible en el PDF:

> ▶ Diagrama generado en CircuiTikZ — revisar antes de la versión final

Esto permite encontrarlos rápidamente para revisar o ajustar.

Los marcadores `\imagenPendiente{...}` indican figuras aún no insertadas (capturas del Floyd u otras imágenes externas). Al insertar una imagen, reemplazar:

```latex
\imagenPendiente{descripción}
```

por:

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.75\textwidth]{imagenes/nombre_archivo}
  \caption{descripción}
\end{figure}
```
