-- 1. Desactivar la revision de llaves foraneas
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Vaciar todas las tablas (en orden inverso de dependencia si fuera necesario, pero TRUNCATE suele manejarlo)
TRUNCATE TABLE auditoria_libro;
TRUNCATE TABLE auditoria_usuario;
TRUNCATE TABLE usuario_respuesta;
TRUNCATE TABLE reserva;
TRUNCATE TABLE prestamo;
TRUNCATE TABLE libro;
TRUNCATE TABLE usuario;
TRUNCATE TABLE categoria;
TRUNCATE TABLE pregunta_seguridad;
TRUNCATE TABLE configuracion;
TRUNCATE TABLE estado_reserva_catalogo;
TRUNCATE TABLE estado_prestamo_catalogo;
TRUNCATE TABLE estado_usuario_catalogo;
TRUNCATE TABLE tipo_usuario_catalogo;

-- 3. Reactivar la revision de llaves foraneas
SET FOREIGN_KEY_CHECKS = 1;