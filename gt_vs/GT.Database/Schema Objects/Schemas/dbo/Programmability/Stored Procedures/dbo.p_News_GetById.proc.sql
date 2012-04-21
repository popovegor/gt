CREATE PROCEDURE [dbo].[p_News_GetById]
	@NewsId int
AS
	SET NOCOUNT ON;

	DECLARE @News udtt_News

        INSERT  INTO @News
                ( [NewsId]
                , RowNumber
                )
                SELECT  n.NewsId
                      , ROW_NUMBER() OVER ( ORDER BY [CreateDate] DESC ) AS RowNumber
                FROM    [News] AS n
                WHERE   n.NewsId = @NewsId
                
        EXEC [dbo].[p_News_GetNewsInternal] @News = @News
RETURN 0