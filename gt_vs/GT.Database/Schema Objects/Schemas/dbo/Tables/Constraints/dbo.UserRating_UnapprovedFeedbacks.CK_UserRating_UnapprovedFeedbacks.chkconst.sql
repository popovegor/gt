ALTER TABLE [dbo].[UserRating_UnusedFeedbacks]
	ADD CONSTRAINT [CK_UserRating_UnusedFeedbacks] 
	CHECK  (([FromUserId]<>[ToUserId]))

GO
ALTER TABLE [dbo].[UserRating_UnusedFeedbacks] CHECK CONSTRAINT [CK_UserRating_UnusedFeedbacks]
