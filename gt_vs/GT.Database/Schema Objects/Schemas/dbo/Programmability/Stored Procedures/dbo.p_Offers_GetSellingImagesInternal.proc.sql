CREATE PROCEDURE [dbo].[p_Offers_GetSellingImagesInternal]
    @SellingImages udtt_sellingImages READONLY
AS 
    BEGIN 
        SELECT TOP ( 1 )
                si.SellingImageId
              , si.Image
              , si.ImageName
              , si.SellingId
        FROM    [dbo].[Offers_SellingImages] AS si
        INNER JOIN @SellingImages AS t ON t.SellingImageId = si.SellingImageId
    END 
