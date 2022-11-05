USE GalloFlixDb;
-- SQL
-- DQL - Data Query Language
-- Exibir todos os campos dos filmes cadastrados
SELECT * FROM Movie;

-- Exibir todos os campos dos filmes cadastrados, ordenados por título
SELECT * FROM Movie ORDER BY Title;

-- Exibir todos os campos dos filmes lançados em 2006
SELECT * FROM Movie 
WHERE MovieYear = 2006;

-- SELECT * FROM Aluno WHERE YEAR(DataNascimento) = 2006;

-- Exibir todos os filmes com classificação etária livre
SELECT * FROM Movie
WHERE AgeRating = 0;

-- Exibir o título, duração e ano de estreia dos filmes com mais de 150 minutos, ordenados do mais longo para o mais curto
SELECT 
	Title,
    Duration,
	MovieYear
FROM Movie
WHERE Duration > 150
ORDER BY Duration DESC;

-- Exibir o título, duração e ano de estreia dos filmes lançados entre 1990 e 2010, renomeando os campos para português
SELECT 
	Title AS 'Titulo',
    Duration AS 'Duração (min.)',
	MovieYear AS 'Ano de Estreia'
FROM Movie
WHERE MovieYear BETWEEN 1990 AND 2010;
-- WHERE MovieYear >= 1990 AND MovieYear <=2010;

-- Exibir o título, duração e ano de estreia dos filmes lançados entre 1990 e 2010 com duração maior que 150 minutos, renomeando os campos para português
SELECT 
	Title AS 'Titulo',
    Duration AS 'Duração (min.)',
	MovieYear AS 'Ano de Estreia'
FROM Movie
WHERE MovieYear BETWEEN 1990 AND 2010
 AND Duration > 150; 
 
-- Exibir todos os filmes que estreiaram nos anos de 1996, 1999, 2005 e 2010 
SELECT * FROM Movie
WHERE MovieYear = 1996 OR MovieYear = 1999 OR MovieYear = 2005 OR MovieYear = 2010;

SELECT * FROM Movie
WHERE MovieYear IN (1996, 1999, 2005, 2010)
ORDER BY MovieYear DESC;

-- Exibir todos os filmes que contenham a palavra 'Guerra' em seu título
SELECT * FROM Movie
WHERE Title LIKE 'guerra%'; -- Pesquisa no começo do texto

SELECT * FROM Movie
WHERE Title LIKE '%guerra'; -- Pesquisa no final do texto

SELECT * FROM Movie
WHERE Title LIKE '%guerra*'; -- Pesquisa em qualquer parte do texto

-- Exibir apenas os anos que possuem filmes cadastrados (não exibir os filmes, apenas os anos)
SELECT DISTINCT MovieYear FROM Movie ORDER BY MovieYear;

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- FUNÇÕES AGREGADAS
-- /////////////////////////////////////////////////////////////////
-- CONTAGEM - COUNT
-- Exibir a quantidade de filmes que estreiam entre 1990 e 2010
 SELECT COUNT(*) AS 'Qtde de Filmes entre 1990 e 2010'
 FROM Movie
 WHERE MovieYear BETWEEN 1990 AND 2010;
 
-- Exibir a quantidade de filmes com duração menos que 150 minutos
 SELECT COUNT(*) AS 'Qtde de Filmes com menos de 150 min'
 FROM Movie
 WHERE Duration < 150;
 
-- Curiosidade 1 - Exibir os anos e a quantidade de filmes lançados naquele ano
SELECT MovieYear, COUNT(*) 
FROM Movie 
GROUP BY MovieYear -- Sem o GROUP BY ele não agrupa
ORDER BY MovieYear;

SELECT MovieYear, 
	COUNT(*) AS 'Qtde de Filme'
FROM Movie 
GROUP BY MovieYear 
ORDER BY 2; -- Esse 2 significa o COUNT
 
-- ///////////////////////////////////////////////////////////////// 
-- MÁXIMO - MAX
-- Maior ocorrência (valor) de um campo 
-- Exibir a maior duração existente entre todos os filmes cadastrados
 SELECT MAX(Duration) AS 'Maior Duração' FROM Movie;

-- Exibir o ano de lançamento mais recente entre os filmes cadastrados
SELECT MAX(MovieYear) AS 'Ano mais recentes' FROM Movie;

-- /////////////////////////////////////////////////////////////////
-- MÍNIMO - MIN
-- Menor ocorrência (valor) de um campo 
-- Exibir a menor  duração existente entre os filmes cadastrados
SELECT MIN(Duration) AS 'Menor Duração' FROM Movie;

-- Exibir o ano de lançamento mais antigo entre os filmes cadastrados
SELECT MIN(MovieYear) AS 'Ano mais antigo' FROM Movie;

-- /////////////////////////////////////////////////////////////////
-- SOMATÓRIO - SUM
-- Exibir o total de tempo necessário para assistir os filmes que estreiaram entre 1990 e 2010
SELECT SUM(Duration) AS 'Duração 1990- 2010' FROM Movie
WHERE MovieYear BETWEEN 1990 AND 2010;

SELECT SUM(Duration)/60 AS 'Duração 1990- 2010' FROM Movie
WHERE MovieYear BETWEEN 1990 AND 2010;

-- /////////////////////////////////////////////////////////////////
-- MÉDIA - AVG
-- A média de duração dos filmes que estreiaram entre 1990 e 2010
 SELECT AVG(Duration) AS 'Duração Média 1990- 2010' FROM Movie
WHERE MovieYear BETWEEN 1990 AND 2010;

 SELECT SUM(Duration)/COUNT(*) AS 'Duração Média 1990- 2010' FROM Movie
WHERE MovieYear BETWEEN 1990 AND 2010;
 
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////
-- SUBCONSULTAS
-- Exibir o filme com a maior (maximo) duração
-- Sem usar subconsulta - atualização do comando manual
SELECT MAX(Duration) FROM Movie;  -- 207
SELECT * FROM Movie WHERE Duration = 207;

-- Com subconsulta - atualização dinâmica
SELECT * FROM Movie WHERE Duration = (
	SELECT MAX(Duration) FROM Movie
);


-- Exibir os filmes do Gênero Terror
-- Sem usar subconsulta - atualização do comando manual
SELECT * FROM Genre WHERE Name LIKE 'Terror';  -- 27
SELECT * FROM MovieGenre WHERE GenreId = 27; -- 32, 51, 61
SELECT * FROM Movie WHERE Id IN (32, 51, 61);

-- Com subconsulta - atualização dinâmica
SELECT * FROM Movie WHERE Id IN (
	SELECT MovieId FROM MovieGenre WHERE GenreId = (
		SELECT Id FROM Genre WHERE Name LIKE 'Terror'
    )
);
