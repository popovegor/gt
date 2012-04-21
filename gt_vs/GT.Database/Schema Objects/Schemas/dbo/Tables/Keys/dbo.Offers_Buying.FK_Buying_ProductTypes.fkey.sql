ALTER TABLE [dbo].[Offers_Buying]
	ADD CONSTRAINT [FK_Buying_ProductTypes] 
	FOREIGN KEY (ProductCategoryId)
	REFERENCES [dbo].[Dictionaries_ProductCategories] ([ProductCategoryId])	



