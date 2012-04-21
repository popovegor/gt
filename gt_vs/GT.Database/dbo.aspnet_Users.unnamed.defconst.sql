/****** Object:  Default [DF__aspnet_Us__UserI__5EBF139D]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT (newid()) FOR [UserId]
GO
/****** Object:  Default [DF__aspnet_Us__Mobil__5FB337D6]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT (NULL) FOR [MobileAlias]
GO
/****** Object:  Default [DF__aspnet_Us__IsAno__60A75C0F]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[aspnet_Users] ADD  DEFAULT ((0)) FOR [IsAnonymous]


