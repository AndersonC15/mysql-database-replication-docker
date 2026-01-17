-- replicacion_full.sql
DROP DATABASE IF EXISTS replicacion;
CREATE DATABASE replicacion;
USE replicacion;

-- Tabla departamentos
CREATE TABLE departamentos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- Tabla empleados (cada empleado pertenece a un departamento)
CREATE TABLE empleados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(150),
  departamento_id INT,
  salario DECIMAL(10,2),
  fecha_ingreso DATE,
  FOREIGN KEY (departamento_id) REFERENCES departamentos(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Tabla proyectos
CREATE TABLE proyectos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  presupuesto DECIMAL(12,2)
) ENGINE=InnoDB;

-- Tabla relacion empleados <-> proyectos (muchos a muchos)
CREATE TABLE empleado_proyecto (
  empleado_id INT,
  proyecto_id INT,
  fecha_asignacion DATE,
  PRIMARY KEY (empleado_id, proyecto_id),
  FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE CASCADE,
  FOREIGN KEY (proyecto_id) REFERENCES proyectos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Datos de ejemplo
INSERT INTO departamentos (nombre) VALUES
('Desarrollo'),
('Recursos Humanos'),
('Finanzas'),
('Marketing');

INSERT INTO empleados (nombre, email, departamento_id, salario, fecha_ingreso) VALUES
('Matteo Coello', 'matteo@example.com', 1, 950.00, '2024-03-01'),
('Anderson López', 'anderson@example.com', 1, 850.00, '2023-07-15'),
('Carlos Pérez', 'carlos@example.com', 2, 600.00, '2022-11-01'),
('Lucía Martínez', 'lucia@example.com', 3, 780.00, '2021-05-20'),
('María Gómez', 'maria@example.com', 4, 720.00, '2020-09-10');

INSERT INTO proyectos (nombre, presupuesto) VALUES
('Proyecto A', 15000.00),
('Proyecto B', 25000.00),
('Campaña Q4', 8000.00);

INSERT INTO empleado_proyecto (empleado_id, proyecto_id, fecha_asignacion) VALUES
(1, 1, '2024-04-01'),
(2, 1, '2024-04-15'),
(2, 2, '2024-06-01'),
(4, 3, '2024-08-01');

-- Opcional: crear un usuario con permisos de lectura para pruebas (no necesario para replicación)
CREATE USER IF NOT EXISTS 'analista'@'%' IDENTIFIED BY 'analista123';
GRANT SELECT ON replicacion.* TO 'analista'@'%';
FLUSH PRIVILEGES;
