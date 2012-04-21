ALTER TABLE [dbo].[MessageSystem_Messages]
    ADD CONSTRAINT [DF_Messages_Deleted] DEFAULT ((0)) FOR [Deleted];

