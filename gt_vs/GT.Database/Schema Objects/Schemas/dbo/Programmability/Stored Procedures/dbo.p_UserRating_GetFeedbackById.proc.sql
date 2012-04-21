-- =============================================
-- Author:		E.Popov
-- Create date: 2009-12-16
-- Description:	gets a vote by the passed id
-- =============================================
CREATE PROCEDURE [dbo].[p_UserRating_GetFeedbackById] @FeedbackId INT
AS 
    BEGIN
        SET NOCOUNT ON ;
        
        DECLARE @Feedbacks udtt_Feedbacks
        
        INSERT  INTO @Feedbacks
                ( FeedbackId, RowNumber )
        VALUES  ( @FeedbackId, 1 )
        
        EXEC [p_UserRating_GetFeedbacksInternal] @Feedbacks = @Feedbacks
    
    END








