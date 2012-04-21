CREATE TABLE [dbo].[Dictionaries_TransferStatuses]
    (
      [TransferStatusId] INT NOT NULL
    , [Name] NVARCHAR(100) NOT NULL
    , [NameRu] NVARCHAR(100) NOT NULL
    , [Description] NVARCHAR(1000) NULL
    , [DescriptionRu] NVARCHAR(1000) NULL
    , CONSTRAINT PK_Dictionaries_TransferStatusId PRIMARY KEY CLUSTERED ( TransferStatusId ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
