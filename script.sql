-- Base de Datos I - Unidad 4 - Ej09: PlataformaELearning
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS INTENTO;
DROP TABLE IF EXISTS estudiante_curso;
DROP TABLE IF EXISTS ESTUDIANTE;
DROP TABLE IF EXISTS LECCION;
DROP TABLE IF EXISTS MODULO;
DROP TABLE IF EXISTS PREGUNTA;
DROP TABLE IF EXISTS EVALUACION;
DROP TABLE IF EXISTS CURSO;
DROP TABLE IF EXISTS INSTRUCTOR;

CREATE TABLE INSTRUCTOR (
    id_instructor INT PRIMARY KEY,
    nombre_instructor VARCHAR(50),
    biografia VARCHAR(100),
    especialidad VARCHAR(50),
    email_contacto VARCHAR(50) UNIQUE,
    telefono_instructor VARCHAR(50)
);

CREATE TABLE CURSO (
    id_curso INT PRIMARY KEY,
    id_instructor INT,
    codigo_curso VARCHAR(50) UNIQUE,
    titulo_curso VARCHAR(50),
    descripcion_curso VARCHAR(100),
    nivel_dificultad VARCHAR(50),
    precio DECIMAL(12,2),
    FOREIGN KEY (id_instructor) REFERENCES INSTRUCTOR(id_instructor)
);

CREATE TABLE EVALUACION (
    id_evaluacion INT PRIMARY KEY,
    id_curso INT,
    codigo_evaluacion VARCHAR(50) UNIQUE,
    titulo_evaluacion VARCHAR(50),
    tipo_evaluacion VARCHAR(50),
    nota_minima INT,
    intentos_permitidos INT,
    FOREIGN KEY (id_curso) REFERENCES CURSO(id_curso)
);

CREATE TABLE PREGUNTA (
    id_pregunta INT PRIMARY KEY,
    id_evaluacion INT,
    codigo_pregunta VARCHAR(50) UNIQUE,
    enunciado VARCHAR(50),
    opcion_correcta VARCHAR(100),
    puntaje INT,
    orden_pregunta INT,
    FOREIGN KEY (id_evaluacion) REFERENCES EVALUACION(id_evaluacion)
);

CREATE TABLE MODULO (
    id_modulo INT PRIMARY KEY,
    id_curso INT,
    numero_modulo INT,
    titulo_modulo VARCHAR(50),
    descripcion_modulo VARCHAR(100),
    duracion_estimada INT,
    estado_publicacion VARCHAR(50),
    FOREIGN KEY (id_curso) REFERENCES CURSO(id_curso)
);

CREATE TABLE LECCION (
    id_leccion INT PRIMARY KEY,
    id_modulo INT,
    numero_leccion INT,
    titulo_leccion VARCHAR(50),
    tipo_leccion VARCHAR(100),
    duracion_leccion INT,
    enlace_contenido VARCHAR(100),
    FOREIGN KEY (id_modulo) REFERENCES MODULO(id_modulo)
);

CREATE TABLE ESTUDIANTE (
    id_estudiante INT PRIMARY KEY,
    nombre_estudiante VARCHAR(50),
    apellido_estudiante VARCHAR(100),
    email_estudiante VARCHAR(50) UNIQUE,
    fecha_registro DATE,
    pais_residencia VARCHAR(50)
);

CREATE TABLE estudiante_curso (
    id_inscripcion INT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    fecha_alta DATE,
    porcentaje_avance DECIMAL(12,2),
    estado_finalizacion VARCHAR(50),
    FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES CURSO(id_curso)
);

CREATE TABLE INTENTO (
    id_intento INT PRIMARY KEY,
    id_inscripcion INT,
    id_evaluacion INT,
    fecha_intento DATE,
    calificacion INT,
    estado_intento VARCHAR(100),
    FOREIGN KEY (id_inscripcion) REFERENCES estudiante_curso(id_inscripcion),
    FOREIGN KEY (id_evaluacion) REFERENCES EVALUACION(id_evaluacion)
);

-- Datos de INSTRUCTOR
INSERT INTO INSTRUCTOR (id_instructor, nombre_instructor, especialidad, email_contacto, telefono_instructor) VALUES (1, 'Laura Vega', 'Python', 'lvega@cursos.com', '261-5001001');
INSERT INTO INSTRUCTOR (id_instructor, nombre_instructor, especialidad, email_contacto, telefono_instructor) VALUES (2, 'Martín Cruz', 'Bases de Datos', 'mcruz@cursos.com', '261-5001002');
INSERT INTO INSTRUCTOR (id_instructor, nombre_instructor, especialidad, email_contacto, telefono_instructor) VALUES (3, 'Hugo Salas', 'Redes', 'hsalas@cursos.com', '261-5001004');
INSERT INTO INSTRUCTOR (id_instructor, nombre_instructor, especialidad, email_contacto, telefono_instructor) VALUES (4, 'Inés Luna', 'Estadística', 'iluna@cursos.com', '261-5001005');

-- Datos de CURSO
INSERT INTO CURSO (id_curso, id_instructor, codigo_curso, titulo_curso, nivel_dificultad) VALUES (1, 1, 'PY-101', 'Python desde cero', 'Inicial');
INSERT INTO CURSO (id_curso, id_instructor, codigo_curso, titulo_curso, nivel_dificultad) VALUES (2, 2, 'SQL-201', 'SQL Esencial', 'Inicial');
INSERT INTO CURSO (id_curso, id_instructor, codigo_curso, titulo_curso, nivel_dificultad) VALUES (3, 3, 'NET-150', 'Redes para Principiantes', 'Inicial');
INSERT INTO CURSO (id_curso, id_instructor, codigo_curso, titulo_curso, nivel_dificultad) VALUES (4, 2, 'SQL-301', 'SQL Avanzado', 'Avanzado');

-- Datos de EVALUACION
INSERT INTO EVALUACION (id_evaluacion, id_curso, codigo_evaluacion, titulo_evaluacion, tipo_evaluacion) VALUES (1, 1, 'EV-01', 'Parcial Python', 'Parcial');
INSERT INTO EVALUACION (id_evaluacion, id_curso, codigo_evaluacion, titulo_evaluacion, tipo_evaluacion) VALUES (2, 2, 'EV-02', 'Quiz SQL', 'Quiz');
INSERT INTO EVALUACION (id_evaluacion, id_curso, codigo_evaluacion, titulo_evaluacion, tipo_evaluacion) VALUES (3, 2, 'EV-03', 'Examen Final SQL', 'Final');
INSERT INTO EVALUACION (id_evaluacion, id_curso, codigo_evaluacion, titulo_evaluacion, tipo_evaluacion) VALUES (4, 3, 'EV-05', 'Test de Redes', 'Test');

-- Datos de PREGUNTA
INSERT INTO PREGUNTA (id_pregunta, id_evaluacion, codigo_pregunta, enunciado, puntaje) VALUES (1, 1, 'Q-01', '¿Qué imprime print(2+3)?', 2);
INSERT INTO PREGUNTA (id_pregunta, id_evaluacion, codigo_pregunta, enunciado, puntaje) VALUES (2, 1, 'Q-02', '¿Qué es una lista?', 2);
INSERT INTO PREGUNTA (id_pregunta, id_evaluacion, codigo_pregunta, enunciado, puntaje) VALUES (3, 2, 'Q-03', '¿Qué hace SELECT?', 3);
INSERT INTO PREGUNTA (id_pregunta, id_evaluacion, codigo_pregunta, enunciado, puntaje) VALUES (4, 3, 'Q-04', '¿Qué es un wireframe?', 5);

-- Datos de MODULO
INSERT INTO MODULO (id_modulo, id_curso, numero_modulo, titulo_modulo, estado_publicacion) VALUES (1, 1, 1, 'Introducción', 'Publicado');
INSERT INTO MODULO (id_modulo, id_curso, numero_modulo, titulo_modulo, estado_publicacion) VALUES (2, 1, 2, 'Funciones', 'Publicado');
INSERT INTO MODULO (id_modulo, id_curso, numero_modulo, titulo_modulo, estado_publicacion) VALUES (3, 2, 1, 'Consultas básicas', 'Publicado');
INSERT INTO MODULO (id_modulo, id_curso, numero_modulo, titulo_modulo, estado_publicacion) VALUES (4, 2, 2, 'JOINs', 'Borrador');

-- Datos de LECCION
INSERT INTO LECCION (id_leccion, id_modulo, numero_leccion, titulo_leccion, duracion_leccion) VALUES (1, 1, 2, 'Tipos de datos', 15);
INSERT INTO LECCION (id_leccion, id_modulo, numero_leccion, titulo_leccion, duracion_leccion) VALUES (2, 2, 1, 'Definir funciones', 20);
INSERT INTO LECCION (id_leccion, id_modulo, numero_leccion, titulo_leccion, duracion_leccion) VALUES (3, 3, 1, 'SELECT y WHERE', 18);
INSERT INTO LECCION (id_leccion, id_modulo, numero_leccion, titulo_leccion, duracion_leccion) VALUES (4, 4, 1, 'INNER JOIN', 25);

-- Datos de ESTUDIANTE
INSERT INTO ESTUDIANTE (id_estudiante, nombre_estudiante, email_estudiante, pais_residencia, fecha_registro) VALUES (1, 'Sol Acosta', 'sol@mail.com', 'Argentina', '2026-03-15');
INSERT INTO ESTUDIANTE (id_estudiante, nombre_estudiante, email_estudiante, pais_residencia, fecha_registro) VALUES (2, 'Tomás Vera', 'tomas@mail.com', 'Chile', '2026-03-20');
INSERT INTO ESTUDIANTE (id_estudiante, nombre_estudiante, email_estudiante, pais_residencia, fecha_registro) VALUES (3, 'Gonzalo Peña', 'gonzalo@mail.com', 'Argentina', '2026-04-11');
INSERT INTO ESTUDIANTE (id_estudiante, nombre_estudiante, email_estudiante, pais_residencia, fecha_registro) VALUES (4, 'Julia Romero', 'julia@mail.com', 'Perú', '2026-04-30');

-- Datos de estudiante_curso
INSERT INTO estudiante_curso (id_inscripcion, id_estudiante, id_curso, estado_finalizacion, fecha_alta) VALUES (1, 1, 1, 'En curso', '2026-04-01');
INSERT INTO estudiante_curso (id_inscripcion, id_estudiante, id_curso, estado_finalizacion, fecha_alta) VALUES (2, 1, 2, 'Completado', '2026-04-05');
INSERT INTO estudiante_curso (id_inscripcion, id_estudiante, id_curso, estado_finalizacion, fecha_alta) VALUES (3, 2, 2, 'En curso', '2026-04-10');
INSERT INTO estudiante_curso (id_inscripcion, id_estudiante, id_curso, estado_finalizacion, fecha_alta) VALUES (4, 3, 4, 'En curso', '2026-05-02');

-- Datos de INTENTO
INSERT INTO INTENTO (id_intento, id_inscripcion, id_evaluacion, calificacion, fecha_intento) VALUES (1, 1, 1, 5, '2026-05-02');
INSERT INTO INTENTO (id_intento, id_inscripcion, id_evaluacion, calificacion, fecha_intento) VALUES (2, 1, 1, 8, '2026-05-09');
INSERT INTO INTENTO (id_intento, id_inscripcion, id_evaluacion, calificacion, fecha_intento) VALUES (3, 2, 2, 7, '2026-05-12');
INSERT INTO INTENTO (id_intento, id_inscripcion, id_evaluacion, calificacion, fecha_intento) VALUES (4, 3, 3, 6, '2026-06-01');
