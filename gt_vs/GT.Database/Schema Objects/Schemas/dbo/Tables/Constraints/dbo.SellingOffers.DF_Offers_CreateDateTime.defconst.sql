/****** Object:  Default [DF_Offers_CreateDateTime]    Script Date: 12/15/2009 01:58:18 ******/
/****** Object:  Default [DF_Offers_CreateDateTime]    Script Date: 01/15/2010 17:42:54 ******/
ALTER TABLE [dbo].[Offers_Selling] ADD  CONSTRAINT [DF_Offers_CreateDateTime]  DEFAULT (GETUTCDATE()) FOR [CreateDate]








