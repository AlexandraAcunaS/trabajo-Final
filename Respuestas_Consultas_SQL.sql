--- 	1.	¿Cuáles son los 3 clientes que más han gastado en total y cuánto han gastado cada uno?

SELECT Invoice.CustomerId AS "ID Cliente", Customer.FirstName AS Nombre, Customer.LastName As Apellido,
		SUM(Invoice.Total) AS Total
FROM Customer
INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Invoice.CustomerId
ORDER BY Total DESC
LIMIT 3;



---		2.	¿Cuáles son los 5 artistas que tiene canciones más largas en promedio

ALTER TABLE Track ADD COLUMN "Minutos" ENTEGER;
UPDATE Track SET Minutos = Milliseconds/60000;

SELECT Artist.ArtistId, Artist.Name AS Nombre, Album.Title AS Titulo,
        round(avg( Track.Minutos),2) AS Promedio
FROM Track
JOIN Album ON Track.AlbumId = Album.AlbumId 
JOIN Artist ON Album.AlbumId = Artist.ArtistId
GROUP BY Track.AlbumId
ORDER BY Track.Minutos DESC
LIMIT 5;
	
	

--- 	3.	Indicar cuales son los 5 álbumes con más canciones, el artista compositor, de que genero son y a que multimedia pertenece.

SELECT Album.Title AS titulo_del_album, Artist.Name AS Nombre_del_artista, Genre.Name AS genero, MediaType.Name AS MULTIMEDIA, 
		COUNT(Track.TrackId) AS Cantidad
FROM Album
JOIN Artist ON Album.ArtistId = Artist.ArtistId
JOIN Track ON Album.AlbumId = Track.AlbumId
JOIN Genre ON Track.GenreId = Genre.GenreId
JOIN MediaType ON Track.MediaTypeId = MediaType.MediaTypeId
GROUP BY Album.AlbumId, Artist.Name
ORDER BY cantidad DESC
LIMIT 5;



--- 	4.	¿Cuáles son los 5 generenos con mayor seguimiento e indique el total de los segundos existentes en la base de datos para esos géneros?.

ALTER TABLE Track ADD COLUMN "Segundos" ENTEGER;
UPDATE Track SET Segundos = Milliseconds/1000;

SELECT Genre.Name AS Genero, count(Genre.GenreId) AS Cantidad, sum(segundos) AS segundos_Total, ROUND(AVG(segundos),2) AS Promedios_de_segundos 
FROM Track
JOIN Genre ON Genre.GenreId=Track.GenreId
GROUP BY Genero
ORDER BY Cantidad DESC
LIMIT 5;



--- 	5.	En tiempo total cual es el artista numero 1 por genero.
SELECT Genre.Name AS Genero, Artist.Name AS Artista, SUM(Track.Milliseconds)/1000 AS TiempoTotalenSegundos
FROM Genre 
JOIN Track ON Genre.GenreId = Track.GenreId
JOIN Album ON Track.AlbumId = Album.AlbumId
JOIN Artist ON Album.ArtistId = Artist.ArtistId
GROUP BY Genre.Name
ORDER BY TiempoTotalenSegundos DESC;