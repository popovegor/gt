-- =============================================
-- Author:		E.Popov
-- Create date: 2009-11-25
-- Description:	returns user's offers 
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_GetSellingOffersForUser]
    @UserId UNIQUEIDENTIFIER
AS 
    BEGIN
        SET NOCOUNT ON ;
	
        DECLARE @Offers udtt_Offers
	
        INSERT  INTO @Offers
                ( OfferId
                , RowNumber
                )
                SELECT  o.[SellingId]
                      , 1
                FROM    [Offers_Selling] AS o
                WHERE   o.SellerId = @UserId
    
        EXEC [p_Offers_GetSellingOffersInternal] @Offers = @Offers
	
    END


