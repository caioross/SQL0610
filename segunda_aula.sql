USE master;
GO

-- Idempotencia para criar o banco de dados
DROP DATABASE IF EXISTS Escola;
GO

CREATE DATABASE Escola;
GO

USE Escola;
GO

-- Idempotencia da para criar tabela Escola
DROP TABLE IF EXISTS Alunos;
CREATE TABLE Alunos (
	id INT IDENTITY(1,1) PRIMARY KEY,
	Nome NVARCHAR(100) NOT NULL,
	Idade INT,
	Email NVARCHAR(100),
	DataMatricula DATE NOT NULL
	);

INSERT INTO Alunos (Nome, Idade, Email, DataMatricula)
VALUES 
	(N'Caio', 38, N'kio199@gmail.com', '2025-02-12'),
	(N'Diego', 29, N'diego@gmail.com', '2023-06-01'),
	(N'Rafaélla', 25, N'rafa@gmail.com', '2020-09-14'),
	(N'Juliana', 27, N'ju@gmail.com', '2024-08-22'),
	(N'Marcela', 18, N'marcela@gmail.com', '2021-01-01');

SELECT * FROM Alunos;

-- mostrando alunos com idades menores que 26 anos
SELECT * FROM Alunos WHERE Idade <= 26;

-- mostrar alunos mais novos primeiro
SELECT * FROM Alunos ORDER BY Idade ASC;

SELECT * FROM Alunos ORDER BY Nome ASC;

--------  Atualizando os dados (UPDATE) -----------
UPDATE Alunos 
SET Email = N'lalala@gmail.com' 
WHERE id = 1;

SELECT id, Nome, Email FROM Alunos
WHERE id = 1;

UPDATE Alunos
SET Idade = Idade + 1;

-------------- Remoção de Dados (DELETE) --------------

DELETE FROM Alunos
WHERE id = 1;

DELETE FROM Alunos
WHERE Idade < 30;

---- Mostrar todos os alunos que começam com uma 
---- letra especifica
SELECT * FROM Alunos
WHERE Nome LIKE N'D%';

--- Mostrar apenas os 3 alunos mais novos
SELECT TOP 3 * FROM Alunos
ORDER BY Idade ASC;

---- quero ver o aluno mais velho! e somente ele!!!
SELECT TOP 1 * FROM Alunos
ORDER BY Idade DESC;

--- quantos alunos nos temos na tabela
SELECT COUNT(*) AS 'Total Alunos' FROM Alunos;

--- calcular a media de idade dos alunos
SELECT AVG(Idade) AS 'Idade Média' FROM Alunos;





