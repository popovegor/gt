-- =============================================
-- Author:		E.Popov
-- Create date: 2009-11-25
-- Description:	returns dynamic data by ids
-- =============================================
CREATE PROCEDURE [dbo].[p_Users_GetDynamicsInternal]
    @Dynamics [dbo].[udtt_Dynamics] READONLY
AS 
    BEGIN
        SET NOCOUNT ON ;

        SELECT  d.[DynamicsId]
              , d.[UserId]
              , d.[MoneyAvailable]
              , d.[MoneyBlocked]
              , d.[MoneyTotal]
              , d.[DealsStarted]
              , d.[DealsSellerFinished]
              , d.[DealsSellerAccepted]
              , d.[DealsSellerSubmitted]
              , d.[DealsSellerConflicted]
              , d.[DealsSellerTotal]
              , d.[DealsBuyerFinished]
              , d.[DealsBuyerAccepted]
              , d.[DealsBuyerSubmitted]
              , d.[DealsBuyerConflicted]
              , d.[DealsBuyerTotal]
              , d.[DealsTotal]
              , d.[FeedbacksNegative]
              , d.[FeedbacksPositive]
              , d.[FeedbacksTotal]
              , d.[FeedbacksNeutral]
              , d.[FeedbacksForOthers]
              , d.[FeedbacksAsSeller]
              , d.[FeedbacksAsBuyer]
              , d.[MessagesIn]
              , d.[MessagesOut]
              , d.[MessagesTotal]
              , d.[MessagesUnread]
              , d.[BuyingTotal]
              , d.[FeedbacksUnused]
        FROM    @Dynamics AS ids
        INNER JOIN Users_Dynamics AS d ON d.DynamicsId = ids.DynamicsId
        ORDER BY ids.RowNumber ASC
	  
    END



