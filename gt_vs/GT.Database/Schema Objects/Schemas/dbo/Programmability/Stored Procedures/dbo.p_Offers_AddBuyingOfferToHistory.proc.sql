-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-09
-- Description:	Creates a history entry by the passed buying offer id
-- =============================================
CREATE PROCEDURE [dbo].[p_Offers_AddBuyingOfferToHistory]
@BuyingOfferId INT
AS
BEGIN
        SET NOCOUNT ON ;

        INSERT  INTO dbo.Offers_BuyingHistory
                ( HistoryOfferCreateDate
                , BuyingOfferId
                , BuyerId
                , GameServerId
                , Title
                , [Description]
                , Price
                , CreateDate
                , UpdateDate
                , ModifyDate
                , ProductCategoryId
                , ProductCategoryMisc
                )
                SELECT  GETUTCDATE() 
                      , bo.BuyingOfferId
                      , bo.BuyerId
                      , bo.GameServerId
                      , bo.Title
                      , bo.[Description]
                      , bo.Price
                      , bo.CreateDate
                      , bo.UpdateDate
                      , ModifyDate
                      , ProductCategoryId
                      , ProductCategoryMisc
                FROM    dbo.Offers_Buying AS bo
                WHERE   bo.BuyingOfferId = @BuyingOfferId
        
        RETURN SCOPE_IDENTITY()
    END








