/****** Object:  ForeignKey [FK__aspnet_Us__Appli__05D8E0BE]    Script Date: 01/18/2010 19:03:36 ******/
ALTER TABLE [dbo].[aspnet_Users]  WITH CHECK ADD FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])


