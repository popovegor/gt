ALTER TABLE [dbo].[MessageSystem_Messages]
    ADD CONSTRAINT [DF_Messages_Unread] DEFAULT ((1)) FOR [Unread];

