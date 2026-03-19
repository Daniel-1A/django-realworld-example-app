# Documentación del Proyecto – Django RealWorld Backend

## 1. Introducción

Este proyecto consiste en el análisis, mejora y optimización de un backend desarrollado en Django que simula una plataforma tipo red social.

El sistema permite a los usuarios registrarse, autenticarse, publicar artículos, seguir a otros usuarios y participar mediante comentarios.

El objetivo principal del trabajo fue entender el sistema existente y aplicar mejoras reales en arquitectura, calidad, seguridad y rendimiento.

---

## 2. Proceso de trabajo

El proyecto se desarrolló en varias fases:

1. Análisis del sistema (Discovery)
2. Identificación de dominios y contextos
3. Recuperación de backlog (historias de usuario)
4. Evaluación de calidad del código
5. Implementación de CI/CD
6. Hardening de seguridad
7. Mejora de arquitectura y entorno
8. Optimización de rendimiento (FinOps)

Cada fase permitió tomar decisiones basadas en evidencia del sistema real.

---

## 3. Arquitectura del sistema

El sistema sigue una arquitectura de tipo monolito modular.

Esto significa que:

- Todo el sistema corre en una sola aplicación Django
- Está dividido en módulos independientes (apps)

### Módulos principales

- users → autenticación y gestión de usuarios  
- profiles → relaciones entre usuarios  
- articles → gestión de contenido  
- comments → interacción sobre artículos  
- tags → clasificación de contenido  

Cada módulo contiene:

- Modelos
- Vistas
- Serializadores
- URLs

### Problemas identificados

Durante el análisis se detectaron varios puntos importantes:

- Lógica de negocio mezclada en las vistas
- Alto acoplamiento en algunos módulos
- Consultas ineficientes a la base de datos
- Uso de tecnologías antiguas

---

## 4. Gestión de calidad (CI/CD)

Se implementó un flujo de integración continua utilizando GitHub Actions.

Este flujo se ejecuta automáticamente en cada pull request.

### Qué valida el pipeline

- Complejidad del código  
- Cobertura de pruebas  

Se utilizó la herramienta Radon para medir la complejidad.

Si el código introduce funciones demasiado complejas, el pipeline falla.

También se evalúa la cobertura para evitar que el código pierda calidad con nuevos cambios.

Esto asegura que el sistema mantenga un nivel mínimo de calidad de forma automática.

---

## 5. Seguridad

Se realizó un análisis de vulnerabilidades en las dependencias del proyecto.

Se utilizó una herramienta que revisa versiones de librerías contra bases de datos de vulnerabilidades conocidas.

### Resultados

Se detectaron vulnerabilidades en:

- Django 1.10.5  
- PyJWT  
- Setuptools  

### Acciones realizadas

- Actualización de PyJWT a una versión más segura  
- Actualización de setuptools  
- Evaluación de impacto en el sistema  

Además, se implementó un mecanismo para evitar la exposición de secretos en el repositorio.

Este control bloquea commits que contengan palabras como:

- SECRET  
- PASSWORD  
- API_KEY  

---

## 6. Entorno de ejecución

Inicialmente el proyecto tenía varios problemas para ejecutarse:

- Dependencias antiguas
- Versiones incompatibles
- Configuración manual

### Solución

Se implementó Docker para:

- Estandarizar el entorno
- Evitar problemas de versiones
- Facilitar la ejecución

También se migró la base de datos de SQLite a PostgreSQL.

Esto permite:

- Mejor manejo de concurrencia
- Comportamiento más realista
- Separación entre aplicación y datos

---

## 7. Optimización de rendimiento (FinOps)

Durante esta fase se identificó un componente con alto consumo de recursos.

### Hotspot principal

El archivo:

conduit/apps/articles/views.py

Fue seleccionado porque:

- Maneja múltiples endpoints
- Realiza muchas consultas a la base de datos
- Tiene impacto directo en el rendimiento

---

## 8. Problema identificado

El principal problema detectado fue el patrón conocido como:

N+1 queries

Esto ocurre cuando:

- Se hace 1 consulta principal
- Luego se hacen muchas consultas adicionales por cada registro

Ejemplo:

- 1 query de artículos
- + 2000 queries adicionales

Esto genera un alto consumo de recursos y lentitud.

---

## 9. Solución aplicada

Se realizó una refactorización en el ORM de Django.

### Antes

- Uso de select_related únicamente

### Después

- Uso combinado de:
  - select_related
  - prefetch_related

Esto permite que las relaciones se carguen de forma conjunta en lugar de una por una.

---

## 10. Resultados (Before vs After)

Según las pruebas realizadas:

### Prueba unitaria (1 solicitud)

- Antes: 10.041 segundos  
- Después: 0.097 segundos  

Mejora aproximada: 99% :contentReference[oaicite:1]{index=1}  

---

### Prueba de carga (100 usuarios)

- Tiempo total:
  - Antes: 29.34 s  
  - Después: 9.98 s  

- Tiempo promedio:
  - Antes: 222.57 ms  
  - Después: 68.93 ms  

- Tiempo máximo:
  - Antes: 497.92 ms  
  - Después: 105.80 ms  

Mejora general: entre 3x y 70% 

---

## 11. Validación de pruebas

Para realizar las pruebas se utilizó:

- django-debug-toolbar  
- Scripts para consultas masivas  
- Pruebas secuenciales  
- Pruebas de concurrencia (100 usuarios)


---

## 12. Limitaciones del sistema

- Uso de Django y Python en versiones antiguas  
- Dependencias fuera de soporte  
- Cobertura de pruebas limitada  
- Arquitectura con acoplamiento en ciertas áreas  

---

## 13. Trabajo futuro

El sistema puede mejorar en varios aspectos:

### A nivel de arquitectura

Separar la lógica de negocio de las vistas para mejorar la mantenibilidad.

Reducir el acoplamiento entre módulos.

Aplicar una capa de servicios para centralizar la lógica.

### A nivel tecnológico

Actualizar Django y Python a versiones modernas.

Eliminar dependencias obsoletas.

### A nivel de rendimiento

Agregar caché para consultas frecuentes.

Optimizar más endpoints críticos.

### A nivel de calidad

Aumentar cobertura de pruebas.

Mejorar validaciones automáticas en CI.

---

## 14. Conclusión

El proyecto permitió analizar un sistema real y aplicar mejoras concretas en:

- Calidad de código  
- Seguridad  
- Arquitectura  
- Rendimiento  

La optimización realizada demuestra cómo pequeños cambios bien enfocados pueden tener un impacto significativo en el desempeño del sistema.

El sistema queda en un estado más estable, entendible y preparado para futuras mejoras.