CREATE TABLE [dbo].[BillingSystem_TransferParticipants](
	[TransferParticipantId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[SellingHistoryId] [int] NULL,
	[RealMoneySourceId] [int] NULL,
 CONSTRAINT [PK_Cashflow_Participants] PRIMARY KEY CLUSTERED 
(
	[TransferParticipantId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]








