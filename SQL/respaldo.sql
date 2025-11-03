-----------------------------------------------------
-- SCRIPT DE RESPALDO Y RESTAURACION - BIBLIOTECA DIGITAL
-----------------------------------------------------

-- 1. COMANDO PARA CREAR UN RESPALDO (BACKUP)

-- Proposito: Se conecta al servidor remoto y crea un archivo 
-- (ej. 'respaldo_biblioteca.sql') en tu PC local
-- que contiene toda la estructura Y los datos de la BD

-- Instruccion: Ejecutar esto en tu terminal local.
-- Te pedira la contraseña (ClaveRoot123) de forma segura

## mysqldump -h 178.16.140.38 -u BIBLIOTECA -p BIBLIOTECA > respaldo_biblioteca.sql ##


-- 2. COMANDO PARA RESTAURAR UN RESPALDO (RESTORE)

-- Proposito: Toma el archivo (ej. 'respaldo_biblioteca.sql')
-- de tu PC y carga todos sus datos en el servidor remoto.

-- ¡ADVERTENCIA! Esto borrara cualquier dato actual en la BD
-- remota y lo reemplazara con los datos del archivo.

## mysql -h 178.16.140.38 -u BIBLIOTECA -p BIBLIOTECA < respaldo_biblioteca.sql ##