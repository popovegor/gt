/****** Object:  Default [DF_Offers_BuyingHistory_BuyingHistoryCreateDate]    Script Date: 12/09/2009 00:57:10 ******/
/****** Object:  Default [DF_Offers_BuyingHistory_BuyingHistoryCreateDate]    Script Date: 12/10/2009 00:21:06 ******/
ALTER TABLE [dbo].[Offers_BuyingHistory] ADD  CONSTRAINT [DF_Offers_BuyingHistory_BuyingHistoryCreateDate]  DEFAULT (GETUTCDATE()) FOR [HistoryOfferCreateDate]





