ALTER TABLE [dbo].[UserRating_UnusedFeedbacks]
	ADD CONSTRAINT [FK_UserRating_UnapprovedFeedbacks_SellingOffersHistory] 
	FOREIGN KEY (SellingHistoryId)
	REFERENCES Offers_SellingHistory ([HistorySellingId])	

GO
ALTER TABLE [dbo].[UserRating_UnapprovedFeedback] CHECK CONSTRAINT [FK_UserRating_UnapprovedFeedbacks_SellingOffersHistory]
