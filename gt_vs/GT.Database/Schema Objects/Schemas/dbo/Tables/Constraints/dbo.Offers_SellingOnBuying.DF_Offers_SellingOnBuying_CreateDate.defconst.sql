/****** Object:  Default [DF_Offers_SellingOnBuying_CreateDate]    Script Date: 12/09/2009 00:17:56 ******/
/****** Object:  Default [DF_Offers_SellingOnBuying_CreateDate]    Script Date: 12/10/2009 00:21:06 ******/
ALTER TABLE [dbo].[Offers_SuggestedSelling] ADD  CONSTRAINT [DF_Offers_SellingOnBuying_CreateDate]  DEFAULT (GETUTCDATE()) FOR [CreateDate]





