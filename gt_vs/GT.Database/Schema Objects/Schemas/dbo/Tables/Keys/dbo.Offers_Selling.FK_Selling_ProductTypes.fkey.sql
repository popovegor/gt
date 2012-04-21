ALTER TABLE [dbo].[Offers_Selling]
	ADD CONSTRAINT [FK_Selling_ProductTypes] 
	FOREIGN KEY (ProductCategoryId)
	REFERENCES [dbo].[Dictionaries_ProductCategories] ([ProductCategoryId])	

