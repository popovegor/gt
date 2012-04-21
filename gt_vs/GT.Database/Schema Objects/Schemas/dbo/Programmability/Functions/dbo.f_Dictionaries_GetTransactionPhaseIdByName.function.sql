CREATE FUNCTION [dbo].[f_Dictionaries_GetTransactionPhaseIdByName] ( @Name NVARCHAR(100) )
RETURNS INT
AS 
    BEGIN
        RETURN (SELECT TOP (1) TransactionPhaseId FROM Dictionaries_TransactionPhases WHERE [Name] = @Name)
    END