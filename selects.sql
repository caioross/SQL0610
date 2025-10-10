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
-- exibir situação de desempenho do aluno
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


---  Consultas combinadas (Exists, Union)
-- Mostrar apenas os alunos que tem pagamentos registrados
SELECT Nomes
FROM Alunos a
WHERE EXISTS (
	SELECT 1 FROM Pagamentos p WHERE p.AlunoId = a.id
);

-- Combinar os alunos e professores em uma mesma lista
SELECT Nome, 'Aluno' AS TIPO
FROM Alunos
UNION
SELECT Nome, 'Professor' AS Tipo
FROM Professores

-- Extra - Receita final
-- Alunos com suas ultimas notas

SELECT a.Nome, c.NomeCurso, n.Nota, n.DataAvaliacao
FROM Alunos a
INNER JOIN Notas n ON a.id = n.AlunoId
INNER JOIN Cursos c ON c.id = n.CursoId
WHERE n.DataAvaliacao = (
	SELECT MAX(DataAvaliacao)
	FROM Notas n2
	WHERE  n2.AlunoId = a.id
);

-- ranking de alunos pelas notas
-- (usaremos uma função de janela)
SELECT 
	a.Nome,
	c.NomeCurso,
	n.Nota,
	RANK() OVER (ORDER BY n.Nota DESC) AS Ranking
FROM Notas n
JOIN Alunos a ON n.AlunoId = a.id
JOIN Cursos c ON n.CursoId = c.id
ORDER BY a.Nome

-- multiplos calculos
SELECT 
	a.Nome AS Aluno,
	AVG(CAST(n.Nota AS DECIMAL(10,2))) as 'Media de Notas',
	MIN(n.Nota) AS 'Menor Nota',
	MAX(n.Nota) AS 'Maior Nota',
	COUNT(*) AS 'Qtd Notas'
FROM Alunos a
INNER JOIN Notas n ON n.AlunoId = a.id
GROUP BY a.Nome

/*
Outras formas de forçar o decimal
AVG(CONVERT(DECIMAL(10,2),n.Nota))
AVG(1.0 * n.Nota)
AVG(CAST(n.Nota AS FLOAT))
*/

--- Contar quantas avaliações há por situação 
SELECT 
	CASE
		WHEN n.Nota >=7 THEN 'Aprovado'
		WHEN n.Nota >=5 THEN 'Recuperação'
		ELSE 'Reprovado'
	END AS Situacao,
	COUNT(*) AS Quantidade
FROM Alunos a
INNER JOIN Notas n ON a.id = n.AlunoId
GROUP BY
	CASE
		WHEN n.Nota >=7 THEN 'Aprovado'
		WHEN n.Nota >=5 THEN 'Recuperação'
		ELSE 'Reprovado'
	END
ORDER BY Quantidade DESC;

-- QUERO ALUNOS COM EMAIL DO GMAIL
SELECT Nome, Email
FROM Alunos
WHERE Email LIKE '%@gmail.com';