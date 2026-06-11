# Matemáticas Visuales: Recursos Interactivos para la Enseñanza en Grados STEM

Repositorio asociado al proyecto de innovación docente **"Matemáticas visuales: recursos interactivos para transformar el aprendizaje en grados STEM"** (PIIDUZ, Universidad de Zaragoza).

## Descripción

Este repositorio recopila los proyectos desarrollados para la creación de visualizaciones matemáticas interactivas destinadas a apoyar la enseñanza de conceptos matemáticos en asignaturas STEM.

Las aplicaciones han sido desarrolladas utilizando **Godot Engine** y están pensadas para su publicación en la web mediante **GitHub Pages**, de forma que puedan utilizarse directamente desde un navegador sin necesidad de instalación adicional.

El objetivo es facilitar una comprensión más intuitiva de distintos conceptos matemáticos mediante la experimentación visual y la manipulación interactiva de parámetros.

---

## Recursos desarrollados

### 1. Transformaciones lineales y acción de matrices

Visualización interactiva de transformaciones lineales en el plano mediante matrices \(2\times2\).

**Versión web**

https://eduroyo.github.io/visual-matrix-1/

**Código fuente**

`matrix-1/`

---

### 2. Integración numérica

Aplicación para explorar distintos métodos de integración numérica y analizar visualmente los errores asociados.

**Versión web**

https://eduroyo.github.io/integracion-numerica/

**Código fuente**

`integracion-numerica/`

---

### 3. Interpolación polinómica y splines

Comparación visual entre interpolación polinómica y diferentes tipos de splines.

**Versión web**

https://eduroyo.github.io/polinomio-y-spline/

**Código fuente**

`polinomio-y-spline/`

---

### 4. Fenómeno de Runge

Visualización del fenómeno de Runge y del comportamiento de los polinomios interpoladores al aumentar el número de nodos.

**Versión web**

https://eduroyo.github.io/fenomeno-runge/

**Código fuente**

`fenomeno-runge/`

---

## Tecnologías empleadas

- Godot Engine 4
- GDScript
- HTML5 / WebAssembly
- Git
- GitHub
- GitHub Pages

El proyecto prioriza el uso de herramientas de código abierto para favorecer la sostenibilidad, la reproducibilidad y la reutilización de los materiales desarrollados.

---

## Estructura del repositorio

```text
matematicas-visuales/
│
├── matrix-1/
├── integracion-numerica/
├── polinomio-y-spline/
├── fenomeno-runge/
│
└── notas/
    ├── resumen.tex
    └── resumen.pdf
```

Cada directorio principal contiene un proyecto independiente de Godot.

---

## Ejecución local

1. Instalar Godot Engine 4.
2. Abrir el proyecto correspondiente (`project.godot`).
3. Ejecutar la escena principal.

---

## Publicación web

Los recursos se exportan desde Godot como aplicaciones HTML5 y se publican mediante GitHub Pages.

La carpeta `notas/` incluye documentación resumida sobre el procedimiento utilizado durante el proyecto para:

- exportación HTML5;
- organización de archivos;
- publicación mediante GitHub;
- despliegue en GitHub Pages.

---

## Objetivos docentes

Los materiales incluidos en este repositorio persiguen varios objetivos:

- Facilitar la comprensión de conceptos matemáticos abstractos mediante representaciones visuales.
- Favorecer el aprendizaje activo a través de la manipulación de parámetros.
- Complementar las clases teóricas y prácticas con recursos interactivos accesibles desde cualquier navegador.
- Promover el uso de herramientas de software libre en contextos educativos.
- Generar materiales reutilizables y ampliables para futuras experiencias docentes.

---

## Contexto académico

Estos materiales han sido desarrollados en el marco del proyecto de innovación docente:

**Matemáticas visuales: recursos interactivos para transformar el aprendizaje en grados STEM**

**Programa PIIDUZ – Universidad de Zaragoza**

El proyecto explora el potencial de las visualizaciones interactivas para reforzar la enseñanza de contenidos matemáticos en titulaciones STEM y sentar las bases para su extensión a otras asignaturas y contextos educativos.

---

## Continuidad

La experiencia adquirida durante el desarrollo de estos recursos ha dado lugar a una segunda fase del proyecto orientada a:

- ampliar el catálogo de visualizaciones disponibles;
- integrar los recursos de forma más sistemática en el aula;
- facilitar la incorporación de nuevo profesorado;
- documentar procedimientos de desarrollo y publicación;
- consolidar una colección abierta de materiales reutilizables.

---

## Licencia

Los materiales de este repositorio pueden reutilizarse y adaptarse con fines docentes y educativos citando la procedencia del proyecto cuando corresponda.

Se recomienda mantener el carácter abierto de las modificaciones y mejoras derivadas.
