ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_Users_DynamicData_MoneyAvailable] DEFAULT ((0)) FOR [MoneyAvailable];

