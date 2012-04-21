-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-09
-- Description:	Checks a transaction phase of the selling offer
-- =============================================
CREATE FUNCTION [dbo].[f_Offers_CheckTransactionPhaseOnSuggestSellingOffer] ( @SellingOfferId INT )
RETURNS BIT
AS 
    BEGIN
        DECLARE @Success BIT = 0
	
        IF EXISTS ( SELECT  'Transaction phase <> 1'
                    FROM    dbo.[Offers_Selling] AS s
                    WHERE   s.TransactionPhaseId = 1
                            AND s.[SellingId] = @SellingOfferId ) 
            BEGIN
                SET @Success = 1
            END 
        RETURN @Success

    END


