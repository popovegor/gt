﻿ALTER TABLE [dbo].[Dictionaries_Games]
    ADD CONSTRAINT [PK_Games] PRIMARY KEY CLUSTERED ([GameId] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

