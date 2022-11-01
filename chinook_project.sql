/*chinook is a database for a music store, I queried the database to use the data answering my questions*/
/*The top ten world cities listening to Jazz music?*/
SELECT c.City,
       SUM(il.Quantity)
FROM Customer c
JOIN Invoice i ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il ON il.InvoiceId = i.InvoiceId
JOIN Track t ON t.TrackId = il.TrackId
JOIN Genre g ON g.GenreId = t.GenreId
WHERE g.name = "Jazz"
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

/*The most valuable customer who listens to Jazz in our platform?*/
SELECT c.CustomerId,
       c.FirstName || " " || c.LastName AS Full_Name,
       SUM(il.UnitPrice * il.Quantity)
FROM Customer c
JOIN Invoice i ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il ON il.InvoiceId = i.InvoiceId
JOIN Track t ON t.TrackId = il.TrackId
JOIN Genre g ON g.GenreId = t.GenreId
WHERE g.Name = "Jazz"
GROUP BY 1,
         2
ORDER BY 3 DESC
LIMIT 8

/*The top selleing artist name who sings and plays Jazz music?*/
SELECT ar.ArtistId,
       ar.Name,
       SUM(il.Quantity * il.UnitPrice) AS total_amount_in_USD
FROM Artist ar
JOIN Album al ON ar.ArtistId = al.ArtistId
JOIN Track t ON t.AlbumId = al.AlbumId
JOIN Genre g ON g.GenreId = t.GenreId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
WHERE g.Name = "Jazz"
GROUP BY 1,
         2
ORDER BY 3 DESC

/*The best sales representatives in the platform targeting customers with Jazz music?*/
SELECT e.EmployeeId,
       e.FirstName || " " || e.LastName AS Full_Name,
       SUM(il.Quantity * il.UnitPrice) AS total_amount_in_USD
FROM Customer c
JOIN Invoice i ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il ON il.InvoiceId = i.InvoiceId
JOIN Track t ON t.TrackId = il.TrackId
JOIN Genre g ON g.GenreId = t.GenreId
JOIN Employee e ON e.EmployeeId = c.SupportRepId
WHERE g.name = "Jazz"
GROUP BY 1,
         2
ORDER BY 3 DESC