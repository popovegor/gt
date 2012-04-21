ALTER TABLE [dbo].[Offers_SellingHistory]
	ADD CONSTRAINT [FK_SellingHistory_ProductTypes] 
	FOREIGN KEY (ProductCategoryId)
	REFERENCES [dbo].[Dictionaries_ProductCategories] ([ProductCategoryId])	


