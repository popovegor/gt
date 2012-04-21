/****** Object:  ForeignKey [FK_UserRating_Feedbacks_Dictionaries_VoteTypes]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[UserRating_Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_UserRating_Feedbacks_Dictionaries_FeedbackTypes] FOREIGN KEY([FeedbackTypeId])
REFERENCES [dbo].[Dictionaries_FeedbackTypes] ([FeedbackTypeId])


GO
ALTER TABLE [dbo].[UserRating_Feedbacks] CHECK CONSTRAINT [FK_UserRating_Feedbacks_Dictionaries_FeedbackTypes]

