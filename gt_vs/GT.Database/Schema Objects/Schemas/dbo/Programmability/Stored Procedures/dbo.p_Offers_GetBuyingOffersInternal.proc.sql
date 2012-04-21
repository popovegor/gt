-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-09
-- Description:	Returns buying offers
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_GetBuyingOffersInternal]
    @BuyingOffers [dbo].[udtt_Offers] READONLY
AS 
    BEGIN
        SET NOCOUNT ON ;
	
        SELECT  b.BuyingOfferId
              , b.BuyerId
              , u.UserName AS [BuyerName]
              , b.CreateDate
              , b.[Description]
              , b.GameServerId
              , b.Price
              , b.Title
              , b.UpdateDate
              , b.ModifyDate
              , b.ProductCategoryId
              , b.ProductCategoryMisc
        FROM    @BuyingOffers AS ids
                INNER JOIN dbo.Offers_Buying AS b ON b.BuyingOfferId = ids.OfferId
                INNER JOIN dbo.aspnet_Users AS u ON u.UserId = b.BuyerId
        ORDER BY ids.RowNumber ASC
	

    END





