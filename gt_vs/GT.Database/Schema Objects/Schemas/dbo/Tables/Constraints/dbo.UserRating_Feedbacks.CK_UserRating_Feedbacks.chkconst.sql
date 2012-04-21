ALTER TABLE [dbo].[UserRating_Feedbacks]  WITH CHECK ADD  CONSTRAINT [CK_UserRating_Feedbacks] CHECK  (([FromUserId]<>[ToUserId]))


GO
ALTER TABLE [dbo].[UserRating_Feedbacks] CHECK CONSTRAINT [CK_UserRating_Feedbacks]
