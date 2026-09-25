# Diagramas TikZ del apunte

Guardar cada archivo en la subcarpeta correspondiente (`tikz/capN/`) con la extensión `.tikz`.
Cuando el archivo existe, aparece automáticamente en el PDF con el banner de revisión.

> ✎ = diagrama hecho a mano (código comentado y parametrizado, fácil de ajustar).

---

## Capítulo 1 — Lógica Secuencial

- [X] ✎ `latch-SR.tikz` — Implementación NOR + NAND acopladas en cruz (fig. 7.1 Floyd)
- [ ] ✎ `latch-SR-timing.tikz` — Diagrama de tiempos latch SR: S/R/Q/Qbar con fases Hold/SET/RESET
- [X] ✎ `latch-SR-simbolo.tikz` — Símbolo en bloque del latch SR: versión activo-alto y activo-bajo (fig. 7.4 Floyd)
- [X] ✎ `debounce-latch.tikz` — Anti-rebote: pulsador SPDT + pull-ups + latch SR NAND (fig. 7.6 Floyd)
- [X] ✎ `bounce-signal.tikz` — Señal ideal (flanco limpio) vs. señal real con rebote
- [X] ✎ `debounce-timing.tikz` — Diagrama de tiempos antirrebote: entrada /S con rebotes → salida Q limpia (fig. 7.7 Floyd)
- [X] ✎ `latch-SR-EN.tikz` — Latch SR con habilitación EN (diagrama 4 NAND + símbolo) (fig. 7.8 Floyd)
- [ ] ✎ `latch-SR-EN-timing.tikz` — Diagrama de tiempos latch SR-EN: EN/S/R/Q mostrando bloqueo con EN=0
- [X] ✎ `latch-D.tikz` — Latch D con habilitación (diagrama + inversor + símbolo) (fig. 7.10 Floyd)
- [ ] ✎ `latch-D-timing.tikz` — Diagrama de tiempos latch D: EN/D/Q con zona EN=0 sombreada
- [ ] ✎ `ff-simbolos.tikz` — Símbolos de FF-D flanco↑, FF-D flanco↓ y FF-JK en circuitikz
- [X] ✎ `flipflop-JK.tikz` — Símbolo del FF-JK (triángulo de clock) + diagrama de tiempos con las 4 operaciones (fig. 7.20 Floyd)
- [ ] ✎ `flipflop-SR-timing.tikz` — Diagrama de tiempos FF-SR por flanco: CLK/S/R/Q con fases Hold/SET/RESET
- [ ] ✎ `flipflop-D-timing.tikz` — Diagrama de tiempos FF-D por flanco: CLK/D/Q con marcas ↑ de captura
- [ ] ✎ `flipflop-T-timing.tikz` — Diagrama de tiempos FF-T: CLK/T/Q con fases Hold/Toggle
- [ ] ✎ `ff-parametros-tiempo.tikz` — Parámetros t_setup, t_hold, t_pd con cotas sobre señales CLK/D/Q
- [X] ✎ `registro-SISO.tikz` — 4 flip-flops D en cascada, registro de desplazamiento (fig. 9.3 Floyd)
- [X] ✎ `contador-asincrono-4bit.tikz` — 4 FF-JK en toggle con CLK en cascada, contador ripple (fig. 8.1 Floyd)
- [ ] ✎ `contador-asincrono-timing.tikz` — Diagrama de tiempos contador asíncrono 3 bits: CLK/Q0/Q1/Q2 + conteo
- [ ] ✎ `contador-sincrono-4bit.tikz` — 4 FF-JK + compuertas AND de habilitación, contador síncrono (fig. 8.18 Floyd)
- [ ] ✎ `contadores-cascada.tikz` — 2 bloques de contador 4 bits en cascada → contador 8 bits (fig. 8.34 Floyd)
- [ ] ✎ `fsm-diagrama.tikz` — Diagrama de estados FSM de Moore: 4 estados S0–S3, automata library

## Capítulo 2 — Memorias Digitales

- [ ] ✎ `celda-SRAM.tikz` — Celda SRAM: 2 inversores (latch) + 2 transistores de acceso + bit lines + word line
- [ ] ✎ `celda-DRAM.tikz` — Celda DRAM: 1 transistor NMOS + 1 capacitor + bit line + word line

## Capítulo 6 — C Embebido (ATmega328)

- [ ] ✎ `display-7seg.tikz` — Display 7 segmentos con segmentos a–g etiquetados y cátodo común
- [ ] ✎ `mux-displays.tikz` — Multiplexado de 4 displays: pines de segmento compartidos, selección individual por dígito

> ✅ Todos los diagramas TikZ están hechos.

---

## Imágenes que vienen del Floyd u otras fuentes (no TikZ)

### Capítulo 1

- [ ] `\imagenPendiente` — 7 modos de movimiento de datos en un registro (fig. 9.2 Floyd)
- [ ] `\imagenPendiente` — Conexión y pinout del 74HC595 en cascada con microcontrolador

### Capítulo 2

- [ ] `\imagenPendiente` — Matriz de celdas: tres organizaciones (64×1, 8×8, 16×4)
- [ ] `\imagenPendiente` — Esquema de memoria con buses de dirección, dato y control (CS, OE, WE)
- [ ] `\imagenPendiente` — Diagrama de tiempos operación de escritura
- [ ] `\imagenPendiente` — Diagrama de tiempos operación de lectura
- [ ] `\imagenPendiente` — Árbol de clasificación de memorias (RAM → SRAM/DRAM; ROM → máscara/PROM/EPROM/EEPROM/Flash)
- [ ] `\imagenPendiente` — Foto o dibujo de chip EPROM con ventana de cuarzo
- [ ] `\imagenPendiente` — Expansión de palabra: 2 chips 1K×4 → memoria 1K×8
- [ ] `\imagenPendiente` — Expansión de capacidad: 4 chips 1K×8 → memoria 4K×8 con decodificador

### Capítulo 3

- [ ] `\imagenPendiente` — Diagrama de bloques Von Neumann (CPU — bus único — memoria única)
- [ ] `\imagenPendiente` — Diagrama de bloques Harvard (bus de programa / bus de datos separados)

### Capítulo 4

- [ ] `\imagenPendiente` — Tabla visual con símbolos estándar del diagrama de flujo
- [ ] `\imagenPendiente` — Diagrama de flujo: secuencia lineal (Inicio → Paso 1 → Paso 2 → Fin)
- [ ] `\imagenPendiente` — Diagrama de flujo: estructura si-sino (rombo + rama Sí / rama No)
- [ ] `\imagenPendiente` — Diagrama de flujo: bucle mientras (rombo antes del bloque + flecha de retorno)
- [ ] `\imagenPendiente` — Diagramas de flujo ejercicios 1 al 5 (capturas de PSeInt)

### Capítulo 6

- [ ] `\imagenPendiente` — Mapa de pines del Arduino Nano (PD0–PD7, PB0–PB5, PC0–PC5)

