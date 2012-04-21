-- =============================================
-- Author:		E.Popov
-- Create date: 2009-11-25
-- Description:	returns transfer participant
-- =============================================
CREATE FUNCTION [dbo].[f_BillingSystem_GetTransferParticipantAsXml]
(@TransferParticipantId INT)
RETURNS XML
AS
BEGIN

	DECLARE @p xml
	
	declare @EmptyGuid uniqueidentifier = dbo.f_GetemptyGuid()

	select @p = cast('' as xml).query(
		'<tp 
			rmsid="{if ( string(sql:column("p.RealMoneySourceId")) = "") then 0 else sql:column("p.RealMoneySourceId")}" 
			soid="{if( string(sql:column("h.HistorySellingId")) = "") then 0 else sql:column("h.SellingId")}"
			uid="{if ( string(sql:column("p.UserId")) = "") then sql:variable("@EmptyGuid") else sql:column("p.UserId")}"
			tpid="{sql:column("p.TransferParticipantId")}"
		/>')
	from [BillingSystem_TransferParticipants] as p
	LEFT JOIN dbo.[Offers_SellingHistory] AS h ON h.[HistorySellingId] = p.SellingHistoryId
	where p.TransferParticipantId = @TransferParticipantId

	RETURN @p

END






