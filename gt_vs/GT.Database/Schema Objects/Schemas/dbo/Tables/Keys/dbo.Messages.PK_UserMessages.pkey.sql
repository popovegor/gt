﻿ALTER TABLE [dbo].[MessageSystem_Messages]
    ADD CONSTRAINT [PK_UserMessages] PRIMARY KEY CLUSTERED ([MessageId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

