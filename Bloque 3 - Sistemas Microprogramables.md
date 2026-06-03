# Sistemas Microprogramables

**Aplicaciones de Electrónica Digital II**
Escuela de Educación Técnica Nro. 1 — Vte. López

---

## Lógica cableada y lógica programada

En electrónica digital se pueden diferenciar dos grandes enfoques para resolver un problema:

**Lógica cableada:** Para cada aplicación se diseña un circuito específico basado en compuertas lógicas. Una vez construido es muy difícil o imposible de modificar. El comportamiento del sistema queda determinado por el hardware.

**Lógica programada:** Un mismo dispositivo puede resolver distintos problemas simplemente cambiando su programa. El comportamiento del sistema queda determinado por el software que se le carga.

---

## Definición de sistema microprogramable

Un sistema microprogramable es un dispositivo, o conjunto de dispositivos, de propósito general que se programa para resolver distintos problemas. Su versatilidad radica en que basta con cambiar el software para cambiar completamente su función.

Algunas aplicaciones típicas:

- **Informática:** computadoras personales, periféricos (teclado, impresora, escáner).
- **Cálculo:** calculadoras científicas, supercomputadoras.
- **Procesos industriales:** PLCs para control de robots y líneas de montaje.
- **Electrodomésticos:** lavadoras, hornos, televisores, reproductores de audio/video.
- **Comunicaciones:** teléfonos fijos y móviles, equipos de red.
- **Automoción:** control de climatización, ABS, airbags.
- **Supervisión y alarmas:** ascensores, calefacción, alarmas contra incendio y robo.
- **Otros:** instrumentación, electromedicina, sistemas de navegación, tarjetas inteligentes (SUBE, monedero electrónico).

---

## Clasificación de los sistemas microprogramables

Los sistemas microprogramables se clasifican según su grado de integración, capacidad de procesamiento y forma de trabajo:

### Microprocesadores

El sistema está distribuido en varios circuitos integrados. El más importante es el **microprocesador**, que contiene únicamente la Unidad Central de Proceso (CPU). La memoria, los puertos de entrada/salida y demás periféricos son componentes externos que se interconectan mediante buses.

Se utiliza cuando se requieren grandes cantidades de memoria, alta velocidad o se prevén futuras ampliaciones. Ejemplo típico: la computadora personal.

### Microcontroladores

Todo el sistema microprogramable —CPU, memoria, puertos de E/S y periféricos— está integrado en un **único circuito integrado**. Esto reduce el costo y el tamaño del sistema final, aunque su capacidad de procesamiento es menor que la de los microprocesadores. Son ideales para aplicaciones embebidas donde se necesita un procesador compacto y de bajo consumo.

Se encuentran en prácticamente todos los dispositivos electrónicos modernos: electrodomésticos, juguetes, instrumentos, automóviles, etc.

### Dispositivos PLDs

Los PLD (*Programmable Logic Device*) integran una matriz de compuertas lógicas cuya interconexión puede ser programada por el usuario. A diferencia de los microprocesadores y microcontroladores, **no están basados en una CPU** que lee instrucciones de una memoria: su lógica queda grabada en la estructura del dispositivo.

Son adecuados para resolver problemas combinacionales o secuenciales de alta velocidad pero de lógica fija, como decodificadores, máquinas de estado o interfaces de hardware.

---

## Hardware, Software y Firmware

Un sistema microprogramable se compone de tres elementos:

- **Hardware:** la parte física del sistema; el conjunto de circuitos electrónicos.
- **Software:** el conjunto de programas e instrucciones que se cargan en el sistema para indicarle qué hacer. También se denomina software al conjunto de lenguajes utilizados para escribir esos programas.
- **Firmware:** software grabado en la memoria interna del dispositivo que el usuario normalmente no puede modificar. Cumple la función de intermediario entre el hardware y el software de aplicación. En una PC, la BIOS es un ejemplo de firmware.

---

## Arquitectura de un sistema basado en CPU

Todo sistema microprogramable —ya sea basado en microprocesador o en microcontrolador— comparte la misma estructura fundamental. Sus elementos esenciales son:

- Reloj
- CPU (ALU + Registros + Unidad de Control)
- Memoria
- Unidad de Entrada/Salida
- Buses del sistema

### Reloj

El reloj es un generador de señal cuadrada de frecuencia constante, normalmente producida por un cristal de cuarzo (aunque también pueden usarse osciladores RC). Todos los elementos del sistema operan sincronizados con esta señal, que determina la velocidad de trabajo del sistema.

A partir de la señal de reloj se define el **ciclo de máquina**, compuesto por dos fases:

1. **Fase de búsqueda (Fetch):** la CPU lee la próxima instrucción de la memoria y la almacena en el registro correspondiente.
2. **Fase de ejecución (Execute):** la CPU ejecuta la instrucción leída.

Algunos microprocesadores completan una instrucción en un único ciclo de máquina; otros requieren varios ciclos para instrucciones más complejas. La frecuencia del reloj y la cantidad de ciclos por instrucción determinan juntos la velocidad real de procesamiento.

---

### CPU (Unidad Central de Proceso)

Es el elemento más importante del sistema. Se encarga de:

- Interpretar y ejecutar las instrucciones del programa.
- Generar las señales de control para coordinar el resto del sistema.
- Realizar las operaciones aritméticas y lógicas.
- Transferir datos hacia y desde la memoria.

La CPU está formada por tres bloques:

#### Unidad Aritmético-Lógica (ALU)

Es un circuito combinacional que realiza operaciones aritméticas (suma, resta, multiplicación) y lógicas (AND, OR, NOT, XOR), así como desplazamientos de bits. Las operaciones las realiza sobre datos provenientes de los registros internos o de posiciones de memoria, y deposita el resultado en un registro (habitualmente el acumulador).

#### Registros

Los registros son pequeñas memorias internas de alta velocidad donde la CPU almacena datos e instrucciones de manera temporal. Están formados por biestables y su tamaño (en bits) define la arquitectura del procesador (8, 16, 32 o 64 bits).

Los registros más importantes son:

**Registro acumulador:** almacena uno de los operandos de la ALU y recibe el resultado de la operación. Todas las operaciones aritméticas y lógicas pasan por él.

**Registro de estado (flags):** conjunto de biestables que reflejan el resultado de la última operación realizada por la ALU. Los flags más comunes son:

| Flag | Nombre | Se activa cuando... |
|------|--------|---------------------|
| Z | Zero | El resultado de la operación es cero |
| C | Carry | Hubo acarreo en el bit de mayor peso |
| N / S | Negativo / Signo | El resultado es negativo |
| V / OV | Overflow | El resultado excede el rango del tipo de dato |
| I | Interrupt | Las interrupciones globales están habilitadas |

**Registros auxiliares o de propósito general:** registros que el programador puede usar libremente para almacenar datos intermedios. Su cantidad varía según la arquitectura.

**Stack Pointer (SP):** puntero que apunta a la cima de la pila (*stack*). La pila es una zona de memoria con estructura LIFO (*Last In, First Out*): el último dato en entrar es el primero en salir. Se utiliza para guardar la dirección de retorno cuando se llama a una subrutina, y para preservar el estado de los registros durante el manejo de interrupciones.

**Contador de Programa (PC):** registro que contiene la dirección de la próxima instrucción a ejecutar. Se incrementa automáticamente en cada ciclo de fetch. Cuando se produce un salto o llamada a subrutina, este registro se actualiza con la nueva dirección.

#### Unidad de Control (UC)

Gobierna el funcionamiento de todo el sistema. Recibe las instrucciones del programa, las decodifica mediante el **decodificador de instrucciones** y genera las señales de control necesarias para que cada elemento realice su tarea en el momento correcto. También contiene el Contador de Programa.

---

### Memoria

La memoria almacena los programas y los datos que el sistema necesita para funcionar. Se divide en dos zonas funcionales:

- **Memoria de programa:** contiene las instrucciones a ejecutar. No se modifica durante la ejecución. Suele implementarse en memoria no volátil (ROM, Flash).
- **Memoria de datos:** almacena los datos y resultados intermedios del programa. Se modifica constantemente durante la ejecución. Siempre es RAM (volátil).

> No confundir con las memorias de almacenamiento masivo (disco duro, pendrive), que son periféricos externos.

---

### Unidad de Entrada/Salida (E/S)

Permite la comunicación del sistema con el mundo exterior. Está formada por registros que, controlados por los buses del sistema, permiten leer señales del exterior (entradas) o escribir señales hacia afuera (salidas). Su función principal es adaptar las velocidades y niveles lógicos del sistema interno con los de los dispositivos externos.

---

### Buses del sistema

Los elementos del sistema se interconectan mediante **buses**: conjuntos de conductores paralelos que transportan información del mismo tipo. El número de líneas de un bus determina su **ancho** y por ende la cantidad de información que puede transmitirse simultáneamente.

En un sistema basado en CPU existen tres buses fundamentales:

#### Bus de direcciones (*Address Bus*)

Transporta la dirección de la posición de memoria o del registro de E/S que se desea acceder. Es **unidireccional**: solo la CPU pone datos en él.

La cantidad de líneas del bus de direcciones determina la cantidad máxima de posiciones de memoria que el sistema puede direccionar:

$$N_{\text{direcciones}} = 2^{N_{\text{líneas}}}$$

Por ejemplo, un bus de 16 líneas puede direccionar $2^{16} = 65.536$ posiciones. Si cada posición almacena 1 byte, la memoria máxima es 64 KB.

Las líneas se nombran A0 (bit de menor peso) a An (bit de mayor peso).

#### Bus de datos (*Data Bus*)

Transporta los datos entre la CPU, la memoria y los periféricos. Es **bidireccional**: los datos pueden ir en ambas direcciones según se trate de una lectura o escritura. Su ancho define la cantidad de bits que se transfieren en paralelo en cada operación.

Las líneas se nombran D0 a Dn.

#### Bus de control (*Control Bus*)

Transporta las señales de coordinación del sistema: órdenes de lectura/escritura, habilitación de dispositivos, señales de interrupción, reset, etc. Permite que todos los elementos del sistema funcionen en sincronía y sin conflictos en el uso de los buses compartidos.

#### Operaciones de lectura y escritura

**Escritura:** la CPU coloca la dirección en el bus de direcciones, activa la señal de escritura en el bus de control y coloca el dato en el bus de datos. El dispositivo seleccionado almacena el dato.

**Lectura:** la CPU coloca la dirección en el bus de direcciones y activa la señal de lectura en el bus de control. El dispositivo seleccionado deposita su contenido en el bus de datos, y la CPU lo lee. La operación de lectura es **no destructiva**: el dato sigue almacenado en la memoria después de ser leído.

---

## Arquitecturas Von Neumann y Harvard

La relación entre la CPU y la memoria puede organizarse de dos maneras distintas:

### Arquitectura Von Neumann

La CPU se conecta a una **única memoria** mediante un **único juego de buses**. Tanto las instrucciones del programa como los datos se almacenan en el mismo espacio de memoria y viajan por el mismo bus.

<!-- IMAGEN: diagrama de bloques Von Neumann (CPU — bus único — memoria única) -->

**Limitaciones:**
- El bus único genera un cuello de botella: mientras la CPU busca una instrucción no puede acceder a datos, y viceversa.
- El tamaño de las instrucciones está condicionado por el ancho del bus de datos.

Es la arquitectura típica de los microprocesadores de uso general (PCs).

### Arquitectura Harvard

La CPU se conecta a **dos memorias separadas** mediante **dos juegos de buses independientes**: uno para instrucciones y otro para datos.

<!-- IMAGEN: diagrama de bloques Harvard (CPU — bus de programa — memoria de programa / bus de datos — memoria de datos) -->

**Ventajas:**
- La CPU puede leer la próxima instrucción y acceder a datos **simultáneamente**, eliminando el cuello de botella.
- El ancho del bus de programa puede ser diferente al del bus de datos, permitiendo optimizar ambos de forma independiente.
- Aumenta significativamente la velocidad de procesamiento.

Es la arquitectura utilizada por la mayoría de los **microcontroladores**, incluyendo la familia AVR (ATmega).

---

## Software: instrucciones y lenguajes de programación

### Formato de una instrucción

Las instrucciones que ejecuta la CPU tienen dos partes:

```
┌──────────────────────┬──────────────────────┐
│   Código de          │      Operando        │
│   operación          │   (puede no estar)   │
└──────────────────────┴──────────────────────┘
```

- **Código de operación:** indica qué hacer (sumar, restar, mover un dato, comparar, saltar...).
- **Operando:** indica con qué dato realizar la operación, o la dirección de memoria donde se encuentra ese dato.

### Tipos de instrucciones

- **Aritméticas:** suma, resta, multiplicación, división.
- **Lógicas:** AND, OR, NOT, XOR.
- **Desplazamiento:** rotación y corrimiento de bits.
- **Transferencia de datos:** mover datos entre registros, entre registros y memoria, o entre registros y puertos E/S.
- **Salto:** condicionales (ejecutan un salto solo si se cumple una condición de los flags) e incondicionales (saltan siempre).
- **Control:** inicialización, detención, no-operación (NOP), habilitación/deshabilitación de interrupciones.

### Lenguajes de programación

Para que un programador pueda escribir el programa, y para que luego ese programa pueda ser ejecutado por la CPU, existen distintos niveles de lenguaje:

#### Lenguaje máquina (código máquina)

Es el único lenguaje que la CPU entiende directamente: secuencias de bits (ceros y unos) que representan instrucciones y datos. Aunque es el más eficiente, es extremadamente difícil de escribir y leer por un ser humano.

#### Lenguaje ensamblador (*Assembler*)

Reemplaza los códigos binarios por **mnemónicos**: abreviaturas en inglés que recuerdan la función de cada instrucción (`MOV`, `ADD`, `JMP`, etc.). Las direcciones de memoria pueden referenciarse con etiquetas simbólicas. Es específico de cada arquitectura.

Un programa llamado **ensamblador** traduce el código escrito en lenguaje ensamblador al código máquina correspondiente.

#### Lenguajes de alto nivel

Son los más cercanos al lenguaje humano y los más fáciles de escribir y mantener. No están atados a una arquitectura específica, lo que permite reutilizar el código en distintos sistemas. Algunos ejemplos: C, C++, Python, Java, Basic.

Para ejecutarse, deben ser traducidos a código máquina mediante un **compilador** (que traduce todo el programa de una vez) o un **intérprete** (que traduce y ejecuta instrucción por instrucción).

En sistemas embebidos, el lenguaje más utilizado es **C**, por su combinación de legibilidad, eficiencia y acceso a bajo nivel de hardware.

---

## El ATmega328 en este curso

El microcontrolador utilizado en este curso es el **ATmega328P**, fabricado por Microchip (familia AVR). Se trabaja sobre placas Arduino Nano como plataforma de desarrollo, pero **sin utilizar el framework ni las bibliotecas de Arduino**: se programa directamente en C, accediendo a los registros del hardware.

Características principales:

| Característica | Valor |
|---|---|
| Arquitectura | Harvard, RISC de 8 bits |
| Frecuencia máxima | 20 MHz |
| Memoria de programa | 32 KB Flash |
| Memoria de datos (RAM) | 2 KB SRAM |
| Memoria no volátil de datos | 1 KB EEPROM |
| Puertos de E/S digitales | Hasta 23 pines |
| Periféricos integrados | Timers, UART, SPI, I²C, ADC (10 bits), Watchdog |

Al ser una arquitectura Harvard, el ATmega328 tiene buses separados para memoria de programa (Flash) y memoria de datos (SRAM), lo que le permite ejecutar la mayoría de las instrucciones en un solo ciclo de reloj.

En los bloques siguientes se verá en detalle cómo programar este microcontrolador: cómo se organizan sus registros internos, cómo se configuran sus puertos y cómo se utilizan sus periféricos.

---

*AED II — Wels, Ariel | EEST N°1 Vte. López*
