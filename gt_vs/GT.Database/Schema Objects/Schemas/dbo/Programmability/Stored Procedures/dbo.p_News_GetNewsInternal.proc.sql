CREATE PROCEDURE [dbo].[p_News_GetNewsInternal]
	@News udtt_News READONLY
AS
BEGIN
	
	SET NOCOUNT ON;
    
    SELECT  n.[NewsId]
          , n.[Title]
          , n.[TitleRu]
          , n.[Body]
          , n.[BodyRu]
          , n.[CreateDate]
    FROM    @News AS ids
    INNER JOIN [News] AS n ON n.[NewsId] = ids.NewsId
    ORDER BY ids.RowNumber ASC
	
END