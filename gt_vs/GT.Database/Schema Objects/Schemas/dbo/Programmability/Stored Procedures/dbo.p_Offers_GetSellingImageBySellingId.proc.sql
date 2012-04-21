CREATE PROCEDURE [dbo].[p_Offers_GetSellingImageBySellingId]
	@SellingId int 
AS
BEGIN

  DECLARE @SellingImages udtt_sellingImages
  
  INSERT INTO @SellingImages (SellingImageId, RowNumber)
  SELECT TOP (1) si.SellingImageId AS SellingImageId, 1  AS RowNumber FROM [dbo].[Offers_SellingImages] AS si
  WHERE si.SellingId = @SellingId
  
  EXEC p_Offers_GetSellingImagesInternal @SellingImages = @SellingImages

END 	
	
	
