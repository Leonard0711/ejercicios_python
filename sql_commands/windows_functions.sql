-- Active: 1756737494822@@localhost@3306@practica_sql
USE practica_sql;

-- DROP TABLE IF EXISTS ventas;

-- Creando la tabla ventas
CREATE TABLE ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vendedor VARCHAR(50),
    region VARCHAR(50),
    mes DATE,
    importe DECIMAL(10,2)
);

-- Insertando los datos a la tabla ventas
INSERT INTO ventas (vendedor, region, mes, importe) VALUES
('Ana', 'Lima',  '2025-01-01', 1200.00),
('Ana', 'Lima',  '2025-02-01', 1500.00),
('Ana', 'Lima',  '2025-03-01', 900.00),
('Luis','Lima',  '2025-01-01', 2000.00),
('Luis','Lima',  '2025-02-01', 1800.00),
('Luis','Lima',  '2025-03-01', 2100.00),
('María','Cusco', '2025-01-01', 1300.00),
('María','Cusco', '2025-02-01', 700.00),
('María','Cusco', '2025-03-01', 1600.00),
('Pablo','Cusco','2025-01-01', 3000.00),
('Pablo','Cusco','2025-02-01', 2500.00),
('Pablo','Cusco','2025-03-01', 2800.00);

-- DROP TABLE IF EXISTS alumnos;

-- Creando la tabla alumnos
CREATE TABLE alumnos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    curso VARCHAR(50),
    alumno VARCHAR(50),
    nota DECIMAL(4,2)
);

-- Insertando los datos a la tabla alumnos
INSERT INTO alumnos (curso, alumno, nota) VALUES
('Estadística', 'Carla', 17.50),
('Estadística', 'Jorge', 18.00),
('Estadística', 'Lucía', 18.00),
('Estadística', 'Diego', 15.00),
('Econometría', 'Carla', 16.00),
('Econometría', 'Jorge', 14.00),
('Econometría', 'Lucía', 19.00),
('Econometría', 'Diego', 19.00);

-- Tabla alumnos
SELECT * FROM alumnos;
-- Tabla ventas
SELECT * FROM ventas;

-- ROW NUMBER() / agrupado por región, ordenado por importe (mayor a menor)
SELECT vendedor, region, mes, importe,
        ROW_NUMBER() OVER (PARTITION BY region ORDER BY importe ASC) AS rn_region
FROM ventas
ORDER BY region, rn_region;

-- RANK() y DENSE_RANK() / ordenado en modo ranking
SELECT curso, alumno, nota,
        RANK() OVER (PARTITION BY curso ORDER BY nota DESC) AS rk_nota,
        DENSE_RANK() OVER (PARTITION BY curso ORDER BY nota DESC) AS drk_nota
FROM alumnos
ORDER BY curso, rk_nota, drk_nota, alumno;
-- RANK salta posiciones en empates (p. ej. 1,2,3,4)
-- DENSE_RANK no salta empates (p. ej. 1,2,2,3)

-- NTILE(n)
-- Distribución de filas en un número especificado de grupos
SELECT vendedor, region, mes, importe,
        NTILE(3) OVER (ORDER BY importe DESC) AS tercios
FROM ventas
ORDER BY tercios, importe DESC;
-- NTILE(3) agrupado en tercios o grupos de 3

-- Suma y promedio por grupos (PARTITION BY)
SELECT region, vendedor, mes, importe,
        SUM(importe) OVER (PARTITION BY region) AS total_region,
        AVG(importe) OVER (PARTITION BY vendedor) AS promedio_vendedor
FROM ventas
ORDER BY region, vendedor, mes;
-- total_region: sumatoria de todo el importe por region
-- promedio_vendedor: promedio del importe por vendedor

-- Total acumulado por mes
SELECT vendedor, mes, importe,
        SUM(importe) OVER (PARTITION BY vendedor ORDER BY mes
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS acumulado
FROM ventas
ORDER BY vendedor, mes;
-- El acumulado se calcula progresivamente según el orden de mes.

-- Total acumulado por mes
SELECT vendedor, mes, importe,
        SUM(importe) OVER (PARTITION BY vendedor ORDER BY mes
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_acumulado
FROM ventas
ORDER BY vendedor, mes;
-- El total se calcula sobre todas las filas de la partición,
-- pero el orden por mes no cambia el resultado (porque siempre toma todo el rango).

