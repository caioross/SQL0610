
USE Escola;
GO

--- Inner Join:
-- Mostrar apenas alunos matriculados
SELECT a.Nome, a.Email, c.NomeCurso,  m.DataInscricao
FROM Alunos a

INNER JOIN Matriculas m ON a.id = m.AlunoId
INNER JOIN Cursos c ON c.id = m.CursoId

ORDER BY a.Nome

INSERT INTO Alunos (Nome, Idade, Email, DataMatricula)
VALUES
	(N'Thamires', 32, 'thamires@gmail.com', '2025-02-12'),
	(N'Antonio', 22, 'antonio@gmail.com', '2025-06-01');

-- Left Join
-- mostrar todos os alunos mesmo sem matricula

SELECT a.Nome, c.NomeCurso, m.DataInscricao
FROM Alunos a

LEFT JOIN Matriculas m ON a.id = m.AlunoId
LEFT JOIN Cursos c ON c.id = m.CursoId

ORDER BY m.DataInscricao


-- Tabela de professores

DROP TABLE IF EXISTS Professores;
CREATE TABLE Professores(
	id INT PRIMARY KEY IDENTITY(1,1),
	Nome NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100)
	);

INSERT INTO Professores (Nome, Email)
VALUES
	('Katia','katia@gmail.com'),
	('Ricardo','ricardo@gmail.com'),
	('Sibeli','sibeli@gmail.com');

SELECT * FROM Professores

-- Tabela de Notas

DROP TABLE IF EXISTS Notas ;
CREATE TABLE Notas(
	id INT PRIMARY KEY IDENTITY(1,1),
	AlunoId INT NOT NULL,
	CursoId INT NOT NULL,
	Nota INT NOT NULL,
	DataAvaliacao DATE NOT NULL
	
	FOREIGN KEY (AlunoId) REFERENCES Alunos(id),
	FOREIGN KEY (CursoId) REFERENCES Cursos(id)
	);

INSERT INTO Notas (AlunoId, CursoId, Nota, DataAvaliacao)
VALUES
	(2,1,8,'2024-02-07'),
	(6,2,7,'2024-03-06'),
	(11,3,6,'2024-04-05'),
	(12,4,5,'2024-05-04'),
	(13,5,4,'2024-06-03'),
	(16,1,3,'2024-07-02'),
	(17,2,2,'2024-08-01');

SELECT * FROM Notas;

--- Tabela de Pagamentos
DROP TABLE IF EXISTS Pagamentos
CREATE TABLE Pagamentos(
	id INT PRIMARY KEY IDENTITY(1,1),
	AlunoId INT NOT NULL,
	Valor INT NOT NULL,
	DataPagamento DATE NOT NULL,
	Situacao NVARCHAR(10) NOT NULL

	FOREIGN KEY (AlunoId) REFERENCES Alunos(id),
	);

INSERT INTO Pagamentos (AlunoId, Valor, DataPagamento, Situacao)
VALUES
	(2,300,'2024-05-01','Pago'),
	(6,500,'2024-05-01','Atrasado'),
	(12,400,'2024-03-10','Pago'),
	(13,300,'2024-04-21','Pendente'),
	(14,630,'2024-05-11','Atrasado'),
	(16,700,'2024-06-12','Pago'),
	(17,100,'2024-02-09','Pendente');

SELECT * FROM Pagamentos

--- Mostrar notas dos alunos em cada Curso
SELECT 
	a.Nome AS Aluno,
	c.NomeCurso AS Curso,
	n.Nota,
	n.DataAvaliacao AS Data
FROM Notas n

INNER JOIN Alunos a ON a.id = n.AlunoId
INNER JOIN Cursos c ON c.id = n.CursoId

ORDER BY n.DataAvaliacao DESC

-- media de notas por curso
SELECT c.NomeCurso, AVG(n.Nota) AS 'Media de Notas'
FROM Notas n
INNER JOIN Cursos c ON c.id = n.CursoId
GROUP BY c.NomeCurso
ORDER BY 'Media de Notas' DESC;

-- visualizar a situação de pagamento por aluno
SELECT a.Nome, p.Valor, p.DataPagamento, p.Situacao
FROM Pagamentos p
INNER JOIN Alunos a ON a.id = p.AlunoId
ORDER BY p.DataPagamento DESC;

-- quantidade de alunos por situacao de pagamento
SELECT p.Situacao, COUNT(*) AS Quantidade
FROM Pagamentos p
GROUP BY p.Situacao
ORDER BY Quantidade DESC;



