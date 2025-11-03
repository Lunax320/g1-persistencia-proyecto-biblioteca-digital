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