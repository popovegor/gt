CREATE PROCEDURE p_Statistics_GetAll
AS
BEGIN
	SET NOCOUNT ON;
	
	EXEC [dbo].[p_Statistic_Games]
	EXEC [dbo].[p_Statistic_GameServers]
END


