CREATE TABLE [dbo].[BillingSystem_WebMoney](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TransferId] [int] NOT NULL,
	[WmInvoiceId] [int] NOT NULL,
	[WmTransferId] [int] NOT NULL,
	[TargetPurse] [nvarchar](13) NOT NULL,
	[SourcePurse] [nvarchar](13) NULL,
	[PaymerNumber] [bigint] NULL,
	[CapitallerWmid] [decimal](12, 0) NULL,
	[EuronoteNumber] [decimal](21, 0) NULL,
	[PayerWmid] [nvarchar](20) NULL,
	[PaymerEmail] [nvarchar](100) NULL,
	[EuronoteEmail] [nvarchar](100) NULL,
	[TelepatPhone] [nvarchar](15) NULL,
	[TelepatOrderId] [int] NULL,
	[Description] [nvarchar](500) NULL,
	[ATMWmTransId] [int] NULL,
	[TransDate] [datetime] NULL,
	[RetCode] [int]  NOT NULL,
	[Commission] [money] NULL,
	[CreateDate] [datetime] NOT NULL
 CONSTRAINT [PK_BillingSystem_WebMoney] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]