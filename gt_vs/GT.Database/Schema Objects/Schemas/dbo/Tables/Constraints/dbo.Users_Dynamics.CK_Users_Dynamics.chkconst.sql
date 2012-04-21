ALTER TABLE [dbo].[Users_Dynamics]
ADD CONSTRAINT [CK_Users_Dynamics] CHECK ([MoneyAvailable]>=(0) AND [MoneyBlocked]>=(0) AND [DealsSellerFinished]>=(0) AND [DealsBuyerFinished]>=(0) AND [DealsSellerAccepted]>=(0) AND [DealsBuyerAccepted]>=(0) AND [DealsSellerSubmitted]>=(0) AND [DealsBuyerSubmitted]>=(0) AND [DealsSellerConflicted]>=(0) AND [DealsBuyerConflicted]>=(0) AND [DealsStarted]>=(0)) ;

