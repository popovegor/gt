ALTER TABLE [dbo].[UserRating_Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_UserRating_Feedbacks_aspnet_Users] FOREIGN KEY([FromUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])

GO
ALTER TABLE [dbo].[UserRating_Feedbacks] CHECK CONSTRAINT [FK_UserRating_Feedbacks_aspnet_Users]
