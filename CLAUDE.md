# Proyecto: Apuntes AED II y AED III
**EEST Nro. 1 — Vte. López | Autor: Ariel Wels**

---

## Qué es este proyecto

Apuntes didácticos para los cursos de Aplicaciones de Electrónica Digital II y III (5to año, escuela técnica). Se desarrollan interactivamente: el docente revisa cada apunte antes de pasar al siguiente.

Los borradores en Markdown ya fueron convertidos a LaTeX. **El flujo de trabajo actual es directamente sobre los archivos `.tex` en `capitulos/`.**

---

## Decisiones importantes del proyecto

- **Microcontrolador:** ATmega328P en placas Arduino Nano, pero **sin usar el framework Arduino ni sus bibliotecas**. Se programa en C puro con `avr-gcc` (`<avr/io.h>`, `<util/delay.h>`, `<avr/interrupt.h>`).
- **Lenguaje de programación:** C estándar (Bloque 5) y C embebido con avr-gcc (Bloque 6).
- **Herramienta de algoritmos:** PSeInt con perfil **EEST1 VL** (disponible en Moodle).
- **Timer:** todos los ejemplos usan Timer 0 en **modo CTC con OCR0A = 249**, preescalador 64, F_CPU = 16 MHz → interrupción exacta cada **1 ms** con vector `TIMER0_COMPA_vect`.
- **Displays:** tabla de patrones para **cátodo común**, segmentos a-g en bits 0..6 del PORTD.
- **Gráficos:** cuando se puede representar algo directamente en LaTeX (con TikZ, circuitikz, tikz-timing, pgfplots, etc.), se prefiere eso por sobre insertar una imagen externa. Solo se inserta imagen externa si el gráfico es una fotografía real, una captura de pantalla de software, o algo demasiado complejo para reproducir en TikZ con calidad razonable. Los diagramas de tiempos, circuitos lógicos, bloques de arquitectura, diagramas de flujo y FSM son todos candidatos a TikZ.
- **Imágenes externas:** se agregarán solo donde no sea viable un gráfico LaTeX. Los archivos `.tex` tienen marcadores `\tikzCircuito{cap*/pendiente}{descripción}` en esos lugares. El libro de referencia para imágenes es **Floyd — Fundamentos de Sistemas Digitales** (PDF en `fuentes/`).
- **Libro de referencia técnico:** Floyd, "Fundamentos de Sistemas Digitales", 9ª ed. (1024 págs., PDF en `fuentes/`). Capítulos usados: 7 (latches/FF), 8 (contadores), 9 (registros), 10 (memorias).

---

## Estructura de archivos

```
apunte/
├── CLAUDE.md                                  ← este archivo
│
├── main.tex                                   ← documento LaTeX principal (compilar aquí)
├── _preview.tex                               ← preview de diagramas TikZ
├── compilar.ps1 / compilar.bat                ← scripts de compilación
├── preview-tikz.ps1                           ← script preview TikZ
├── imagenes/
│   └── logo.png
├── capitulos/
│   ├── capitulo1.tex  ← Lógica Secuencial
│   ├── capitulo2.tex  ← Memorias
│   ├── capitulo3.tex  ← Sistemas Microprogramables
│   ├── capitulo4.tex  ← Algoritmos y Diagramas de Flujo
│   ├── capitulo5.tex  ← Introducción a C
│   └── capitulo6.tex  ← C Embebido ATmega328
├── tikz/
│   ├── estilos.tex                            ← estilos TikZ compartidos (timing/aed, flujo, bloques)
│   ├── PENDIENTES.md                          ← estado de cada diagrama (revisado / a revisar)
│   ├── cap1/                                  ← diagramas del Cap. 1 (Lógica Secuencial)
│   │   └── ref/                               ← capturas Floyd (referencia lado a lado)
│   ├── cap2/                                  ← diagramas del Cap. 2 (Memorias)
│   ├── cap3/                                  ← diagramas del Cap. 3 (Von Neumann / Harvard)
│   ├── cap4/                                  ← diagramas de flujo del Cap. 4
│   └── cap6/                                  ← diagramas del Cap. 6 (C Embebido)
└── fuentes/                                   ← documentos de referencia originales
    ├── Fundamentos de Sistemas Digitales.pdf  ← Floyd (referencia principal de imágenes)
    ├── Apunte memorias.pdf                    ← apunte anterior (base Cap. 2)
    ├── Sistemas Microprogramables.pdf         ← apunte anterior (base Cap. 3)
    ├── TP Algoritmos.pdf                      ← guía TP3 (base Caps. 4 y 5)
    └── TPs Programacion embebidos.pdf         ← guía TPs 1-7 (base Cap. 6)
```

**Compilar:** ejecutar `compilar.ps1` (o usar el botón "Compilar LaTeX" en VS Code) desde la raíz del proyecto. El CWD debe ser la raíz porque los `\include{capituloX}` e `\input{tikz/...}` son rutas relativas a ese directorio. Los scripts buscan `pdflatex` en el PATH o en cualquier `C:\texlive\<año>\bin\...` (en esta PC: TeX Live 2026, esquema custom con latexextra, pictures, langspanish, fontsrecommended, mathscience).

**Convenciones TikZ:**
- Todos los diagramas de tiempos usan `\begin{tikztimingtable}[timing/aed]` (definido en `tikz/estilos.tex`). Dentro de `\extracode`: x = 1 unidad por carácter, y = 1 unidad por altura de señal, la fila k tiene base en `-(k-1)*\rowdist`. Usar `\vertlines{...}` para líneas guía y los estilos `fase`, `nota`, `zona`. No usar `rowdist`/`coldist` en ex/pt ni `timing/name/.style={right}` (los nombres quedan encima de las señales).
- Flip-flops con flanco ↓ u otras variantes: `flipflop def={t1=D, c3=1, n3=1, ...}` (manual circuitikz §4.23).
- Para escribir `.tikz` desde Claude Code usar la herramienta Write/Edit, nunca heredocs/printf/sed de Bash: convierten `\\` en `\` y rompen las tablas de tikz-timing.

---

## Estado actual y pendientes

### AED II — Bloques en LaTeX

| Bloque | Tema | Estado |
|--------|------|--------|
| 1 | Lógica Secuencial (latches, FF, registros, contadores, FSM) | ✅ en LaTeX |
| 2 | Memorias (organización, RAM, ROM, Flash, expansión) | ✅ en LaTeX |
| 3 | Sistemas Microprogramables (arquitectura CPU, Von Neumann/Harvard, buses, lenguajes) | ✅ en LaTeX |
| 4 | Pensamiento Computacional y Algoritmos (diagramas de flujo, PSeInt) | ✅ en LaTeX |
| 5 | Introducción a C (tipos, operadores, estructuras de control, ejercicios) | ✅ en LaTeX |
| 6 | C Embebido ATmega328 (DDR/PORT/PIN, bitwise, timer CTC, ISR, display, mux) | ✅ en LaTeX |

### AED III — Pendiente

Los bloques de AED III aún no se han desarrollado. Temas previstos (conversación inicial):

- Bloque 1: Máquinas de estado en C — diseño estructurado
- Bloque 2: Planificación de tareas sin RTOS (superloop, flags, timers por software)
- Bloque 3: ADC — modos de conversión, referencia, ejemplos
- Bloque 4: PWM — generación, control de motor / LED
- Bloque 5: SPI — maestro/esclavo, registro de desplazamiento, displays
- Bloque 6: I²C — protocolo, sensores típicos
- Bloque 7: Watchdog y modos de bajo consumo (sleep modes)
- Bloque 8: Proyecto integrador guiado

### Imágenes pendientes (para todos los bloques)

Desde 2026-10-16 todos los gráficos viables en TikZ están hechos (ver `tikz/PENDIENTES.md`; los marcados `[ ]` esperan la revisión del docente). Solo quedan `\imagenPendiente` para las capturas de PSeInt de los ejercicios 1–5 (cap. 4). Las fotos van en `imagenes/` con nombres sin espacios (ej. `eprom-chip.jpg`, `eprom-ventana.jpg`). El workflow para nuevos diagramas es: imagen Floyd → TikZ en `tikz/capN/nombre.tikz` → `\tikzCircuito{capN/nombre}{caption}` lo incluye automáticamente; verificar con `preview-tikz.ps1` (`_preview.tex` muestra cada diagrama, junto a la captura de `ref/` si existe).

---

## Cómo continuar este proyecto

Al retomar con un nuevo agente, leer este archivo primero. Luego:

1. Preguntar al docente qué bloque quiere revisar o continuar.
2. Leer el `.tex` correspondiente en `capitulos/` antes de editar.
3. Para AED III: arrancar con una conversación sobre el orden didáctico de los temas antes de escribir.
4. Mantener este `CLAUDE.md` actualizado al terminar cada sesión.
