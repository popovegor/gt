CREATE PROCEDURE [dbo].[p_BillingSystem_WebMoney_GetByTransferId]
	@TransferId int
AS
	SET NOCOUNT ON;

	DECLARE @WM udtt_WebMoney

	INSERT  INTO @WM
                ( [Id]
                , RowNumber
                )
	SELECT Id, ROW_NUMBER() OVER ( ORDER BY [CreateDate] DESC ) AS RowNumber
	From [BillingSystem_WebMoney]
	Where [BillingSystem_WebMoney].TransferId = @TransferId
	
	EXEC [dbo].[p_BillingSystem_WebMoney_GetInternal] @WM = @WM
