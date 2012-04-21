CREATE PROCEDURE [dbo].[p_News_Add]
	@News XML
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @id INT
    
    INSERT INTO [News]
		( Title,
		  Body,
		  CreateDate
		 )
	VALUES ( @News.value('(/n/@title)[1]', 'nvarchar(150)')
			,@News.value('(/n/@body)[1]', 'nvarchar(1000)')
			,GETUTCDATE()
			)
	SET @Id = SCOPE_IDENTITY()
	
	DECLARE @NewsT udtt_News
    INSERT  INTO @NewsT
                ( NewsId, RowNumber )
    VALUES  ( @Id, 1 )
    
    EXEC [p_News_GetNewsInternal] @News = @NewsT
END