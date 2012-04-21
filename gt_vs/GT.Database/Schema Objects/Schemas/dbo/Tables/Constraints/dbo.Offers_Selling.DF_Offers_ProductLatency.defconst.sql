ALTER TABLE [dbo].[Offers_Selling]
ADD CONSTRAINT [DF_Offers_ProductLatency] 
DEFAULT 1
FOR [DeliveryTime]


