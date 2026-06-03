# Introducción al Lenguaje C

**Aplicaciones de Electrónica Digital II**
Escuela de Educación Técnica Nro. 1 — Vte. López

---

## Del diagrama de flujo al código

En el bloque anterior aprendimos a representar algoritmos con diagramas de flujo. Ahora vamos a traducir esos diagramas a un lenguaje que la computadora puede compilar y ejecutar: el **lenguaje C**.

C es un lenguaje de propósito general creado en los años 70. Es el lenguaje más usado en sistemas embebidos y microcontroladores por dos razones principales: es **eficiente** (genera código compacto y rápido) y ofrece **acceso directo al hardware** (registros, puertos, memoria). Todo lo que aprendamos en este bloque se va a aplicar directamente en la programación del microcontrolador.

---

## Estructura de un programa en C

Todo programa en C tiene la siguiente estructura mínima:

```c
#include <stdio.h>      // Incluir biblioteca estándar de entrada/salida

int main(void) {        // Función principal — el programa empieza aquí
    // instrucciones
    return 0;           // Indicar que el programa terminó correctamente
}
```

**Elementos obligatorios:**

- `#include <stdio.h>`: incluye la biblioteca que permite usar `printf` y `scanf` (entrada y salida por consola). En programas para microcontrolador esto cambiará, pero por ahora la usamos para probar en la PC.
- `int main(void)`: función principal. Todo programa en C debe tener exactamente una función `main`. La ejecución empieza en la primera línea de `main` y termina cuando se llega al `return`.
- `{ }`: las llaves definen un **bloque** de código. Todo lo que está entre `{` y `}` pertenece a ese bloque.
- `;`: cada instrucción termina con punto y coma. Olvidarlo es uno de los errores más frecuentes.
- `// comentario`: el compilador ignora todo lo que está a la derecha de `//` en esa línea. Los comentarios sirven para explicar el código.

---

## Variables y tipos de datos

Antes de usar una variable en C hay que **declararla**: indicar su nombre y el tipo de dato que va a almacenar.

```c
tipo nombre;
tipo nombre = valor_inicial;
```

### Tipos de datos básicos

| Tipo | Tamaño típico | Rango aproximado | Uso |
|------|:---:|---|---|
| `int` | 2 o 4 bytes | −32.768 a 32.767 (2 bytes) | Números enteros |
| `unsigned int` | 2 o 4 bytes | 0 a 65.535 (2 bytes) | Enteros sin signo |
| `float` | 4 bytes | ±3.4 × 10³⁸ | Números decimales (simple precisión) |
| `double` | 8 bytes | ±1.7 × 10³⁰⁸ | Números decimales (doble precisión) |
| `char` | 1 byte | −128 a 127 | Un carácter ASCII o un entero de 8 bits |
| `unsigned char` | 1 byte | 0 a 255 | Byte sin signo — muy usado en embebidos |

> En programación de microcontroladores AVR, el tipo más usado es `uint8_t` (equivalente a `unsigned char`, siempre 8 bits). Por ahora trabajamos con `int` y `float` para mayor comodidad.

### Ejemplos de declaración

```c
int edad;               // declara una variable entera sin valor inicial
int contador = 0;       // declara e inicializa en 0
float temperatura = 25.5;
char letra = 'A';
unsigned int suma = 0;
```

### Reglas para nombrar variables

- Solo letras, números y guion bajo `_`. No puede empezar con un número.
- C distingue mayúsculas de minúsculas: `Temperatura` y `temperatura` son variables distintas.
- No se pueden usar palabras reservadas del lenguaje (`int`, `if`, `while`, `return`, etc.).
- Elegir nombres descriptivos: `temperatura` es mejor que `t` o `x`.

---

## Operadores

### Aritméticos

| Operador | Operación | Ejemplo | Resultado |
|:---:|---|---|:---:|
| `+` | Suma | `3 + 2` | `5` |
| `-` | Resta | `5 - 3` | `2` |
| `*` | Multiplicación | `4 * 3` | `12` |
| `/` | División | `7 / 2` | `3` (entera si ambos son `int`) |
| `%` | Módulo (resto) | `7 % 2` | `1` |

> **Atención con la división entera:** en C, dividir dos `int` descarta los decimales. `7 / 2` da `3`, no `3.5`. Para obtener el decimal hay que usar `float`: `7.0 / 2` da `3.5`.

### Relacionales

| Operador | Significado |
|:---:|---|
| `==` | Igual (doble signo — no confundir con `=` de asignación) |
| `!=` | Distinto |
| `>` | Mayor que |
| `<` | Menor que |
| `>=` | Mayor o igual |
| `<=` | Menor o igual |

### Lógicos

| Operador | Significado |
|:---:|---|
| `&&` | AND lógico |
| `\|\|` | OR lógico |
| `!` | NOT lógico |

### Asignación

```c
x = 5;          // asigna 5 a x
x = x + 1;      // incrementa x en 1
x += 1;         // equivalente al anterior (forma abreviada)
x++;            // también equivalente — incremento en 1
x--;            // decremento en 1
```

---

## Entrada y salida por consola

Para los ejercicios en PC usamos dos funciones de `<stdio.h>`:

### `printf` — mostrar datos en pantalla

```c
printf("Hola mundo\n");             // imprime texto
printf("El resultado es %d\n", x); // imprime texto + valor de x (entero)
printf("Temperatura: %.2f\n", t);  // imprime t con 2 decimales
```

Los especificadores de formato más comunes:

| Especificador | Tipo |
|:---:|---|
| `%d` | Entero (`int`) |
| `%f` | Decimal (`float` o `double`) |
| `%.2f` | Decimal con 2 cifras decimales |
| `%c` | Carácter (`char`) |
| `%s` | Cadena de texto |

El `\n` al final provoca un salto de línea.

### `scanf` — leer datos del teclado

```c
int x;
scanf("%d", &x);    // lee un entero y lo guarda en x

float t;
scanf("%f", &t);    // lee un decimal y lo guarda en t
```

> El `&` antes del nombre de la variable es obligatorio en `scanf`. Indica la **dirección de memoria** donde se debe guardar el dato. Olvidarlo causa comportamiento impredecible.

---

## Estructuras de control

### Secuencia

Las instrucciones se ejecutan en orden, de arriba a abajo. No requiere ninguna sintaxis especial.

```c
int a, b, resultado;
scanf("%d", &a);
scanf("%d", &b);
resultado = a + b;
printf("Resultado: %d\n", resultado);
```

### Decisión: `if` / `else`

```c
if (condición) {
    // se ejecuta si la condición es verdadera
} else {
    // se ejecuta si la condición es falsa (opcional)
}
```

Para condiciones encadenadas:

```c
if (temperatura > 26) {
    printf("Hace calor\n");
} else if (temperatura < 22) {
    printf("Hace frio\n");
} else {
    printf("Temperatura agradable\n");
}
```

> **Errores frecuentes:**
> - Usar `=` en lugar de `==` dentro del `if`: `if (x = 5)` asigna 5 a x y siempre es verdadero. Lo correcto es `if (x == 5)`.
> - Olvidar las llaves `{}` cuando el bloque tiene más de una instrucción.

### Repetición: `while`

La condición se evalúa **antes** de cada iteración. Si es falsa desde el principio, el cuerpo no se ejecuta.

```c
while (condición) {
    // cuerpo del bucle
}
```

```c
int contador = 1;
while (contador <= 10) {
    printf("%d\n", contador);
    contador++;
}
```

### Repetición: `do-while`

El cuerpo se ejecuta **al menos una vez**; la condición se evalúa al final.

```c
do {
    // cuerpo del bucle
} while (condición);
```

```c
int valor;
do {
    printf("Ingrese un numero positivo: ");
    scanf("%d", &valor);
} while (valor <= 0);
```

### Repetición: `for`

Forma compacta de escribir un bucle cuando se conoce de antemano la cantidad de iteraciones.

```c
for (inicialización; condición; actualización) {
    // cuerpo del bucle
}
```

```c
for (int i = 1; i <= 10; i++) {
    printf("%d\n", i);
}
```

Equivale exactamente a:

```c
int i = 1;
while (i <= 10) {
    printf("%d\n", i);
    i++;
}
```

---

## Equivalencia entre pseudocódigo y C

| Pseudocódigo (PSeInt) | C |
|---|---|
| `Leer variable` | `scanf("%d", &variable);` |
| `Escribir "texto"` | `printf("texto\n");` |
| `Escribir variable` | `printf("%d\n", variable);` |
| `variable ← valor` | `variable = valor;` |
| `Si condición Entonces ... Fin Si` | `if (condición) { ... }` |
| `Si ... Sino ... Fin Si` | `if (...) { ... } else { ... }` |
| `Mientras condición Hacer ... Fin Mientras` | `while (condición) { ... }` |
| `Repetir ... Hasta Que condición` | `do { ... } while (condición);` |
| `MOD` | `%` |
| `Y` | `&&` |
| `O` | `\|\|` |
| `NO` | `!` |

---

## Ejercicios: los algoritmos del TP en C

Los siguientes programas son la traducción directa de los diagramas de flujo del Bloque 4. Se pueden compilar y ejecutar en cualquier compilador de C estándar (online: repl.it, OnlineGDB, Tutorialspoint; local: VSCode con GCC).

---

### Ejercicio 1 — Suma de dos valores

```c
#include <stdio.h>

int main(void) {
    int a, b, resultado;

    printf("Ingrese el primer numero: ");
    scanf("%d", &a);

    printf("Ingrese el segundo numero: ");
    scanf("%d", &b);

    resultado = a + b;

    printf("La suma es: %d\n", resultado);

    return 0;
}
```

---

### Ejercicio 2 — Operación con tres valores

```c
#include <stdio.h>

int main(void) {
    int a, b, c, resultado;

    printf("Ingrese el primer numero: ");
    scanf("%d", &a);

    printf("Ingrese el segundo numero: ");
    scanf("%d", &b);

    printf("Ingrese el tercer numero: ");
    scanf("%d", &c);

    resultado = (a + b) - c;

    printf("El resultado es: %d\n", resultado);

    return 0;
}
```

---

### Ejercicio 3 — Módulo (valor absoluto)

```c
#include <stdio.h>

int main(void) {
    int numero, modulo;

    printf("Ingrese un numero: ");
    scanf("%d", &numero);

    if (numero < 0) {
        modulo = -numero;
    } else {
        modulo = numero;
    }

    printf("El modulo es: %d\n", modulo);

    return 0;
}
```

> **Nota:** la biblioteca estándar `<math.h>` tiene la función `abs()` que hace esto automáticamente, pero aquí lo implementamos manualmente para practicar la estructura `if/else`.

---

### Ejercicio 4 — Sensor de temperatura

```c
#include <stdio.h>

int main(void) {
    float temperatura;

    printf("Ingrese la temperatura: ");
    scanf("%f", &temperatura);

    if (temperatura > 26.0) {
        printf("Hace calor\n");
    } else if (temperatura < 22.0) {
        printf("Hace frio\n");
    }

    return 0;
}
```

> Cuando la temperatura está entre 22° y 26° el programa no imprime nada, tal como pide el enunciado.

---

### Ejercicio 5 — Promedio de una serie de valores

```c
#include <stdio.h>

int main(void) {
    int numero;
    float suma = 0;
    int cantidad = 0;

    printf("Ingrese numeros (0 para terminar):\n");

    scanf("%d", &numero);

    while (numero != 0) {
        suma = suma + numero;
        cantidad++;
        scanf("%d", &numero);
    }

    if (cantidad > 0) {
        printf("El promedio es: %.2f\n", suma / cantidad);
    } else {
        printf("No se ingresaron numeros.\n");
    }

    return 0;
}
```

> **Puntos importantes de este ejercicio:**
> - La suma se declara como `float` para que la división no pierda los decimales.
> - El `if (cantidad > 0)` evita la división por cero si el usuario ingresa 0 inmediatamente.
> - El 0 final **no se suma** porque la condición del `while` se evalúa antes de acumular.

---

## Entorno de desarrollo

Para compilar y ejecutar programas en C se puede usar cualquiera de los siguientes entornos:

**Online (sin instalación):**
- [repl.it](https://replit.com) — crea un proyecto de tipo C.
- [OnlineGDB](https://www.onlinegdb.com) — compilador + depurador online.
- [Tutorialspoint C Compiler](https://www.tutorialspoint.com/compile_c_online.php)

**Local:**
- **VSCode** + extensión C/C++ + compilador GCC (a través de MinGW en Windows).

---

*AED II — Wels, Ariel | EEST N°1 Vte. López*
