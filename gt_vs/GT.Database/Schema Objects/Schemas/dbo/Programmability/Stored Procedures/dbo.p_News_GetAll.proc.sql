CREATE PROCEDURE p_News_GetAll
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @News udtt_News

        INSERT  INTO @News
                ( [NewsId]
                , RowNumber
                )
                SELECT  n.NewsId
                      , ROW_NUMBER() OVER ( ORDER BY [CreateDate] DESC ) AS RowNumber
                FROM    [News] AS n
                
        EXEC [dbo].[p_News_GetNewsInternal] @News = @News
END