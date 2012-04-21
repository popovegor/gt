CREATE TABLE [dbo].[SiteMapNodeRemapping] (
    [NodeID]          INT          NOT NULL,
    [ThemeName]       VARCHAR (50) NOT NULL,
    [Display]         BIT          NOT NULL,
    [ChildNodesIndex] SMALLINT     NULL
);

