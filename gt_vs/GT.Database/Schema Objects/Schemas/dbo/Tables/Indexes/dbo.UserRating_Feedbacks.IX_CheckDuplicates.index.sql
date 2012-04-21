/****** Object:  Index [IX_CheckDuplicates]    Script Date: 04/03/2010 15:45:04 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CheckDuplicates] ON [dbo].[UserRating_Feedbacks] 
(
	[FromUserId] ASC,
	[ToUserId] ASC,
	[SellingHistoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
