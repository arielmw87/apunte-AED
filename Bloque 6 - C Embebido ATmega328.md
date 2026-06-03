# Programación de Microcontroladores en C

**Aplicaciones de Electrónica Digital II**
Escuela de Educación Técnica Nro. 1 — Vte. López

---

## C estándar vs. C embebido

En el Bloque 5 aprendimos C para correr programas en una PC. Al programar un microcontrolador, el lenguaje es el mismo pero el contexto cambia completamente:

| | C en PC | C en microcontrolador |
|---|---|---|
| Sistema operativo | Sí (Windows, Linux) | No hay |
| Entrada/salida | Teclado, pantalla (`printf`, `scanf`) | Pines físicos del chip |
| Memoria | Abundante (GB) | Escasa (KB) |
| Punto de entrada | `main()` retorna cuando termina | `main()` nunca debe retornar — bucle infinito |
| Bibliotecas estándar | `<stdio.h>`, `<math.h>`, etc. | Reemplazadas por bibliotecas del fabricante |

En lugar de `#include <stdio.h>` usaremos las bibliotecas de AVR:

```c
#include <avr/io.h>        // definiciones de registros y pines del ATmega
#include <util/delay.h>    // función _delay_ms() para retardos
#include <avr/interrupt.h> // manejo de interrupciones
```

### Estructura básica de un programa embebido

```c
#include <avr/io.h>
#include <util/delay.h>

int main(void) {

    // --- INICIALIZACIÓN (se ejecuta una sola vez al encender) ---
    // Configurar puertos, registros, periféricos...

    // --- BUCLE PRINCIPAL (se ejecuta para siempre) ---
    while (1) {
        // lógica de la aplicación
    }

    return 0; // nunca se llega aquí, pero el compilador lo requiere
}
```

Esta estructura de **inicialización + bucle infinito** es el patrón fundamental de todo programa embebido. El microcontrolador no tiene un sistema operativo que lo controle: es el programa quien toma el control total del hardware desde el primer momento.

---

## Los puertos de E/S del ATmega328

El ATmega328 tiene tres puertos de E/S digitales: **PORTB**, **PORTC** y **PORTD**, cada uno con hasta 8 pines. Cada puerto se controla mediante tres registros de 8 bits:

| Registro | Función |
|----------|---------|
| `DDRx` | *Data Direction Register* — define si cada pin es **entrada (0)** o **salida (1)** |
| `PORTx` | Si el pin es **salida**: escribe el nivel lógico (0 = LOW, 1 = HIGH). Si el pin es **entrada**: activa (1) o desactiva (0) la resistencia de pull-up interna |
| `PINx` | *Port Input Pins* — permite **leer** el estado actual de los pines (solo lectura) |

Donde `x` es `B`, `C` o `D` según el puerto.

<!-- IMAGEN: mapa de pines del Arduino Nano con la correspondencia entre pin físico y puerto/bit del ATmega (PD0..PD7, PB0..PB5, PC0..PC5) -->

### Correspondencia Arduino Nano — ATmega328

| Pin Arduino | Puerto ATmega | Bit |
|:-----------:|:-------------:|:---:|
| D0 | PORTD | 0 |
| D1 | PORTD | 1 |
| D2 | PORTD | 2 |
| D3 | PORTD | 3 |
| D4 | PORTD | 4 |
| D5 | PORTD | 5 |
| D6 | PORTD | 6 |
| D7 | PORTD | 7 |
| D8 | PORTB | 0 |
| D9 | PORTB | 1 |
| D10 | PORTB | 2 |
| D11 | PORTB | 3 |
| D12 | PORTB | 4 |
| D13 | PORTB | 5 |
| A0 | PORTC | 0 |
| A1 | PORTC | 1 |
| A2 | PORTC | 2 |
| A3 | PORTC | 3 |
| A4 | PORTC | 4 |
| A5 | PORTC | 5 |

---

## Operadores de manejo de bits

Para configurar y controlar los registros del microcontrolador necesitamos modificar bits individuales sin afectar los demás. Para eso usamos los **operadores bitwise** (a nivel de bits):

| Operador | Nombre | Operación |
|:---:|---|---|
| `&` | AND bit a bit | El bit resultado es 1 solo si ambos operandos tienen 1 |
| `\|` | OR bit a bit | El bit resultado es 1 si al menos uno de los operandos tiene 1 |
| `^` | XOR bit a bit | El bit resultado es 1 si los operandos son distintos |
| `~` | NOT bit a bit | Invierte todos los bits |
| `<<` | Desplazamiento a la izquierda | Desplaza los bits hacia la izquierda N posiciones |
| `>>` | Desplazamiento a la derecha | Desplaza los bits hacia la derecha N posiciones |

### Desplazamiento de bits

El operador `<<` es clave para crear **máscaras**: valores que tienen un único bit en 1 en la posición deseada.

```
1 << 0  →  0b00000001  →  0x01   (bit 0)
1 << 1  →  0b00000010  →  0x02   (bit 1)
1 << 3  →  0b00001000  →  0x08   (bit 3)
1 << 7  →  0b10000000  →  0x80   (bit 7)
```

En la biblioteca `<avr/io.h>` los bits de cada registro ya tienen nombres definidos. Por ejemplo, `PD3` es el bit 3 del puerto D, y su valor es `3`. Entonces `(1 << PD3)` genera la máscara para ese bit.

---

## Técnicas de enmascarado

### Poner un bit en 1 (SET)

Se usa OR con una máscara que tiene 1 en la posición deseada:

```c
PORTD = PORTD | (1 << PD3);   // pone el bit 3 de PORTD en 1
PORTD |= (1 << PD3);           // forma abreviada (equivalente)
```

Ejemplo: `PORTD = 0b00000000`, aplicar máscara `0b00001000`:
```
  0 0 0 0 0 0 0 0   (PORTD original)
| 0 0 0 0 1 0 0 0   (máscara: 1 << PD3)
= 0 0 0 0 1 0 0 0   (resultado: solo el bit 3 cambió)
```

### Poner un bit en 0 (CLEAR)

Se usa AND con el complemento de la máscara (`~`):

```c
PORTD = PORTD & ~(1 << PD3);  // pone el bit 3 de PORTD en 0
PORTD &= ~(1 << PD3);          // forma abreviada
```

Ejemplo: `PORTD = 0b11111111`, aplicar máscara:
```
  1 1 1 1 1 1 1 1   (PORTD original)
& 1 1 1 1 0 1 1 1   (~(1 << PD3): todos 1 excepto el bit 3)
= 1 1 1 1 0 1 1 1   (resultado: solo el bit 3 se puso en 0)
```

### Invertir un bit (TOGGLE)

Se usa XOR con la máscara:

```c
PORTD ^= (1 << PD3);   // invierte el bit 3 de PORTD
```

### Leer el estado de un bit

Se usa AND con la máscara y se compara con cero:

```c
if (PIND & (1 << PD2)) {
    // el bit 2 de PIND está en 1 (pin en HIGH)
}

if (!(PIND & (1 << PD2))) {
    // el bit 2 de PIND está en 0 (pin en LOW)
}
```

---

## Configuración de puertos (TP1)

### Configurar un pin como salida

Para usar un pin como salida, se pone en 1 el bit correspondiente en `DDRx`:

```c
DDRD |= (1 << PD5);    // PD5 (pin D5) como salida
```

### Configurar un pin como entrada

Para usar un pin como entrada, se pone en 0 el bit correspondiente en `DDRx`:

```c
DDRD &= ~(1 << PD2);   // PD2 (pin D2) como entrada
```

### Activar la resistencia de pull-up interna

Cuando un pin es entrada, se puede activar su resistencia pull-up interna poniéndolo en 1 en `PORTx`. Esto evita que el pin "flote" cuando no hay nada conectado:

```c
DDRD  &= ~(1 << PD2);  // PD2 como entrada
PORTD |=  (1 << PD2);  // activa pull-up interno en PD2
```

Con pull-up activo, la lógica se **invierte**: el pin lee 1 cuando el pulsador está suelto y 0 cuando está presionado (porque el pulsador conecta el pin a GND).

### Escribir en un pin de salida

```c
PORTD |=  (1 << PD5);  // pone PD5 en HIGH (LED encendido)
PORTD &= ~(1 << PD5);  // pone PD5 en LOW  (LED apagado)
```

### Leer un pin de entrada

```c
if (!(PIND & (1 << PD2))) {
    // pulsador presionado (con pull-up: pulsador conecta a GND → lee 0)
}
```

### Ejemplo completo — TP1: un pulsador controla un LED

```c
#include <avr/io.h>

int main(void) {

    // Inicialización
    DDRD |=  (1 << PD5);   // PD5 (D5) como salida → LED
    DDRD &= ~(1 << PD2);   // PD2 (D2) como entrada → pulsador
    PORTD |= (1 << PD2);   // activar pull-up en PD2

    while (1) {
        if (!(PIND & (1 << PD2))) {
            // pulsador presionado → encender LED
            PORTD |= (1 << PD5);
        } else {
            // pulsador suelto → apagar LED
            PORTD &= ~(1 << PD5);
        }
    }

    return 0;
}
```

---

## Retardos

La función `_delay_ms(n)` detiene la ejecución durante `n` milisegundos. Es un retardo **bloqueante**: mientras espera, el programa no hace nada más.

```c
#include <util/delay.h>

_delay_ms(500);    // espera 500 ms
_delay_us(100);    // espera 100 microsegundos
```

> **Importante:** para que `_delay_ms` funcione correctamente, el compilador debe saber a qué frecuencia corre el microcontrolador. Esto se configura con la constante `F_CPU` antes del include, o en las opciones del compilador:
> ```c
> #define F_CPU 16000000UL   // 16 MHz (Arduino Nano)
> #include <util/delay.h>
> ```

Los retardos son útiles para efectos simples (parpadeo, secuencias de LEDs), pero tienen una desventaja importante: **bloquean todo el programa**. Mientras espera, el microcontrolador no puede leer pulsadores, actualizar displays ni hacer otra cosa. Para aplicaciones más complejas se usan los **timers con interrupciones** (TP5).

---

## Escribir en el puerto completo

Cuando se controlan varios pines simultáneamente (por ejemplo, 8 LEDs o los 7 segmentos de un display), conviene escribir en el registro completo en lugar de bit a bit:

```c
PORTD = 0b00110101;   // escribe el valor completo en el puerto D
PORTB = 0x3F;         // escribe 0x3F en el puerto B (en hexadecimal)
```

> **Precaución:** esto sobreescribe **todos** los bits del puerto. Si algunos pines están configurados como entradas (con pull-up), sobreescribir el registro afectará también a esos bits. Hay que tener en cuenta qué pines se usan para qué.

---

## Display de 7 segmentos (TP4)

Un display de 7 segmentos tiene 7 LEDs (a, b, c, d, e, f, g) y opcionalmente un punto decimal (dp), que se encienden en distintas combinaciones para mostrar un dígito.

<!-- IMAGEN: disposición de los segmentos a-g en el display y su numeración -->

Existen dos tipos:
- **Ánodo común:** el cátodo de cada segmento se conecta al pin del µC. Para encender un segmento se pone el pin en **LOW (0)**.
- **Cátodo común:** el ánodo de cada segmento se conecta al pin del µC. Para encender un segmento se pone el pin en **HIGH (1)**.

Si conectamos los segmentos a, b, c, d, e, f, g del display a los bits 0..6 del PORTD (cátodo común), la tabla de patrones para mostrar los dígitos 0 al 9 es:

| Dígito | g | f | e | d | c | b | a | Hex |
|:------:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:---:|
| 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | `0x3F` |
| 1 | 0 | 0 | 0 | 0 | 1 | 1 | 0 | `0x06` |
| 2 | 1 | 0 | 1 | 1 | 0 | 1 | 1 | `0x5B` |
| 3 | 1 | 0 | 0 | 1 | 1 | 1 | 1 | `0x4F` |
| 4 | 1 | 1 | 0 | 0 | 1 | 1 | 0 | `0x66` |
| 5 | 1 | 1 | 0 | 1 | 1 | 0 | 1 | `0x6D` |
| 6 | 1 | 1 | 1 | 1 | 1 | 0 | 1 | `0x7D` |
| 7 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | `0x07` |
| 8 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | `0x7F` |
| 9 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | `0x6F` |

En el código se almacena esta tabla en un arreglo y se indexa con el dígito a mostrar:

```c
#include <avr/io.h>

// Patrones para dígitos 0-9 (cátodo común, segmentos en PORTD bits 0..6)
const uint8_t digitos[10] = {
    0x3F, // 0
    0x06, // 1
    0x5B, // 2
    0x4F, // 3
    0x66, // 4
    0x6D, // 5
    0x7D, // 6
    0x07, // 7
    0x7F, // 8
    0x6F  // 9
};

int main(void) {
    DDRD = 0x7F;          // PD0..PD6 como salidas (segmentos a-g)
    PORTD = digitos[0];   // mostrar el dígito 0

    while (1) {
        // la lógica de conteo iría aquí
    }
    return 0;
}
```

---

## Timers e interrupciones (TP5)

### El problema del código bloqueante

Con `_delay_ms()` el microcontrolador se queda "dormido" esperando. No puede atender pulsadores ni actualizar displays mientras espera. Esto es el **código bloqueante**.

La solución son los **timers con interrupciones**: el timer cuenta en segundo plano y cuando llega a un valor configurado, interrumpe al programa principal para ejecutar una función especial (ISR).

### Interrupciones

Una **interrupción** es una señal que detiene temporalmente la ejecución del programa principal para atender un evento (el timer llegó al valor, llegó un dato por UART, cambió un pin, etc.). Al terminar la función de interrupción, el programa principal continúa desde donde fue interrumpido.

Para usar interrupciones:

1. Configurar la fuente de interrupción (timer, pin externo, etc.).
2. Definir la función ISR (*Interrupt Service Routine*) que se ejecutará.
3. Habilitar las interrupciones globales con `sei()`.

```c
#include <avr/io.h>
#include <avr/interrupt.h>

// Función ISR: se ejecuta automáticamente cuando ocurre la interrupción
ISR(TIMER0_COMPA_vect) {
    // código que se ejecuta cada 1 ms (modo CTC, comparación con OCR0A)
}

int main(void) {
    // configurar el timer...

    sei();    // habilitar interrupciones globales

    while (1) {
        // programa principal — sin delays bloqueantes
    }
    return 0;
}
```

La función ISR **no se llama** desde el programa: la llama automáticamente el hardware cuando ocurre el evento. El argumento de ISR es el **vector de interrupción** que indica la fuente.

### Vectores de interrupción del ATmega328

Los principales vectores disponibles son:

```c
INT0_vect          // Interrupción externa en pin INT0 (D2)
INT1_vect          // Interrupción externa en pin INT1 (D3)
PCINT0_vect        // Cambio de pin en PORTB
PCINT1_vect        // Cambio de pin en PORTC
PCINT2_vect        // Cambio de pin en PORTD
TIMER0_OVF_vect    // Desbordamiento del Timer 0
TIMER0_COMPA_vect  // Comparación A del Timer 0
TIMER1_OVF_vect    // Desbordamiento del Timer 1
TIMER1_COMPA_vect  // Comparación A del Timer 1
TIMER2_OVF_vect    // Desbordamiento del Timer 2
USART_RX_vect      // Recepción UART completa
ADC_vect           // Conversión ADC completa
TWI_vect           // I²C (Two Wire Interface)
SPI_STC_vect       // SPI transferencia completa
```

### Configuración del Timer 0 en modo CTC

El modo CTC (*Clear Timer on Compare Match*) hace que el contador se reinicie automáticamente a 0 cada vez que alcanza el valor cargado en el registro `OCR0A`, generando la interrupción `TIMER0_COMPA_vect`. Esto permite obtener intervalos de tiempo exactos y predecibles sin depender del período de desbordamiento.

El valor de `OCR0A` se calcula con la fórmula:

$$OCR0A = \frac{F_{CPU}}{prescaler \times f_{interrupción}} - 1$$

Para obtener una interrupción cada **1 ms** (1000 Hz) con el ATmega a 16 MHz y preescalador 64:

$$OCR0A = \frac{16.000.000}{64 \times 1000} - 1 = 250 - 1 = 249$$

```c
// Configurar Timer 0 en modo CTC — interrupción cada 1 ms
// F_CPU = 16 MHz, preescalador = 64, OCR0A = 249
TCCR0A = (1 << WGM01);                 // modo CTC
TCCR0B = (1 << CS01) | (1 << CS00);   // preescalador 64
OCR0A  = 249;                          // comparación: interrupt cada 1 ms

// Habilitar interrupción por comparación A
TIMSK0 = (1 << OCIE0A);
```

En modo CTC el contador no desborda: sube de 0 a OCR0A, genera la interrupción y vuelve a 0. El período de la interrupción es exactamente 1 ms, lo que hace muy simple llevar cuentas de tiempo en la ISR (cada llamada = 1 ms).

### Ejemplo — parpadeo de LED sin código bloqueante

La ISR se ejecuta cada 1 ms. Contando 500 llamadas se obtiene un período de 500 ms → el LED parpadea a 1 Hz (500 ms encendido, 500 ms apagado).

```c
#define F_CPU 16000000UL
#include <avr/io.h>
#include <avr/interrupt.h>

volatile uint16_t contador_ms = 0;

ISR(TIMER0_COMPA_vect) {           // se ejecuta cada 1 ms
    contador_ms++;
    if (contador_ms >= 500) {      // 500 ms
        contador_ms = 0;
        PORTB ^= (1 << PB5);       // toggle LED (pin D13)
    }
}

int main(void) {
    DDRB |= (1 << PB5);            // D13 como salida

    // Timer 0 — modo CTC — 1 ms
    TCCR0A = (1 << WGM01);
    TCCR0B = (1 << CS01) | (1 << CS00);   // preescalador 64
    OCR0A  = 249;
    TIMSK0 = (1 << OCIE0A);

    sei();

    while (1) {
        // el programa principal puede hacer otras cosas sin bloqueos
    }
    return 0;
}
```

> **La palabra clave `volatile`:** cuando una variable se modifica dentro de una ISR y se usa fuera de ella, **debe declararse `volatile`**. Esto le indica al compilador que no optimice los accesos a esa variable, ya que puede cambiar en cualquier momento por la interrupción.

---

## Multiplexado de displays (TP6)

Cuando se usan varios displays de 7 segmentos, conectar cada uno con 7 pines propios requeriría demasiados pines del microcontrolador. La solución es el **multiplexado**: compartir los 7 pines de segmentos entre todos los displays y activar un display a la vez, rotando muy rápido (>50 Hz) para que el ojo humano perciba todos encendidos simultáneamente.

<!-- IMAGEN: esquema de multiplexado de 4 displays — pines de segmentos compartidos, pines de selección individuales -->

### Principio de funcionamiento

1. Activar display 1: encender su pin de selección (common), escribir el dígito 1 en los segmentos.
2. Pequeña espera (~2ms).
3. Apagar display 1, activar display 2: escribir el dígito 2 en los segmentos.
4. Pequeña espera (~2ms).
5. Repetir para displays 3 y 4.
6. Volver al display 1.

Si la rotación es más rápida que ~20 ms por display (50 Hz), el parpadeo es imperceptible.

### Implementación con Timer 0

El multiplexado se implementa en la ISR del Timer 0, sin bloquear el programa principal:

```c
#define F_CPU 16000000UL
#include <avr/io.h>
#include <avr/interrupt.h>

// Patrones de dígitos (cátodo común)
const uint8_t digitos[10] = {
    0x3F, 0x06, 0x5B, 0x4F, 0x66,
    0x6D, 0x7D, 0x07, 0x7F, 0x6F
};

// Pines de selección de cada display (en PORTB)
#define SEL0  PB0
#define SEL1  PB1
#define SEL2  PB2
#define SEL3  PB3

volatile uint8_t display_actual = 0;
uint8_t valores[4] = {1, 2, 3, 4};  // dígitos a mostrar en cada display

// ISR cada 1 ms — rota entre los 4 displays
// Cada display se muestra 1 ms → frecuencia de refresco = 1/(4×1ms) = 250 Hz
ISR(TIMER0_COMPA_vect) {
    // Apagar todos los displays
    PORTB &= ~((1<<SEL0)|(1<<SEL1)|(1<<SEL2)|(1<<SEL3));

    // Escribir el dígito del display actual en los segmentos
    PORTD = digitos[valores[display_actual]];

    // Activar solo el display actual
    PORTB |= (1 << (SEL0 + display_actual));

    // Avanzar al siguiente display
    display_actual++;
    if (display_actual >= 4) display_actual = 0;
}

int main(void) {
    DDRD = 0x7F;                    // PD0..PD6 como salidas (segmentos)
    DDRB |= (1<<SEL0)|(1<<SEL1)|(1<<SEL2)|(1<<SEL3);  // selección

    // Timer 0 — modo CTC — 1 ms
    TCCR0A = (1 << WGM01);
    TCCR0B = (1 << CS01) | (1 << CS00);   // preescalador 64
    OCR0A  = 249;
    TIMSK0 = (1 << OCIE0A);

    sei();

    while (1) {
        // el programa principal puede modificar valores[] en cualquier momento
    }
    return 0;
}
```

---

## Eliminación de rebote por software

Los pulsadores mecánicos "rebotan" al presionarse: hacen contacto y lo rompen varias veces en pocos milisegundos antes de estabilizarse. Esto puede interpretarse como múltiples pulsaciones.

### Método bloqueante (simple, para aprender)

Esperar un tiempo mayor que el rebote (~20ms) después de detectar el primer flanco:

```c
if (!(PIND & (1 << PD2))) {         // detectar flanco de bajada
    _delay_ms(20);                   // esperar que termine el rebote
    if (!(PIND & (1 << PD2))) {     // verificar que sigue presionado
        // acción al presionar
    }
}
```

### Método por detección de flanco (no bloqueante, TP5)

Se guarda el estado anterior del pin y se actúa solo cuando hay un **cambio de estado** (de 1 a 0 = flanco de bajada, de 0 a 1 = flanco de subida). El conteo de rebotes se hace en la ISR del timer:

```c
volatile uint8_t estado_anterior = 1;   // con pull-up, inicial = 1 (suelto)
volatile uint8_t contador_rebote = 0;

// ISR cada 1 ms — muestreo del pulsador
ISR(TIMER0_COMPA_vect) {
    uint8_t estado_actual = (PIND >> PD2) & 1;

    if (estado_actual != estado_anterior) {
        contador_rebote++;
        if (contador_rebote >= 20) {     // 20 lecturas estables = 20 ms
            estado_anterior = estado_actual;
            contador_rebote = 0;
            if (estado_actual == 0) {
                // flanco de bajada confirmado → pulsador presionado
            }
        }
    } else {
        contador_rebote = 0;
    }
}
```

---

## Resumen de registros del ATmega328 usados en los TPs

| Registro | Función |
|----------|---------|
| `DDRB`, `DDRC`, `DDRD` | Dirección de datos de cada puerto |
| `PORTB`, `PORTC`, `PORTD` | Escritura de salidas / pull-ups de entradas |
| `PINB`, `PINC`, `PIND` | Lectura del estado de los pines |
| `TCCR0A`, `TCCR0B` | Control del Timer 0 (modo y preescalador) |
| `TCCR1A`, `TCCR1B` | Control del Timer 1 |
| `TIMSK0` | Habilitación de interrupciones del Timer 0 |
| `TIMSK1` | Habilitación de interrupciones del Timer 1 |
| `TCNT0` | Valor actual del contador del Timer 0 |
| `OCR0A`, `OCR0B` | Registros de comparación del Timer 0 |
| `SREG` | Registro de estado (flags de la CPU, incluye el bit I de interrupciones globales) |

> `sei()` pone en 1 el bit I del SREG (habilita interrupciones globales).
> `cli()` lo pone en 0 (deshabilita interrupciones globales).

---

*AED II — Wels, Ariel | EEST N°1 Vte. López*
