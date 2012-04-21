ALTER TABLE [dbo].[SiteMapNodeRemapping]
    ADD CONSTRAINT [FK_SiteMapNodeRemapping_SiteMap] FOREIGN KEY ([NodeID]) REFERENCES [dbo].[SiteMap] ([ID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

