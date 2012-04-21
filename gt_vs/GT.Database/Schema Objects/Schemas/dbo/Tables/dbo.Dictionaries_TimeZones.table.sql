CREATE TABLE [dbo].[Dictionaries_TimeZones]
    (
      [TimeZoneId] [int] NOT NULL
    , [DotNetTimeZoneId] [nvarchar](400) NOT NULL
    , [Name] [nvarchar](400) NOT NULL
    , [NameRu] [nvarchar](400) NOT NULL
    , [Offset] [nvarchar](50) NOT NULL
    , CONSTRAINT [PK_TimeZones] PRIMARY KEY CLUSTERED ( [TimeZoneId] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY]