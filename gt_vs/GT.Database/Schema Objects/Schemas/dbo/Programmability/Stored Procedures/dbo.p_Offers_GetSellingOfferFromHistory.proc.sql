-- =============================================
-- Author:		E.Popov
-- Create date: 2010-01-15
-- Description:	gets selling offer from history by id
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_GetSellingOfferFromHistory] @HistoryId INT
AS 
    BEGIN
	
        DECLARE @HistoryOffers udtt_HistoryOffers

        INSERT  INTO @HistoryOffers
                ( HistoryOfferId, RowNumber )
        VALUES  ( @HistoryId, 1 )
	
        EXEC dbo.[p_Offers_GetSellingOffersFromHistoryInternal] @HistoryOffers = @HistoryOffers

	
    END


