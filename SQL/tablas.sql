-- Creacion de la base de datos
CREATE DATABASE biblioteca_digital;
USE biblioteca_digital;

-- -----------------------------------------------------
-- Tablas Catalogo (Independientes)
-- Estas tablas almacenan valores fijos para normalizar la base de datos
-- -----------------------------------------------------

-- 1. Tabla categoria
-- Almacena los generos o temas de los libros
CREATE TABLE categoria (
    id_categoria INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NULL,
    PRIMARY KEY (id_categoria),
    UNIQUE (nombre)
);

-- 2. Tabla tipo_usuario_catalogo
-- Almacena los roles 
CREATE TABLE tipo_usuario_catalogo (
    id_tipo_usuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_tipo_usuario),
    UNIQUE (nombre)
);

-- 3. Tabla estado_usuario_catalogo
-- Almacena los estados de la cuenta 
CREATE TABLE estado_usuario_catalogo (
    id_estado_usuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_estado_usuario),
    UNIQUE (nombre)
);

-- 4. Tabla estado_prestamo_catalogo
-- Almacena los estados del ciclo de vida de un prestamo 
CREATE TABLE estado_prestamo_catalogo (
    id_estado_prestamo INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_estado_prestamo),
    UNIQUE (nombre)
);

-- 5. Tabla estado_reserva_catalogo
-- Almacena los estados de la reserva 
CREATE TABLE estado_reserva_catalogo (
    id_estado_reserva INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_estado_reserva),
    UNIQUE (nombre)
);

-- 6. Tabla configuracion
-- Almacena reglas de negocio globales 
CREATE TABLE configuracion (
    clave VARCHAR(50) NOT NULL,
    valor VARCHAR(100) NOT NULL,
    PRIMARY KEY (clave)
);

-- 7. Tabla pregunta_seguridad
-- Almacena las preguntas para recuperacion de cuenta (US_1, US_4)
CREATE TABLE pregunta_seguridad (
    id_pregunta INT NOT NULL AUTO_INCREMENT,
    texto_pregunta VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_pregunta),
    UNIQUE (texto_pregunta)
);


-- -----------------------------------------------------
-- Tablas Principales (Dependientes)
-- Estas tablas contienen la logica central del sistema
-- -----------------------------------------------------

-- 8. Tabla usuario (depende de tipo_usuario_catalogo, estado_usuario_catalogo)
-- Almacena la informacion de las personas que interactuan con el sistema
CREATE TABLE usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    email VARCHAR(255) NULL,
    id_tipo_usuario INT NOT NULL,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_estado_usuario INT NOT NULL,
    intentos_fallidos INT NOT NULL DEFAULT 0,
    requiere_cambio_pass TINYINT NOT NULL DEFAULT 1,
    
    PRIMARY KEY (id_usuario),
    UNIQUE (username),
    UNIQUE (email),
    FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario_catalogo(id_tipo_usuario),
    FOREIGN KEY (id_estado_usuario) REFERENCES estado_usuario_catalogo(id_estado_usuario)
);

-- 9. Tabla libro (depende de categoria)
-- Almacena la informacion de cada libro digital
CREATE TABLE libro (
    id_libro INT NOT NULL AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    editorial VARCHAR(100) NULL,
    ano_publicacion VARCHAR(10) NULL,
    descripcion TEXT NULL,
    portada_url VARCHAR(512) NULL,
    recurso_url VARCHAR(512) NULL,
    cantidad_total INT NOT NULL DEFAULT 1,
    cantidad_disponible INT NOT NULL DEFAULT 1,

    PRIMARY KEY (id_libro),
    UNIQUE (isbn),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);


-- -----------------------------------------------------
-- Tablas Transaccionales y de Auditoria (Dependientes)
-- -----------------------------------------------------

-- 10. Tabla prestamo (depende de usuario, libro, estado_prestamo_catalogo)
-- Registra las transacciones de prestamos de libros a usuarios
CREATE TABLE prestamo (
    id_prestamo INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_prestamo DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_devolucion_esperada DATETIME NOT NULL,
    fecha_devolucion_real DATETIME NULL,
    id_estado_prestamo INT NOT NULL,

    PRIMARY KEY (id_prestamo),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_estado_prestamo) REFERENCES estado_prestamo_catalogo(id_estado_prestamo)
);

-- 11. Tabla reserva (depende de usuario, libro, estado_reserva_catalogo)
-- Almacena las solicitudes de reserva para libros no disponibles
CREATE TABLE reserva (
    id_reserva INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_reserva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_estado_reserva INT NOT NULL,

    PRIMARY KEY (id_reserva),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_estado_reserva) REFERENCES estado_reserva_catalogo(id_estado_reserva)
);

-- 12. Tabla usuario_respuesta (depende de usuario, pregunta_seguridad)
-- Vincula la respuesta de un usuario a una pregunta de seguridad
CREATE TABLE usuario_respuesta (
    id_respuesta INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_pregunta INT NOT NULL,
    respuesta VARCHAR(255) NOT NULL,

    PRIMARY KEY (id_respuesta),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_pregunta) REFERENCES pregunta_seguridad(id_pregunta)
);

-- 13. Tabla auditoria_usuario (depende de usuario)
-- Registra eventos de seguridad sobre cuentas de usuario (US_20)
CREATE TABLE auditoria_usuario (
    id_auditoria_usuario INT NOT NULL AUTO_INCREMENT,
    id_usuario_afectado INT NOT NULL,
    id_usuario_admin INT NULL,
    fecha_evento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_accion VARCHAR(50) NOT NULL,
    descripcion TEXT NULL,

    PRIMARY KEY (id_auditoria_usuario),
    FOREIGN KEY (id_usuario_afectado) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_usuario_admin) REFERENCES usuario(id_usuario)
);

-- 14. Tabla auditoria_libro (depende de libro, usuario)
-- Registra cambios en los metadatos de los libros (US_11)
CREATE TABLE auditoria_libro (
    id_auditoria_libro INT NOT NULL AUTO_INCREMENT,
    id_libro INT NOT NULL,
    id_usuario_admin INT NOT NULL,
    fecha_evento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion_cambio TEXT NULL,

    PRIMARY KEY (id_auditoria_libro),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_usuario_admin) REFERENCES usuario(id_usuario)
);