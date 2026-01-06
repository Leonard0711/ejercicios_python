
-- Selección de la base de datos
USE Players;

-- Tabla players
SELECT * FROM players
LIMIT 10;

-- Tabla clubs
SELECT * FROM clubs
LIMIT 10;

-- Jugadores con su posición y el nombre del club donde juegan
SELECT p.name, p.position, c.name AS club_name
FROM players p 
JOIN clubs c ON p.current_club_id = c.club_id
LIMIT 10;

-- Top 10 jugadores más altos que el promedio
SELECT DISTINCT(name), height_in_cm
FROM players
WHERE height_in_cm > (SELECT AVG(height_in_cm) FROM players)
ORDER BY height_in_cm DESC
LIMIT 10;

-- Top 10 jugadores más altos que el promedio (versión con JOIN)
SELECT DISTINCT(p.name), p.height_in_cm
FROM players p
JOIN (SELECT AVG(height_in_cm) AS promedio FROM players)
AS avg_height ON p.height_in_cm > avg_height.promedio
ORDER BY p.height_in_cm DESC
LIMIT 10;

-- Top 10 clubes con mayor edad promedio de jugadores
SELECT c.name AS club_name,
        ROUND(AVG(TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()))) AS avg_age
FROM clubs c
JOIN players p ON c.club_id = p.current_club_id
GROUP BY c.name
ORDER BY avg_age DESC
LIMIT 10;

-- Top 10 jugadores con mayor valor de mercado junto con su club
SELECT DISTINCT(c.name) AS club_name, p.name, p.market_value_in_eur
FROM players p
JOIN clubs c ON p.current_club_id = c.club_id
ORDER BY p.market_value_in_eur DESC
LIMIT 10;

-- Cantidad de jugadores por posición en cada club
SELECT c.name AS club_name, p.position, COUNT(*) AS total_players
FROM players p
JOIN clubs c ON p.current_club_id = c.club_id
GROUP BY c.name, p.position
ORDER BY c.name, total_players DESC;

-- Top 10 jugadores con valor de mercado por encima del promedio de su club
SELECT DISTINCT p.name, p.market_value_in_eur, c.name
FROM players p
JOIN (
        SELECT current_club_id, AVG(market_value_in_eur) AS avg_value
        FROM players
        GROUP BY current_club_id
) club_avg ON p.current_club_id = club_avg.current_club_id
JOIN clubs c ON p.current_club_id = c.club_id
WHERE p.market_value_in_eur > club_avg.avg_value
ORDER BY market_value_in_eur DESC
LIMIT 10;





