-- 1. Crear una base de datos llamada películas.

CREATE TABLE peliculas (
id int PRIMARY KEY,
pelicula varchar(64) NOT NULL,
"Año estreno" int  NOT NULL,
director varchar(50) NOT NULL
);

COPY peliculas
FROM '/Users/vanessa/Desktop/a/peliculas.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM peliculas;

-- 2. Cargar ambos archivos a su tabla correspondiente y aplicar el truncado de estas.

CREATE TABLE reparto (
pelicula_id INTEGER,
actores VARCHAR(60),
FOREIGN KEY (pelicula_id) REFERENCES peliculas(id)

);

COPY reparto
FROM '/Users/vanessa/Desktop/a/reparto.csv'
WITH CSV DELIMITER ',';

SELECT * FROM reparto;

-- 3. Obtener el ID de la película “Titanic”

SELECT id FROM peliculas WHERE pelicula = 'Titanic';

-- 4. Listar a todos los actores que aparecen en la película "Titanic"

SELECT reparto.actores, peliculas.pelicula
FROM reparto
RIGHT JOIN peliculas ON pelicula_id = id
WHERE peliculas.pelicula = 'Titanic';


-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford.

SELECT peliculas.pelicula, reparto.actores
FROM peliculas
INNER JOIN reparto ON id = pelicula_id
WHERE actores = 'Harrison Ford';

-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.

SELECT pelicula, "Año estreno" 
FROM peliculas
WHERE "Año estreno" >= 1990 AND "Año estreno" <= 1999 
ORDER BY pelicula;

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.

SELECT pelicula AS titulo, LENGTH(pelicula) AS longitud_titulo
FROM peliculas;

-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas.

SELECT MAX(LENGTH(pelicula)) AS longitud_maxima
FROM peliculas;


SELECT pelicula, MAX(LENGTH(pelicula)) AS longitud_maxima
FROM peliculas
GROUP BY pelicula
ORDER BY longitud_maxima DESC
LIMIT 1;
