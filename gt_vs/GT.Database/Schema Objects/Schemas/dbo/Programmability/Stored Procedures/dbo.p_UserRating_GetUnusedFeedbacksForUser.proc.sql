CREATE PROCEDURE [dbo].[p_UserRating_GetUnusedFeedbacksForUser]
    @UserId UNIQUEIDENTIFIER
AS 
    BEGIN
    
        SELECT  UnusedFeedbackId
              , SellingHistoryId
              , FromUserId
              , ToUserId
              , tu.[UserName] AS [ToUserName]
              , uf.CreateDate
              , sh.Title AS SellingTitle
              , sh.TransactionPhaseId
        FROM    dbo.[UserRating_UnusedFeedbacks] AS uf
        INNER JOIN dbo.Offers_SellingHistory AS sh ON sh.[HistorySellingId] = uf.SellingHistoryId
        INNER JOIN dbo.[aspnet_Users] AS tu ON tu.[UserId] = uf.[ToUserId]
        WHERE   @UserId = uf.FromUserId
      
    END 