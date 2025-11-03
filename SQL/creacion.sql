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

-- SELECCIONAR LA BASE DE DATOS
USE biblioteca_digital;

-- -----------------------------------------------------
-- 1. TABLAS CATALOGO (INDEPENDIENTES)
-- Estas tablas deben llenarse primero
-- -----------------------------------------------------

-- 1.1. tipo_usuario_catalogo (Define los roles)
INSERT INTO tipo_usuario_catalogo (nombre) VALUES
('estudiante'),
('bibliotecario'),
('administrador');

-- 1.2. estado_usuario_catalogo (Define los estados de cuenta)
INSERT INTO estado_usuario_catalogo (nombre) VALUES
('activo'),
('inactivo'),
('pendiente'),
('bloqueado');

-- 1.3. estado_prestamo_catalogo (Define el ciclo de vida de un prestamo) [cite: 272]
INSERT INTO estado_prestamo_catalogo (nombre) VALUES
('solicitado'),
('activo'),
('devuelto'),
('vencido');

-- 1.4. estado_reserva_catalogo (Define el ciclo de vida de una reserva)
INSERT INTO estado_reserva_catalogo (nombre) VALUES
('pendiente'),
('disponible'),
('cancelada'),
('completada');

-- 1.5. configuracion (Define las reglas de negocio)
INSERT INTO configuracion (clave, valor) VALUES
('max_prestamos_simultaneos', '3'),     -- [cite: 274]
('periodo_prestamo_dias', '14'),        -- [cite: 273]
('max_renovaciones', '1'),              -- [cite: 301]
('dias_renovacion', '7'),               -- [cite: 301]
('dias_expiracion_reserva', '2');      -- [cite: 305]

-- 1.6. pregunta_seguridad (Para recuperacion de cuenta)
INSERT INTO pregunta_seguridad (texto_pregunta) VALUES
('Cual es el nombre de tu primera mascota?'),
('Cual es tu comida favorita?'),
('Cual es el nombre de tu abuela materna?'),
('En que ciudad naciste?');

-- 1.7. categoria (Minimo 10 categorias) [cite: 115]
INSERT INTO categoria (nombre, descripcion) VALUES
('Programacion', 'Libros sobre desarrollo de software, algoritmos y lenguajes de programacion.'),
('Bases de Datos', 'Todo sobre SQL, NoSQL, modelado y administracion de datos.'),
('Inteligencia Artificial', 'Machine learning, deep learning y conceptos de IA.'),
('Redes y Seguridad', 'Protocolos, ciberseguridad, redes e infraestructura.'),
('Sistemas Operativos', 'Conceptos de Windows, Linux, macOS y gestion de sistemas.'),
('Diseno Grafico', 'Libros sobre teoria del color, tipografia y herramientas de diseno.'),
('Matematicas', 'Calculo, algebra, estadistica y matematica discreta.'),
('Literatura', 'Novelas clasicas, contemporaneas y poesia.'),
('Historia', 'Libros sobre eventos historicos mundiales y locales.'),
('Negocios y Finanzas', 'Marketing, administracion, contabilidad y economia.');

-- -----------------------------------------------------
-- 2. TABLA USUARIO
-- Insertamos 30 usuarios: 10 de cada tipo.
-- ID_TIPO_USUARIO: 1=estudiante, 2=bibliotecario, 3=administrador
-- ID_ESTADO_USUARIO: 1=activo, 2=inactivo
-- -----------------------------------------------------

-- Estudiantes (10 usuarios)
INSERT INTO usuario (username, nombre, contrasena, email, id_tipo_usuario, id_estado_usuario, fecha_registro, requiere_cambio_pass) VALUES
('ana.garcia', 'Ana Garcia', 'pass123', 'ana.garcia@universidad.edu.co', 1, 1, '2025-02-10', 0),
('bruno.fernandez', 'Bruno Fernandez', 'pass123', 'bruno.fernandez@universidad.edu.co', 1, 1, '2025-02-11', 0),
('carla.martinez', 'Carla Martinez', 'pass123', 'carla.martinez@universidad.edu.co', 1, 1, '2025-02-12', 0),
('david.rodriguez', 'David Rodriguez', 'pass123', 'david.rodriguez@universidad.edu.co', 1, 1, '2025-02-13', 0),
('elena.gomez', 'Elena Gomez', 'pass123', 'elena.gomez@universidad.edu.co', 1, 1, '2025-02-14', 0),
('felipe.torres', 'Felipe Torres', 'pass123', 'felipe.torres@universidad.edu.co', 1, 1, '2025-03-01', 0),
('gabriela.ruiz', 'Gabriela Ruiz', 'pass123', 'gabriela.ruiz@universidad.edu.co', 1, 1, '2025-03-02', 0),
('hector.diaz', 'Hector Diaz', 'pass123', 'hector.diaz@universidad.edu.co', 1, 1, '2025-03-03', 0),
('irene.sanchez', 'Irene Sanchez', 'pass123', 'irene.sanchez@universidad.edu.co', 1, 1, '2025-03-04', 0),
('javier.morales', 'Javier Morales', 'pass123', 'javier.morales@universidad.edu.co', 1, 2, '2025-03-05', 0); -- Usuario inactivo

-- Bibliotecarios (10 usuarios)
INSERT INTO usuario (username, nombre, contrasena, email, id_tipo_usuario, id_estado_usuario, fecha_registro, requiere_cambio_pass) VALUES
('ricardo.alvarez', 'Ricardo Alvarez', 'biblioPass', 'ricardo.alvarez@biblioteca.edu.co', 2, 1, '2024-01-15', 0),
('sofia.mendoza', 'Sofia Mendoza', 'biblioPass', 'sofia.mendoza@biblioteca.edu.co', 2, 1, '2024-01-15', 0),
('tomas.herrera', 'Tomas Herrera', 'biblioPass', 'tomas.herrera@biblioteca.edu.co', 2, 1, '2024-01-15', 0),
('valeria.campos', 'Valeria Campos', 'biblioPass', 'valeria.campos@biblioteca.edu.co', 2, 1, '2024-02-20', 0),
('walter.navarro', 'Walter Navarro', 'biblioPass', 'walter.navarro@biblioteca.edu.co', 2, 1, '2024-02-20', 0),
('ximena.flores', 'Ximena Flores', 'biblioPass', 'ximena.flores@biblioteca.edu.co', 2, 1, '2024-03-10', 0),
('yara.pinto', 'Yara Pinto', 'biblioPass', 'yara.pinto@biblioteca.edu.co', 2, 1, '2024-03-10', 0),
('zacarias.leon', 'Zacarias Leon', 'biblioPass', 'zacarias.leon@biblioteca.edu.co', 2, 2, '2024-04-01', 0), -- Usuario inactivo
('andrea.solis', 'Andrea Solis', 'biblioPass', 'andrea.solis@biblioteca.edu.co', 2, 1, '2024-04-01', 0),
('benjamin.castro', 'Benjamin Castro', 'biblioPass', 'benjamin.castro@biblioteca.edu.co', 2, 1, '2024-05-15', 0);

-- Administradores (10 usuarios)
-- (Usamos los nombres de 'general' del script original, pero con rol 'administrador')
-- (requiere_cambio_pass = 1 para cumplir US_15)
INSERT INTO usuario (username, nombre, contrasena, email, id_tipo_usuario, id_estado_usuario, fecha_registro, requiere_cambio_pass) VALUES
('hugo.luna', 'Hugo Luna', 'adminPass', 'hugo.luna@admin.edu.co', 3, 1, '2025-01-20', 1),
('ines.medina', 'Ines Medina', 'adminPass', 'ines.medina@admin.edu.co', 3, 1, '2025-01-21', 1),
('jorge.ponce', 'Jorge Ponce', 'adminPass', 'jorge.ponce@admin.edu.co', 3, 1, '2025-01-22', 1),
('karina.salas', 'Karina Salas', 'adminPass', 'karina.salas@admin.edu.co', 3, 1, '2025-02-25', 1),
('luis.rojas', 'Luis Rojas', 'adminPass', 'luis.rojas@admin.edu.co', 3, 2, '2025-02-26', 1), -- Usuario inactivo
('monica.bravo', 'Monica Bravo', 'adminPass', 'monica.bravo@admin.edu.co', 3, 1, '2025-02-27', 1),
('nicolas.silva', 'Nicolas Silva', 'adminPass', 'nicolas.silva@admin.edu.co', 3, 1, '2025-03-20', 1),
('olga.pena', 'Olga Pena', 'adminPass', 'olga.pena@admin.edu.co', 3, 1, '2025-03-21', 1),
('patricio.arias', 'Patricio Arias', 'adminPass', 'patricio.arias@admin.edu.co', 3, 1, '2025-03-22', 1),
('quintin.nunez', 'Quintin Nunez', 'adminPass', 'quintin.nunez@admin.edu.co', 3, 1, '2025-04-05', 1);

-- -----------------------------------------------------
-- 3. TABLA LIBRO
-- Insertamos 150 libros: 15 en cada categoria (ID 1-10)
-- -----------------------------------------------------

-- Categoria 1: Programacion
INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, cantidad_total, cantidad_disponible) VALUES
(1, '9780132350884', 'Codigo Limpio', 'Robert C. Martin', 'Prentice Hall', '2008', 'Un manual de artesania de software agil.', 5, 4),
(1, '9780201633610', 'Patrones de Diseno', 'Erich Gamma', 'Addison-Wesley', '1994', 'Elementos de software orientado a objetos reutilizable.', 4, 3),
(1, '9788400000001', 'Programacion Orientada a Objetos Explicada', 'Autor POO', 'Editorial Tech', '2020', 'Conceptos de POO.', 5, 5),
(1, '9788400000002', 'Python para Analisis de Datos', 'Autor Python', 'Data Press', '2021', 'Uso de Pandas y NumPy.', 7, 6),
(1, '9788400000003', 'JavaScript: La Guia Definitiva', 'Autor JS', 'OReilly', '2020', 'JavaScript a fondo.', 10, 10),
(1, '9788400000004', 'Estructuras de Datos en Java', 'Autor Java', 'Pearson', '2019', 'Algoritmos y estructuras.', 8, 7),
(1, '9788400000005', 'Desarrollo Web con React', 'Autor React', 'React Press', '2022', 'Creacion de SPAs.', 6, 6),
(1, '9788400000006', 'Introduccion a C#', 'Autor CSharp', 'Microsoft Press', '2018', 'Conceptos basicos de .NET.', 5, 5),
(1, '9780201616161', 'El Programador Pragmatico', 'Andrew Hunt', 'Addison-Wesley', '1999', 'De aprendiz a maestro.', 4, 3),
(1, '9788400000008', 'Aprendiendo SQL', 'Autor SQL', 'OReilly', '2017', 'Consultas y manejo de datos.', 9, 9),
(1, '9788400000009', 'Go en la Practica', 'Autor Go', 'Manning', '2019', 'Lenguaje Go de Google.', 3, 3),
(1, '9788400000010', 'Ruby on Rails Tutorial', 'Michael Hartl', 'Addison-Wesley', '2021', 'Desarrollo web agil.', 5, 5),
(1, '9780134494166', 'Clean Architecture', 'Robert C. Martin', 'Prentice Hall', '2017', 'Arquitectura de software.', 6, 4),
(1, '9788400000012', 'Programacion Funcional con Scala', 'Autor Scala', 'Scala Books', '2020', 'Paradigmas funcionales.', 4, 4),
(1, '9788400000013', 'Kotlin para Android', 'Autor Kotlin', 'Android Dev', '2021', 'Desarrollo movil.', 7, 7);

-- Categoria 2: Bases de Datos
INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, cantidad_total, cantidad_disponible) VALUES
(2, '9780132365638', 'Database System Concepts', 'Silberschatz', 'McGraw-Hill', '2010', 'La biblia de las bases de datos.', 5, 5),
(2, '9781449344020', 'MongoDB: The Definitive Guide', 'Kristina Chodorow', 'OReilly', '2013', 'Guia de la base de datos NoSQL MongoDB.', 3, 2),
(2, '9788400000014', 'Diseno de Bases de Datos Relacionales', 'Autor Diseno DB', 'DB Press', '2019', 'Normalizacion y ER.', 6, 6),
(2, '9788400000015', 'SQL Avanzado: Optimizacion', 'Autor SQL Avanzado', 'OReilly', '2021', 'Query performance tuning.', 5, 4),
(2, '9788400000016', 'PostgreSQL: Up and Running', 'Autor PostgreSQL', 'OReilly', '2018', 'Administracion de PostgreSQL.', 7, 7),
(2, '9788400000017', 'Redis Essentials', 'Autor Redis', 'Packt', '2015', 'Bases de datos en memoria.', 4, 3),
(2, '9788400000018', 'Modelado de Datos NoSQL', 'Autor NoSQL', 'NoSQL Press', '2020', 'Diseno para NoSQL.', 6, 6),
(2, '9788400000019', 'MySQL High Availability', 'Autor MySQL', 'OReilly', '2021', 'Clusters y replicacion.', 5, 5),
(2, '9788400000020', 'Neo4j in Action', 'Autor Neo4j', 'Manning', '2017', 'Bases de datos de grafos.', 3, 3),
(2, '9788400000021', 'Fundamentos de Big Data', 'Autor Big Data', 'Data Science Editorial', '2019', 'Hadoop y Spark.', 8, 7),
(2, '9788400000022', 'Data Warehousing Fundamentals', 'Autor DW', 'Wiley', '2014', 'Conceptos de Bodegas de Datos.', 5, 5),
(2, '9788400000023', 'Cassandra: The Definitive Guide', 'Autor Cassandra', 'OReilly', '2016', 'Bases de datos distribuidas.', 4, 4),
(2, '9788400000024', 'SQL Server Administration', 'Autor MSSQL', 'Microsoft Press', '2020', 'Admin. de MS SQL Server.', 6, 6),
(2, '9788400000025', 'Learning Spark', 'Autor Spark', 'OReilly', '2020', 'Procesamiento de datos a gran escala.', 7, 6),
(2, '9788400000026', 'Diseno de Data Marts', 'Autor Data Marts', 'Kimball Group', '2013', 'Modelado dimensional.', 5, 5);

-- Categoria 3: Inteligencia Artificial
INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, cantidad_total, cantidad_disponible) VALUES
(3, '9780262033848', 'Pattern Recognition and Machine Learning', 'Christopher Bishop', 'Springer', '2006', 'Un clasico del aprendizaje automatico.', 4, 4),
(3, '9780133351000', 'Inteligencia Artificial: Un Enfoque Moderno', 'Russell y Norvig', 'Prentice Hall', '2016', 'El libro de texto estandar de IA.', 6, 6),
(3, '9788400000027', 'Deep Learning con Python', 'Francois Chollet', 'Manning', '2017', 'Uso de Keras.', 8, 8),
(3, '9788400000028', 'Hands-On Machine Learning', 'Aurelien Geron', 'OReilly', '2019', 'Con Scikit-Learn y TensorFlow.', 10, 9),
(3, '9788400000029', 'Procesamiento de Lenguaje Natural', 'Autor NLP', 'NLP Press', '2020', 'NLP con Python.', 6, 6),
(3, '9788400000030', 'Introduccion a la Robotica', 'Autor Robotica', 'Robot Press', '2018', 'Mecanica y control.', 5, 5),
(3, '9788400000031', 'Vision por Computadora', 'Autor Vision', 'CV Press', '2021', 'Algoritmos y aplicaciones.', 7, 6),
(3, '9788400000032', 'Sistemas Expertos', 'Autor Sistemas Expertos', 'IA Editorial', '2015', 'Logica y motores de inferencia.', 4, 4),
(3, '9788400000033', 'Redes Neuronales desde Cero', 'Autor Redes', 'NN Press', '2019', 'Implementacion en Python.', 6, 6),
(3, '9788400000034', 'Aprendizaje por Refuerzo', 'Richard S. Sutton', 'MIT Press', '2018', 'Una introduccion.', 5, 5),
(3, '9788400000035', 'Logica Difusa y Aplicaciones', 'Autor Logica Difusa', 'Fuzzy Logic Books', '2017', 'Teoria y practica.', 3, 3),
(3, '9788400000036', 'Data Science para Negocios', 'Autor Data Science', 'OReilly', '2013', 'Ciencia de datos aplicada.', 9, 9),
(3, '9788400000037', 'Algoritmos Geneticos', 'Autor Geneticos', 'IA Editorial', '2019', 'Optimizacion y busqueda.', 5, 5),
(3, '9788400000038', 'PyTorch para Deep Learning', 'Autor PyTorch', 'Packt', '2020', 'Guia practica.', 6, 6),
(3, '9788400000039', 'Etica en Inteligencia Artificial', 'Autor Etica', 'Filosofia Tech', '2022', 'Riesgos y regulacion.', 7, 7);

-- Categoria 4: Redes y Seguridad
INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, cantidad_total, cantidad_disponible) VALUES
(4, '9780132126953', 'Redes de Computadoras', 'Andrew S. Tanenbaum', 'Pearson', '2010', 'Un enfoque descendente.', 5, 5),
(4, '9781593275609', 'Hacking: The Art of Exploitation', 'Jon Erickson', 'No Starch Press', '2008', 'Conceptos de hacking y seguridad.', 3, 3),
(4, '9788400000040', 'Seguridad Informatica: Hacking Etico', 'Autor Hacking', 'Seguridad Press', '2021', 'Pentesting.', 8, 8),
(4, '9788400000041', 'TCP/IP Ilustrado, Vol. 1', 'W. Richard Stevens', 'Addison-Wesley', '2011', 'Los protocolos.', 6, 6),
(4, '9788400000042', 'Criptografia y Seguridad de Redes', 'William Stallings', 'Pearson', '2017', 'Principios y practica.', 7, 7),
(4, '9788400000043', 'Wireshark: Analisis de Protocolos', 'Autor Wireshark', 'No Starch Press', '2018', 'Analisis de paquetes.', 5, 4),
(4, '9788400000044', 'Seguridad en Aplicaciones Web', 'Autor WebSec', 'OReilly', '2020', 'OWASP Top 10.', 6, 6),
(4, '9788400000045', 'Firewalls y Seguridad de Red', 'Autor Firewalls', 'Cisco Press', '2019', 'Diseno e implementacion.', 5, 5),
(4, '9788400000046', 'Gestion de Riesgos de Seguridad', 'Autor Riesgos', 'Seguridad Press', '2017', 'ISO 27001.', 4, 4),
(4, '9788400000047', 'Kubernetes: Seguridad', 'Autor Kubernetes', 'OReilly', '2021', 'Proteccion de clusters.', 6, 6),
(4, '9788400000048', 'Analisis Forense Digital', 'Autor Forense', 'Wiley', '2019', 'Investigacion digital.', 5, 5),
(4, '9788400000049', 'Metasploit: Guia de Pentesting', 'Autor Metasploit', 'No Starch Press', '2011', 'Para hackers.', 3, 3),
(4, '9788400000050', 'Diseno de Redes LAN/WAN', 'Autor Redes', 'Cisco Press', '2020', 'Arquitectura de red.', 7, 7),
(4, '9788400000051', 'Seguridad en la Nube (Cloud Security)', 'Autor Cloud', 'Cloud Press', '2022', 'AWS, Azure y GCP.', 8, 8),
(4, '9788400000052', 'Malware Analysis', 'Autor Malware', 'No Starch Press', '2015', 'Analisis de software malicioso.', 4, 4);

-- Categoria 5: Sistemas Operativos
INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, cantidad_total, cantidad_disponible) VALUES
(5, '9780133591620', 'Sistemas Operativos Modernos', 'Andrew S. Tanenbaum', 'Pearson', '2014', 'Conceptos y diseno de SO.', 4, 4),
(5, '9781118063330', 'Linux Bible', 'Christopher Negus', 'Wiley', '2012', 'Guia completa de Linux.', 5, 5),
(5, '9788400000053', 'Diseno e Implementacion de Sistemas Operativos', 'A. Tanenbaum', 'Prentice Hall', '2006', 'Basado en MINIX.', 5, 5),
(5, '9788400000054', 'Administracion de Windows Server', 'Autor Windows', 'Microsoft Press', '2021', 'Active Directory y mas.', 6, 6),
(5, '9788400000055', 'Shell Scripting en Linux', 'Autor Shell', 'Linux Press', '2019', 'Automatizacion con Bash.', 7, 7),
(5, '9788400000056', 'Conceptos Internos de macOS', 'Autor macOS', 'Apple Press', '2018', 'Arquitectura de XNU.', 4, 4),
(5, '9788400000057', 'Virtualizacion y Cloud Computing', 'Autor Cloud', 'VMware Press', '2020', 'VMs y contenedores.', 8, 8),
(5, '9788400000058', 'Linux Kernel Development', 'Robert Love', 'Addison-Wesley', '2010', 'Desarrollo del kernel.', 5, 4),
(5, '9788400000059', 'Administracion de Red Hat (RHCSA)', 'Autor Red Hat', 'Red Hat Press', '2022', 'Guia de certificacion.', 6, 6),
(5, '9788400000060', 'Sistemas de Archivos', 'Autor FS', 'Tech Press', '2017', 'Diseno e implementacion.', 3, 3),
(5, '9788400000061', 'Docker: Up & Running', 'Autor Docker', 'OReilly', '2020', 'Contenedores.', 9, 9),
(5, '9788400000062', 'Sistemas Distribuidos', 'George Coulouris', 'Pearson', '2011', 'Conceptos y diseno.', 5, 5),
(5, '9788400000063', 'Programacion de Sistemas en Linux', 'Autor Linux Sys', 'Linux Press', '2019', 'APIs del sistema.', 4, 4),
(5, '9788400000064', 'PowerShell para Administradores', 'Autor PowerShell', 'Microsoft Press', '2021', 'Automatizacion en Windows.', 6, 6),
(5, '9780139411802', 'UNIX: El Entorno de Programacion', 'Kernighan y Pike', 'Prentice Hall', '1984', 'Un clasico.', 5, 5);

-- Categoria 6: Diseno Grafico
INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, cantidad_total, cantidad_disponible) VALUES
(6, '9780321700676', 'La Interaccion del Color', 'Josef Albers', 'Yale University Press', '2010', 'Estudio de la teoria del color.', 3, 3),
(6, '9780470650651', 'No me hagas pensar', 'Steve Krug', 'New Riders', '2014', 'Usabilidad y diseno web.', 5, 5),
(6, '9788400000066', 'Psicologia del Color', 'Eva Heller', 'GG', '2000', 'Como actuan los colores.', 8, 8),
(6, '9788400000067', 'Logo Design Love', 'David Airey', 'New Riders', '2009', 'Diseno de logos.', 7, 7),
(6, '9788400000068', 'Fundamentos del Diseno (Bauhaus)', 'Wassily Kandinsky', 'Paidos', '1926', 'Punto y linea sobre el plano.', 5, 5),
(6, '9788400000069', 'Adobe Photoshop: Aula Creativa', 'Autor Photoshop', 'Anaya', '2022', 'Fotomanipulacion.', 10, 9),
(6, '9788400000070', 'Adobe Illustrator: Aula Creativa', 'Autor Illustrator', 'Anaya', '2022', 'Diseno vectorial.', 9, 9),
(6, '9788400000071', 'Diseno de Interfaces (UI/UX)', 'Autor UI/UX', 'UX Press', '2021', 'Principios de diseno de UI.', 8, 8),
(6, '9788400000072', 'Tipografia: Manual de Diseno', 'Emil Ruder', 'GG', '1967', 'Un manual de tipografia.', 6, 6),
(6, '9788400000073', 'Diseno de UX (Experiencia de Usuario)', 'Autor UX', 'OReilly', '2019', 'Investigacion y prototipado.', 7, 7),
(6, '9788400000074', 'La Sintaxis de la Imagen', 'D. A. Dondis', 'GG', '1973', 'Introduccion al alfabeto visual.', 5, 5),
(6, '9788400000075', 'Adobe InDesign: Aula Creativa', 'Autor InDesign', 'Anaya', '2022', 'Maquetacion y diseno editorial.', 6, 6),
(6, '9788400000076', 'Branding: Gestion de Marca', 'Autor Branding', 'Brand Press', '2020', 'Estrategia de marca.', 7, 7),
(6, '9788400000077', 'Historia del Diseno Grafico', 'Philip B. Meggs', 'Wiley', '2016', 'Un recorrido historico.', 4, 4),
(6, '9788400000078', 'Figma: Guia de Diseno Colaborativo', 'Autor Figma', 'UX Press', '2021', 'Diseno de interfaces en la nube.', 8, 8);

-- Categoria 7: Matematicas
INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, cantidad_total, cantidad_disponible) VALUES
(7, '9780534351890', 'Calculo: Trascendentes Tempranas', 'James Stewart', 'Cengage', '2011', 'El libro estandar de calculo.', 6, 6),
(7, '9780321795434', 'Algebra Lineal y sus Aplicaciones', 'David C. Lay', 'Pearson', '2015', 'Introduccion al algebra lineal.', 4, 4),
(7, '9788400000079', 'Matematica Discreta y sus Aplicaciones', 'Kenneth Rosen', 'McGraw-Hill', '2012', 'Para ciencias de la computacion.', 9, 9),
(7, '9788400000080', 'Probabilidad y Estadistica', 'Morris H. DeGroot', 'Pearson', '2011', 'Para ingenieria.', 8, 7),
(7, '9780262033849', 'Introduccion a los Algoritmos (CLRS)', 'Cormen, Leiserson', 'MIT Press', '2009', 'La biblia de algoritmos.', 7, 6),
(7, '9788400000082', 'Calculo Vectorial', 'Autor Vectorial', 'Math Press', '2018', 'Geometria y vectores.', 6, 6),
(7, '9788400000083', 'Ecuaciones Diferenciales', 'Dennis G. Zill', 'Cengage', '2017', 'Con aplicaciones.', 5, 5),
(7, '9788400000084', 'Teoria de Numeros', 'Autor Numeros', 'Number Press', '2019', 'Introduccion a la teoria.', 4, 4),
(7, '9788400000085', 'Analisis Matematico', 'Autor Analisis', 'Math Press', '2017', 'Fundamentos del calculo.', 5, 5),
(7, '9788400000086', 'El Hombre que Calculaba', 'Malba Tahan', 'Record', '1949', 'Aventuras matematicas.', 10, 10),
(7, '9788400000087', 'Optimizacion y Programacion Lineal', 'Autor Optimizacion', 'Springer', '2016', 'Metodos y modelos.', 6, 6),
(7, '9788400000088', 'Geometria Euclidiana', 'Euclides', 'Clasicos', '300 AC', 'Los Elementos.', 5, 5),
(7, '9788400000089', 'Estadistica Aplicada', 'Autor Estadistica', 'Data Press', '2021', 'Estadistica para ciencia de datos.', 7, 7),
(7, '9788400000090', 'Variable Compleja', 'Autor Compleja', 'Math Press', '2019', 'Funciones de variable compleja.', 4, 4),
(7, '9788400000091', 'Fisica Universitaria Vol. 1', 'Sears y Zemansky', 'Pearson', '2018', 'Mecanica.', 8, 8);

-- Categoria 8: Literatura
INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, cantidad_total, cantidad_disponible) VALUES
(8, '9780307387899', 'Cien Anos de Soledad', 'Gabriel Garcia Marquez', 'Vintage', '1967', 'Realismo magico.', 7, 6),
(8, '9780679720218', '1984', 'George Orwell', 'Signet Classic', '1949', 'Novela distopica.', 8, 8),
(8, '9788400000092', 'Don Quijote de la Mancha', 'Miguel de Cervantes', 'RAE', '1605', 'Novela moderna.', 10, 10),
(8, '9788400000093', 'Orgullo y Prejuicio', 'Jane Austen', 'Penguin', '1813', 'Novela romantica.', 8, 7),
(8, '9788400000094', 'Ulises', 'James Joyce', 'Vintage', '1922', 'Modernismo.', 3, 2),
(8, '9788400000095', 'El Extranjero', 'Albert Camus', 'Alianza', '1942', 'Existencialismo.', 7, 7),
(8, '9788400000096', 'Ficciones', 'Jorge Luis Borges', 'Debolsillo', '1944', 'Relatos cortos.', 9, 9),
(8, '9788400000097', 'Moby Dick', 'Herman Melville', 'Penguin', '1851', 'Novela marina.', 6, 6),
(8, '9788400000098', 'Guerra y Paz', 'Leon Tolstoi', 'Penguin', '1869', 'Novela historica rusa.', 5, 5),
(8, '9788400000099', 'El Gran Gatsby', 'F. Scott Fitzgerald', 'Scribner', '1925', 'La era del jazz.', 8, 8),
(8, '9788400000100', 'Crimen y Castigo', 'Fiodor Dostoievski', 'Alianza', '1866', 'Novela psicologica.', 7, 7),
(8, '9788400000101', 'La Metamorfosis', 'Franz Kafka', 'Catedra', '1915', 'Relato.', 10, 10),
(8, '9788400000102', 'En Busca del Tiempo Perdido', 'Marcel Proust', 'Valdemar', '1913', 'Novela.', 2, 2),
(8, '9788400000103', 'El Amor en los Tiempos del Colera', 'Gabriel Garcia Marquez', 'Debolsillo', '1985', 'Novela.', 9, 9),
(8, '9788400000104', 'Tokio Blues (Norwegian Wood)', 'Haruki Murakami', 'Tusquets', '1987', 'Novela contemporanea.', 8, 8);

-- Categoria 9: Historia
INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, cantidad_total, cantidad_disponible) VALUES
(9, '9780060935467', 'Breve Historia del Tiempo', 'Stephen Hawking', 'Bantam', '1988', 'Divulgacion cientifica e historia.', 5, 5),
(9, '9780743226719', 'Sapiens: De animales a dioses', 'Yuval Noah Harari', 'Harper', '2015', 'Breve historia de la humanidad.', 10, 9),
(9, '9788400000105', 'Armas, Germenes y Acero', 'Jared Diamond', 'Debate', '1997', 'El destino de las sociedades.', 7, 7),
(9, '9788400000106', 'La Segunda Guerra Mundial', 'Antony Beevor', 'Critica', '2012', 'Historia militar.', 6, 6),
(9, '9788400000107', 'Historia de Roma', 'Indro Montanelli', 'Debolsillo', '1957', 'Desde la fundacion.', 8, 8),
(9, '9788400000108', 'Revolucion Francesa', 'Autor Francesa', 'Historia Press', '2019', 'Ensayo historico.', 5, 5),
(9, '9788400000109', 'El Siglo de las Luces', 'Autor Luces', 'Historia Press', '2017', 'La Ilustracion.', 6, 6),
(9, '9788400000110', 'Mitologia Griega', 'Robert Graves', 'Alianza', '1955', 'Los mitos griegos.', 9, 9),
(9, '9788400000111', 'Historia de Estados Unidos', 'Howard Zinn', 'Siglo XXI', '1980', 'La otra historia.', 7, 7),
(9, '9788400000112', 'El Antiguo Egipto', 'Autor Egipto', 'Egipto Press', '2018', 'Faraones y piramides.', 5, 5),
(9, '9788400000113', 'La Ruta de la Seda', 'Peter Frankopan', 'Critica', '2015', 'Una nueva historia del mundo.', 6, 6),
(9, '9788400000114', 'Historia de Colombia', 'Autor Colombia', 'Planeta', '2020', 'Historia del pais.', 8, 8),
(9, '9788400000115', 'Los Vikingos', 'Autor Vikingos', 'Viking Press', '2016', 'Era vikinga.', 5, 5),
(9, '9788400000116', 'El Renacimiento', 'Autor Renacimiento', 'Arte Press', '2017', 'Arte e historia.', 6, 6),
(9, '9788400000117', 'GULAG: Historia de los campos sovieticos', 'Anne Applebaum', 'Debate', '2003', 'Historia sovietica.', 4, 4);

-- Categoria 10: Negocios y Finanzas
INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, cantidad_total, cantidad_disponible) VALUES
(10, '9780132369421', 'El Inversor Inteligente', 'Benjamin Graham', 'HarperBusiness', '1949', 'El libro definitivo sobre value investing.', 5, 5),
(10, '9780812971328', 'El Cisne Negro', 'Nassim Nicholas Taleb', 'Random House', '2007', 'El impacto de lo altamente improbable.', 4, 4),
(10, '9788400000118', 'Padre Rico, Padre Pobre', 'Robert Kiyosaki', 'Aguilar', '1997', 'Educacion financiera.', 10, 10),
(10, '9788400000119', 'El Metodo Lean Startup', 'Eric Ries', 'Crown Business', '2011', 'Creacion de empresas.', 8, 8),
(10, '9788400000120', 'Marketing 4.0', 'Philip Kotler', 'Wiley', '2017', 'De tradicional a digital.', 7, 7),
(10, '9788400000121', 'Principios', 'Ray Dalio', 'Simon & Schuster', '2017', 'Vida y trabajo.', 6, 6),
(10, '9788400000122', 'La Estrategia del Oceano Azul', 'W. Chan Kim', 'Harvard Business', '2005', 'Crear nuevos mercados.', 7, 7),
(10, '9788400000123', 'Pensar rapido, pensar despacio', 'Daniel Kahneman', 'Debate', '2011', 'Economia conductual.', 6, 6),
(10, '9788400000124', 'Contabilidad para Dummies', 'Autor Contabilidad', 'Para Dummies', '2021', 'Conceptos basicos.', 9, 9),
(10, '9788400000125', 'El MBA Personal', 'Josh Kaufman', 'Portfolio', '2010', 'Conceptos de negocios.', 7, 7),
(10, '9788400000126', 'Como ganar amigos e influir sobre las personas', 'Dale Carnegie', 'Simon & Schuster', '1936', 'Habilidades sociales.', 10, 10),
(10, '9788400000127', 'De Cero a Uno', 'Peter Thiel', 'Crown Business', '2014', 'Startups y futuro.', 6, 6),
(10, '9788400000128', 'La Riqueza de las Naciones', 'Adam Smith', 'Alianza', '1776', 'Economia clasica.', 4, 4),
(10, '9788400000129', 'Freakonomics', 'Levitt y Dubner', 'HarperCollins', '2005', 'El lado oculto de la economia.', 8, 8),
(10, '9788400000130', 'Gestion de Proyectos (PMBOK)', 'PMI', 'PMI', '2021', 'Guia de gestion.', 5, 5);

-- -----------------------------------------------------
-- 4. TABLA PRESTAMO
-- Insertamos 20 prestamos en diferentes estados (5 de cada uno).
-- ID_ESTADO_PRESTAMO: 1=solicitado, 2=activo, 3=devuelto, 4=vencido
-- -----------------------------------------------------

-- 5 prestamos 'activos' (ID 2)
-- (Usamos fechas futuras para la devolucion esperada)
INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, id_estado_prestamo) VALUES
(1, 1, '2025-10-10 10:00:00', '2025-10-24 10:00:00', NULL, 2),
(2, 4, '2025-10-12 11:00:00', '2025-10-26 11:00:00', NULL, 2),
(3, 15, '2025-10-15 14:00:00', '2025-10-29 14:00:00', NULL, 2),
(6, 20, '2025-10-18 09:00:00', '2025-11-01 09:00:00', NULL, 2),
(11, 30, '2025-10-19 16:00:00', '2025-11-02 16:00:00', NULL, 2);

-- 5 prestamos 'devueltos' (ID 3)
-- (Usamos fechas pasadas y fecha_devolucion_real ESTA llena)
INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, id_estado_prestamo) VALUES
(4, 3, '2025-09-01 10:00:00', '2025-09-15 10:00:00', '2025-09-14 11:00:00', 3),
(5, 5, '2025-09-02 11:00:00', '2025-09-16 11:00:00', '2025-09-16 10:00:00', 3),
(7, 6, '2025-09-03 14:00:00', '2025-09-17 14:00:00', '2025-09-15 15:00:00', 3),
(8, 8, '2025-09-05 09:00:00', '2025-09-19 09:00:00', '2025-09-18 12:00:00', 3),
(9, 9, '2025-09-10 16:00:00', '2025-09-24 16:00:00', '2025-09-22 17:00:00', 3);

-- 5 prestamos 'vencidos' (ID 4)
-- (Usamos fechas pasadas y fecha_devolucion_real es NULL)
INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, id_estado_prestamo) VALUES
(13, 2, '2025-09-01 10:00:00', '2025-09-15 10:00:00', NULL, 4),
(23, 10, '2025-09-03 11:00:00', '2025-09-17 11:00:00', NULL, 4),
(25, 12, '2025-09-05 14:00:00', '2025-09-19 14:00:00', NULL, 4),
(10, 1, '2025-09-10 09:00:00', '2025-09-24 09:00:00', NULL, 4),
(14, 18, '2025-09-15 16:00:00', '2025-09-29 16:00:00', NULL, 4);

-- 5 prestamos 'solicitados' (ID 1)
-- (Usamos fechas de hoy, el estado es 1)
INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, id_estado_prestamo) VALUES
(15, 50, '2025-10-20 10:00:00', '2025-11-03 10:00:00', NULL, 1),
(1, 60, '2025-10-20 11:00:00', '2025-11-03 11:00:00', NULL, 1),
(2, 70, '2025-10-20 12:00:00', '2025-11-03 12:00:00', NULL, 1),
(3, 80, '2025-10-20 13:00:00', '2025-11-03 13:00:00', NULL, 1),
(5, 90, '2025-10-20 14:00:00', '2025-11-03 14:00:00', NULL, 1);


-- -----------------------------------------------------
-- 5. TABLA RESERVA
-- Insertamos 10 reservas.
-- ID_ESTADO_RESERVA: 1=pendiente, 3=cancelada
-- -----------------------------------------------------
INSERT INTO reserva (id_usuario, id_libro, fecha_reserva, id_estado_reserva) VALUES
(8, 1, '2025-10-05 10:00:00', 1), -- Pendiente para libro 1 (activo)
(9, 1, '2025-10-06 11:00:00', 1), -- Pendiente para libro 1 (activo)
(10, 1, '2025-10-07 12:00:00', 3), -- Cancelada para libro 1
(11, 4, '2025-10-08 14:00:00', 1), -- Pendiente para libro 4 (activo)
(12, 15, '2025-10-09 09:00:00', 1), -- Pendiente para libro 15 (activo)
(1, 2, '2025-10-10 16:00:00', 1), -- Pendiente para libro 2 (vencido)
(3, 18, '2025-10-11 10:00:00', 1), -- Pendiente para libro 18 (vencido)
(4, 10, '2025-10-12 11:00:00', 1), -- Pendiente para libro 10 (vencido)
(6, 11, '2025-10-13 12:00:00', 3), -- Cancelada
(7, 12, '2025-10-14 14:00:00', 1); -- Pendiente para libro 12 (vencido)


-- -----------------------------------------------------
-- 6. TABLA USUARIO_RESPUESTA
-- Insertamos datos para las preguntas de seguridad (US_1, US_4)
-- ID_PREGUNTA: 1='mascota', 2='comida', 3='abuela', 4='ciudad'
-- -----------------------------------------------------
INSERT INTO usuario_respuesta (id_usuario, id_pregunta, respuesta) VALUES
(1, 1, 'Fido'),
(1, 4, 'Bogota'),
(2, 2, 'Pizza'),
(3, 1, 'Misi'),
(4, 3, 'Elena'),
(5, 4, 'Cartagena'),
(11, 1, 'Bruno'),
(16, 2, 'Ajiaco');

-- -----------------------------------------------------
-- 7. TABLAS DE AUDITORIA (DATOS DE PRUEBA)
-- Insertamos datos simulados para probar las consultas
-- de auditoria (US_11 y US_20).
-- -----------------------------------------------------

-- 7.1. auditoria_libro
-- Simulamos que el bibliotecario (ID 11, Ricardo Alvarez)
-- ha editado algunos libros.
INSERT INTO auditoria_libro (id_libro, id_usuario_admin, fecha_evento, descripcion_cambio) VALUES
(1, 11, '2025-06-01 10:00:00', 'Se actualizo la descripcion del libro Codigo Limpio.'),
(3, 12, '2025-06-05 14:20:00', 'Correcion en el nombre del autor.'),
(10, 11, '2025-07-10 09:00:00', 'Se agrego la URL de la portada.');

-- 7.2. auditoria_usuario
-- Simulamos eventos de seguridad.
-- Admin (ID 21, Hugo Luna) gestiona cuentas.
INSERT INTO auditoria_usuario (id_usuario_afectado, id_usuario_admin, fecha_evento, tipo_accion, descripcion) VALUES
(10, 21, '2025-03-05 10:00:00', 'CAMBIO_ESTADO', 'Cuenta de javier.morales puesta como inactiva.'),
(2, NULL, '2025-10-19 08:15:00', 'LOGIN_FALLIDO', 'Intento de inicio de sesion fallido para bruno.fernandez'),
(2, NULL, '2025-10-19 08:15:30', 'LOGIN_FALLIDO', 'Intento de inicio de sesion fallido para bruno.fernandez'),
(28, 21, '2025-09-01 11:00:00', 'RESETEO_PASS', 'Admin reseteo la contrasena para luis.rojas.'),
(25, 22, '2025-08-20 12:00:00', 'BLOQUEO_CUENTA', 'Cuenta bloqueada por admin Ines Medina por seguridad.');

USE biblioteca_digital;

-- Indices para la tabla: usuario
CREATE INDEX idx_usuario_tipo ON usuario (id_tipo_usuario);
CREATE INDEX idx_usuario_estado ON usuario (id_estado_usuario);

-- Indices para la tabla: libro
CREATE INDEX idx_libro_categoria ON libro (id_categoria);

-- Indices para la tabla: prestamo (Las más importantes)
CREATE INDEX idx_prestamo_usuario ON prestamo (id_usuario);
CREATE INDEX idx_prestamo_libro ON prestamo (id_libro);
CREATE INDEX idx_prestamo_estado ON prestamo (id_estado_prestamo);

-- Indices para la tabla: reserva
CREATE INDEX idx_reserva_usuario ON reserva (id_usuario);
CREATE INDEX idx_reserva_libro ON reserva (id_libro);
CREATE INDEX idx_reserva_estado ON reserva (id_estado_reserva);

-- Indices para la tabla: usuario_respuesta
CREATE INDEX idx_respuesta_usuario ON usuario_respuesta (id_usuario);
CREATE INDEX idx_respuesta_pregunta ON usuario_respuesta (id_pregunta);

-- Indices para la tabla: auditoria_usuario
CREATE INDEX idx_auditoria_usu_afectado ON auditoria_usuario (id_usuario_afectado);
CREATE INDEX idx_auditoria_usu_admin ON auditoria_usuario (id_usuario_admin);

-- Indices para la tabla: auditoria_libro
CREATE INDEX idx_auditoria_lib_libro ON auditoria_libro (id_libro);
CREATE INDEX idx_auditoria_lib_admin ON auditoria_libro (id_usuario_admin);