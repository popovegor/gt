CREATE PROCEDURE [dbo].[p_BillingSystem_WebMoney_Add]
	@wm xml
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @id INT
    
    INSERT INTO [BillingSystem_WebMoney]
		(   [TransferId]
           ,[WmInvoiceId]
           ,[WmTransferId]
           ,[TargetPurse]
           ,[SourcePurse]
           ,[PaymerNumber]
           ,[CapitallerWmid]
           ,[EuronoteNumber]
           ,[PayerWmid]
           ,[PaymerEmail]
           ,[EuronoteEmail]
           ,[TelepatPhone]
           ,[TelepatOrderId]
           ,[Description]
           ,[ATMWmTransId]
           ,[TransDate]
           ,[RetCode]
           ,[Commission]
           ,[CreateDate]
		 )
	VALUES ( @wm.value('(/wm/@tid)[1]', 'int')
			,@wm.value('(/wm/@wmiid)[1]', 'int')
			,@wm.value('(/wm/@wmtid)[1]', 'int')
			,@wm.value('(/wm/@tp)[1]', 'nvarchar(13)')
			,@wm.value('(/wm/@sp)[1]', 'nvarchar(13)')
			,@wm.value('(/wm/@pn)[1]', 'bigint')
			,@wm.value('(/wm/@cwmid)[1]', 'decimal(12,0)')
			,@wm.value('(/wm/@en)[1]', 'decimal(21,0)')
			,@wm.value('(/wm/@pwmid)[1]', 'nvarchar(20)')
			,@wm.value('(/wm/@pe)[1]', 'nvarchar(100)')
			,@wm.value('(/wm/@ee)[1]', 'nvarchar(100)')
			,@wm.value('(/wm/@telp)[1]', 'nvarchar(15)')
			,@wm.value('(/wm/@toid)[1]', 'int')
			,@wm.value('(/wm/@d)[1]', 'nvarchar(500)')
			,@wm.value('(/wm/@atm)[1]', 'int')
			,@wm.value('(/wm/@tdate)[1]', 'datetime')
			,@wm.value('(/wm/@rc)[1]', 'int')
			,@wm.value('(/wm/@com)[1]', 'money')
			,GETUTCDATE()
			)
			
	SET @Id = SCOPE_IDENTITY()
	
	DECLARE @w udtt_WebMoney
    INSERT  INTO @w
                ( Id, RowNumber )
    VALUES  ( @Id, 1 )
    
    EXEC [p_BillingSystem_WebMoney_GetInternal] @WM = @w
    
END    