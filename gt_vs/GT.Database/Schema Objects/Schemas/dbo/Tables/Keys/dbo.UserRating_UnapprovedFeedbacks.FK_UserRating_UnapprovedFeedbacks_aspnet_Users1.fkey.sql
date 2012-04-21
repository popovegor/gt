ALTER TABLE [dbo].[UserRating_UnusedFeedbacks]  WITH CHECK ADD  CONSTRAINT [FK_UserRating_UnapprovedFeedbacks_aspnet_Users1] FOREIGN KEY([ToUserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])

GO
ALTER TABLE [dbo].[UserRating_UnusedFeedbacks] CHECK CONSTRAINT [FK_UserRating_UnapprovedFeedbacks_aspnet_Users1]
