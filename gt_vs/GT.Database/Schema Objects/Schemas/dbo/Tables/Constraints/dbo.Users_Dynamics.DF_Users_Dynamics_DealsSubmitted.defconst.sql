ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_Users_Dynamics_DealsSellerSubmitted] DEFAULT ((0)) FOR [DealsSellerSubmitted];

GO

ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_Users_Dynamics_DealsBuyerSubmitted] DEFAULT ((0)) FOR [DealsBuyerSubmitted];

