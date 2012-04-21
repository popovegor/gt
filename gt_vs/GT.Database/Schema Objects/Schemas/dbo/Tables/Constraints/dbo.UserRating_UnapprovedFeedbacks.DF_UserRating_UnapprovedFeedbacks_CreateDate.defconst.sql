ALTER TABLE [dbo].[UserRating_UnusedFeedbacks] ADD  CONSTRAINT [DF_UserRating_UnusedFeedbacks_CreateDate]  DEFAULT (GETUTCDATE()) FOR [CreateDate]
