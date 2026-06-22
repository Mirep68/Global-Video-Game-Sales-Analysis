------------------------------------------------------------
-- Proceso de Limpieza – Tabla video_games

------------------------------------------------------------
-- 1. Limpieza de la columna Name

UPDATE video_games
SET "Name" = REPLACE("Name", '.hack', '')
WHERE "Name" LIKE '.hack%';

-- Verificacion
SELECT *
FROM video_games
WHERE "Name" LIKE 'hack%';

------------------------------------------------------------
-- 2. Eliminación de registros nulos

DELETE FROM video_games
WHERE "Platform" IS NULL
   OR "Year" IS NULL
   OR "Genre" IS NULL;

-- Verificacion
SELECT *
FROM video_games
WHERE "Platform" IS NULL
   OR "Year" IS NULL
   OR "Genre" IS NULL;

------------------------------------------------------------
-- 3. Limpieza de la columna Year

--Reemplazo de valores “N/A”
UPDATE video_games
SET "Year" = NULL
WHERE TRIM("Year") = 'N/A';

-- Verificacion
SELECT *
FROM video_games
WHERE TRIM("Year") = 'N/A';


--Eliminación de valores no numéricos
DELETE FROM video_games
WHERE "Year" IS NOT NULL
AND "Year" !~ '^[0-9]+$';

-- Verificacion
SELECT *
FROM video_games
WHERE "Year" IS NOT NULL
AND "Year" !~ '^[0-9]+$';

------------------------------------------------------------
-- 4. Conversión de tipo de dato

ALTER TABLE video_games
ALTER COLUMN "Year" TYPE INTEGER
USING "Year"::INTEGER;

-- Verificacion
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'video_games'
AND column_name = 'Year';




------------------------------------------------------------
-- Proceso de Limpieza – Tabla video_games_sales

------------------------------------------------------------
-- 1. Eliminar tambien los datos en la tabla video_games_sales

DELETE FROM video_games_sales
WHERE "Rank" NOT IN (
    SELECT "Rank"
    FROM video_games
);

-- Verificacion
SELECT *
FROM video_games_sales vgs
LEFT JOIN video_games vg
ON vgs."Rank" = vg."Rank"
WHERE vg."Rank" IS NULL;

------------------------------------------------------------
-- 2. Limpieza Publisher

UPDATE video_games_sales
SET "Publisher" = NULL
WHERE TRIM("Publisher") = 'N/A';

-- Verificacion
SELECT *
FROM video_games_sales
WHERE TRIM("Publisher") = 'N/A';

------------------------------------------------------------
-- 3. Limpieza NA_Sales

UPDATE video_games_sales
SET "NA_Sales" = NULL
WHERE "NA_Sales" IN ('Inc', ' Inc.', ' Inc');

-- Verificacion
SELECT *
FROM video_games_sales
WHERE "NA_Sales" IN ('Inc', ' Inc.',' Inc');

------------------------------------------------------------
-- 4. Conversión de tipo de dato NA_Sales

ALTER TABLE video_games_sales
ALTER COLUMN "NA_Sales" TYPE real
USING "NA_Sales"::real;

-- Verificacion
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'video_games_sales'
AND column_name = 'NA_Sales';





   