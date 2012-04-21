-- =============================================
-- Author:		E.Popov
-- Create date: 2009-08-10
-- Description:	get an offer by id and seller
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_GetSellingOfferById] @Id INT
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;
	
        DECLARE @Offers udtt_Offers
	
        INSERT  INTO @Offers
                ( OfferId
                , RowNumber
                )
                SELECT  o.[SellingId]
                      , 1
                FROM    [Offers_Selling] AS o
                WHERE   o.[SellingId] = @Id
    
        EXEC [p_Offers_GetSellingOffersInternal] @Offers = @Offers
	
    END


