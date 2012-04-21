ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_UsersDynamicData_DealsSellerAccepted] DEFAULT ((0)) FOR [DealsSellerAccepted];

GO

ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_UsersDynamicData_DealsBuyerAccepted] DEFAULT ((0)) FOR [DealsBuyerAccepted];
