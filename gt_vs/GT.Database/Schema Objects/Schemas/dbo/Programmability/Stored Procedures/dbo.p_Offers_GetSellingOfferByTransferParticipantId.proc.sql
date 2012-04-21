-- =============================================
-- Author:		E.Popov
-- Create date: 2010-01-15
-- Description:	gets a selling offer by the passed transfer participant id
-- =============================================
-- =============================================
-- Author:		E.Popov
-- Create date: 2010-01-15
-- Description:	gets a selling offer by the passed transfer participant id
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_GetSellingOfferByTransferParticipantId]
    @TransferParticipantId INT
AS 
    BEGIN
        SET NOCOUNT ON ;

        DECLARE @HistoryOffers udtt_HistoryOffers
	
        INSERT  INTO @HistoryOffers
                ( HistoryOfferId
                , RowNumber
                )
                SELECT  h.[HistorySellingId]
                      , 1
                FROM    dbo.[BillingSystem_TransferParticipants] AS p
                        INNER JOIN dbo.[Offers_SellingHistory] AS h ON h.[HistorySellingId] = p.SellingHistoryId
                WHERE   p.TransferParticipantId = @TransferParticipantId
	
        EXEC dbo.[p_Offers_GetSellingOffersFromHistoryInternal] @HistoryOffers = @HistoryOffers
	
    END





