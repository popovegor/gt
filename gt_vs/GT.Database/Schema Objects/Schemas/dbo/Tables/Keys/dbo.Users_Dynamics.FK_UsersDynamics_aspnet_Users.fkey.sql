ALTER TABLE [dbo].[Users_Dynamics]
    ADD CONSTRAINT [FK_UsersDynamics_aspnet_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

