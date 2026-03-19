
# Django RealWorld Backend – Versión Mejorada

## Descripción del proyecto

Este proyecto es un backend desarrollado en Django que simula una plataforma similar a una red social. Permite que los usuarios se registren, publiquen artículos, sigan a otros usuarios y participen mediante comentarios.

El objetivo no fue únicamente ejecutar el sistema, sino entender cómo está construido y mejorarlo progresivamente aplicando prácticas reales de desarrollo.

---

## Qué se hizo en este proyecto

A lo largo del desarrollo se trabajó en varias etapas.

Primero se analizó el código para entender su funcionamiento y estructura. Luego se identificaron los módulos principales del sistema (usuarios, perfiles, artículos, comentarios y tags).

Después se definieron historias de usuario basadas en el comportamiento real del sistema.

Se configuró un flujo de integración continua para validar automáticamente la calidad del código en cada cambio.

En la parte de seguridad, se revisaron dependencias vulnerables y se aplicaron mejoras. También se implementó un mecanismo para evitar que información sensible se suba al repositorio por error.

Finalmente, se realizaron ajustes en la arquitectura y en el entorno de ejecución para que el proyecto pueda levantarse de forma más sencilla usando Docker.

---

## Cómo ejecutar el proyecto

Para levantar el sistema solo es necesario ejecutar el siguiente comando desde la raíz del proyecto:

```bash
docker compose up --build
```

Una vez iniciado, la API estará disponible en:

```
http://localhost:8000/api/
```

---

## Versiones utilizadas

El proyecto funciona con versiones específicas debido a la compatibilidad del código original:

* Python 3.6
* Django 1.10.5
* Django REST Framework
* PostgreSQL 13 (usado con Docker)

Dependencias relevantes:

* PyJWT 2.4.0
* setuptools 59.6.0
* psycopg2-binary
* dj-database-url

Estas versiones se ajustaron para mejorar la seguridad sin romper el funcionamiento del sistema.

---

## Arquitectura actual

El sistema sigue una estructura de tipo monolito modular.

Esto significa que todo el backend está en una sola aplicación, pero dividido internamente en módulos que representan diferentes partes del dominio:

* users (usuarios y autenticación)
* profiles (relaciones entre usuarios)
* articles (publicación de contenido)
* comments (interacciones sobre artículos)
* tags (clasificación del contenido)

Cada módulo tiene sus propios modelos, vistas y lógica, lo que permite cierta separación de responsabilidades.

Sin embargo, aún existen áreas donde la lógica está muy concentrada, especialmente en las vistas, lo que hace que algunas partes del sistema sean más difíciles de mantener o escalar.

---

## Integración continua (GitHub Actions)

Se configuró un flujo automático en GitHub Actions que se ejecuta cada vez que se hace un pull request.

Este flujo revisa la calidad del código antes de permitir que los cambios se integren al proyecto principal.

El proceso realiza lo siguiente:

Analiza el código para medir qué tan complejo es. Si el código nuevo introduce demasiada complejidad, el cambio es bloqueado.

También se revisa la cobertura de pruebas. Si los cambios hacen que la calidad baje, el sistema lo detecta y evita que se integren sin revisión.

Este flujo funciona como un control automático que ayuda a mantener el código más ordenado, entendible y consistente a lo largo del tiempo.

---

## Cambios importantes realizados

Durante el proyecto se hicieron varias mejoras sobre el código original.

Se identificaron partes del sistema con demasiada lógica concentrada y se propuso separarlas para mejorar el mantenimiento.

Se ajustó la configuración para utilizar PostgreSQL en lugar de SQLite, lo que permite un comportamiento más cercano a un entorno real.

Se automatizó el proceso de ejecución del proyecto, eliminando configuraciones manuales.

---

## Seguridad

Se realizó un análisis de dependencias para detectar vulnerabilidades conocidas.

Algunas librerías fueron actualizadas para reducir riesgos, manteniendo compatibilidad con el sistema actual.

También se implementó un control que evita subir al repositorio información sensible como contraseñas o claves.

---

## Rendimiento

Se identificaron partes del sistema que podían consumir más recursos de lo necesario.

Se hicieron ajustes en la estructura del código para mejorar la eficiencia, principalmente separando responsabilidades y evitando lógica innecesaria en ciertos componentes.

Esto permitió mejorar el comportamiento general sin afectar la funcionalidad.

---

## Rutas disponibles de la API

Base URL:

```
http://localhost:8000/api/
```

### Usuarios

* POST `/api/users`
* POST `/api/users/login`
* GET `/api/user`
* PUT `/api/user`

### Perfiles

* GET `/api/profiles/{username}`
* POST `/api/profiles/{username}/follow`
* DELETE `/api/profiles/{username}/follow`

### Artículos

* GET `/api/articles`
* GET `/api/articles/feed`
* GET `/api/articles/{slug}`
* POST `/api/articles`
* PUT `/api/articles/{slug}`
* DELETE `/api/articles/{slug}`

### Favoritos

* POST `/api/articles/{slug}/favorite`
* DELETE `/api/articles/{slug}/favorite`

### Comentarios

* GET `/api/articles/{slug}/comments`
* POST `/api/articles/{slug}/comments`
* DELETE `/api/articles/{slug}/comments/{id}`

### Tags

* GET `/api/tags`

---

## Limitaciones actuales

El proyecto utiliza versiones antiguas de Django y Python, lo cual limita algunas mejoras más profundas.

No todas las dependencias pueden actualizarse sin hacer cambios mayores en el sistema.

La cobertura de pruebas es limitada.

---

## Trabajo futuro

A nivel de arquitectura, el sistema puede mejorar en varios aspectos.

Una de las mejoras principales sería separar la lógica de negocio de las vistas, ya que actualmente muchas responsabilidades están mezcladas. Esto ayudaría a que el código sea más fácil de mantener y probar.

También se podría dividir el sistema en servicios más pequeños o al menos reforzar la modularidad interna, para reducir el acoplamiento entre componentes.

Otra mejora importante sería actualizar el stack tecnológico a versiones más recientes, lo que permitiría usar mejores herramientas, mejorar la seguridad y facilitar el mantenimiento a largo plazo.

Además, se podría incorporar un sistema de caché para mejorar el rendimiento en consultas frecuentes.

Estas mejoras permitirían que el sistema evolucione hacia una arquitectura más escalable, mantenible y preparada para entornos reales.

---
