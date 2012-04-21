CREATE PROCEDURE [dbo].[p_BillingSystem_WebMoney_GetInternal]
@WM [dbo].[udtt_WebMoney] READONLY
AS
BEGIN
	
	SET NOCOUNT ON;
    
    SELECT  wm.[Id]
		   ,wm.[TransferId]
		   ,wm.[WmInvoiceId]
           ,wm.[WmTransferId]
           ,wm.[TargetPurse]
           ,wm.[SourcePurse]
           ,wm.[PaymerNumber]
           ,wm.[CapitallerWmid]
           ,wm.[EuronoteNumber]
           ,wm.[PayerWmid]
           ,wm.[PaymerEmail]
           ,wm.[EuronoteEmail]
           ,wm.[TelepatPhone]
           ,wm.[TelepatOrderId]
           ,wm.[Description]
           ,wm.[ATMWmTransId]
           ,wm.[TransDate]
           ,wm.[RetCode]
           ,wm.[Commission]
           ,wm.[CreateDate]
    FROM    @WM AS ids
    INNER JOIN [BillingSystem_WebMoney] AS wm ON wm.[Id] = ids.Id
    ORDER BY ids.RowNumber ASC
	
END