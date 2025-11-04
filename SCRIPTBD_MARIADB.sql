-- ---
-- Script traducido a MariaDB / MySQL
-- Se han corregido errores de PK y FK del DDL original de Oracle.
-- ---

-- Define el motor de almacenamiento y el charset por defecto
SET default_storage_engine=InnoDB;
SET NAMES utf8mb4;

-- ---
-- TABLA ARBITRO
-- ---
CREATE TABLE `ARBITRO` (
  `id_arbitro` INT NOT NULL AUTO_INCREMENT,
  `nombre`   VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_arbitro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---
-- TABLA CANCHA
-- ---
CREATE TABLE `CANCHA` (
  `id_cancha` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(50) NOT NULL,
  `nombre`  VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_cancha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---
-- TABLA EQUIPO
-- ---
CREATE TABLE `EQUIPO` (
  `id_equipo`   SMALLINT NOT NULL AUTO_INCREMENT,
  `color_secundario` VARCHAR(50) NOT NULL,
  `director_tecnico` VARCHAR(50) NOT NULL,
  `nombre`   VARCHAR(50) NOT NULL,
  `color_primario`  VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---
-- TABLA USUARIO
-- (Fusionada con JUGADOR, como en tu modelo final)
-- ---
CREATE TABLE `USUARIO` (
  `id_usuario`   SMALLINT NOT NULL AUTO_INCREMENT,
  `rol`    VARCHAR(50) NOT NULL,
  `clave`    VARCHAR(50) NOT NULL,
  `correo`   VARCHAR(50) NOT NULL,
  `nombre`   VARCHAR(50) NOT NULL,
  `numero_camiseta` SMALLINT NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `apellido`   VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---
-- TABLA TORNEO
-- (Implementada como 1:N, según tu hipótesis)
-- ---
CREATE TABLE `TORNEO` (
  `id_torneo`   SMALLINT NOT NULL AUTO_INCREMENT,
  `tipo`    VARCHAR(50) NOT NULL,
  `nombre`    VARCHAR(50) NOT NULL,
  `categoria`   VARCHAR(50) NOT NULL,
  `estado`    CHAR(1) NOT NULL,
  `anio`    SMALLINT NOT NULL,
  `USUARIO_id_usuario` SMALLINT NOT NULL,
  PRIMARY KEY (`id_torneo`),
  CONSTRAINT `TORNEO_USUARIO_FK`
    FOREIGN KEY (`USUARIO_id_usuario`)
    REFERENCES `USUARIO` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---
-- TABLA PARTIDO
-- (Fusionada con RESULTADO y con FKs corregidas)
-- ---
CREATE TABLE `PARTIDO` (
  `id_partido`   SMALLINT NOT NULL AUTO_INCREMENT,
  `fecha`    DATE NOT NULL,
  -- CORRECCIÓN: Se especificó un tamaño para VARCHAR
  `estadio_partido`  VARCHAR(100) NOT NULL,
  `goles_visitante`  SMALLINT NOT NULL,
  `goles_local`   SMALLINT NOT NULL,
  `tiempo_extra`   SMALLINT NOT NULL,
  `penales_visitante` SMALLINT NOT NULL,
  `penales_local`   SMALLINT NOT NULL,
  `ARBITRO_id_arbitro` INT NOT NULL,
  `CANCHA_id_cancha`  INT NOT NULL,
  PRIMARY KEY (`id_partido`),
  CONSTRAINT `PARTIDO_ARBITRO_FK`
    FOREIGN KEY (`ARBITRO_id_arbitro`)
    REFERENCES `ARBITRO` (`id_arbitro`),
  CONSTRAINT `PARTIDO_CANCHA_FK`
    FOREIGN KEY (`CANCHA_id_cancha`)
    REFERENCES `CANCHA` (`id_cancha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---
-- TABLAS DE EVENTOS (Especialización)
-- NOTA: Este modelo de especialización es muy complejo y propenso a errores.
-- Se han corregido las PK y se asume que id_evento es la PK para todas.
-- ---
CREATE TABLE `CAMBIO` (
  `id_evento`   INT NOT NULL AUTO_INCREMENT, -- PK unificada
  `id_salida`   SMALLINT NOT NULL,
  `id_entrada`  SMALLINT NOT NULL,
  `minuto`    VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_evento`)
  -- NOTA: Las columnas `id_salida` y `id_entrada` deberían ser FK a USUARIO
  -- CONSTRAINT `CAMBIO_SALIDA_FK` FOREIGN KEY (`id_salida`) REFERENCES `USUARIO` (`id_usuario`),
  -- CONSTRAINT `CAMBIO_ENTRADA_FK` FOREIGN KEY (`id_entrada`) REFERENCES `USUARIO` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `GOL` (
  `id_evento`   INT NOT NULL AUTO_INCREMENT, -- PK unificada
  `id_anotador`   SMALLINT NOT NULL,
  `id_asistencia`  SMALLINT NOT NULL,
  `minuto`    VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_evento`)
  -- NOTA: `id_anotador` y `id_asistencia` deberían ser FK a USUARIO
  -- CONSTRAINT `GOL_ANOTADOR_FK` FOREIGN KEY (`id_anotador`) REFERENCES `USUARIO` (`id_usuario`),
  -- CONSTRAINT `GOL_ASISTENCIA_FK` FOREIGN KEY (`id_asistencia`) REFERENCES `USUARIO` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `TARJETA` (
  `id_evento`   INT NOT NULL AUTO_INCREMENT, -- PK unificada
  `id_amonestado`  SMALLINT NOT NULL,
  `color`    VARCHAR(10) NOT NULL,
  `minuto`    VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_evento`)
  -- NOTA: `id_amonestado` debería ser FK a USUARIO
  -- CONSTRAINT `TARJETA_AMONESTADO_FK` FOREIGN KEY (`id_amonestado`) REFERENCES `USUARIO` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `MOMENTO_PARTIDO` (
  `id_evento` INT NOT NULL AUTO_INCREMENT, -- PK unificada
  `detalle`   VARCHAR(100) NOT NULL,
  `minuto`  VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_evento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ---
-- TABLAS ASOCIATIVAS (N:M)
-- ---
CREATE TABLE `EQUIPO-PARTIDO` (
  `EQUIPO_id_equipo`  SMALLINT NOT NULL,
  `PARTIDO_id_partido` SMALLINT NOT NULL,
  -- CORRECCIÓN: La PK en una tabla N:M debe ser compuesta
  PRIMARY KEY (`EQUIPO_id_equipo`, `PARTIDO_id_partido`),
  CONSTRAINT `EQUIPO-PARTIDO_EQUIPO_FK`
    FOREIGN KEY (`EQUIPO_id_equipo`)
    REFERENCES `EQUIPO` (`id_equipo`),
  CONSTRAINT `EQUIPO-PARTIDO_PARTIDO_FK`
    FOREIGN KEY (`PARTIDO_id_partido`)
    REFERENCES `PARTIDO` (`id_partido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `USUARIO-EQUIPO` (
  `USUARIO_id_usuario` SMALLINT NOT NULL,
  `EQUIPO_id_equipo`  SMALLINT NOT NULL,
  -- Esta es la forma correcta de una PK compuesta (N:M)
  PRIMARY KEY (`USUARIO_id_usuario`, `EQUIPO_id_equipo`),
  CONSTRAINT `USUARIO-EQUIPO_USUARIO_FK`
    FOREIGN KEY (`USUARIO_id_usuario`)
    REFERENCES `USUARIO` (`id_usuario`),
  CONSTRAINT `USUARIO-EQUIPO_EQUIPO_FK`
    FOREIGN KEY (`EQUIPO_id_equipo`)
    REFERENCES `EQUIPO` (`id_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ---
-- TABLAS DE RELACIÓN DE ESPECIALIZACIÓN (Arcos)
-- NOTA: Este diseño es muy inusual.
-- El DDL original tenía PKs incorrectas y FKs faltantes.
-- ---
CREATE TABLE `EVENTO-PARTIDO` (
  -- Se asume que un evento solo puede ser de un tipo
  `PARTIDO_id_partido` SMALLINT NOT NULL,
  `CAMBIO_id_evento`   INT NULL,
  `GOL_id_evento`    INT NULL,
  `MOMENTO_PARTIDO_id_evento` INT NULL,
  `TARJETA_id_evento`   INT NULL,
  
  -- CORRECCIÓN: Se añaden las FKs que faltaban en el DDL
  CONSTRAINT `EV-PA_PARTIDO_FK`
    FOREIGN KEY (`PARTIDO_id_partido`)
    REFERENCES `PARTIDO` (`id_partido`),
  CONSTRAINT `EV-PA_CAMBIO_FK`
    FOREIGN KEY (`CAMBIO_id_evento`)
    REFERENCES `CAMBIO` (`id_evento`),
  CONSTRAINT `EV-PA_GOL_FK`
    FOREIGN KEY (`GOL_id_evento`)
    REFERENCES `GOL` (`id_evento`),
  CONSTRAINT `EV-PA_MOMENTO_FK`
    FOREIGN KEY (`MOMENTO_PARTIDO_id_evento`)
    REFERENCES `MOMENTO_PARTIDO` (`id_evento`),
  CONSTRAINT `EV-PA_TARJETA_FK`
    FOREIGN KEY (`TARJETA_id_evento`)
    REFERENCES `TARJETA` (`id_evento`)
  -- NOTA: Falta una PK y una restricción CHECK
  -- para asegurar que solo una de las FK de evento no sea NULL.
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `JUGADOR-EVENTO` (
  -- Se asume que un evento solo puede ser de un tipo
  `USUARIO_id_usuario` SMALLINT NOT NULL,
  `CAMBIO_id_evento`   INT NULL,
  `GOL_id_evento`    INT NULL,
  `MOMENTO_PARTIDO_id_evento` INT NULL,
  `TARJETA_id_evento`   INT NULL,

  -- CORRECCIÓN: Se añaden las FKs que faltaban en el DDL
  CONSTRAINT `JU-EV_USUARIO_FK`
    FOREIGN KEY (`USUARIO_id_usuario`)
    REFERENCES `USUARIO` (`id_usuario`),
  CONSTRAINT `JU-EV_CAMBIO_FK`
    FOREIGN KEY (`CAMBIO_id_evento`)
    REFERENCES `CAMBIO` (`id_evento`),
  CONSTRAINT `JU-EV_GOL_FK`
    FOREIGN KEY (`GOL_id_evento`)
    REFERENCES `GOL` (`id_evento`),
  CONSTRAINT `JU-EV_MOMENTO_FK`
    FOREIGN KEY (`MOMENTO_PARTIDO_id_evento`)
    REFERENCES `MOMENTO_PARTIDO` (`id_evento`),
  CONSTRAINT `JU-EV_TARJETA_FK`
    FOREIGN KEY (`TARJETA_id_evento`)
    REFERENCES `TARJETA` (`id_evento`)
  -- NOTA: Falta una PK y una restricción CHECK
  -- para asegurar que solo una de las FK de evento no sea NULL.
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;