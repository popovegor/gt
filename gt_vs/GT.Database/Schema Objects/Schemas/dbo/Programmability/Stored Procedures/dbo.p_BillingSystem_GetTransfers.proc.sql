-- =============================================
-- Author:		E.Popov
-- Create date: 2009-11-25
-- Description:	returns transfers by ids
-- =============================================
CREATE PROCEDURE [dbo].[p_BillingSystem_GetTransfers]
    @Transfers [dbo].[udtt_Transfers] READONLY
AS 
    BEGIN
        SET NOCOUNT ON ;

        SELECT  t.TransferId
              , t.CreateDate
              , t.Amount
              , t.Note
              , t.StatusId
              , t.StatusModifyDate
              , dbo.[f_BillingSystem_GetTransferParticipantAsXml](t.FromTransferParticipantId) AS FromTransferParticipant
              , dbo.[f_BillingSystem_GetTransferParticipantAsXml](t.ToTransferParticipantId) AS ToTransferParticipant
              , t.Commission
              , t.OurCommission
              , t.OurCommissionRecieved
        FROM    @Transfers AS ids
                INNER JOIN [BillingSystem_Transfers] AS t ON t.TransferId = ids.TransferId
        ORDER BY ids.RowNumber ASC 
    
    END






