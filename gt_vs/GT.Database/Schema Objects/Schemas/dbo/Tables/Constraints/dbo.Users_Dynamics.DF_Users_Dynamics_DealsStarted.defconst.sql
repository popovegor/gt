ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_Users_Dynamics_DealsStarted] DEFAULT ((0)) FOR [DealsStarted];

