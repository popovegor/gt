ALTER TABLE [dbo].[MessageSystem_Messages]
    ADD CONSTRAINT [DF_UserMessages_CreateDate] DEFAULT (GETUTCDATE()) FOR [CreateDate];

