ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [DF_Users_DynamicData_MoneyBlocked] DEFAULT ((0)) FOR [MoneyBlocked];

