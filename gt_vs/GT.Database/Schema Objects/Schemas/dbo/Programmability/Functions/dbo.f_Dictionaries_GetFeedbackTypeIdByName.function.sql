CREATE FUNCTION [dbo].[f_Dictionaries_GetFeedbackTypeIdByName]
(
	@Name nvarchar(100) 
)
RETURNS INT
AS
BEGIN
	RETURN (SELECT TOP (1) ft.FeedbackTypeId FROM dbo.Dictionaries_FeedbackTypes AS ft WHERE ft.Name = @Name)
END