-- BASE DE DATOS CORRECTA
USE biblioteca_digital;

-- CONSULTA 1: CONTEO DE USUARIOS POR TIPO (Prueba de Catalogo)
-- -------------------------------------------------------------
-- Proposito: Verificar que la carga de usuarios (30) y el JOIN con la tabla tipo_usuario_catalogo funcionan.
SELECT 
    tc.nombre AS tipo_de_usuario, 
    COUNT(u.id_usuario) AS total_usuarios
FROM usuario u
JOIN tipo_usuario_catalogo tc ON u.id_tipo_usuario = tc.id_tipo_usuario
GROUP BY tc.nombre;

-- CONSULTA 2: CONTEO DE LIBROS POR CATEGORIA (Prueba de JOIN simple)
-- --------------------------------------------------------------------
-- Proposito: Verificar la carga de libros (150) y el JOIN con categoria
SELECT
    c.nombre AS nombre_categoria,
    COUNT(l.id_libro) AS total_libros
FROM libro l
JOIN categoria c ON l.id_categoria = c.id_categoria
GROUP BY c.nombre
ORDER BY c.id_categoria;

-- CONSULTA 3: VER PRESTAMOS ACTIVOS CON NOMBRES (Prueba de JOIN multiple)
-- ------------------------------------------------------------------------
-- Proposito: Probar la relacion central (Usuario -> Prestamo -> Libro) y verificar el JOIN con el catalogo de estados
SELECT 
    p.id_prestamo,
    u.nombre AS nombre_usuario,
    l.titulo AS titulo_libro,
    e.nombre AS estado,
    p.fecha_prestamo,
    p.fecha_devolucion_esperada
FROM prestamo p
JOIN usuario u ON p.id_usuario = u.id_usuario
JOIN libro l ON p.id_libro = l.id_libro
JOIN estado_prestamo_catalogo e ON p.id_estado_prestamo = e.id_estado_prestamo
WHERE e.nombre = 'activo';

-- CONSULTA 4: VER PRESTAMOS VENCIDOS (Prueba de Catalogo)
-- -------------------------------------------------------
-- Proposito: Simular un reporte de biblioteca para buscar morosos
-- Verifica que el estado vencido funciona
SELECT 
    u.nombre AS usuario_moroso,
    l.titulo,
    e.nombre AS estado,
    p.fecha_devolucion_esperada
FROM prestamo p
JOIN usuario u ON p.id_usuario = u.id_usuario
JOIN libro l ON p.id_libro = l.id_libro
JOIN estado_prestamo_catalogo e ON p.id_estado_prestamo = e.id_estado_prestamo
WHERE e.nombre = 'vencido';

-- CONSULTA 5: VER HISTORIAL DE UN SOLO USUARIO (Prueba de Filtro)
-- ----------------------------------------------------------------
-- Proposito: Simular la vista de "Mis Prestamos" de un usuario
-- Buscamos al usuario 'ana.garcia' (ID 1)
SELECT 
    l.titulo,
    e.nombre AS estado,
    p.fecha_prestamo
FROM prestamo p
JOIN libro l ON p.id_libro = l.id_libro
JOIN usuario u ON p.id_usuario = u.id_usuario
JOIN estado_prestamo_catalogo e ON p.id_estado_prestamo = e.id_estado_prestamo
WHERE u.username = 'ana.garcia';

-- CONSULTA 6: LIBROS QUE NUNCA HAN SIDO DEVUELTOS (Prueba de IS NULL)
-- --------------------------------------------------------------------
-- Proposito: Probar la logica de fecha_devolucion_real siendo NULL.
-- Debe mostrar activos, vencidos y solicitados.
SELECT 
    l.titulo,
    u.nombre,
    e.nombre AS estado
FROM prestamo p
JOIN libro l ON p.id_libro = l.id_libro
JOIN usuario u ON p.id_usuario = u.id_usuario
JOIN estado_prestamo_catalogo e ON p.id_estado_prestamo = e.id_estado_prestamo
WHERE p.fecha_devolucion_real IS NULL;

-- CONSULTA 7: REPORTE DE LIBROS MAS POPULARES (Prueba de GROUP BY)
-- -----------------------------------------------------------------
-- Proposito: Simular un reporte. Contamos apariciones en la tabla prestamo
SELECT
    l.titulo,
    COUNT(p.id_prestamo) AS total_de_prestamos
FROM prestamo p
JOIN libro l ON p.id_libro = l.id_libro
GROUP BY l.titulo
ORDER BY total_de_prestamos DESC
LIMIT 5;

-- CONSULTA 8: VER USUARIOS MAS ACTIVOS (Prueba de GROUP BY)
-- ----------------------------------------------------------
-- Proposito: Similar al anterior, pero enfocado en usuarios
SELECT
    u.nombre,
    COUNT(p.id_prestamo) AS total_prestamos_personales
FROM prestamo p
JOIN usuario u ON p.id_usuario = u.id_usuario
GROUP BY u.nombre
ORDER BY total_prestamos_personales DESC
LIMIT 3;

-- CONSULTA 9: VER COLA DE RESERVAS PARA UN LIBRO (Prueba de Reservas)
-- --------------------------------------------------------------------
-- Proposito: Verificar que la tabla reserva funciona como una cola
-- Buscamos reservas pendientes para el libro Codigo Limpio (ID 1)
SELECT 
    l.titulo,
    u.nombre AS usuario_en_espera,
    r.fecha_reserva,
    e.nombre AS estado
FROM reserva r
JOIN libro l ON r.id_libro = l.id_libro
JOIN usuario u ON r.id_usuario = u.id_usuario
JOIN estado_reserva_catalogo e ON r.id_estado_reserva = e.id_estado_reserva
WHERE l.isbn = '9780132350884' AND e.nombre = 'pendiente'
ORDER BY r.fecha_reserva ASC;

-- CONSULTA 10: BUSCAR UN LIBRO POR SU ISBN (Prueba de UNIQUE)
-- ------------------------------------------------------------
-- Proposito: Simular la busqueda exacta por ISBN.
SELECT * FROM libro 
WHERE isbn = '9780060935467'; -- (Breve Historia del Tiempo)

-- CONSULTA 11: REPORTE DE HISTORIAL DE AUDITORIA DE LIBROS (Prueba de US_11)
-- ------------------------------------------------------------------------------
-- Proposito: Verificar que la tabla auditoria_libro funciona
-- Muestra que admin edito que libro
SELECT
    a.fecha_evento,
    l.titulo AS libro_editado,
    u.nombre AS admin_editor,
    a.descripcion_cambio
FROM auditoria_libro a
JOIN libro l ON a.id_libro = l.id_libro
JOIN usuario u ON a.id_usuario_admin = u.id_usuario;

-- CONSULTA 12: REPORTE DE AUDITORIA DE SEGURIDAD (Prueba de US_20)
-- -----------------------------------------------------------------
-- Proposito: Verificar que la tabla 'auditoria_usuario' registra eventos de seguridad
SELECT
    a.fecha_evento,
    u_afectado.nombre AS usuario_afectado,
    a.tipo_accion,
    a.descripcion
FROM auditoria_usuario a
JOIN usuario u_afectado ON a.id_usuario_afectado = u_afectado.id_usuario
WHERE a.tipo_accion = 'LOGIN_FALLIDO';

-- CONSULTA 13: REPORTE DE ACCIONES DE ADMINISTRADORES (Prueba de US_20)
-- ----------------------------------------------------------------------
-- Proposito: Verificar que auditoria_usuario registra acciones realizadas por un administrador (no automaticas)
SELECT
    a.fecha_evento,
    u_afectado.nombre AS usuario_afectado,
    u_admin.nombre AS admin_responsable,
    a.tipo_accion
FROM auditoria_usuario a
JOIN usuario u_afectado ON a.id_usuario_afectado = u_afectado.id_usuario
JOIN usuario u_admin ON a.id_usuario_admin = u_admin.id_usuario
WHERE a.id_usuario_admin IS NOT NULL;

-- CONSULTA 14: BUSCAR PREGUNTAS DE SEGURIDAD DE UN USUARIO (Prueba de US_4)
-- ---------------------------------------------------------------------------
-- Proposito: Simular el inicio de la recuperacion de contrasena
-- Busca las preguntas que configuro ana.garcia (ID 1).
SELECT 
    u.nombre,
    p.texto_pregunta,
    ur.respuesta -- (Esto solo para prueba, la app no mostraria la respuesta)
FROM usuario_respuesta ur
JOIN usuario u ON ur.id_usuario = u.id_usuario
JOIN pregunta_seguridad p ON ur.id_pregunta = p.id_pregunta
WHERE u.username = 'ana.garcia';

-- CONSULTA 15: USUARIOS QUE DEBEN CAMBIAR SU CONTRASENA (Prueba de US_15)
-- -------------------------------------------------------------------------
-- Proposito: Encontrar usuarios marcados con 'requiere_cambio_pass = 1'
SELECT username, nombre, id_tipo_usuario
FROM usuario
WHERE requiere_cambio_pass = 1;

-- CONSULTA 16: LIBROS DISPONIBLES EN CATEGORIA 'Programacion'
-- ------------------------------------------------------------
-- Proposito: Simular una busqueda filtrada (US_5)
SELECT 
    l.titulo, 
    l.autor, 
    l.cantidad_disponible
FROM libro l
JOIN categoria c ON l.id_categoria = c.id_categoria
WHERE c.nombre = 'Programacion' AND l.cantidad_disponible > 0;

-- CONSULTA 17: LIBROS SIN STOCK (Agotados)
-- ----------------------------------------------------
-- Proposito: Encontrar libros que no se pueden prestar
SELECT titulo, autor, cantidad_disponible
FROM libro
WHERE cantidad_disponible = 0;

-- CONSULTA 18: LEER LA CONFIGURACION DEL SISTEMA (Prueba de US_19)
-- ----------------------------------------------------
-- Proposito: Verificar que la tabla 'configuracion' funciona
SELECT * FROM configuracion;

-- CONSULTA 19: USUARIOS INACTIVOS O BLOQUEADOS (Prueba de Catalogo)
-- ----------------------------------------------------
-- Proposito: Encontrar usuarios que no pueden acceder al sistema
SELECT 
    u.username,
    u.nombre,
    e.nombre AS estado
FROM usuario u
JOIN estado_usuario_catalogo e ON u.id_estado_usuario = e.id_estado_usuario
WHERE e.nombre IN ('inactivo', 'bloqueado');

-- CONSULTA 20: LIBROS QUE NO ESTAN ACTUALMENTE PRESTADOS
-- ----------------------------------------------------
-- Proposito: Encontrar libros que no estan en estado 'activo' o 'vencido'
-- Util para saber que se puede prestar (excluyendo 'solicitado')S
SELECT 
    l.titulo,
    l.autor,
    l.cantidad_disponible
FROM libro l
WHERE l.id_libro NOT IN (
    SELECT p.id_libro
    FROM prestamo p
    JOIN estado_prestamo_catalogo e ON p.id_estado_prestamo = e.id_estado_prestamo
    WHERE e.nombre IN ('activo', 'vencido', 'solicitado')
);