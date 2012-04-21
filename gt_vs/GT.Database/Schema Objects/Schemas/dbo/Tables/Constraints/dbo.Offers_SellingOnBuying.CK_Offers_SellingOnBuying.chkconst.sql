/****** Object:  Check [CK_Offers_SellingOnBuying]    Script Date: 12/10/2009 00:21:06 ******/
ALTER TABLE [dbo].[Offers_SuggestedSelling]  WITH CHECK ADD  CONSTRAINT [CK_Offers_SellingOnBuying] CHECK  (([dbo].[f_Offers_CheckTransactionPhaseOnSuggestSellingOffer]([SellingId])=(1)))


GO
ALTER TABLE [dbo].[Offers_SuggestedSelling] CHECK CONSTRAINT [CK_Offers_SellingOnBuying]

