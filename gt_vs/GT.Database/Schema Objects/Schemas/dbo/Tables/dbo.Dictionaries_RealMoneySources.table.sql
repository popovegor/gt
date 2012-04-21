CREATE TABLE [dbo].[Dictionaries_RealMoneySources]
    (
      [RealMoneySourceId] INT NOT NULL
    , [Name] NVARCHAR(100) NOT NULL
    , [Description] NVARCHAR(500) NULL
    , [Commission] DECIMAL(8, 6) NOT NULL
                                DEFAULT ( 0 )
    , [OurCommission] DECIMAL(8, 6) NOT NULL
                                   DEFAULT ( 0 )
    , [MinTransferAmount] money NOT NULL DEFAULT (0)
    ) ;
