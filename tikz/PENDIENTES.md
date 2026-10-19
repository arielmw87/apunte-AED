# Diagramas TikZ del apunte

Guardar cada archivo en la subcarpeta correspondiente (`tikz/capN/`) con la extensión `.tikz`.
Cuando el archivo existe, aparece automáticamente en el PDF con el banner de revisión.

> ✎ = diagrama hecho a mano (código comentado y parametrizado, fácil de ajustar).
> `[X]` = revisado por el docente. `[ ]` = hecho, falta la revisión del docente.
> 🔧 = corregido el 2026-10-16 · 🆕 = creado el 2026-10-16

**Estilos compartidos:** `tikz/estilos.tex` (lo cargan `main.tex` y `_preview.tex`).
Define `timing/aed` para todos los diagramas de tiempos, los nodos de diagramas de flujo
(`terminal`, `proceso`, `decision`, `entrada`, `conector`, `flecha`) y los de bloques
(`bloque`, `bus`, `busflecha`, `anchobus`). Cambiar un estilo ahí cambia todos los diagramas.

---

## Capítulo 1 — Lógica Secuencial

> ✅ Capítulo revisado por el docente (2026-10-19): usa `\tikzFigura` (sin banner).

- [X] ✎ `latch-SR.tikz` — Implementación NOR + NAND acopladas en cruz (fig. 7.1 Floyd)
- [ ] ✎ 🔧 `latch-SR-timing.tikz` — Diagrama de tiempos latch SR: S/R/Q/Qbar con fases Hold/SET/RESET
- [X] ✎ `latch-SR-simbolo.tikz` — Símbolo en bloque del latch SR: versión activo-alto y activo-bajo (fig. 7.4 Floyd)
- [X] ✎ `debounce-latch.tikz` — Anti-rebote: pulsador SPDT + pull-ups + latch SR NAND (fig. 7.6 Floyd)
- [X] ✎ `bounce-signal.tikz` — Señal ideal (flanco limpio) vs. señal real con rebote
- [X] ✎ `debounce-timing.tikz` — Diagrama de tiempos antirrebote: entrada /S con rebotes → salida Q limpia (fig. 7.7 Floyd)
- [X] ✎ `latch-SR-EN.tikz` — Latch SR con habilitación EN (diagrama 4 NAND + símbolo) (fig. 7.8 Floyd)
- [ ] ✎ 🔧 `latch-SR-EN-timing.tikz` — Diagrama de tiempos latch SR-EN: EN/S/R/Q mostrando bloqueo con EN=0
- [X] ✎ `latch-D.tikz` — Latch D con habilitación (diagrama + inversor + símbolo) (fig. 7.10 Floyd)
- [ ] ✎ 🔧 `latch-D-timing.tikz` — Diagrama de tiempos latch D: EN/D/Q con zona EN=0 sombreada
- [ ] ✎ 🔧 `ff-simbolos.tikz` — Símbolos de FF-D flanco↑, FF-D flanco↓ (con burbuja) y FF-JK
- [X] ✎ `flipflop-JK.tikz` — Símbolo del FF-JK (triángulo de clock) + diagrama de tiempos con las 4 operaciones (fig. 7.20 Floyd)
- [ ] ✎ 🔧 `flipflop-SR-timing.tikz` — Diagrama de tiempos FF-SR por flanco: CLK/S/R/Q con fases Hold/SET/RESET
- [ ] ✎ 🔧 `flipflop-D-timing.tikz` — Diagrama de tiempos FF-D por flanco (corregido: D cambiaba justo en el flanco)
- [ ] ✎ 🔧 `flipflop-T-timing.tikz` — Diagrama de tiempos FF-T: CLK/T/Q con fases Hold/Toggle
- [ ] ✎ 🔧 `ff-parametros-tiempo.tikz` — Parámetros t_setup, t_hold, t_pd con cotas sobre señales CLK/D/Q
- [ ] ✎ 🆕 `registro-modos.tikz` — Los 7 modos de movimiento de datos en un registro (fig. 9.2 Floyd)
- [X] ✎ `registro-SISO.tikz` — 4 flip-flops D en cascada, registro de desplazamiento (fig. 9.3 Floyd)
- [ ] ✎ 🆕 `hc595-cascada.tikz` — ATmega328P + dos 74HC595 en cascada, con números de pin
- [X] ✎ `contador-asincrono-4bit.tikz` — 4 FF-JK en toggle con CLK en cascada, contador ripple (fig. 8.1 Floyd)
- [ ] ✎ 🔧 `contador-asincrono-timing.tikz` — Contador asíncrono 3 bits (corregido: ahora cambia en flancos ↓)
- [ ] ✎ `contador-sincrono-4bit.tikz` — 4 FF-JK + compuertas AND de habilitación, contador síncrono (fig. 8.18 Floyd)
- [ ] ✎ 🔧 `contadores-cascada.tikz` — 2 bloques de contador 4 bits en cascada → contador 8 bits (fig. 8.34 Floyd)
- [ ] ✎ 🔧 `fsm-diagrama.tikz` — Diagrama de estados FSM de Moore: 4 estados S0–S3, automata library

## Capítulo 2 — Memorias Digitales

- [ ] ✎ 🆕 `matriz-organizaciones.tikz` — Matriz de 64 celdas: 64×1, 8×8, 16×4
- [ ] ✎ 🆕 `memoria-buses.tikz` — Memoria 1K×8 con bus de direcciones, datos y control (CS, OE, WE)
- [ ] ✎ 🆕 `escritura-timing.tikz` — Diagrama de tiempos de escritura (pasos 1–4 numerados)
- [ ] ✎ 🆕 `lectura-timing.tikz` — Diagrama de tiempos de lectura (pasos 1–4 + tiempo de acceso)
- [ ] ✎ 🆕 `clasificacion-memorias.tikz` — Árbol RAM (SRAM/DRAM) / ROM (máscara/PROM/EPROM/EEPROM/Flash)
- [ ] ✎ 🆕 `celda-SRAM-latch.tikz` — Celda SRAM básica: latch D + AND de escritura + buffer tri-estado de lectura (idea fig. 10.8 Floyd, corregida)
- [ ] ✎ 🔧 `celda-SRAM.tikz` — Celda SRAM 6T (optimización): 2 inversores cruzados + 2 transistores de acceso + BL/BL̄ + WL (rehecha 2026-10-19)
- [ ] ✎ `celda-DRAM.tikz` — Celda DRAM: 1 transistor NMOS + 1 capacitor + bit line + word line
- [ ] ✎ 🆕 `expansion-palabra.tikz` — 2 chips 1K×4 → memoria 1K×8
- [ ] ✎ 🆕 `expansion-capacidad.tikz` — 4 chips 1K×8 + decodificador 2 a 4 → memoria 4K×8

## Capítulo 3 — Sistemas Microprogramables

- [ ] ✎ 🆕 `von-neumann.tikz` — CPU — bus único — memoria única (cuello de botella resaltado)
- [ ] ✎ 🆕 `harvard.tikz` — Memoria de programa / CPU / memoria de datos con buses separados

## Capítulo 4 — Algoritmos

- [ ] ✎ 🆕 `simbolos-flujo.tikz` — Tabla visual de símbolos del diagrama de flujo
- [ ] ✎ 🆕 `secuencia.tikz` — Secuencia (ejemplo: área del rectángulo)
- [ ] ✎ 🆕 `si-sino.tikz` — Decisión si-sino (ejemplo: positivo / negativo)
- [ ] ✎ 🆕 `mientras.tikz` — Bucle mientras con flecha de retorno

## Capítulo 6 — C Embebido (ATmega328)

- [ ] ✎ 🆕 `nano-pinout.tikz` — Pinout del Arduino Nano con puertos PB/PC/PD coloreados
- [ ] ✎ 🔧 `display-7seg.tikz` — Segmentos a–g + circuito equivalente de cátodo común
- [ ] ✎ 🔧 `mux-displays.tikz` — Multiplexado de 4 displays (selección PB0–PB3, segmentos PD0–PD6)

---

## Imágenes que siguen pendientes (no conviene hacerlas en TikZ)

### Capítulo 4

- [ ] `\imagenPendiente` — Diagramas de flujo ejercicios 1 al 5 (capturas de PSeInt)
