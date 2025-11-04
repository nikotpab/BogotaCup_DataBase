# 🗂️ BogotáCup DataBase – Base de Datos para Sistema de Gestión de Torneos de Fútbol Amateur

Este repositorio corresponde a la **estructura de base de datos relacional** desarrollada para el sistema de gestión de torneos amateur en Bogotá, denominado BogotaCup. Contiene scripts de creación, normalización, datos iniciales, diccionario de datos y demás artefactos para soportar la aplicación principal.

---

## 📋 Descripción del Proyecto

El objetivo principal de este módulo es brindar una **base de datos relacional normalizada** (hasta al menos 3FN) que soporte correctamente las operaciones del sistema: gestión de torneos, equipos, jugadores, partidos, árbitros, resultados y tablas de posiciones.

Además, ofrece documentación técnica (diccionario de datos, modelo E-R, relaciones, restricciones de integridad) que permite asegurar la consistencia, integridad y escalabilidad del sistema.

---

## 🎯 Objetivos

### Objetivo General

Diseñar e implementar una base de datos relacional normalizada para el sistema de gestión de torneos de fútbol amateur.

### Objetivos Específicos

* Modelar entidades y relaciones mediante diagrama E-R (por ejemplo estilo Chen o Crow’s Foot).
* Normalizar la estructura hasta la 3FN, eliminando redundancias y asegurando dependencia funcional adecuada.
* Crear los scripts de creación de esquema (tablas, vistas, índices, restricciones) y los scripts de datos iniciales.
* Documentar el diccionario de datos con atributos, dominios, claves primarias, claves foráneas, etc.
* Incluir consultas de ejemplo para análisis, tablas de posición, informes básicos.

---

## 🧩 Alcance y Entidades Principales

El esquema de base de datos contempla las siguientes entidades principales (y sus relaciones):

* Torneo
* Equipo
* Jugador
* Árbitro
* Cancha
* Partido
* Resultado
* Usuario (roles de sistema)
* TablaPosiciones / Estadísticas
* Categoría

Cada entidad incluye sus atributos, restricciones (PK, FK, UNIQUE, NOT NULL) y se relaciona con otras según el modelo del dominio.

---

## 💡 Supuestos Técnicos / Funcionales en la Base de Datos

* Se asume el uso de un sistema de gestión de base de datos relacional (por ejemplo PostgreSQL o MariaDB).
* La estructura está normalizada hasta 3FN para evitar redundancias e inconsistencias.
* Integridad referencial garantizada mediante claves foráneas y restricciones.
* El sistema soporta múltiples torneos simultáneos sin mezclar datos entre ellos.
* Un jugador sólo puede pertenecer a un equipo por torneo.
* Un partido se juega en una única cancha, en una fecha y hora determinada.
* Un árbitro puede dirigir múltiples partidos pero no solapados en tiempo.

---

## 🔧 Contenido del Repositorio

* Scripts de creación de esquema (por ejemplo `create_tables.sql`, `schema.sql`).
* Scripts de inserción de datos iniciales (por ejemplo `insert_data.sql`).
* Archivo de diccionario de datos (por ejemplo `diccionario_de_datos.docx` o `diccionario_de_datos.md`).
* Diagrama de modelo E-R (por ejemplo `ER_diagram.png`, `ER_diagram.pdf`).
* Consultas de ejemplo para reportes, estadísticas y tablas de posición (`consultas.sql`).
* Readme (este archivo) e instrucciones de uso.

---

## 🚀 Instalación y Ejecución

1. Clona el repositorio:

   ```bash
   git clone https://github.com/nikotpab/BogotaCup_DataBase.git
   cd BogotaCup_DataBase
   ```

2. Selecciona el motor de base de datos (PostgreSQL o MariaDB) y crea una base de datos vacía (por ejemplo `bogotacup_db`).

3. Ejecuta el script de creación de esquema:

   ```bash
   psql -U usuario -d bogotacup_db -f create_tables.sql  # ejemplo PostgreSQL
   ```

4. Ejecuta el script de inserción de datos iniciales:

   ```bash
   psql -U usuario -d bogotacup_db -f insert_data.sql
   ```

5. Verifica la integridad y visualiza el modelo: abre `ER_diagram.png` y revisa el diccionario de datos.

6. Puedes ejecutar las consultas de ejemplo para validar la funcionalidad:

   ```bash
   psql -U usuario -d bogotacup_db -f consultas.sql
   ```

---

## 👥 Autores y Contribución

Este módulo de base de datos fue desarrollado como parte del sistema de Gestión de Torneos “BogotáCup”, dentro del curso de Ingeniería de Sistemas del autor. Se recomienda que, si deseas contribuir, respetes la estructura relacional y normalizada existente.

### Contribuir

1. Haz un fork del repositorio.
2. Crea una rama `feature/tu-cambio`.
3. Añade cambios con documentación adecuada (nuevo script, actualización del diccionario, etc.).
4. Envía un Pull Request describiendo claramente la modificación.

---

## 📜 Licencia

Este proyecto se distribuye con fines **académicos** y **no comerciales**, bajo una licencia abierta para consulta y aprendizaje.
