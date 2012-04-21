CREATE TABLE [dbo].[BillingSystem_Transfers]
    (
      [TransferId] [int] IDENTITY(1, 1)
                         NOT NULL
    , [Amount] [money] NOT NULL
    , [CreateDate] [datetime] NOT NULL
    , [FromTransferParticipantId] [int] NOT NULL
    , [ToTransferParticipantId] [int] NOT NULL
    , [Note] [nvarchar](500) NULL
    , [StatusId] [int] NOT NULL
    , [StatusModifyDate] [datetime] NULL
    , [Commission] [money] NOT NULL
                           DEFAULT ( 0 )
    , [OurCommission] [money] NOT NULL
                              DEFAULT ( 0 )
    , [OurCommissionRecieved] [bit] NOT NULL
                                    DEFAULT ( 0 )
     CONSTRAINT [PK_BillingSystem_Transfers] PRIMARY KEY CLUSTERED 
(
	[TransferId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




