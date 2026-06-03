# Memorias Digitales

**Aplicaciones de Electrónica Digital II**
Escuela de Educación Técnica Nro. 1 — Vte. López

---

## ¿Qué es una memoria?

La memoria es la parte de un sistema digital que almacena datos binarios en grandes cantidades. Está formada por matrices de elementos de almacenamiento —biestables o capacitores— capaces de retener un bit de información cada uno.

En un sistema microprogramable la memoria cumple dos funciones distintas:

- **Memoria de programa:** almacena las instrucciones que la CPU va a ejecutar. No se modifica durante la ejecución del programa. Se implementa en memoria no volátil (Flash, ROM).
- **Memoria de datos:** almacena las variables y resultados intermedios del programa. Se modifica constantemente durante la ejecución. Se implementa en RAM (volátil).

---

## Unidades de datos binarios

| Unidad | Tamaño | Descripción |
|--------|--------|-------------|
| Bit | 1 bit | Unidad mínima de información: un 0 o un 1 |
| Nibble | 4 bits | Medio byte; útil en representación BCD |
| Byte | 8 bits | Unidad básica de almacenamiento en la mayoría de los sistemas |
| Palabra (*word*) | variable | Unidad completa de trabajo de la CPU (8, 16, 32 o 64 bits según la arquitectura) |

Las capacidades de memoria se expresan en múltiplos de byte:

| Múltiplo | Equivale a |
|----------|------------|
| 1 Kbyte (KB) | $2^{10}$ bytes = 1.024 bytes |
| 1 Megabyte (MB) | $2^{20}$ bytes = 1.048.576 bytes |
| 1 Gigabyte (GB) | $2^{30}$ bytes = 1.073.741.824 bytes |

---

## Organización interna: la matriz de memoria

Internamente, una memoria se organiza como una **matriz de celdas**, donde cada celda almacena un bit. La forma en que se agrupan esas celdas determina la organización de la memoria.

<!-- IMAGEN: matriz de celdas — tres organizaciones posibles (64×1, 8×8, 16×4) -->

Por ejemplo, una matriz de 64 celdas puede organizarse como:

- **64 × 1:** 64 palabras de 1 bit cada una.
- **8 × 8:** 8 palabras de 8 bits (8 bytes).
- **16 × 4:** 16 palabras de 4 bits (16 nibbles).

La **capacidad** de una memoria se calcula como:

$$\text{Capacidad} = N_{\text{direcciones}} \times \text{longitud de palabra}$$

**Ejemplos:**

- Una memoria 16 × 4: 16 posiciones × 4 bits = 64 bits en total.
- Una memoria 16K × 8: $16.384$ posiciones × 8 bits = 131.072 bits = 16 KB.

> **Nota:** los números de posiciones son siempre potencias de 2. El "16k" es en realidad $2^{14} = 16.384$, redondeado a la unidad más próxima por convención.

---

## Direccionamiento

Cada posición de la matriz tiene una **dirección**: un código binario único que la identifica. Para acceder a una posición se coloca su dirección en el **bus de direcciones**; un decodificador interno selecciona la fila y columna correspondientes.

<!-- IMAGEN: esquema de una memoria con bus de direcciones, bus de datos y señales de control (CS, OE, WE) -->

La cantidad de posiciones direccionables depende del número de líneas del bus de direcciones:

$$N_{\text{posiciones}} = 2^{N_{\text{líneas de dirección}}}$$

**Ejemplo:** una memoria con 10 líneas de dirección (A0–A9) puede tener $2^{10} = 1.024$ posiciones.

---

## Operaciones básicas: lectura y escritura

Para controlar si una operación es de lectura o escritura, y para habilitar o deshabilitar el chip, las memorias disponen de señales de control. Las más comunes son:

| Señal | Nombre | Función |
|-------|--------|---------|
| $\overline{CS}$ (o $\overline{CE}$) | *Chip Select / Chip Enable* | Activa el chip (activa en bajo). Permite conectar varios chips al mismo bus y seleccionar solo uno a la vez |
| $\overline{OE}$ | *Output Enable* | Habilita las salidas de datos durante una lectura |
| $\overline{WE}$ | *Write Enable* | Habilita la escritura de datos |

### Operación de escritura

1. Se coloca la dirección en el bus de direcciones.
2. Se activa $\overline{CS}$ (se pone en bajo).
3. Se coloca el dato en el bus de datos.
4. Se activa $\overline{WE}$ (pulso en bajo): el dato queda grabado en la posición seleccionada.

<!-- IMAGEN: diagrama de tiempos de una operación de escritura -->

> Escribir en una posición **destruye** el dato que había antes en esa dirección.

### Operación de lectura

1. Se coloca la dirección en el bus de direcciones.
2. Se activa $\overline{CS}$ (se pone en bajo).
3. Se activa $\overline{OE}$ (se pone en bajo): la memoria deposita el dato almacenado en esa dirección sobre el bus de datos.
4. La CPU lee el dato del bus.

<!-- IMAGEN: diagrama de tiempos de una operación de lectura -->

> La lectura es **no destructiva**: el dato permanece almacenado en la memoria después de ser leído.

---

## Clasificación de las memorias

Las memorias se clasifican según dos criterios principales:

**Según su posibilidad de escritura:**
- **ROM** (*Read Only Memory*): solo lectura.
- **RAM** (*Random Access Memory*): lectura y escritura.

**Según su volatilidad:**
- **Volátiles:** pierden los datos al retirar la alimentación (RAM).
- **No volátiles:** conservan los datos sin alimentación (ROM y sus variantes).

<!-- IMAGEN: árbol de clasificación de memorias (RAM → SRAM / DRAM; ROM → máscara / PROM / EPROM / EEPROM / Flash) -->

---

## Memorias RAM

### RAM estática (SRAM)

Utiliza **biestables (latches o flip-flops)** como elementos de almacenamiento. Cada celda almacena un bit de forma estable mientras haya alimentación, sin necesidad de refresco.

<!-- IMAGEN: celda básica SRAM (latch con líneas de selección de bit y datos) -->

**Características:**
- Mantiene el dato indefinidamente con alimentación.
- Alta velocidad de acceso.
- Mayor área de silicio por bit → mayor costo y menor densidad.
- Se usa en cachés de CPU, registros de microcontroladores y en la memoria de datos (SRAM) de los microcontroladores.

### RAM dinámica (DRAM)

Utiliza **capacitores** como elementos de almacenamiento. Un transistor controla el acceso al capacitor. La carga del capacitor representa el bit almacenado.

<!-- IMAGEN: celda básica DRAM (transistor MOS + capacitor) -->

**Características:**
- El capacitor se descarga lentamente → necesita un **ciclo de refresco** periódico para no perder el dato.
- Mayor densidad de almacenamiento (celda más pequeña) → menor costo por bit.
- Requiere circuitería adicional para el refresco.
- Es la tecnología utilizada en los módulos de RAM de las computadoras personales (DDR, DDR4, etc.).

---

## Memorias ROM y sus variantes

### ROM de máscara

Programada durante la fabricación del chip. El contenido no puede modificarse de ninguna manera. Solo es económica en grandes volúmenes de producción.

### PROM (*Programmable ROM*)

Puede ser programada **una única vez** por el usuario mediante un programador de memoria. El proceso es irreversible: una vez programada no puede cambiarse. También llamada OTP (*One Time Programmable*).

### EPROM (*Erasable PROM*)

Puede ser **borrada mediante luz ultravioleta** a través de una ventana de cuarzo en el encapsulado, y luego reprogramada. El borrado es total (no selectivo) y tarda varios minutos. Reconocible por la ventana transparente en el chip.

<!-- IMAGEN: foto o dibujo de un chip EPROM con ventana de cuarzo -->

### EEPROM (*Electrically Erasable PROM*)

Puede ser **borrada y reprogramada eléctricamente**, byte a byte, sin necesidad de extraer el chip del circuito. Permite actualizaciones en el propio sistema (*In-System Programming*). Velocidad de escritura más lenta que la RAM; número de ciclos de escritura limitado (típicamente 100.000 a 1.000.000).

### Memoria Flash

Es la evolución de la EEPROM. Comparte la capacidad de borrado y escritura eléctrica, pero opera por **bloques** en lugar de byte a byte, lo que la hace significativamente más rápida en operaciones de borrado. Combina:

- Alta densidad de almacenamiento.
- No volatilidad.
- Lectura/escritura en el propio circuito.
- Velocidad de operación comparativamente alta.
- Bajo costo por bit.

Por estas razones es la tecnología dominante en memorias USB, tarjetas SD y en la **memoria de programa de los microcontroladores modernos** (incluyendo el ATmega328, que tiene 32 KB de Flash).

**Comparativa de tipos de ROM:**

| Tipo | Programación | Borrado | Granularidad borrado |
|------|-------------|---------|----------------------|
| ROM de máscara | En fábrica | No borrable | — |
| PROM | Usuario, 1 vez | No borrable | — |
| EPROM | Usuario | UV, total | Todo el chip |
| EEPROM | Eléctricamente | Eléctricamente | Byte a byte |
| Flash | Eléctricamente | Eléctricamente | Por bloques |

---

## Expansión de memoria

En muchas aplicaciones la capacidad o el ancho de palabra de un único chip de memoria no son suficientes. Se pueden combinar varios chips para ampliar la memoria total del sistema. Existen dos técnicas:

### Expansión de palabra (ampliación de bits por posición)

Se usa cuando el ancho de palabra de los chips es menor que el del bus de datos del sistema. Los chips se conectan **en paralelo**, compartiendo el mismo bus de direcciones y las mismas señales de control, pero cada uno aporta algunos bits del bus de datos.

**Ejemplo:** el bus de datos del sistema es de 8 bits, pero se tienen chips de 4 bits de ancho (organizados como 1K × 4). Se conectan dos chips en paralelo: uno proporciona D0–D3 y el otro D4–D7. Ambos chips responden a la misma dirección simultáneamente.

<!-- IMAGEN: diagrama de expansión de palabra — dos chips 1K×4 formando una memoria 1K×8 -->

$$\text{Chips necesarios} = \frac{\text{ancho de palabra del sistema}}{\text{ancho de palabra del chip}}$$

### Expansión de capacidad (ampliación de direcciones)

Se usa cuando la cantidad de posiciones de un único chip es menor que la requerida. Los chips se conectan de forma que cada uno responde a un rango diferente de direcciones. Se usa la señal $\overline{CS}$ de cada chip para habilitarlo solo cuando el bus de direcciones está en su rango.

**Ejemplo:** se necesitan 4K posiciones de 8 bits, pero solo se tienen chips de 1K × 8. Se conectan 4 chips: el primero responde a las direcciones 0x000–0x3FF, el segundo a 0x400–0x7FF, y así sucesivamente. Un decodificador (por ejemplo, un 74138) genera las señales $\overline{CS}$ individuales a partir de las líneas de mayor peso del bus de direcciones.

<!-- IMAGEN: diagrama de expansión de capacidad — cuatro chips 1K×8 formando una memoria 4K×8, con decodificador de dirección -->

$$\text{Chips necesarios} = \frac{\text{capacidad total requerida}}{\text{capacidad de cada chip}}$$

### Expansión combinada

Es posible aplicar ambas técnicas simultáneamente para ampliar tanto el ancho de palabra como la cantidad de posiciones. En ese caso:

$$\text{Chips necesarios} = \frac{\text{capacidad total}}{\text{capacidad del chip}} \times \frac{\text{ancho de palabra del sistema}}{\text{ancho de palabra del chip}}$$

---

*AED II — Wels, Ariel | EEST N°1 Vte. López*
