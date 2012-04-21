/****** Object:  ForeignKey [FK_UserRating_Feedbacks_aspnet_Users1]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[UserRating_Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_UserRating_Feedbacks_aspnet_Users1] FOREIGN KEY([ToUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])


GO
ALTER TABLE [dbo].[UserRating_Feedbacks] CHECK CONSTRAINT [FK_UserRating_Feedbacks_aspnet_Users1]
