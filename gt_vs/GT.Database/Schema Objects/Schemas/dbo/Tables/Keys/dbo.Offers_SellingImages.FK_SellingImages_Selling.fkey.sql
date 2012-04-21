ALTER TABLE [dbo].[Offers_SellingImages]
ADD CONSTRAINT [FK_SellingImages_Selling] 
FOREIGN KEY (SellingId)
REFERENCES [dbo].Offers_Selling ([SellingId])	ON DELETE CASCADE


