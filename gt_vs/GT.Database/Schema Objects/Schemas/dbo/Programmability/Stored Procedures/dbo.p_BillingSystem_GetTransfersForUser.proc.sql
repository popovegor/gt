-- =============================================
-- Author:		E.Popov
-- Create date: 2009-11-25
-- Description:	returns transfers for actual user
-- =============================================
CREATE PROCEDURE [dbo].[p_BillingSystem_GetTransfersForUser] 
	@UserId uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;

	declare @Transfers udtt_Transfers
	
	insert into @Transfers(TransferId, RowNumber)
	select t.TransferId, ROW_NUMBER() over (order by [CreateDate] desc)
	from [BillingSystem_Transfers] as t
	inner join [BillingSystem_TransferParticipants] as p 
		on p.TransferParticipantId in (t.ToTransferParticipantId, t.FromTransferParticipantId)
	where p.UserId = @UserId

	exec [p_BillingSystem_GetTransfers] @Transfers = @Transfers

END
