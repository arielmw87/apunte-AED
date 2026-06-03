# Lógica Secuencial

**Aplicaciones de Electrónica Digital II**
Escuela de Educación Técnica Nro. 1 — Vte. López

---

## Lógica combinacional vs. lógica secuencial

En lógica combinacional, las salidas dependen únicamente del valor actual de las entradas. En lógica **secuencial**, las salidas dependen tanto de las entradas actuales como del **estado anterior** del circuito. Esto significa que el circuito tiene memoria: recuerda lo que ocurrió antes.

El bloque fundamental de la lógica secuencial es el **dispositivo biestable**: un circuito que puede permanecer indefinidamente en uno de dos estados estables (SET o RESET), y que solo cambia de estado cuando se lo indica una señal de entrada.

Los dispositivos biestables se dividen en dos categorías:

- **Latches:** cambian de estado de forma asíncrona, es decir, responden directamente al nivel de sus entradas en cualquier momento.
- **Flip-flops:** cambian de estado de forma síncrona, es decir, solo en el momento en que ocurre un flanco de la señal de reloj.

---

## Latches

### Latch SR (Set-Reset)

Es el tipo más simple de dispositivo biestable. Tiene dos entradas (S y R) y dos salidas complementarias (Q y $\overline{Q}$).

Puede implementarse con dos puertas NOR (entradas activas a nivel alto) o con dos puertas NAND (entradas activas a nivel bajo).

<!-- IMAGEN: símbolo lógico del latch SR con puertas NOR y con puertas NAND (figura 7.1 Floyd) -->

**Tabla de verdad — Latch SR con entradas activas a nivel bajo (puertas NAND):**

| $\overline{S}$ | $\overline{R}$ | Q | $\overline{Q}$ | Condición |
|:---:|:---:|:---:|:---:|---|
| 1 | 1 | Q₀ | $\overline{Q_0}$ | No cambia (retiene estado) |
| 0 | 1 | 1 | 0 | SET (Q pasa a 1) |
| 1 | 0 | 0 | 1 | RESET (Q pasa a 0) |
| 0 | 0 | ? | ? | **No válido** |

La condición no válida ocurre cuando ambas entradas se activan simultáneamente: fuerza a ambas salidas al mismo nivel, violando la condición de complementariedad. Si luego se desactivan al mismo tiempo, el estado final es impredecible.

<!-- IMAGEN: diagrama de tiempos del latch SR mostrando las tres condiciones válidas (figura 7.3 Floyd) -->

**Aplicación — Eliminación de rebote de pulsadores:**
Un latch SR se puede usar para eliminar el rebote mecánico de un interruptor. El primer contacto es suficiente para activar el latch, y los rebotes posteriores no alteran su estado. Esto proporciona una transición limpia en la salida.

<!-- IMAGEN: circuito eliminador de rebote con latch SR (figura 7.6 Floyd) -->

### Latch SR con habilitación

Agrega una entrada de habilitación (EN). El latch solo puede cambiar de estado cuando EN está activo. Permite controlar exactamente en qué momento el latch responde a sus entradas.

<!-- IMAGEN: diagrama y símbolo del latch SR con entrada EN (figura 7.8 Floyd) -->

### Latch D con habilitación

Tiene una única entrada de datos (D) además de la habilitación (EN). Elimina la condición no válida del latch SR: cuando EN está activo, la salida Q sigue al valor de D. Cuando EN se desactiva, el latch retiene el último valor de D.

<!-- IMAGEN: diagrama y símbolo del latch D (figura 7.10 Floyd) -->

| D | EN | Q | Condición |
|:---:|:---:|:---:|---|
| 0 | 1 | 0 | RESET |
| 1 | 1 | 1 | SET |
| X | 0 | Q₀ | No cambia |

---

## Flip-flops

La diferencia fundamental entre un latch y un flip-flop es el mecanismo de disparo. Un flip-flop **disparado por flanco** solo cambia de estado en el instante exacto del flanco (de subida o de bajada) de la señal de reloj. Fuera de ese instante, es insensible a los cambios en sus entradas.

En los símbolos lógicos, el flanco activo se indica con un **triángulo** en la entrada de reloj (indicador de entrada dinámica). Si hay un círculo adicional, el disparo es por flanco negativo (bajada); sin círculo, por flanco positivo (subida).

<!-- IMAGEN: símbolos de flip-flops D, SR y JK disparados por flanco positivo y negativo (figura 7.13 Floyd) -->

### Flip-flop SR disparado por flanco

Similar al latch SR pero sincronizado con el reloj. Las entradas S y R solo son evaluadas en el flanco activo del reloj.

| S | R | Q siguiente | Condición |
|:---:|:---:|:---:|---|
| 0 | 0 | Q₀ | No cambia |
| 1 | 0 | 1 | SET |
| 0 | 1 | 0 | RESET |
| 1 | 1 | ? | No válido |

### Flip-flop D disparado por flanco

La salida Q toma el valor de la entrada D en cada flanco activo del reloj. Es el más simple y el más utilizado en la práctica.

| D | Q siguiente |
|:---:|:---:|
| 0 | 0 |
| 1 | 1 |

<!-- IMAGEN: diagrama de tiempos de un flip-flop D — entrada D, reloj CLK y salida Q (figura 7.15 Floyd) -->

### Flip-flop JK disparado por flanco

El flip-flop JK resuelve la condición no válida del SR reemplazando el estado indeterminado por una operación de **basculación (toggle)**: cuando J = K = 1, la salida cambia de estado en cada flanco de reloj.

| J | K | Q siguiente | Condición |
|:---:|:---:|:---:|---|
| 0 | 0 | Q₀ | No cambia |
| 1 | 0 | 1 | SET |
| 0 | 1 | 0 | RESET |
| 1 | 1 | $\overline{Q_0}$ | Bascula (Toggle) |

<!-- IMAGEN: símbolo y diagrama de tiempos del flip-flop JK (figura 7.20 Floyd) -->

### Flip-flop T (Toggle)

Es un caso especial del JK con ambas entradas unidas (J = K = T). Cuando T = 1, la salida bascula en cada flanco de reloj. Cuando T = 0, la salida no cambia.

| T | Q siguiente |
|:---:|:---:|
| 0 | Q₀ |
| 1 | $\overline{Q_0}$ |

El flip-flop T es la base de los contadores binarios.

### Entradas asíncronas: Preset y Clear

La mayoría de los flip-flops tienen entradas asíncronas que actúan **independientemente del reloj**:

- **Preset (PRE):** fuerza la salida Q a 1.
- **Clear (CLR):** fuerza la salida Q a 0.

Son útiles para inicializar el sistema a un estado conocido al encender, o para hacer resets de emergencia.

### Características de funcionamiento

Algunas características importantes de los flip-flops al trabajar con señales reales:

**Retardo de propagación ($t_{pd}$):** tiempo que transcurre desde el flanco activo del reloj hasta que la salida estabiliza su nuevo valor. Limita la frecuencia máxima de operación.

**Tiempo de establecimiento ($t_{setup}$):** tiempo mínimo que la entrada debe estar estable **antes** del flanco activo del reloj para garantizar una lectura correcta.

**Tiempo de mantenimiento ($t_{hold}$):** tiempo mínimo que la entrada debe permanecer estable **después** del flanco activo del reloj.

**Frecuencia máxima ($f_{max}$):** frecuencia de reloj máxima a la que el flip-flop puede operar correctamente.

<!-- IMAGEN: diagrama temporal mostrando t_setup, t_hold y t_pd (figura 7.25 Floyd) -->

---

## Registros de desplazamiento

Un registro de desplazamiento es un circuito formado por flip-flops en cascada que cumple dos funciones: **almacenamiento** y **desplazamiento** de datos. Cada flip-flop representa un bit; por lo tanto, un registro de N etapas almacena N bits.

Los datos pueden entrar y salir del registro de distintas formas:

<!-- IMAGEN: los 7 modos básicos de movimiento de datos en un registro (figura 9.2 Floyd) -->

### Entrada serie / Salida serie (SISO)

Los bits entran uno a uno por un extremo y salen uno a uno por el otro. En cada pulso de reloj, todos los bits se desplazan una posición. Se necesitan N pulsos para cargar N bits y otros N para extraerlos.

<!-- IMAGEN: registro SISO de 4 bits con flip-flops D en cascada (figura 9.3 Floyd) -->

> **CI típico:** **74HC164** — registro SIPO de 8 bits (serie in / paralelo out). También puede usarse como SISO tomando solo la salida del último flip-flop.

### Entrada serie / Salida paralelo (SIPO)

Los bits entran en serie pero se leen simultáneamente de todas las salidas Q de cada etapa. Una vez cargados los N bits, están disponibles todos al mismo tiempo en las salidas paralelo. Se usa para convertir datos serie a paralelo, por ejemplo para controlar múltiples LEDs o segmentos usando solo unos pocos pines del microcontrolador.

> **CI típicos:**
> - **74HC595** — registro SIPO de 8 bits con latch de salida separado y salida en colector abierto para cascada. Es el más utilizado en proyectos con microcontroladores para expandir salidas digitales.
> - **74HC164** — registro SIPO de 8 bits sin latch de salida (las salidas cambian mientras se desplazan los datos).

<!-- IMAGEN: diagrama de pines y conexión del 74HC595 en cascada con microcontrolador -->

### Entrada paralelo / Salida serie (PISO)

Los N bits se cargan simultáneamente en las etapas (carga paralelo) y luego se extraen uno a uno en serie. Se usa para convertir datos paralelo a serie, por ejemplo para leer el estado de múltiples entradas digitales usando pocos pines del microcontrolador.

> **CI típicos:**
> - **74HC165** — registro PISO de 8 bits con carga paralela asíncrona. Muy usado para leer matrices de pulsadores o DIP switches desde un microcontrolador por SPI.
> - **74LS165** — versión TTL del mismo.

### Entrada paralelo / Salida paralelo (PIPO)

Los datos se cargan y se leen en paralelo. Funciona esencialmente como un banco de flip-flops D con habilitación. Se usa principalmente como registro de almacenamiento temporal o buffer de datos.

> **CI típico:** **74HC195** — registro PIPO de 4 bits con entrada serie y paralelo y salida paralelo.

### Registros bidireccionales

Pueden desplazar datos tanto hacia la izquierda como hacia la derecha, según el valor de una entrada de control de dirección. Son los más versátiles ya que combinan múltiples modos de operación.

> **CI típicos:**
> - **74HC194** — registro universal de 4 bits: SISO izquierda, SISO derecha, carga paralelo, retención. Controlado por dos entradas de modo (S0, S1).
> - **74LS194** — versión TTL del mismo.

### Contadores basados en registros de desplazamiento

Conectando la salida del último flip-flop a la entrada del primero (registro en anillo), se obtienen secuencias especiales:

**Contador en anillo:** desplaza un único bit activo de forma circular. Un registro de N etapas genera una secuencia de N estados únicos y requiere N flip-flops para contar N estados (sin decodificador adicional).

**Contador Johnson (o de anillo torcido):** la salida complementada del último flip-flop ($\overline{Q}$) se realimenta a la entrada del primero. Un registro de N etapas genera una secuencia de 2N estados.

---

## Contadores

Un contador es un circuito secuencial formado por flip-flops que recorre una secuencia determinada de estados binarios, uno por cada pulso de reloj. El **módulo** de un contador es la cantidad total de estados distintos que recorre antes de repetirse.

$$\text{Módulo} = 2^N \quad \text{(para un contador binario de N flip-flops)}$$

### Contadores asíncronos (con propagación)

El reloj se aplica solo al primer flip-flop. Cada flip-flop siguiente se dispara con la salida del anterior. Los cambios de estado se propagan de etapa en etapa, por eso también se los llama **contadores con propagación** (*ripple counters*).

<!-- IMAGEN: contador asíncrono de 2 bits con flip-flops JK en modo toggle (figura 8.1 Floyd) -->

**Diagrama de tiempos de un contador asíncrono de 3 bits:**

<!-- IMAGEN: diagrama de tiempos Q0, Q1, Q2 del contador asíncrono de 3 bits (figura 8.3 Floyd) -->

La secuencia de salidas Q2 Q1 Q0 va de 000 a 111 (0 a 7), y luego vuelve a 000. Esto es un contador módulo-8.

**Desventaja:** el retardo de propagación se acumula etapa a etapa. En contadores muy rápidos o con muchas etapas, los estados intermedios falsos (*glitches*) pueden causar problemas en la lógica de decodificación.

**Contador de décadas asíncrono:** un contador que llega solo hasta 9 (BCD) y luego se reinicia. Se obtiene forzando el reset del contador cuando se alcanza la combinación binaria 10 (1010₂).

### Contadores síncronos

El reloj se conecta **simultáneamente** a todos los flip-flops. Los cambios de estado ocurren al mismo tiempo en todas las etapas, eliminando el problema de acumulación de retardos.

<!-- IMAGEN: contador síncrono de 4 bits con flip-flops JK (figura 8.18 Floyd) -->

La lógica de habilitación de cada etapa se diseña para que el flip-flop cambie de estado solo cuando todos los bits de menor peso estén en 1 (condición de acarreo).

**Ventajas sobre los asíncronos:**
- Todos los bits cambian simultáneamente → no hay glitches por propagación.
- Pueden operar a mayor frecuencia.
- Son preferidos en diseños digitales modernos.

### Contadores ascendentes/descendentes

Un contador puede recorrer su secuencia en sentido creciente (ascendente, *up*) o decreciente (descendente, *down*). Con una entrada de control de dirección se puede elegir el sentido en tiempo real.

### Módulo de un contador y truncamiento de secuencia

Un contador de N flip-flops tiene módulo $2^N$ por defecto. Para obtener un módulo M menor, se detecta el estado M (cuando el contador llega a M) y se fuerza un reset síncrono o asíncrono, haciendo que el contador salte desde M-1 de vuelta a 0.

**Ejemplo:** contador módulo-5 con 3 flip-flops (que tendrían módulo 8 por defecto). Se detecta el estado 5 (101₂) y se usa para resetear el contador, obteniendo la secuencia 0→1→2→3→4→0→...

### Contadores en cascada

Se pueden conectar varios contadores en serie para obtener módulos más grandes. La señal de fin de cuenta (*terminal count*, TC) del primer contador habilita el reloj del segundo.

<!-- IMAGEN: dos contadores de 4 bits en cascada para obtener un contador de 8 bits (figura 8.34 Floyd) -->

### Decodificación de estados

Para detectar un estado específico del contador se puede usar una puerta AND que active su salida solo cuando las salidas del contador forman la combinación deseada. Se debe tener cuidado con los *glitches* en contadores asíncronos.

---

## Máquinas de estado

Una máquina de estado finito (FSM, *Finite State Machine*) es un modelo para describir sistemas secuenciales de forma sistemática. Se define por:

- Un conjunto de **estados** posibles.
- Un **estado inicial**.
- Las **condiciones de transición** entre estados (dependientes de las entradas).
- Las **salidas** asociadas a cada estado o a cada transición.

### Diagrama de estados

El comportamiento de una máquina de estados se representa gráficamente con un **diagrama de estados**:

- Cada estado se representa con un círculo o nodo.
- Las transiciones entre estados se representan con flechas etiquetadas con la condición de entrada que las provoca.
- Las salidas se indican dentro del nodo (Moore) o sobre la flecha (Mealy).

<!-- IMAGEN: ejemplo de diagrama de estados con 4 estados y transiciones -->

### Máquina de Moore

Las salidas dependen **únicamente del estado actual**. Son más fáciles de diseñar y menos propensas a glitches en las salidas.

### Máquina de Mealy

Las salidas dependen del **estado actual y de las entradas**. Pueden reaccionar más rápido a los cambios de entrada, pero las salidas pueden tener transitorios.

### Tabla de estados

Una forma alternativa y más formal de describir una máquina de estados es mediante una tabla:

| Estado actual | Entrada | Estado siguiente | Salida |
|:---:|:---:|:---:|:---:|
| S0 | 0 | S0 | 0 |
| S0 | 1 | S1 | 0 |
| S1 | 0 | S0 | 1 |
| S1 | 1 | S2 | 0 |
| ... | ... | ... | ... |

### Proceso de diseño de una máquina de estados

1. Definir el comportamiento deseado y los estados necesarios.
2. Elaborar el diagrama de estados.
3. Asignar una codificación binaria a cada estado.
4. Derivar las ecuaciones de estado siguiente y de salida (usando mapas de Karnaugh si es necesario).
5. Implementar el circuito con flip-flops y lógica combinacional.

---

*AED II — Wels, Ariel | EEST N°1 Vte. López*
