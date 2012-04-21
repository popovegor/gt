/****** Object:  ForeignKey [FK_UserRating_Feedbacks_UserRating_Feedbacks]    Script Date: 12/07/2009 22:59:13 ******/
ALTER TABLE [dbo].[UserRating_Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_UserRating_Feedbacks_UserRating_Feedbacks] FOREIGN KEY([FeedbackTypeId])
REFERENCES [dbo].[Dictionaries_FeedbackTypes] ([FeedbackTypeId])


GO
ALTER TABLE [dbo].[UserRating_Feedbacks] CHECK CONSTRAINT [FK_UserRating_Feedbacks_UserRating_Feedbacks]

