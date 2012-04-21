-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-16
-- Description:	Adds a vote
-- =============================================
CREATE PROCEDURE [dbo].[p_UserRating_AddFeedback] @Feedback AS XML
AS 
    BEGIN
        SET NOCOUNT ON ;

        DECLARE @FeedbackTypeId INT = @Feedback.value('(/f/@ftid)[1]', 'int')
        DECLARE @SellingHistoryId INT = NULLIF(@Feedback.value('(/f/@shid)[1]', 'int'), 0)
        DECLARE @FromUserId UNIQUEIDENTIFIER = NULLIF(@Feedback.value('(/f/@fuid)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())
        DECLARE @ToUserId UNIQUEIDENTIFIER = NULLIF(@Feedback.value('(/f/@tuid)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())


        BEGIN TRY
        
            BEGIN TRANSACTION
        
            INSERT  INTO dbo.UserRating_Feedbacks
                    ( FromUserId
                    , ToUserId
                    , FeedbackTypeId
                    , Comment
                    , SellingHistoryId
                    , CreateDate
                    )
            VALUES  ( @FromUserId
                    , -- FromUserId - uniqueidentifier
                      @ToUserId
                    , -- ToUserId - uniqueidentifier
                      @FeedbackTypeId
                    , -- FeedbackTypeId - int
                      @Feedback.value('(/f/@c)[1]', 'nvarchar(1000)')
                    , -- Note - nvarchar(1000)
                      @SellingHistoryId
                    , -- SellingHistoryId - int
                      GETUTCDATE()  -- CreateDate - datetime
                    )
        
            DECLARE @FeedbackId INT = SCOPE_IDENTITY()
            
            DECLARE @SellerId UNIQUEIDENTIFIER
              , @BuyerId UNIQUEIDENTIFIER
            
            SELECT TOP ( 1 )
                    @SellerId = [SellerId]
                  , @BuyerId = [BuyerId]
            FROM    [dbo].[Offers_SellingHistory]
            WHERE   [HistorySellingId] = @SellingHistoryId
        
            UPDATE TOP ( 1 )
                    dbo.Users_Dynamics
            SET     FeedbacksNegative 
                  += CASE WHEN @FeedbackTypeId = dbo.f_Dictionaries_GetFeedbackTypeIdByName('Negative') THEN 1
                          ELSE 0
                     END
                  , FeedbacksPositive 
                  += CASE WHEN @FeedbackTypeId = dbo.f_Dictionaries_GetFeedbackTypeIdByName('Positive') THEN 1
                          ELSE 0
                     END
                  , FeedbacksNeutral 
                  += CASE WHEN @FeedbackTypeId = dbo.f_Dictionaries_GetFeedbackTypeIdByName('Neutral') THEN 1
                          ELSE 0
                     END
                  , FeedbacksAsSeller += CASE WHEN @ToUserId = @SellerId THEN 1
                                              ELSE 0
                                         END
                  , FeedbacksAsBuyer += CASE WHEN @ToUserId = @BuyerId THEN 1
                                             ELSE 0
                                        END
            WHERE   [UserId] = @ToUserId
            
            UPDATE TOP ( 1 )
                    dbo.[Users_Dynamics]
            SET     [FeedbacksForOthers] += 1
                  , [FeedbacksUnused] -= CASE WHEN [FeedbacksUnused] > 0 THEN 1
                                              ELSE 0
                                         END
            WHERE   UserId = @FromUserId
         
        
            DECLARE @Feedbacks udtt_Feedbacks
        
            INSERT  INTO @Feedbacks
                    ( FeedbackId, RowNumber )
            VALUES  ( @FeedbackId, 1 )
            
            DELETE  FROM dbo.[UserRating_UnusedFeedbacks]
            WHERE   SellingHistoryId = @SellingHistoryId
                    AND FromUserId = @FromUserId
                    AND ToUserId = @ToUserId
        
            EXEC [p_UserRating_GetFeedbacksInternal] @Feedbacks = @Feedbacks
            
            IF @@TRANCOUNT > 0 
                BEGIN 
                    COMMIT TRANSACTION
                END 
            
        END TRY 
        BEGIN CATCH
            IF @@TRANCOUNT > 0 
                BEGIN 
                    ROLLBACK TRANSACTION
                END
        END CATCH 

    END








