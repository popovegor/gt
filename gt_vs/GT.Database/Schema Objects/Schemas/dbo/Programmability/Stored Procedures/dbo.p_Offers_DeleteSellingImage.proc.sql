CREATE PROCEDURE [dbo].[p_Offers_DeleteSellingImage]
    @SellerId UNIQUEIDENTIFIER
  , @SellingId INT
AS 
    BEGIN 
        DELETE  dbo.Offers_SellingImages
        WHERE   [dbo].[Offers_SellingImages].[SellingId] = @SellingId
                AND EXISTS ( SELECT TOP ( 1 )
                                    1
                             FROM   [dbo].[Offers_Selling] AS s
                             WHERE  s.[SellerId] = @SellerId
                                    AND s.[SellingId] = @SellingId )
    END 
