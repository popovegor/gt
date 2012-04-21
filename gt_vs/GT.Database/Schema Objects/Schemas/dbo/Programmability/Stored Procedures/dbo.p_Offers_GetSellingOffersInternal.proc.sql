-- =============================================
-- Author:		E.Popov
-- Create date: 2009-08-10
-- Description:	returns the offer(s) by ids
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_GetSellingOffersInternal]
    @Offers udtt_Offers READONLY
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

        SELECT  o.[SellingId]
              , o.[SellerId]
              , u.[UserName] AS SellerName
              , o.[GameServerId]
              , o.[Title]
              , o.[Description]
              , o.[Price]
              , o.[TransactionPhaseId]
              , o.[CreateDate]
              , o.[UpdateDate]
              , o.[ModifyDate]
              , o.[ValidKey]
              , o.[DeliveryTime]
              , o.[BuyerId]
              , u2.[UserName] AS BuyerName
              , o.ProductCategoryId
              , o.ProductCategoryMisc
        FROM    @Offers AS ids
        INNER JOIN [Offers_Selling] AS o ON o.[SellingId] = ids.OfferId
        INNER JOIN aspnet_Users AS u ON o.SellerId = u.UserId
        LEFT JOIN aspnet_Users AS u2 ON o.BuyerId = u2.UserId
        ORDER BY ids.RowNumber ASC
	
    END


