-- =============================================
-- Author:		E.Popov
-- Create date: 2009-08-11
-- Description:	Add an offer
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_AddSelling]
    @Offer XML
  , @History INT OUTPUT
AS 
    BEGIN
	
        SET NOCOUNT ON ;

        DECLARE @id INT

        INSERT  INTO [Offers_Selling]
                ( SellerId
                , GameServerId
                , Price
                , Title
                , [Description]
                , TransactionPhaseId
                , CreateDate
                , [DeliveryTime]
                , ProductCategoryId
                , ProductCategoryMisc
                )
        VALUES  ( @Offer.value('(/selling/@sellerId)[1]', 'uniqueidentifier')
                , @Offer.value('(/selling/@gameServerId)[1]', 'int')
                , @Offer.value('(/selling/@price)[1]', 'money')
                , @Offer.value('(/selling/@title)[1]', 'nvarchar(250)')
                , @Offer.value('(/selling/@description)[1]', 'nvarchar(4000)')
                , 1
                , GETUTCDATE()
                , ISNULL(@Offer.value('(/selling/@deliveryTime)[1]', 'int'), 1)
                , NULLIF(@Offer.value('(/selling/@productCategoryId)[1]', 'int'), 0)
                , CASE WHEN NULLIF(@Offer.value('(/selling/@productCategoryId)[1]', 'int'), 0) = 4
                       THEN NULLIF(@Offer.value('(/selling/@productCategoryMisc)[1]', 'nvarchar(100)'), '')
                       ELSE NULL
                  END
                )
    
        SET @Id = SCOPE_IDENTITY()
    
        EXEC @History = [p_Offers_AddSellingToHistory] @OfferId = @Id, @Note = 'Start' 
        
        DECLARE @Image VARBINARY(MAX) = @Offer.value('(/selling/image/@d)[1]', 'varbinary(max)')
        
        IF @Image IS NOT NULL 
            BEGIN 
        
                INSERT  INTO [dbo].[Offers_SellingImages]
                        ( [SellingId]
                        , [ImageName]
                        , [Image] 
                        )
                VALUES  ( @Id
                        , @Offer.value('(/selling/image/@in)[1]', 'nvarchar(500)')
                        , @Image
                        )
            END 
        
        DECLARE @Offers udtt_Offers
        INSERT  INTO @Offers
                ( OfferId, RowNumber )
        VALUES  ( @Id, 1 )
    
    
        EXEC [p_Offers_GetSellingOffersInternal] @Offers = @Offers
    
    END



