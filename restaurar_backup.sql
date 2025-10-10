USE master;
GO

ALTER DATABASE Escola SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
RESTORE DATABASE Escola
FROM DISK = N'C:\Users\noturno\Desktop\Full_bkp_Escola.bak'
WITH REPLACE, -- permite sobreescrever os dados antigos
	STATS = 5;