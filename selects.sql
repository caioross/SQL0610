USE Escola;
GO

------  Seleções Básicas e Ordenações
-- [01] mostrar todos os cursos ordenados pela carga horaria
SELECT NomeCurso, CargaHoraria
FROM Cursos
ORDER BY CargaHoraria DESC;

-- [02] mostrar os 3 cursos mais curtos
SELECT TOP 3 NomeCurso, CargaHoraria
FROM Cursos
ORDER BY CargaHoraria ASC;

------   Filtros com WHERE
-- [01] Alunos maiores que 25 anos
SELECT Nome, Idade, Email
FROM Alunos
WHERE Idade > 30;

-- [02] Pagamentos ainda pendentes
SELECT AlunoId, Valor, Situacao
FROM Pagamentos
WHERE Situacao <> 'Pago';

-- [03] Cursos com carga horaria entre 40 e 80 horas
SELECT *
FROM Cursos
WHERE CargaHoraria BETWEEN 40 AND 80;

------   Funções de Agregação
-- SUM, AVG, COUNT, MAX, MIN...

-- [01] Quantidade de alunos matriculados por curso
SELECT c.NomeCurso, COUNT(m.AlunoId) AS 'Total Alunos'
FROM Cursos c
LEFT JOIN Matriculas m ON c.id = m.CursoId
GROUP BY c.NomeCurso
ORDER BY 'Total Alunos' DESC;

-- [02] Nota Média por Aluno
SELECT a.Nome, AVG(n.Nota) AS 'Média de notas'
FROM Alunos a
INNER JOIN Notas n ON a.id = n.AlunoId
GROUP BY a.Nome;

-- [03] Soma do total ja pago!
SELECT SUM(Valor) AS 'Total Pago'
FROM Pagamentos
WHERE Situacao = 'Pago';

------- HAVING (filtros em grupos)
-- cursos com mais de 1 aluno matriculado
SELECT c.NomeCurso, COUNT(m.AlunoId) AS Total
FROM Cursos c
INNER JOIN Matriculas m ON c.id = m.CursoId
GROUP BY c.NomeCurso
HAVING COUNT(m.AlunoId) > 1

------ SubqQueries (Sub Consultas)
-- Alunos com notas acima da media geral
SELECT Nome
FROM Alunos
WHERE id IN (
	SELECT AlunoId
	FROM Notas
	WHERE Nota > (
		SELECT AVG(Nota)
		FROM Notas
		)
	);

------ CASE e Formatação
-- exi   bir situação de desempenho do aluno
SELECT 
	a.Nome,
	n.Nota,
	CASE 
		WHEN n.Nota >= 7 THEN 'Aprovado'
		WHEN n.Nota >= 5 THEN 'Recuperação'
		ELSE 'Reprovado'
	END AS Situacao
FROM Alunos a
INNER JOIN Notas n ON a.id = n.AlunoId;