USE Escola;
GO

-- excluir as tabelas caso ja existam (idempotencia)
DROP TABLE IF EXISTS Cursos;
DROP TABLE IF EXISTS Matriculas;

CREATE TABLE Cursos(
	id INT PRIMARY KEY IDENTITY(1,1),
	NomeCurso NVARCHAR(100) NOT NULL,
	CargaHoraria INT NOT NULL
	);

INSERT INTO Cursos (NomeCurso, CargaHoraria)
VALUES
('SQL',		40),
('Python',	32),
('Power BI',70),
('Excel',	16),
('PHP',		80);

CREATE TABLE Matriculas (
	id INT PRIMARY KEY IDENTITY(1,1),
	AlunoId INT NOT NULL,
	CursoId INT NOT NULL,
	DataInscricao DATE NOT NULL,

	FOREIGN KEY (AlunoId) REFERENCES Alunos(id),
	FOREIGN KEY (CursoId) REFERENCES Cursos(id)
	);