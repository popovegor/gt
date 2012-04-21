-- =============================================
-- Author:		E.Popov
-- Create date: 2009-08-11
-- Description:	Update the offer
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_UpdateSelling]
    @Offer XML
  , @History INT OUT
AS 
    BEGIN
    
        DECLARE @SellingId INT = @Offer.value('(/selling/@id)[1]', 'int')
	
        UPDATE  [Offers_Selling]
        SET     GameServerId = @Offer.value('(/selling/@gameServerId)[1]', 'int')
              , Price = @Offer.value('(/selling/@price)[1]', 'money')
              , Title = @Offer.value('(/selling/@title)[1]', 'nvarchar(250)')
              , [Description] = @Offer.value('(/selling/@description)[1]', 'nvarchar(4000)')
              , TransactionPhaseId = 1
              , UpdateDate = GETUTCDATE()
              , [DeliveryTime] = NULLIF(@Offer.value('(/selling/@deliveryTime)[1]', 'int'), 0)
              , ProductCategoryId = NULLIF(@Offer.value('(/selling/@productCategoryId)[1]', 'int'), 0)
              , ProductCategoryMisc = CASE WHEN NULLIF(@Offer.value('(/selling/@productCategoryId)[1]', 'int'), 0) = 4
                                              THEN NULLIF(@Offer.value('(/selling/@productCategoryMisc)[1]', 'nvarchar(100)'), '')
                                              ELSE NULL
                                         END
        WHERE   [SellingId] = @SellingId
                AND SellerId = @Offer.value('(/selling/@sellerId)[1]', 'uniqueidentifier')
                AND TransactionPhaseId = 1
	    
        EXEC @History = [p_Offers_AddSellingToHistory] @OfferId = @SellingId, @Note = 'Update'
	    
        DECLARE @Image VARBINARY(MAX) = @Offer.value('(/selling/image/@d)[1]', 'varbinary(max)')
        DECLARE @ImageName NVARCHAR(500) = @Offer.value('(/selling/image/@in)[1]', 'nvarchar(500)')
        
        IF @Image IS NOT NULL 
            BEGIN 
        		
                MERGE TOP ( 1 ) INTO [dbo].[Offers_SellingImages] AS t
                    USING 
                        ( SELECT    @SellingId AS SellingId
                                  , @ImageName AS ImageName
                                  , @Image AS [Image]
                        ) AS s
                    ON t.[SellingId] = s.SellingId
                    WHEN MATCHED 
                        THEN 
        			UPDATE
                         SET    t.ImageName = s.ImageName
                              , t.[Image] = s.[Image]
                    WHEN NOT MATCHED 
                        THEN 
					INSERT    (
                                          SellingId
                                        , ImageName
                                        , [Image]
                                        )
                         VALUES         ( s.SellingId
                                        , s.ImageName
                                        , s.[Image]
                                        ) ;
                
            END 
	    
        DECLARE @Offers udtt_Offers
	
        INSERT  INTO @Offers
                ( OfferId, RowNumber )
        VALUES  ( @SellingId, 1 )
    
        EXEC [p_Offers_GetSellingOffersInternal] @Offers = @Offers
    END


