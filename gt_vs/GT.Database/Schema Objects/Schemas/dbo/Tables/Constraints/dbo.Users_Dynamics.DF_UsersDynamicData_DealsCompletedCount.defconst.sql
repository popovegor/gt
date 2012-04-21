ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_UsersDynamicData_DealsSellerCompletedCount] DEFAULT ((0)) FOR [DealsSellerFinished];

GO

ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_UsersDynamicData_DealsBuyerCompletedCount] DEFAULT ((0)) FOR [DealsBuyerFinished];