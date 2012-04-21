/****** Object:  Default [DF_UserRating_Feedbacks_CreateDate]    Script Date: 12/07/2009 22:59:13 ******/
/****** Object:  Default [DF_UserRating_Feedbacks_CreateDate]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[UserRating_Feedbacks] ADD  CONSTRAINT [DF_UserRating_Feedbacks_CreateDate]  DEFAULT (GETUTCDATE()) FOR [CreateDate]





