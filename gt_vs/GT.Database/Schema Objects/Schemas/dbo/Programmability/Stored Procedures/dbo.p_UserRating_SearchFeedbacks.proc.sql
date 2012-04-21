-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-16
-- Description:	Searches feedbacks by the passed filter
-- =============================================
CREATE PROCEDURE [dbo].[p_UserRating_SearchFeedbacks] @Filter XML
AS 
    BEGIN
        SET NOCOUNT ON ;
        
        DECLARE @Feedbacks udtt_Feedbacks
        
        DECLARE @FromUserId UNIQUEIDENTIFIER 
			= NULLIF(@Filter.value('(/vsf/@fuid)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())
          , @ToUserId UNIQUEIDENTIFIER
			= NULLIF(@Filter.value('(/vsf/@tuid)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())
          , @ToSellerId UNIQUEIDENTIFIER
			= NULLIF(@Filter.value('(/vsf/@tsid)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())
          , @ToBuyerId UNIQUEIDENTIFIER
			= NULLIF(@Filter.value('(/vsf/@tbid)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())
          , @Count INT = @Filter.value('(/vsf/@c)[1]', 'int')
			
			
        
			
        DECLARE @FeedbackTypes TABLE ( FeedbackTypeId INT )
        DECLARE @ApplyFeedbackTypeFilter BIT = 0
		
        INSERT  INTO @FeedbackTypes
                ( FeedbackTypeId
                )
                SELECT  t.value('.', 'int')
                FROM    @filter.nodes('/vsf/ftc/ftid') AS T ( t )
        
        IF @@RowCount > 0 
            BEGIN
                SET @ApplyFeedbackTypeFilter = 1
            END ;
            WITH    f AS ( SELECT   v.FeedbackId
                                  , ROW_NUMBER() OVER ( ORDER BY v.CreateDate DESC ) AS RowNumber
                           FROM     dbo.UserRating_Feedbacks AS v
                           INNER JOIN dbo.Offers_SellingHistory AS sh ON sh.[HistorySellingId] = v.SellingHistoryId
                           WHERE    ( @FromUserId IS NULL
                                      OR v.FromUserId = @FromUserId
                                    )
                                    AND ( @ToUserId IS NULL
                                          OR v.ToUserId = @ToUserId
                                        )
                                    AND ( @ToBuyerId IS NULL
                                          OR sh.BuyerId = @ToBuyerId AND v.[ToUserId] = @ToBuyerId
                                        )
                                    AND ( @ToSellerId IS NULL
                                          OR sh.SellerId = @ToSellerId AND v.[ToUserId] = @ToSellerId
                                        )
                                    AND ( @ApplyFeedbackTypeFilter = 0
                                          OR v.FeedbackTypeId IN ( SELECT   vt.FeedbackTypeId
                                                                   FROM     @FeedbackTypes AS vt )
                                        )
                         )
            INSERT  INTO @Feedbacks
                    ( FeedbackId
                    , RowNumber 
                    )
                    SELECT  f.FeedbackId
                          , f.RowNumber
                    FROM    f
                    WHERE   f.RowNumber <= @Count
                
        
        EXEC dbo.p_UserRating_GetFeedbacksInternal @Feedbacks = @Feedbacks
    
    END








