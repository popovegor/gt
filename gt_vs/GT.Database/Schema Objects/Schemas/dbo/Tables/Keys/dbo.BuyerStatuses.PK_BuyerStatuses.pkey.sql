﻿ALTER TABLE [dbo].[Dictionaries_BuyerStatuses]
    ADD CONSTRAINT [PK_BuyerStatuses] PRIMARY KEY CLUSTERED ([BuyerStatusId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);
