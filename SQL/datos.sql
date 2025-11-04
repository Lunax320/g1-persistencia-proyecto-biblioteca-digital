
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

-- =========================
-- ESTUDIANTES (10)
-- =========================
INSERT INTO usuario (username, nombre, contrasena, email, id_tipo_usuario, id_estado_usuario, fecha_registro, requiere_cambio_pass, intentos_fallidos) VALUES
('ana.garcia', 'Ana Garcia', 'Pwd_ana.garcia!', 'ana.garcia@universidad.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='estudiante' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-02-10 00:00:00', 0, 0),
('bruno.fernandez', 'Bruno Fernandez', 'Pwd_bruno.fernandez!', 'bruno.fernandez@universidad.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='estudiante' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-02-11 00:00:00', 0, 0),
('carla.martinez', 'Carla Martinez', 'Pwd_carla.martinez!', 'carla.martinez@universidad.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='estudiante' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-02-12 00:00:00', 0, 0),
('david.rodriguez', 'David Rodriguez', 'Pwd_david.rodriguez!', 'david.rodriguez@universidad.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='estudiante' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-02-13 00:00:00', 0, 0),
('elena.gomez', 'Elena Gomez', 'Pwd_elena.gomez!', 'elena.gomez@universidad.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='estudiante' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-02-14 00:00:00', 0, 0),
('felipe.torres', 'Felipe Torres', 'Pwd_felipe.torres!', 'felipe.torres@universidad.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='estudiante' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-03-01 00:00:00', 0, 0),
('gabriela.ruiz', 'Gabriela Ruiz', 'Pwd_gabriela.ruiz!', 'gabriela.ruiz@universidad.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='estudiante' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-03-02 00:00:00', 0, 0),
('hector.diaz', 'Hector Diaz', 'Pwd_hector.diaz!', 'hector.diaz@universidad.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='estudiante' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-03-03 00:00:00', 0, 0),
('irene.sanchez', 'Irene Sanchez', 'Pwd_irene.sanchez!', 'irene.sanchez@universidad.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='estudiante' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-03-04 00:00:00', 0, 0),
('javier.morales', 'Javier Morales', 'Pwd_javier.morales!', 'javier.morales@universidad.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='estudiante' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='inactivo' LIMIT 1),
 '2025-03-05 00:00:00', 0, 0);

-- =========================
-- BIBLIOTECARIOS (10)
-- =========================
INSERT INTO usuario (username, nombre, contrasena, email, id_tipo_usuario, id_estado_usuario, fecha_registro, requiere_cambio_pass, intentos_fallidos) VALUES
('ricardo.alvarez', 'Ricardo Alvarez', 'Pwd_ricardo.alvarez!', 'ricardo.alvarez@biblioteca.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='bibliotecario' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2024-01-15 00:00:00', 0, 0),
('sofia.mendoza', 'Sofia Mendoza', 'Pwd_sofia.mendoza!', 'sofia.mendoza@biblioteca.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='bibliotecario' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2024-01-15 00:00:00', 0, 0),
('tomas.herrera', 'Tomas Herrera', 'Pwd_tomas.herrera!', 'tomas.herrera@biblioteca.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='bibliotecario' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2024-01-15 00:00:00', 0, 0),
('valeria.campos', 'Valeria Campos', 'Pwd_valeria.campos!', 'valeria.campos@biblioteca.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='bibliotecario' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2024-02-20 00:00:00', 0, 0),
('walter.navarro', 'Walter Navarro', 'Pwd_walter.navarro!', 'walter.navarro@biblioteca.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='bibliotecario' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2024-02-20 00:00:00', 0, 0),
('ximena.flores', 'Ximena Flores', 'Pwd_ximena.flores!', 'ximena.flores@biblioteca.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='bibliotecario' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2024-03-10 00:00:00', 0, 0),
('yara.pinto', 'Yara Pinto', 'Pwd_yara.pinto!', 'yara.pinto@biblioteca.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='bibliotecario' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2024-03-10 00:00:00', 0, 0),
('zacarias.leon', 'Zacarias Leon', 'Pwd_zacarias.leon!', 'zacarias.leon@biblioteca.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='bibliotecario' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='inactivo' LIMIT 1),
 '2024-04-01 00:00:00', 0, 0),
('andrea.solis', 'Andrea Solis', 'Pwd_andrea.solis!', 'andrea.solis@biblioteca.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='bibliotecario' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2024-04-01 00:00:00', 0, 0),
('benjamin.castro', 'Benjamin Castro', 'Pwd_benjamin.castro!', 'benjamin.castro@biblioteca.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='bibliotecario' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2024-05-15 00:00:00', 0, 0);

-- =========================
-- ADMINISTRADORES (10)  -- requiere_cambio_pass = 1
-- =========================
INSERT INTO usuario (username, nombre, contrasena, email, id_tipo_usuario, id_estado_usuario, fecha_registro, requiere_cambio_pass, intentos_fallidos) VALUES
('hugo.luna', 'Hugo Luna', 'Pwd_hugo.luna!', 'hugo.luna@admin.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='administrador' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-01-20 00:00:00', 1, 0),
('ines.medina', 'Ines Medina', 'Pwd_ines.medina!', 'ines.medina@admin.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='administrador' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-01-21 00:00:00', 1, 0),
('jorge.ponce', 'Jorge Ponce', 'Pwd_jorge.ponce!', 'jorge.ponce@admin.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='administrador' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-01-22 00:00:00', 1, 0),
('karina.salas', 'Karina Salas', 'Pwd_karina.salas!', 'karina.salas@admin.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='administrador' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-02-25 00:00:00', 1, 0),
('luis.rojas', 'Luis Rojas', 'Pwd_luis.rojas!', 'luis.rojas@admin.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='administrador' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='inactivo' LIMIT 1),
 '2025-02-26 00:00:00', 1, 0),
('monica.bravo', 'Monica Bravo', 'Pwd_monica.bravo!', 'monica.bravo@admin.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='administrador' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-02-27 00:00:00', 1, 0),
('nicolas.silva', 'Nicolas Silva', 'Pwd_nicolas.silva!', 'nicolas.silva@admin.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='administrador' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-03-20 00:00:00', 1, 0),
('olga.pena', 'Olga Pena', 'Pwd_olga.pena!', 'olga.pena@admin.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='administrador' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-03-21 00:00:00', 1, 0),
('patricio.arias', 'Patricio Arias', 'Pwd_patricio.arias!', 'patricio.arias@admin.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='administrador' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-03-22 00:00:00', 1, 0),
('quintin.nunez', 'Quintin Nunez', 'Pwd_quintin.nunez!', 'quintin.nunez@admin.edu.co',
 (SELECT id_tipo_usuario FROM tipo_usuario_catalogo WHERE nombre='administrador' LIMIT 1),
 (SELECT id_estado_usuario FROM estado_usuario_catalogo WHERE nombre='activo' LIMIT 1),
 '2025-04-05 00:00:00', 1, 0);
-- -----------------------------------------------------
-- 3. TABLA LIBRO
-- Insertamos 150 libros: 15 en cada categoria (ID 1-10)
-- -----------------------------------------------------
-- Categoria 1: Programacion
SET @cat_prog := (SELECT id_categoria FROM categoria WHERE nombre = 'Programacion');

-- Inserta los libros de Programacion usando el id por consulta
INSERT INTO libro (
  id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, portada_url, cantidad_total, cantidad_disponible
) VALUES
(@cat_prog, '9780132350884', 'Codigo Limpio', 'Robert C. Martin', 'Prentice Hall', '2008', 'Un manual de artesania de software agil.', 'https://cdn.biblioteca.edu/covers/9780132350884.jpg', 5, 4),
(@cat_prog, '9780201633610', 'Patrones de Diseno', 'Erich Gamma', 'Addison-Wesley', '1994', 'Elementos de software orientado a objetos reutilizable.', 'https://cdn.biblioteca.edu/covers/9780201633610.jpg', 4, 3),
(@cat_prog, '9788400000001', 'Programacion Orientada a Objetos Explicada', 'Autor POO', 'Editorial Tech', '2020', 'Conceptos de POO.', 'https://cdn.biblioteca.edu/covers/9788400000001.jpg', 5, 5),
(@cat_prog, '9788400000002', 'Python para Analisis de Datos', 'Autor Python', 'Data Press', '2021', 'Uso de Pandas y NumPy.', 'https://cdn.biblioteca.edu/covers/9788400000002.jpg', 7, 6),
(@cat_prog, '9788400000003', 'JavaScript: La Guia Definitiva', 'Autor JS', 'OReilly', '2020', 'JavaScript a fondo.', 'https://cdn.biblioteca.edu/covers/9788400000003.jpg', 10, 10),
(@cat_prog, '9788400000004', 'Estructuras de Datos en Java', 'Autor Java', 'Pearson', '2019', 'Algoritmos y estructuras.', 'https://cdn.biblioteca.edu/covers/9788400000004.jpg', 8, 7),
(@cat_prog, '9788400000005', 'Desarrollo Web con React', 'Autor React', 'React Press', '2022', 'Creacion de SPAs.', 'https://cdn.biblioteca.edu/covers/9788400000005.jpg', 6, 6),
(@cat_prog, '9788400000006', 'Introduccion a C#', 'Autor CSharp', 'Microsoft Press', '2018', 'Conceptos basicos de .NET.', 'https://cdn.biblioteca.edu/covers/9788400000006.jpg', 5, 5),
(@cat_prog, '9780201616161', 'El Programador Pragmatico', 'Andrew Hunt', 'Addison-Wesley', '1999', 'De aprendiz a maestro.', 'https://cdn.biblioteca.edu/covers/9780201616161.jpg', 4, 3),
(@cat_prog, '9788400000008', 'Aprendiendo SQL', 'Autor SQL', 'OReilly', '2017', 'Consultas y manejo de datos.', 'https://cdn.biblioteca.edu/covers/9788400000008.jpg', 9, 9),
(@cat_prog, '9788400000009', 'Go en la Practica', 'Autor Go', 'Manning', '2019', 'Lenguaje Go de Google.', 'https://cdn.biblioteca.edu/covers/9788400000009.jpg', 3, 3),
(@cat_prog, '9788400000010', 'Ruby on Rails Tutorial', 'Michael Hartl', 'Addison-Wesley', '2021', 'Desarrollo web agil.', 'https://cdn.biblioteca.edu/covers/9788400000010.jpg', 5, 5),
(@cat_prog, '9780134494166', 'Clean Architecture', 'Robert C. Martin', 'Prentice Hall', '2017', 'Arquitectura de software.', 'https://cdn.biblioteca.edu/covers/9780134494166.jpg', 6, 4),
(@cat_prog, '9788400000012', 'Programacion Funcional con Scala', 'Autor Scala', 'Scala Books', '2020', 'Paradigmas funcionales.', 'https://cdn.biblioteca.edu/covers/9788400000012.jpg', 4, 4),
(@cat_prog, '9788400000013', 'Kotlin para Android', 'Autor Kotlin', 'Android Dev', '2021', 'Desarrollo movil.', 'https://cdn.biblioteca.edu/covers/9788400000013.jpg', 7, 7);

-- Categoria 2: Bases de Datos

SET @cat_bd := (SELECT id_categoria FROM categoria WHERE nombre = 'Bases de Datos');

INSERT INTO libro (
  id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, portada_url, cantidad_total, cantidad_disponible
) VALUES
(@cat_bd, '9780132365638', 'Database System Concepts', 'Silberschatz', 'McGraw-Hill', '2010', 'La biblia de las bases de datos.', 'https://cdn.biblioteca.edu/covers/9780132365638.jpg', 5, 5),
(@cat_bd, '9781449344020', 'MongoDB: The Definitive Guide', 'Kristina Chodorow', 'OReilly', '2013', 'Guía de la base de datos NoSQL MongoDB.', 'https://cdn.biblioteca.edu/covers/9781449344020.jpg', 3, 2),
(@cat_bd, '9788400000014', 'Diseño de Bases de Datos Relacionales', 'Autor Diseno DB', 'DB Press', '2019', 'Normalización y ER.', 'https://cdn.biblioteca.edu/covers/9788400000014.jpg', 6, 6),
(@cat_bd, '9788400000015', 'SQL Avanzado: Optimización', 'Autor SQL Avanzado', 'OReilly', '2021', 'Query performance tuning.', 'https://cdn.biblioteca.edu/covers/9788400000015.jpg', 5, 4),
(@cat_bd, '9788400000016', 'PostgreSQL: Up and Running', 'Autor PostgreSQL', 'OReilly', '2018', 'Administración de PostgreSQL.', 'https://cdn.biblioteca.edu/covers/9788400000016.jpg', 7, 7),
(@cat_bd, '9788400000017', 'Redis Essentials', 'Autor Redis', 'Packt', '2015', 'Bases de datos en memoria.', 'https://cdn.biblioteca.edu/covers/9788400000017.jpg', 4, 3),
(@cat_bd, '9788400000018', 'Modelado de Datos NoSQL', 'Autor NoSQL', 'NoSQL Press', '2020', 'Diseño para NoSQL.', 'https://cdn.biblioteca.edu/covers/9788400000018.jpg', 6, 6),
(@cat_bd, '9788400000019', 'MySQL High Availability', 'Autor MySQL', 'OReilly', '2021', 'Clusters y replicación.', 'https://cdn.biblioteca.edu/covers/9788400000019.jpg', 5, 5),
(@cat_bd, '9788400000020', 'Neo4j in Action', 'Autor Neo4j', 'Manning', '2017', 'Bases de datos de grafos.', 'https://cdn.biblioteca.edu/covers/9788400000020.jpg', 3, 3),
(@cat_bd, '9788400000021', 'Fundamentos de Big Data', 'Autor Big Data', 'Data Science Editorial', '2019', 'Hadoop y Spark.', 'https://cdn.biblioteca.edu/covers/9788400000021.jpg', 8, 7),
(@cat_bd, '9788400000022', 'Data Warehousing Fundamentals', 'Autor DW', 'Wiley', '2014', 'Conceptos de bodegas de datos.', 'https://cdn.biblioteca.edu/covers/9788400000022.jpg', 5, 5),
(@cat_bd, '9788400000023', 'Cassandra: The Definitive Guide', 'Autor Cassandra', 'OReilly', '2016', 'Bases de datos distribuidas.', 'https://cdn.biblioteca.edu/covers/9788400000023.jpg', 4, 4),
(@cat_bd, '9788400000024', 'SQL Server Administration', 'Autor MSSQL', 'Microsoft Press', '2020', 'Administración de MS SQL Server.', 'https://cdn.biblioteca.edu/covers/9788400000024.jpg', 6, 6),
(@cat_bd, '9788400000025', 'Learning Spark', 'Autor Spark', 'OReilly', '2020', 'Procesamiento de datos a gran escala.', 'https://cdn.biblioteca.edu/covers/9788400000025.jpg', 7, 6),
(@cat_bd, '9788400000026', 'Diseño de Data Marts', 'Autor Data Marts', 'Kimball Group', '2013', 'Modelado dimensional.', 'https://cdn.biblioteca.edu/covers/9788400000026.jpg', 5, 5);

-- Categoria 3: Inteligencia Artificial

SET @cat_ia := (SELECT id_categoria FROM categoria WHERE nombre = 'Inteligencia Artificial');

INSERT INTO libro (
  id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, portada_url, cantidad_total, cantidad_disponible
) VALUES
(@cat_ia, '9780262033848', 'Pattern Recognition and Machine Learning', 'Christopher Bishop', 'Springer', '2006', 'Un clásico del aprendizaje automático.', 'https://cdn.biblioteca.edu/covers/9780262033848.jpg', 4, 4),
(@cat_ia, '9780133351000', 'Inteligencia Artificial: Un Enfoque Moderno', 'Russell y Norvig', 'Prentice Hall', '2016', 'El libro de texto estándar de IA.', 'https://cdn.biblioteca.edu/covers/9780133351000.jpg', 6, 6),
(@cat_ia, '9788400000027', 'Deep Learning con Python', 'Francois Chollet', 'Manning', '2017', 'Uso de Keras.', 'https://cdn.biblioteca.edu/covers/9788400000027.jpg', 8, 8),
(@cat_ia, '9788400000028', 'Hands-On Machine Learning', 'Aurelien Geron', 'OReilly', '2019', 'Con Scikit-Learn y TensorFlow.', 'https://cdn.biblioteca.edu/covers/9788400000028.jpg', 10, 9),
(@cat_ia, '9788400000029', 'Procesamiento de Lenguaje Natural', 'Autor NLP', 'NLP Press', '2020', 'NLP con Python.', 'https://cdn.biblioteca.edu/covers/9788400000029.jpg', 6, 6),
(@cat_ia, '9788400000030', 'Introducción a la Robótica', 'Autor Robótica', 'Robot Press', '2018', 'Mecánica y control.', 'https://cdn.biblioteca.edu/covers/9788400000030.jpg', 5, 5),
(@cat_ia, '9788400000031', 'Visión por Computadora', 'Autor Visión', 'CV Press', '2021', 'Algoritmos y aplicaciones.', 'https://cdn.biblioteca.edu/covers/9788400000031.jpg', 7, 6),
(@cat_ia, '9788400000032', 'Sistemas Expertos', 'Autor Sistemas Expertos', 'IA Editorial', '2015', 'Lógica y motores de inferencia.', 'https://cdn.biblioteca.edu/covers/9788400000032.jpg', 4, 4),
(@cat_ia, '9788400000033', 'Redes Neuronales desde Cero', 'Autor Redes', 'NN Press', '2019', 'Implementación en Python.', 'https://cdn.biblioteca.edu/covers/9788400000033.jpg', 6, 6),
(@cat_ia, '9788400000034', 'Aprendizaje por Refuerzo', 'Richard S. Sutton', 'MIT Press', '2018', 'Una introducción.', 'https://cdn.biblioteca.edu/covers/9788400000034.jpg', 5, 5),
(@cat_ia, '9788400000035', 'Lógica Difusa y Aplicaciones', 'Autor Lógica Difusa', 'Fuzzy Logic Books', '2017', 'Teoría y práctica.', 'https://cdn.biblioteca.edu/covers/9788400000035.jpg', 3, 3),
(@cat_ia, '9788400000036', 'Data Science para Negocios', 'Autor Data Science', 'OReilly', '2013', 'Ciencia de datos aplicada.', 'https://cdn.biblioteca.edu/covers/9788400000036.jpg', 9, 9),
(@cat_ia, '9788400000037', 'Algoritmos Genéticos', 'Autor Genéticos', 'IA Editorial', '2019', 'Optimización y búsqueda.', 'https://cdn.biblioteca.edu/covers/9788400000037.jpg', 5, 5),
(@cat_ia, '9788400000038', 'PyTorch para Deep Learning', 'Autor PyTorch', 'Packt', '2020', 'Guía práctica.', 'https://cdn.biblioteca.edu/covers/9788400000038.jpg', 6, 6),
(@cat_ia, '9788400000039', 'Ética en Inteligencia Artificial', 'Autor Ética', 'Filosofía Tech', '2022', 'Riesgos y regulación.', 'https://cdn.biblioteca.edu/covers/9788400000039.jpg', 7, 7);

-- Categoria 4: Redes y Seguridad
SET @cat_redes := (SELECT id_categoria FROM categoria WHERE nombre = 'Redes y Seguridad');

INSERT INTO libro (
  id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, portada_url, cantidad_total, cantidad_disponible
) VALUES
(@cat_redes, '9780132126953', 'Redes de Computadoras', 'Andrew S. Tanenbaum', 'Pearson', 2010, 'Un enfoque descendente.', 'https://cdn.biblioteca.edu/covers/9780132126953.jpg', 5, 5),
(@cat_redes, '9781593275609', 'Hacking: The Art of Exploitation', 'Jon Erickson', 'No Starch Press', 2008, 'Conceptos de hacking y seguridad.', 'https://cdn.biblioteca.edu/covers/9781593275609.jpg', 3, 3),
(@cat_redes, '9788400000040', 'Seguridad Informática: Hacking Ético', 'Autor Hacking', 'Seguridad Press', 2021, 'Pentesting y auditorías de seguridad.', 'https://cdn.biblioteca.edu/covers/9788400000040.jpg', 8, 8),
(@cat_redes, '9788400000041', 'TCP/IP Ilustrado, Vol. 1', 'W. Richard Stevens', 'Addison-Wesley', 2011, 'Los protocolos fundamentales de Internet.', 'https://cdn.biblioteca.edu/covers/9788400000041.jpg', 6, 6),
(@cat_redes, '9788400000042', 'Criptografía y Seguridad de Redes', 'William Stallings', 'Pearson', 2017, 'Principios y práctica de la criptografía moderna.', 'https://cdn.biblioteca.edu/covers/9788400000042.jpg', 7, 7),
(@cat_redes, '9788400000043', 'Wireshark: Análisis de Protocolos', 'Autor Wireshark', 'No Starch Press', 2018, 'Análisis de tráfico de red con Wireshark.', 'https://cdn.biblioteca.edu/covers/9788400000043.jpg', 5, 4),
(@cat_redes, '9788400000044', 'Seguridad en Aplicaciones Web', 'Autor WebSec', 'OReilly', 2020, 'OWASP Top 10 y protección de aplicaciones.', 'https://cdn.biblioteca.edu/covers/9788400000044.jpg', 6, 6),
(@cat_redes, '9788400000045', 'Firewalls y Seguridad de Red', 'Autor Firewalls', 'Cisco Press', 2019, 'Diseño e implementación de firewalls.', 'https://cdn.biblioteca.edu/covers/9788400000045.jpg', 5, 5),
(@cat_redes, '9788400000046', 'Gestión de Riesgos de Seguridad', 'Autor Riesgos', 'Seguridad Press', 2017, 'Aplicación de ISO 27001 en entornos corporativos.', 'https://cdn.biblioteca.edu/covers/9788400000046.jpg', 4, 4),
(@cat_redes, '9788400000047', 'Kubernetes: Seguridad', 'Autor Kubernetes', 'OReilly', 2021, 'Protección de contenedores y clusters Kubernetes.', 'https://cdn.biblioteca.edu/covers/9788400000047.jpg', 6, 6),
(@cat_redes, '9788400000048', 'Análisis Forense Digital', 'Autor Forense', 'Wiley', 2019, 'Investigación de incidentes y evidencias digitales.', 'https://cdn.biblioteca.edu/covers/9788400000048.jpg', 5, 5),
(@cat_redes, '9788400000049', 'Metasploit: Guía de Pentesting', 'Autor Metasploit', 'No Starch Press', 2011, 'Uso de Metasploit para pruebas de penetración.', 'https://cdn.biblioteca.edu/covers/9788400000049.jpg', 3, 3),
(@cat_redes, '9788400000050', 'Diseño de Redes LAN/WAN', 'Autor Redes', 'Cisco Press', 2020, 'Arquitectura y optimización de redes LAN/WAN.', 'https://cdn.biblioteca.edu/covers/9788400000050.jpg', 7, 7),
(@cat_redes, '9788400000051', 'Seguridad en la Nube (Cloud Security)', 'Autor Cloud', 'Cloud Press', 2022, 'Buenas prácticas en AWS, Azure y GCP.', 'https://cdn.biblioteca.edu/covers/9788400000051.jpg', 8, 8),
(@cat_redes, '9788400000052', 'Malware Analysis', 'Autor Malware', 'No Starch Press', 2015, 'Análisis y detección de software malicioso.', 'https://cdn.biblioteca.edu/covers/9788400000052.jpg', 4, 4);

-- Categoria 5: Sistemas Operativos

SET @cat_so := (SELECT id_categoria FROM categoria WHERE nombre = 'Sistemas Operativos');
INSERT INTO libro (
  id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, portada_url, cantidad_total, cantidad_disponible
) VALUES
(@cat_so, '9780133591620', 'Sistemas Operativos Modernos', 'Andrew S. Tanenbaum', 'Pearson', '2014', 'Conceptos y diseño de SO.', 'https://cdn.biblioteca.edu/covers/9780133591620.jpg', 4, 4),
(@cat_so, '9781118063330', 'Linux Bible', 'Christopher Negus', 'Wiley', '2012', 'Guía completa de Linux.', 'https://cdn.biblioteca.edu/covers/9781118063330.jpg', 5, 5),
(@cat_so, '9788400000053', 'Diseño e Implementación de Sistemas Operativos', 'A. Tanenbaum', 'Prentice Hall', '2006', 'Basado en MINIX.', 'https://cdn.biblioteca.edu/covers/9788400000053.jpg', 5, 5),
(@cat_so, '9788400000054', 'Administración de Windows Server', 'Autor Windows', 'Microsoft Press', '2021', 'Active Directory y más.', 'https://cdn.biblioteca.edu/covers/9788400000054.jpg', 6, 6),
(@cat_so, '9788400000055', 'Shell Scripting en Linux', 'Autor Shell', 'Linux Press', '2019', 'Automatización con Bash.', 'https://cdn.biblioteca.edu/covers/9788400000055.jpg', 7, 7),
(@cat_so, '9788400000056', 'Conceptos Internos de macOS', 'Autor macOS', 'Apple Press', '2018', 'Arquitectura de XNU.', 'https://cdn.biblioteca.edu/covers/9788400000056.jpg', 4, 4),
(@cat_so, '9788400000057', 'Virtualización y Cloud Computing', 'Autor Cloud', 'VMware Press', '2020', 'VMs y contenedores.', 'https://cdn.biblioteca.edu/covers/9788400000057.jpg', 8, 8),
(@cat_so, '9788400000058', 'Linux Kernel Development', 'Robert Love', 'Addison-Wesley', '2010', 'Desarrollo del kernel.', 'https://cdn.biblioteca.edu/covers/9788400000058.jpg', 5, 4),
(@cat_so, '9788400000059', 'Administración de Red Hat (RHCSA)', 'Autor Red Hat', 'Red Hat Press', '2022', 'Guía de certificación.', 'https://cdn.biblioteca.edu/covers/9788400000059.jpg', 6, 6),
(@cat_so, '9788400000060', 'Sistemas de Archivos', 'Autor FS', 'Tech Press', '2017', 'Diseño e implementación.', 'https://cdn.biblioteca.edu/covers/9788400000060.jpg', 3, 3),
(@cat_so, '9788400000061', 'Docker: Up & Running', 'Autor Docker', 'OReilly', '2020', 'Contenedores.', 'https://cdn.biblioteca.edu/covers/9788400000061.jpg', 9, 9),
(@cat_so, '9788400000062', 'Sistemas Distribuidos', 'George Coulouris', 'Pearson', '2011', 'Conceptos y diseño.', 'https://cdn.biblioteca.edu/covers/9788400000062.jpg', 5, 5),
(@cat_so, '9788400000063', 'Programación de Sistemas en Linux', 'Autor Linux Sys', 'Linux Press', '2019', 'APIs del sistema.', 'https://cdn.biblioteca.edu/covers/9788400000063.jpg', 4, 4),
(@cat_so, '9788400000064', 'PowerShell para Administradores', 'Autor PowerShell', 'Microsoft Press', '2021', 'Automatización en Windows.', 'https://cdn.biblioteca.edu/covers/9788400000064.jpg', 6, 6),
(@cat_so, '9780139411802', 'UNIX: El Entorno de Programación', 'Kernighan y Pike', 'Prentice Hall', '1984', 'Un clásico.', 'https://cdn.biblioteca.edu/covers/9780139411802.jpg', 5, 5);

-- Categoria 6: Diseno Grafico

SET @cat_dg := (SELECT id_categoria FROM categoria WHERE nombre = 'Diseño Gráfico');

INSERT INTO libro (
  id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, portada_url, cantidad_total, cantidad_disponible
) VALUES
(@cat_dg, '9780321700676', 'La Interacción del Color', 'Josef Albers', 'Yale University Press', '2010', 'Estudio de la teoría del color.', 'https://cdn.biblioteca.edu/covers/9780321700676.jpg', 3, 3),
(@cat_dg, '9780470650651', 'No me hagas pensar', 'Steve Krug', 'New Riders', '2014', 'Usabilidad y diseño web.', 'https://cdn.biblioteca.edu/covers/9780470650651.jpg', 5, 5),
(@cat_dg, '9788400000066', 'Psicología del Color', 'Eva Heller', 'GG', '2000', 'Cómo actúan los colores.', 'https://cdn.biblioteca.edu/covers/9788400000066.jpg', 8, 8),
(@cat_dg, '9788400000067', 'Logo Design Love', 'David Airey', 'New Riders', '2009', 'Diseño de logos.', 'https://cdn.biblioteca.edu/covers/9788400000067.jpg', 7, 7),
(@cat_dg, '9788400000068', 'Fundamentos del Diseño (Bauhaus)', 'Wassily Kandinsky', 'Paidos', '1926', 'Punto y línea sobre el plano.', 'https://cdn.biblioteca.edu/covers/9788400000068.jpg', 5, 5),
(@cat_dg, '9788400000069', 'Adobe Photoshop: Aula Creativa', 'Autor Photoshop', 'Anaya', '2022', 'Fotomanipulación.', 'https://cdn.biblioteca.edu/covers/9788400000069.jpg', 10, 9),
(@cat_dg, '9788400000070', 'Adobe Illustrator: Aula Creativa', 'Autor Illustrator', 'Anaya', '2022', 'Diseño vectorial.', 'https://cdn.biblioteca.edu/covers/9788400000070.jpg', 9, 9),
(@cat_dg, '9788400000071', 'Diseño de Interfaces (UI/UX)', 'Autor UI/UX', 'UX Press', '2021', 'Principios de diseño de UI.', 'https://cdn.biblioteca.edu/covers/9788400000071.jpg', 8, 8),
(@cat_dg, '9788400000072', 'Tipografía: Manual de Diseño', 'Emil Ruder', 'GG', '1967', 'Un manual de tipografía.', 'https://cdn.biblioteca.edu/covers/9788400000072.jpg', 6, 6),
(@cat_dg, '9788400000073', 'Diseño de UX (Experiencia de Usuario)', 'Autor UX', 'OReilly', '2019', 'Investigación y prototipado.', 'https://cdn.biblioteca.edu/covers/9788400000073.jpg', 7, 7),
(@cat_dg, '9788400000074', 'La Sintaxis de la Imagen', 'D. A. Dondis', 'GG', '1973', 'Introducción al alfabeto visual.', 'https://cdn.biblioteca.edu/covers/9788400000074.jpg', 5, 5),
(@cat_dg, '9788400000075', 'Adobe InDesign: Aula Creativa', 'Autor InDesign', 'Anaya', '2022', 'Maquetación y diseño editorial.', 'https://cdn.biblioteca.edu/covers/9788400000075.jpg', 6, 6),
(@cat_dg, '9788400000076', 'Branding: Gestión de Marca', 'Autor Branding', 'Brand Press', '2020', 'Estrategia de marca.', 'https://cdn.biblioteca.edu/covers/9788400000076.jpg', 7, 7),
(@cat_dg, '9788400000077', 'Historia del Diseño Gráfico', 'Philip B. Meggs', 'Wiley', '2016', 'Un recorrido histórico.', 'https://cdn.biblioteca.edu/covers/9788400000077.jpg', 4, 4),
(@cat_dg, '9788400000078', 'Figma: Guía de Diseño Colaborativo', 'Autor Figma', 'UX Press', '2021', 'Diseño de interfaces en la nube.', 'https://cdn.biblioteca.edu/covers/9788400000078.jpg', 8, 8);

-- Categoria 7: Matematicas


SET @cat_mate := (SELECT id_categoria FROM categoria WHERE nombre = 'Matemáticas');

INSERT INTO libro (id_categoria, isbn, titulo, autor, editorial, ano_publicacion,descripcion, portada_url, cantidad_total, cantidad_disponible) VALUES
(@cat_mate, '9780534351890', 'Cálculo: Trascendentes Tempranas', 'James Stewart', 'Cengage', 2011, 'El libro estándar de cálculo.', 'https://cdn.biblioteca.edu/covers/9780534351890.jpg', 6, 6),
(@cat_mate, '9780321795434', 'Álgebra Lineal y sus Aplicaciones', 'David C. Lay', 'Pearson', 2015, 'Introducción al álgebra lineal.', 'https://cdn.biblioteca.edu/covers/9780321795434.jpg', 4, 4),
(@cat_mate, '9788400000079', 'Matemática Discreta y sus Aplicaciones', 'Kenneth Rosen', 'McGraw-Hill', 2012, 'Para ciencias de la computación.', 'https://cdn.biblioteca.edu/covers/9788400000079.jpg', 9, 9),
(@cat_mate, '9788400000080', 'Probabilidad y Estadística', 'Morris H. DeGroot', 'Pearson', 2011, 'Para ingeniería.', 'https://cdn.biblioteca.edu/covers/9788400000080.jpg', 8, 7),
(@cat_mate, '9780262033849', 'Introducción a los Algoritmos (CLRS)', 'Cormen, Leiserson', 'MIT Press', 2009, 'La biblia de algoritmos.', 'https://cdn.biblioteca.edu/covers/9780262033849.jpg', 7, 6),
(@cat_mate, '9788400000082', 'Cálculo Vectorial', 'Autor Vectorial', 'Math Press', 2018, 'Geometría y vectores.', 'https://cdn.biblioteca.edu/covers/9788400000082.jpg', 6, 6),
(@cat_mate, '9788400000083', 'Ecuaciones Diferenciales', 'Dennis G. Zill', 'Cengage', 2017, 'Con aplicaciones.', 'https://cdn.biblioteca.edu/covers/9788400000083.jpg', 5, 5),
(@cat_mate, '9788400000084', 'Teoría de Números', 'Autor Números', 'Number Press', 2019, 'Introducción a la teoría.', 'https://cdn.biblioteca.edu/covers/9788400000084.jpg', 4, 4),
(@cat_mate, '9788400000085', 'Análisis Matemático', 'Autor Análisis', 'Math Press', 2017, 'Fundamentos del cálculo.', 'https://cdn.biblioteca.edu/covers/9788400000085.jpg', 5, 5),
(@cat_mate, '9788400000086', 'El Hombre que Calculaba', 'Malba Tahan', 'Record', 1949, 'Aventuras matemáticas.', 'https://cdn.biblioteca.edu/covers/9788400000086.jpg', 10, 10),
(@cat_mate, '9788400000087', 'Optimización y Programación Lineal', 'Autor Optimización', 'Springer', 2016, 'Métodos y modelos.', 'https://cdn.biblioteca.edu/covers/9788400000087.jpg', 6, 6),
(@cat_mate, '9788400000088', 'Geometría Euclidiana', 'Euclides', 'Clásicos', 300, 'Los Elementos.', 'https://cdn.biblioteca.edu/covers/9788400000088.jpg', 5, 5),
(@cat_mate, '9788400000089', 'Estadística Aplicada', 'Autor Estadística', 'Data Press', 2021, 'Estadística para ciencia de datos.', 'https://cdn.biblioteca.edu/covers/9788400000089.jpg', 7, 7),
(@cat_mate, '9788400000090', 'Variable Compleja', 'Autor Compleja', 'Math Press', 2019, 'Funciones de variable compleja.', 'https://cdn.biblioteca.edu/covers/9788400000090.jpg', 4, 4),
(@cat_mate, '9788400000091', 'Física Universitaria Vol. 1', 'Sears y Zemansky', 'Pearson', 2018, 'Mecánica.', 'https://cdn.biblioteca.edu/covers/9788400000091.jpg', 8, 8);

-- Categoria 8: Literatura

SET @cat_lit := (SELECT id_categoria FROM categoria WHERE nombre = 'Literatura');

INSERT INTO libro (
  id_categoria, isbn, titulo, autor, editorial, ano_publicacion,
  descripcion, portada_url, cantidad_total, cantidad_disponible
) VALUES
(@cat_lit, '9780307387899', 'Cien Años de Soledad', 'Gabriel García Márquez', 'Vintage', 1967, 'Realismo mágico.', 'https://cdn.biblioteca.edu/covers/9780307387899.jpg', 7, 6),
(@cat_lit, '9780679720218', '1984', 'George Orwell', 'Signet Classic', 1949, 'Novela distópica.', 'https://cdn.biblioteca.edu/covers/9780679720218.jpg', 8, 8),
(@cat_lit, '9788400000092', 'Don Quijote de la Mancha', 'Miguel de Cervantes', 'RAE', 1605, 'Novela moderna.', 'https://cdn.biblioteca.edu/covers/9788400000092.jpg', 10, 10),
(@cat_lit, '9788400000093', 'Orgullo y Prejuicio', 'Jane Austen', 'Penguin', 1813, 'Novela romántica.', 'https://cdn.biblioteca.edu/covers/9788400000093.jpg', 8, 7),
(@cat_lit, '9788400000094', 'Ulises', 'James Joyce', 'Vintage', 1922, 'Modernismo.', 'https://cdn.biblioteca.edu/covers/9788400000094.jpg', 3, 2),
(@cat_lit, '9788400000095', 'El Extranjero', 'Albert Camus', 'Alianza', 1942, 'Existencialismo.', 'https://cdn.biblioteca.edu/covers/9788400000095.jpg', 7, 7),
(@cat_lit, '9788400000096', 'Ficciones', 'Jorge Luis Borges', 'Debolsillo', 1944, 'Relatos cortos.', 'https://cdn.biblioteca.edu/covers/9788400000096.jpg', 9, 9),
(@cat_lit, '9788400000097', 'Moby Dick', 'Herman Melville', 'Penguin', 1851, 'Novela marina.', 'https://cdn.biblioteca.edu/covers/9788400000097.jpg', 6, 6),
(@cat_lit, '9788400000098', 'Guerra y Paz', 'León Tolstói', 'Penguin', 1869, 'Novela histórica rusa.', 'https://cdn.biblioteca.edu/covers/9788400000098.jpg', 5, 5),
(@cat_lit, '9788400000099', 'El Gran Gatsby', 'F. Scott Fitzgerald', 'Scribner', 1925, 'La era del jazz.', 'https://cdn.biblioteca.edu/covers/9788400000099.jpg', 8, 8),
(@cat_lit, '9788400000100', 'Crimen y Castigo', 'Fiódor Dostoievski', 'Alianza', 1866, 'Novela psicológica.', 'https://cdn.biblioteca.edu/covers/9788400000100.jpg', 7, 7),
(@cat_lit, '9788400000101', 'La Metamorfosis', 'Franz Kafka', 'Cátedra', 1915, 'Relato.', 'https://cdn.biblioteca.edu/covers/9788400000101.jpg', 10, 10),
(@cat_lit, '9788400000102', 'En Busca del Tiempo Perdido', 'Marcel Proust', 'Valdemar', 1913, 'Novela.', 'https://cdn.biblioteca.edu/covers/9788400000102.jpg', 2, 2),
(@cat_lit, '9788400000103', 'El Amor en los Tiempos del Cólera', 'Gabriel García Márquez', 'Debolsillo', 1985, 'Novela.', 'https://cdn.biblioteca.edu/covers/9788400000103.jpg', 9, 9),
(@cat_lit, '9788400000104', 'Tokio Blues (Norwegian Wood)', 'Haruki Murakami', 'Tusquets', 1987, 'Novela contemporánea.', 'https://cdn.biblioteca.edu/covers/9788400000104.jpg', 8, 8);

-- Categoria 9: Historia

SET @cat_hist := (SELECT id_categoria FROM categoria WHERE nombre = 'Historia');

INSERT INTO libro (
  id_categoria, isbn, titulo, autor, editorial, ano_publicacion,
  descripcion, portada_url, cantidad_total, cantidad_disponible
) VALUES
(@cat_hist, '9780060935467', 'Breve Historia del Tiempo', 'Stephen Hawking', 'Bantam', 1988, 'Divulgación científica e historia.', 'https://cdn.biblioteca.edu/covers/9780060935467.jpg', 5, 5),
(@cat_hist, '9780743226719', 'Sapiens: De Animales a Dioses', 'Yuval Noah Harari', 'Harper', 2015, 'Breve historia de la humanidad.', 'https://cdn.biblioteca.edu/covers/9780743226719.jpg', 10, 9),
(@cat_hist, '9788400000105', 'Armas, Gérmenes y Acero', 'Jared Diamond', 'Debate', 1997, 'El destino de las sociedades.', 'https://cdn.biblioteca.edu/covers/9788400000105.jpg', 7, 7),
(@cat_hist, '9788400000106', 'La Segunda Guerra Mundial', 'Antony Beevor', 'Crítica', 2012, 'Historia militar.', 'https://cdn.biblioteca.edu/covers/9788400000106.jpg', 6, 6),
(@cat_hist, '9788400000107', 'Historia de Roma', 'Indro Montanelli', 'Debolsillo', 1957, 'Desde la fundación.', 'https://cdn.biblioteca.edu/covers/9788400000107.jpg', 8, 8),
(@cat_hist, '9788400000108', 'Revolución Francesa', 'Autor Francesa', 'Historia Press', 2019, 'Ensayo histórico.', 'https://cdn.biblioteca.edu/covers/9788400000108.jpg', 5, 5),
(@cat_hist, '9788400000109', 'El Siglo de las Luces', 'Autor Luces', 'Historia Press', 2017, 'La Ilustración.', 'https://cdn.biblioteca.edu/covers/9788400000109.jpg', 6, 6),
(@cat_hist, '9788400000110', 'Mitología Griega', 'Robert Graves', 'Alianza', 1955, 'Los mitos griegos.', 'https://cdn.biblioteca.edu/covers/9788400000110.jpg', 9, 9),
(@cat_hist, '9788400000111', 'Historia de Estados Unidos', 'Howard Zinn', 'Siglo XXI', 1980, 'La otra historia.', 'https://cdn.biblioteca.edu/covers/9788400000111.jpg', 7, 7),
(@cat_hist, '9788400000112', 'El Antiguo Egipto', 'Autor Egipto', 'Egipto Press', 2018, 'Faraones y pirámides.', 'https://cdn.biblioteca.edu/covers/9788400000112.jpg', 5, 5),
(@cat_hist, '9788400000113', 'La Ruta de la Seda', 'Peter Frankopan', 'Crítica', 2015, 'Una nueva historia del mundo.', 'https://cdn.biblioteca.edu/covers/9788400000113.jpg', 6, 6),
(@cat_hist, '9788400000114', 'Historia de Colombia', 'Autor Colombia', 'Planeta', 2020, 'Historia del país.', 'https://cdn.biblioteca.edu/covers/9788400000114.jpg', 8, 8),
(@cat_hist, '9788400000115', 'Los Vikingos', 'Autor Vikingos', 'Viking Press', 2016, 'Era vikinga.', 'https://cdn.biblioteca.edu/covers/9788400000115.jpg', 5, 5),
(@cat_hist, '9788400000116', 'El Renacimiento', 'Autor Renacimiento', 'Arte Press', 2017, 'Arte e historia.', 'https://cdn.biblioteca.edu/covers/9788400000116.jpg', 6, 6),
(@cat_hist, '9788400000117', 'GULAG: Historia de los Campos Soviéticos', 'Anne Applebaum', 'Debate', 2003, 'Historia soviética.', 'https://cdn.biblioteca.edu/covers/9788400000117.jpg', 4, 4);

-- Categoria 10: Negocios y Finanzas

SET @cat_neg := (SELECT id_categoria FROM categoria WHERE nombre = 'Negocios y Finanzas');

-- Insertar libros de Negocios y Finanzas usando el id por consulta
INSERT INTO libro (
  id_categoria, isbn, titulo, autor, editorial, ano_publicacion, descripcion, portada_url, cantidad_total, cantidad_disponible
) VALUES
(@cat_neg, '9780132369421', 'El Inversor Inteligente', 'Benjamin Graham', 'HarperBusiness', '1949', 'El libro definitivo sobre value investing.', 'https://cdn.biblioteca.edu/covers/9780132369421.jpg', 5, 5),
(@cat_neg, '9780812971328', 'El Cisne Negro', 'Nassim Nicholas Taleb', 'Random House', '2007', 'El impacto de lo altamente improbable.', 'https://cdn.biblioteca.edu/covers/9780812971328.jpg', 4, 4),
(@cat_neg, '9788400000118', 'Padre Rico, Padre Pobre', 'Robert Kiyosaki', 'Aguilar', '1997', 'Educacion financiera.', 'https://cdn.biblioteca.edu/covers/9788400000118.jpg', 10, 10),
(@cat_neg, '9788400000119', 'El Metodo Lean Startup', 'Eric Ries', 'Crown Business', '2011', 'Creacion de empresas.', 'https://cdn.biblioteca.edu/covers/9788400000119.jpg', 8, 8),
(@cat_neg, '9788400000120', 'Marketing 4.0', 'Philip Kotler', 'Wiley', '2017', 'De tradicional a digital.', 'https://cdn.biblioteca.edu/covers/9788400000120.jpg', 7, 7),
(@cat_neg, '9788400000121', 'Principios', 'Ray Dalio', 'Simon & Schuster', '2017', 'Vida y trabajo.', 'https://cdn.biblioteca.edu/covers/9788400000121.jpg', 6, 6),
(@cat_neg, '9788400000122', 'La Estrategia del Oceano Azul', 'W. Chan Kim', 'Harvard Business', '2005', 'Crear nuevos mercados.', 'https://cdn.biblioteca.edu/covers/9788400000122.jpg', 7, 7),
(@cat_neg, '9788400000123', 'Pensar rapido, pensar despacio', 'Daniel Kahneman', 'Debate', '2011', 'Economia conductual.', 'https://cdn.biblioteca.edu/covers/9788400000123.jpg', 6, 6),
(@cat_neg, '9788400000124', 'Contabilidad para Dummies', 'Autor Contabilidad', 'Para Dummies', '2021', 'Conceptos basicos.', 'https://cdn.biblioteca.edu/covers/9788400000124.jpg', 9, 9),
(@cat_neg, '9788400000125', 'El MBA Personal', 'Josh Kaufman', 'Portfolio', '2010', 'Conceptos de negocios.', 'https://cdn.biblioteca.edu/covers/9788400000125.jpg', 7, 7),
(@cat_neg, '9788400000126', 'Como ganar amigos e influir sobre las personas', 'Dale Carnegie', 'Simon & Schuster', '1936', 'Habilidades sociales.', 'https://cdn.biblioteca.edu/covers/9788400000126.jpg', 10, 10),
(@cat_neg, '9788400000127', 'De Cero a Uno', 'Peter Thiel', 'Crown Business', '2014', 'Startups y futuro.', 'https://cdn.biblioteca.edu/covers/9788400000127.jpg', 6, 6),
(@cat_neg, '9788400000128', 'La Riqueza de las Naciones', 'Adam Smith', 'Alianza', '1776', 'Economia clasica.', 'https://cdn.biblioteca.edu/covers/9788400000128.jpg', 4, 4),
(@cat_neg, '9788400000129', 'Freakonomics', 'Levitt y Dubner', 'HarperCollins', '2005', 'El lado oculto de la economia.', 'https://cdn.biblioteca.edu/covers/9788400000129.jpg', 8, 8),
(@cat_neg, '9788400000130', 'Gestion de Proyectos (PMBOK)', 'PMI', 'PMI', '2021', 'Guia de gestion.', 'https://cdn.biblioteca.edu/covers/9788400000130.jpg', 5, 5);

-- -----------------------------------------------------
-- 4. TABLA PRESTAMO
-- Insertamos 20 prestamos en diferentes estados (5 de cada uno).
-- ID_ESTADO_PRESTAMO: 1=solicitado, 2=activo, 3=devuelto, 4=vencido
-- -----------------------------------------------------
/* === PRÉSTAMOS ACTIVOS*/

INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, id_estado_prestamo) VALUES
(
  (SELECT id_usuario FROM usuario WHERE username='ana.garcia' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Codigo Limpio' LIMIT 1),
  '2025-10-10 10:00:00','2025-10-24 10:00:00',NULL,2
),
(
  (SELECT id_usuario FROM usuario WHERE username='bruno.fernandez'  LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Estructuras de Datos en Java' LIMIT 1),
  '2025-10-12 11:00:00','2025-10-26 11:00:00',NULL,2
),
(
  (SELECT id_usuario FROM usuario WHERE username='carla.martinez'  LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Programacion Funcional con Scala' LIMIT 1),
  '2025-10-15 14:00:00','2025-10-29 14:00:00',NULL,2
),
(
  (SELECT id_usuario FROM usuario WHERE username='david.rodriguez' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Neo4j in Action' LIMIT 1),
  '2025-10-18 09:00:00','2025-11-01 09:00:00',NULL,2
),
(
  (SELECT id_usuario FROM usuario WHERE username='elena.gomez'  LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Introduccion a la Robotica' LIMIT 1),
  '2025-10-19 16:00:00','2025-11-02 16:00:00',NULL,2
);

/*=== PRÉSTAMOS DEVUELTOS (id_estado_prestamo = 3) === */
INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, id_estado_prestamo) VALUES
(
  (SELECT id_usuario FROM usuario WHERE username='felipe.torres' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Patrones de Diseno' LIMIT 1),
  '2025-09-01 10:00:00','2025-09-15 10:00:00','2025-09-14 11:00:00',3
),
(
  (SELECT id_usuario FROM usuario WHERE username='gabriela.ruiz' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Aprendiendo SQL' LIMIT 1),
  '2025-09-02 11:00:00','2025-09-16 11:00:00','2025-09-16 10:00:00',3
),
(
  (SELECT id_usuario FROM usuario WHERE username='hector.diaz' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Introduccion a C#' LIMIT 1),
  '2025-09-03 14:00:00','2025-09-17 14:00:00','2025-09-15 15:00:00',3
),
(
  (SELECT id_usuario FROM usuario WHERE username='irene.sanchez' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Python para Analisis de Datos' LIMIT 1),
  '2025-09-05 09:00:00','2025-09-19 09:00:00','2025-09-18 12:00:00',3
),
(
  (SELECT id_usuario FROM usuario WHERE username='javier.morales' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Go en la Practica' LIMIT 1),
  '2025-09-10 16:00:00','2025-09-24 16:00:00','2025-09-22 17:00:00',3
);

/* === PRÉSTAMOS VENCIDOS (id_estado_prestamo = 4) === */
INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, id_estado_prestamo) VALUES
(
  (SELECT id_usuario FROM usuario WHERE username='ana.garcia' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Inteligencia Artificial: Un Enfoque Moderno' LIMIT 1),
  '2025-09-01 10:00:00','2025-09-15 10:00:00',NULL,4
),
(
  (SELECT id_usuario FROM usuario WHERE username='bruno.fernandez'  LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Docker: Up & Running' LIMIT 1),
  '2025-09-03 11:00:00','2025-09-17 11:00:00',NULL,4
),
(
  (SELECT id_usuario FROM usuario WHERE username='carla.martinez'  LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Historia de Colombia' LIMIT 1),
  '2025-09-05 14:00:00','2025-09-19 14:00:00',NULL,4
),
(
  (SELECT id_usuario FROM usuario WHERE username='david.rodriguez' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='El Programador Pragmatico' LIMIT 1),
  '2025-09-10 09:00:00','2025-09-24 09:00:00',NULL,4
),
(
  (SELECT id_usuario FROM usuario WHERE username='elena.gomez' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Clean Architecture' LIMIT 1),
  '2025-09-15 16:00:00','2025-09-29 16:00:00',NULL,4
);

/* === PRÉSTAMOS SOLICITADOS (id_estado_prestamo = 1) === */
INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, id_estado_prestamo) VALUES
(
  (SELECT id_usuario FROM usuario WHERE username='felipe.torres'  LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Kubernetes: Seguridad' LIMIT 1),
  '2025-10-20 10:00:00','2025-11-03 10:00:00',NULL,1
),
(
  (SELECT id_usuario FROM usuario WHERE username='gabriela.ruiz'  LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Seguridad en la Nube (Cloud Security)' LIMIT 1),
  '2025-10-20 11:00:00','2025-11-03 11:00:00',NULL,1
),
(
  (SELECT id_usuario FROM usuario WHERE username='hector.diaz'  LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Data Science para Negocios' LIMIT 1),
  '2025-10-20 12:00:00','2025-11-03 12:00:00',NULL,1
),
(
  (SELECT id_usuario FROM usuario WHERE username='irene.sanchez' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Figma: Guia de Diseno Colaborativo' LIMIT 1),
  '2025-10-20 13:00:00','2025-11-03 13:00:00',NULL,1
),
(
  (SELECT id_usuario FROM usuario WHERE username='javier.morales' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='El Inversor Inteligente' LIMIT 1),
  '2025-10-20 14:00:00','2025-11-03 14:00:00',NULL,1
);

-- -----------------------------------------------------
-- 5. TABLA RESERVA
-- Insertamos 10 reservas.
-- ID_ESTADO_RESERVA: 1=pendiente, 3=cancelada
-- -----------------------------------------------------
INSERT INTO reserva (id_usuario, id_libro, fecha_reserva, id_estado_reserva) VALUES
(
  (SELECT id_usuario FROM usuario WHERE username='ana.garcia'LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Codigo Limpio' LIMIT 1),
  '2025-10-05 10:00:00', 1
),
(
  (SELECT id_usuario FROM usuario WHERE username='bruno.fernandez' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Codigo Limpio' LIMIT 1),
  '2025-10-06 11:00:00', 1
),
(
  (SELECT id_usuario FROM usuario WHERE username='carla.martinez' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Codigo Limpio' LIMIT 1),
  '2025-10-07 12:00:00', 3  -- Cancelada
),
(
  (SELECT id_usuario FROM usuario WHERE username='david.rodriguez' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Estructuras de Datos en Java' LIMIT 1),
  '2025-10-08 14:00:00', 1
),
(
  (SELECT id_usuario FROM usuario WHERE username='elena.gomez' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Kotlin para Android' LIMIT 1),
  '2025-10-09 09:00:00', 1
),
(
  (SELECT id_usuario FROM usuario WHERE username='felipe.torres'  LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Patrones de Diseno' LIMIT 1),
  '2025-10-10 16:00:00', 1
),
(
  (SELECT id_usuario FROM usuario WHERE username='gabriela.ruiz' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Procesamiento de Lenguaje Natural' LIMIT 1),
  '2025-10-11 10:00:00', 1
),
(
  (SELECT id_usuario FROM usuario WHERE username='hector.diaz'  LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Aprendiendo SQL' LIMIT 1),
  '2025-10-12 11:00:00', 1
),
(
  (SELECT id_usuario FROM usuario WHERE username='irene.sanchez' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Go en la Practica' LIMIT 1),
  '2025-10-13 12:00:00', 3  -- Cancelada
),
(
  (SELECT id_usuario FROM usuario WHERE username='javier.morales' LIMIT 1),
  (SELECT id_libro FROM libro WHERE titulo='Ruby on Rails Tutorial' LIMIT 1),
  '2025-10-14 14:00:00', 1
);


-- -----------------------------------------------------
-- 6. TABLA USUARIO_RESPUESTA
-- Insertamos datos para las preguntas de seguridad (US_1, US_4)
-- ID_PREGUNTA: 1='mascota', 2='comida', 3='abuela', 4='ciudad'
-- -----------------------------------------------------
INSERT INTO usuario_respuesta (id_usuario, id_pregunta, respuesta) VALUES
(
  (SELECT id_usuario FROM usuario WHERE username = 'ana.garcia' LIMIT 1),
  (SELECT id_pregunta FROM pregunta_seguridad WHERE texto_pregunta = 'Cual es el nombre de tu primera mascota?' LIMIT 1),
  'Fido'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'ana.garcia' LIMIT 1),
  (SELECT id_pregunta FROM pregunta_seguridad WHERE texto_pregunta = 'En que ciudad naciste?' LIMIT 1),
  'Bogota'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'bruno.fernandez' LIMIT 1),
  (SELECT id_pregunta FROM pregunta_seguridad WHERE texto_pregunta = 'Cual es tu comida favorita?' LIMIT 1),
  'Pizza'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'carla.martinez' LIMIT 1),
  (SELECT id_pregunta FROM pregunta_seguridad WHERE texto_pregunta = 'Cual es el nombre de tu primera mascota?' LIMIT 1),
  'Misi'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'david.rodriguez' LIMIT 1),
  (SELECT id_pregunta FROM pregunta_seguridad WHERE texto_pregunta = 'Cual es el nombre de tu abuela materna?' LIMIT 1),
  'Elena'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'elena.gomez' LIMIT 1),
  (SELECT id_pregunta FROM pregunta_seguridad WHERE texto_pregunta = 'En que ciudad naciste?' LIMIT 1),
  'Cartagena'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'ricardo.alvarez' LIMIT 1),
  (SELECT id_pregunta FROM pregunta_seguridad WHERE texto_pregunta = 'Cual es el nombre de tu primera mascota?' LIMIT 1),
  'Bruno'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'felipe.torres' LIMIT 1),
  (SELECT id_pregunta FROM pregunta_seguridad WHERE texto_pregunta = 'Cual es tu comida favorita?' LIMIT 1),
  'Ajiaco'
);


-- -----------------------------------------------------
-- 7. TABLAS DE AUDITORIA (DATOS DE PRUEBA)
-- Insertamos datos simulados para probar las consultas
-- de auditoria (US_11 y US_20).
-- -----------------------------------------------------

-- 7.1. auditoria_libro
-- Simulamos que el bibliotecario (ID 11, Ricardo Alvarez)
-- ha editado algunos libros.
INSERT INTO auditoria_libro (id_libro, id_usuario_admin, fecha_evento, descripcion_cambio) VALUES
(
  (SELECT id_libro FROM libro WHERE isbn = '9780132350884' LIMIT 1),         -- "Codigo Limpio"
  (SELECT id_usuario FROM usuario WHERE username = 'hugo.luna' LIMIT 1),
  '2025-06-01 10:00:00',
  'Se actualizo la descripcion del libro Codigo Limpio.'
),
(
  (SELECT id_libro FROM libro WHERE isbn = '9788400000001' LIMIT 1),         -- "Programacion Orientada a Objetos Explicada"
  (SELECT id_usuario FROM usuario WHERE username = 'ines.medina' LIMIT 1),
  '2025-06-05 14:20:00',
  'Correcion en el nombre del autor.'
),
(
  (SELECT id_libro FROM libro WHERE isbn = '9788400000008' LIMIT 1),         -- "Aprendiendo SQL"
  (SELECT id_usuario FROM usuario WHERE username = 'monica.bravo' LIMIT 1),
  '2025-07-10 09:00:00',
  'Se agrego la URL de la portada.'
);


-- 7.2. auditoria_usuario
-- Simulamos eventos de seguridad.
-- Admin (ID 21, Hugo Luna) gestiona cuentas.
INSERT INTO auditoria_usuario (id_usuario_afectado, id_usuario_admin, fecha_evento, tipo_accion, descripcion) VALUES
(
  (SELECT id_usuario FROM usuario WHERE username = 'javier.morales' LIMIT 1),
  (SELECT id_usuario FROM usuario WHERE username = 'hugo.luna' LIMIT 1),
  '2025-03-05 10:00:00',
  'CAMBIO_ESTADO',
  'Cuenta de javier.morales puesta como inactiva.'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'bruno.fernandez' LIMIT 1),
  (SELECT id_usuario FROM usuario WHERE username = 'ines.medina' LIMIT 1),
  '2025-10-19 08:15:00',
  'LOGIN_FALLIDO',
  'Intento de inicio de sesion fallido para bruno.fernandez'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'bruno.fernandez' LIMIT 1),
  (SELECT id_usuario FROM usuario WHERE username = 'ines.medina' LIMIT 1),
  '2025-10-19 08:15:30',
  'LOGIN_FALLIDO',
  'Intento de inicio de sesion fallido para bruno.fernandez'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'elena.gomez' LIMIT 1),
  (SELECT id_usuario FROM usuario WHERE username = 'hugo.luna' LIMIT 1),
  '2025-09-01 11:00:00',
  'RESETEO_PASS',
  'Admin reseteo la contrasena para elena.gomez.'
),
(
  (SELECT id_usuario FROM usuario WHERE username = 'ana.garcia' LIMIT 1),
  (SELECT id_usuario FROM usuario WHERE username = 'ines.medina' LIMIT 1),
  '2025-08-20 12:00:00',
  'BLOQUEO_CUENTA',
  'Cuenta bloqueada por admin Ines Medina por seguridad.'
);

