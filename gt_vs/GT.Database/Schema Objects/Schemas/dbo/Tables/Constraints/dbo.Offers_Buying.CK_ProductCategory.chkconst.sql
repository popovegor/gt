ALTER TABLE [dbo].[Offers_Buying]
ADD CONSTRAINT [CK_Offers_Buying_ProductCategory] 
CHECK  ((ISNULL([ProductCategoryId],0) != 4) OR ([ProductCategoryId] = 4 AND ISNULL(ProductCategoryMisc, '') != ''))
