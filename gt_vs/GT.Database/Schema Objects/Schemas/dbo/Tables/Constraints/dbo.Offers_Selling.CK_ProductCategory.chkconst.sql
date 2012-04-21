ALTER TABLE [dbo].[Offers_Selling]
ADD CONSTRAINT [CK_Offers_Selling_ProductCategory] 
CHECK  ((ISNULL([ProductCategoryId],0) != 4) OR ([ProductCategoryId] = 4 AND ISNULL(ProductCategoryMisc, '') != ''))
