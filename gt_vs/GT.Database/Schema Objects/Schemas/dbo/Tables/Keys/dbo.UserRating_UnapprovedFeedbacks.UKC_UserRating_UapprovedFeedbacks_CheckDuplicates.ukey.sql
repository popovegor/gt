ALTER TABLE [dbo].[UserRating_UnusedFeedbacks]
ADD CONSTRAINT [UKC_UserRating_UapprovedFeedbacks_CheckDuplicates]
UNIQUE (FromUserId, ToUserId, SellingHistoryId)
    

GO 

ALTER TABLE [dbo].[UserRating_UnusedFeedbacks] CHECK CONSTRAINT [UKC_UserRating_UapprovedFeedbacks_CheckDuplicates]