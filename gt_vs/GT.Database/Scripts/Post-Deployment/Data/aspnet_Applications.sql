IF NOT EXISTS(SELECT TOP 1 1 FROM [dbo].[aspnet_Applications] AS a WHERE a.[ApplicationId] = $(ApplicationId))
BEGIN

/****** Object:  Table [dbo].[aspnet_Applications]    Script Date: 12/11/2009 20:51:57 ******/
INSERT [dbo].[aspnet_Applications] ([ApplicationName], [LoweredApplicationName], [ApplicationId], [Description]) VALUES (N'GT', N'gt', $(ApplicationId), NULL)

END 


--DELETE [dbo].[aspnet_Applications] WHERE [ApplicationId] = @ApplicationId