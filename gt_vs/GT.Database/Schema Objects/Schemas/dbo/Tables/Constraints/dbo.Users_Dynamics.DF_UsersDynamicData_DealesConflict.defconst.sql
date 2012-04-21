ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_UsersDynamicData_DealesSellerConflict] DEFAULT ((0)) FOR [DealsSellerConflicted];

GO

ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_UsersDynamicData_DealesBuyerConflict] DEFAULT ((0)) FOR [DealsBuyerConflicted];