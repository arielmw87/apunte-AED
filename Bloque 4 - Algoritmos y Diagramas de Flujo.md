# Pensamiento Computacional y Algoritmos

**Aplicaciones de Electrónica Digital II**
Escuela de Educación Técnica Nro. 1 — Vte. López

---

## ¿Qué es un algoritmo?

Un **algoritmo** es una secuencia finita de pasos ordenados y precisos que describe cómo resolver un problema. Para que una secuencia de pasos sea considerada un algoritmo debe cumplir las siguientes características:

- **Finito:** debe terminar en algún momento, no puede ejecutarse indefinidamente.
- **Preciso:** cada paso debe ser claro e inequívoco, sin ambigüedades.
- **Definido:** si se ejecuta dos veces con los mismos datos de entrada, siempre produce el mismo resultado.
- **Con entrada y salida:** puede recibir datos del exterior (entradas) y debe producir al menos un resultado (salida).

> Los algoritmos son independientes del lenguaje de programación. Se pueden expresar en lenguaje natural, en pseudocódigo o en un diagrama de flujo, y luego traducirse a cualquier lenguaje de programación.

**Ejemplo cotidiano — receta de cocina:**
1. Calentar agua hasta que hierva.
2. Agregar los fideos.
3. Esperar 8 minutos.
4. Colar y servir.

Este es un algoritmo: tiene pasos ordenados, es finito y produce un resultado determinado.

---

## Representación de algoritmos: el diagrama de flujo

Un **diagrama de flujo** es una representación gráfica de un algoritmo. Utiliza símbolos estandarizados conectados por flechas que indican el orden de ejecución de los pasos.

### Símbolos básicos

| Símbolo | Forma | Uso |
|---------|-------|-----|
| Terminal | Óvalo / rectángulo redondeado | Inicio y fin del algoritmo |
| Proceso | Rectángulo | Operación, cálculo o asignación de valor |
| Decisión | Rombo | Condición o pregunta con ramificación (Sí / No) |
| Entrada/Salida | Paralelogramo | Leer datos del usuario o mostrar resultados |
| Conector | Círculo pequeño | Unir partes del diagrama cuando no caben en una página |
| Flecha | Línea con flecha | Indica el flujo de ejecución entre pasos |

<!-- IMAGEN: tabla visual con los símbolos del diagrama de flujo dibujados -->

### Reglas generales

- Todo diagrama empieza con un símbolo **Inicio** y termina con uno o más símbolos **Fin**.
- Las flechas indican la dirección del flujo: normalmente de arriba hacia abajo y de izquierda a derecha.
- Un rombo de decisión siempre tiene exactamente **dos salidas**: una para cuando la condición es verdadera (Sí) y otra para cuando es falsa (No).
- No deben existir caminos que queden sin salida ni flechas que apunten "al vacío".

---

## Estructuras de control

Todo algoritmo se construye combinando tres estructuras fundamentales:

### 1. Secuencia

Los pasos se ejecutan uno tras otro, en el orden en que aparecen. Es la estructura más simple.

<!-- IMAGEN: diagrama de flujo de una secuencia de tres pasos: Inicio → Paso 1 → Paso 2 → Paso 3 → Fin -->

**Ejemplo:** calcular el área de un rectángulo.
1. Leer base.
2. Leer altura.
3. Calcular área = base × altura.
4. Mostrar área.

### 2. Decisión (selección)

El flujo se divide en dos caminos según el resultado de una condición. Se evalúa una expresión lógica (verdadera o falsa) y se ejecuta uno u otro bloque de pasos.

<!-- IMAGEN: diagrama de flujo de una estructura si-sino: rombo con rama Sí y rama No -->

**Ejemplo:** determinar si un número es positivo o negativo.

```
Si número > 0 entonces
    Mostrar "El número es positivo"
Sino
    Mostrar "El número es negativo o cero"
Fin Si
```

Las decisiones pueden encadenarse o anidarse para evaluar múltiples condiciones.

### 3. Repetición (iteración)

Un bloque de pasos se ejecuta más de una vez, mientras se cumpla una condición. Hay dos variantes principales:

#### Repetir mientras (while — condición al inicio)

La condición se evalúa **antes** de ejecutar el bloque. Si la condición es falsa desde el principio, el bloque no se ejecuta nunca.

<!-- IMAGEN: diagrama de flujo del bucle mientras — rombo antes del bloque, flecha de retorno -->

```
Mientras condición sea verdadera hacer
    [bloque de pasos]
Fin Mientras
```

**Ejemplo:** mostrar los números del 1 al 10.
```
contador = 1
Mientras contador <= 10 hacer
    Mostrar contador
    contador = contador + 1
Fin Mientras
```

#### Repetir hasta (do-while — condición al final)

El bloque se ejecuta **al menos una vez** y la condición se evalúa al final. Si la condición sigue siendo verdadera, vuelve a ejecutarse.

```
Repetir
    [bloque de pasos]
Hasta que condición sea verdadera
```

---

## Variables

Una **variable** es un espacio de memoria con nombre que almacena un valor que puede cambiar durante la ejecución del algoritmo.

Características:
- Tiene un **nombre** (identificador) que la distingue de las demás.
- Almacena un **tipo de dato** (número entero, número decimal, texto, etc.).
- Su valor puede **leerse** (consultar qué tiene) o **escribirse** (asignarle un nuevo valor).

### Tipos de datos básicos

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| Entero | Número sin decimales | 5, -3, 100 |
| Real | Número con decimales | 3.14, -0.5 |
| Carácter | Un símbolo de texto | 'A', '7' |
| Cadena | Texto (varios caracteres) | "Hola", "temperatura" |
| Lógico | Verdadero o falso | Verdadero, Falso |

### Asignación

La asignación guarda un valor en una variable. En pseudocódigo se escribe con la flecha `←`:

```
temperatura ← 25
resultado ← base * altura
nombre ← "Juan"
```

---

## Operadores

### Aritméticos

| Operador | Operación |
|:---:|---|
| `+` | Suma |
| `-` | Resta |
| `*` | Multiplicación |
| `/` | División |
| `MOD` | Módulo (resto de la división entera) |

### Relacionales (comparación)

| Operador | Significado |
|:---:|---|
| `>` | Mayor que |
| `<` | Menor que |
| `>=` | Mayor o igual que |
| `<=` | Menor o igual que |
| `=` | Igual |
| `<>` | Distinto |

### Lógicos

| Operador | Significado |
|:---:|---|
| `Y` / `AND` | Verdadero solo si ambas condiciones son verdaderas |
| `O` / `OR` | Verdadero si al menos una condición es verdadera |
| `NO` / `NOT` | Invierte el valor lógico |

---

## Herramienta: PSeInt

**PSeInt** es un programa que permite escribir y ejecutar algoritmos en pseudocódigo, y visualizarlos como diagrama de flujo de forma automática.

### Configuración del perfil

Para este curso se usa el perfil **EEST1 VL**, disponible en el aula virtual (Moodle). Para cargarlo:

1. Ir a **Configurar → Opciones del lenguaje (perfiles) → Cargar**.
2. Seleccionar el archivo `EEST1_VL`.
3. Hacer clic en **Aceptar**.

### Editar el diagrama de flujo

Existen tres formas de acceder al modo de diagrama de flujo:

- Hacer clic en el ícono de diagrama de flujo en la barra de menú.
- Ir a **Archivo → Editar diagrama de flujo**.
- Presionar **F7**.

### Ejecutar el algoritmo

- **Ejecución completa:** botón *Ejecutar* (flecha verde), o **F9**.
- **Ejecución paso a paso:** botón *Paso a paso* (ícono de pies), útil para seguir el flujo y detectar errores.

---

## Ejercicios

Los siguientes ejercicios deben resolverse primero dibujando el diagrama de flujo en PSeInt y verificando su funcionamiento con distintos valores de entrada.

---

### Ejercicio 1 — Suma de dos valores

Realizar un algoritmo capaz de sumar 2 valores e informar el resultado.

**Diagrama de flujo esperado:**

```
Inicio
  └─ Leer A
  └─ Leer B
  └─ resultado ← A + B
  └─ Mostrar resultado
Fin
```

<!-- IMAGEN: diagrama de flujo del ejercicio 1 en PSeInt -->

---

### Ejercicio 2 — Operación con tres valores

Realizar un algoritmo que permita ingresar 3 valores, sumar los primeros 2, restarle el tercero al resultado, e informar el resultado final.

**Relación esperada:** resultado = (A + B) − C

<!-- IMAGEN: diagrama de flujo del ejercicio 2 en PSeInt -->

---

### Ejercicio 3 — Módulo de un valor

Realizar un algoritmo capaz de calcular el módulo (valor absoluto) de un número e informar el resultado. Recordar que el módulo devuelve el valor positivo: si el número es positivo lo devuelve igual, si es negativo lo invierte.

> Este ejercicio introduce la estructura de decisión: se necesita evaluar si el número es negativo para invertirlo.

<!-- IMAGEN: diagrama de flujo del ejercicio 3 en PSeInt -->

---

### Ejercicio 4 — Sensor de temperatura

Realizar un algoritmo capaz de informar si hace calor o frío. Se ingresa un valor de temperatura y el algoritmo debe:

- Si la temperatura supera los 26°C: informar "hace calor".
- Si la temperatura es menor a 22°C: informar "hace frío".
- En cualquier otro caso (entre 22° y 26°): no informar nada (temperatura agradable).

> Este ejercicio introduce decisiones múltiples: más de una condición debe evaluarse.

<!-- IMAGEN: diagrama de flujo del ejercicio 4 en PSeInt -->

---

### Ejercicio 5 — Promedio de una serie de valores

Realizar un algoritmo capaz de calcular el promedio de todos los números ingresados. El ingreso termina cuando el usuario introduce un 0.

> Este ejercicio introduce la estructura de repetición. El algoritmo no sabe de antemano cuántos números se van a ingresar: debe seguir pidiendo valores hasta que se ingrese un 0, y recién entonces calcular y mostrar el promedio.

**Consideraciones:**
- Llevar la cuenta de cuántos valores se ingresaron (contador).
- Llevar la suma acumulada de los valores.
- No incluir el 0 en el cálculo del promedio.
- Tener en cuenta el caso en que se ingrese 0 como primer valor (no hay valores para promediar).

<!-- IMAGEN: diagrama de flujo del ejercicio 5 en PSeInt -->

---

*AED II — Wels, Ariel | EEST N°1 Vte. López*
