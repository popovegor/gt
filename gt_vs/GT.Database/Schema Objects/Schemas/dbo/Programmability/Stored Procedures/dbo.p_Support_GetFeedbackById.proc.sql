CREATE PROCEDURE [dbo].[p_Support_GetFeedbackById]
	@FeedbackId int
AS
  BEGIN
    SELECT TOP 1 * FROM dbo.Support_Feedbacks AS f
    WHERE f.FeedbackId = @FeedbackId	
  END
	
