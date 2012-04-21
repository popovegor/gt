CREATE PROCEDURE [dbo].[p_Support_AddFeedback] @Feedback XML
AS 
    BEGIN
        DECLARE @UserName NVARCHAR(200) = NULLIF(@Feedback.value('(/feedback/@userName)[1]', 'nvarchar(200)'), '')
          , @UserEmail NVARCHAR(200) = NULLIF(@Feedback.value('(/feedback/@userEmail)[1]', 'nvarchar(200)'), '')
          , @Message NVARCHAR(MAX) = NULLIF(@Feedback.value('(/feedback/@message)[1]', 'nvarchar(2000)'), '')
       
        INSERT  INTO dbo.Support_Feedbacks
                ( UserName, UserEmail, Message )
        VALUES  ( @UserName, @UserEmail, @Message )
        
        DECLARE @Id INT = SCOPE_IDENTITY()
		
        EXEC dbo.p_Support_GetFeedbackById @FeedbackId = @Id
		    
        RETURN @id
		
    END