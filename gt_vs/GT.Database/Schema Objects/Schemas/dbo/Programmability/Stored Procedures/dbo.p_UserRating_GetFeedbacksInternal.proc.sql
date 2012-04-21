-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-16
-- Description:	Gets votes by ids
-- =============================================
CREATE PROCEDURE [dbo].[p_UserRating_GetFeedbacksInternal]
    @Feedbacks udtt_Feedbacks READONLY
AS 
    BEGIN
        SET NOCOUNT ON ;

        SELECT  v.FeedbackId
              , v.FeedbackTypeId
              , v.ToUserId
              , tu.[UserName] AS ToUserName
              , v.Comment
              , v.SellingHistoryId
              , sh.[Title] AS SellingTitle
              , v.FromUserId
              , fu.[UserName] AS FromUserName
              , v.CreateDate
        FROM    @Feedbacks AS ids
        INNER JOIN dbo.UserRating_Feedbacks AS v ON v.FeedbackId = ids.FeedbackId
        INNER JOIN dbo.[Offers_SellingHistory] AS sh ON sh.[HistorySellingId] = v.[SellingHistoryId]
        INNER JOIN dbo.[aspnet_Users] AS fu ON fu.[UserId] = v.[FromUserId]
        INNER JOIN dbo.[aspnet_Users] AS tu ON tu.[UserId] = v.[ToUserId]
        ORDER BY ids.RowNumber ASC 
	
    END