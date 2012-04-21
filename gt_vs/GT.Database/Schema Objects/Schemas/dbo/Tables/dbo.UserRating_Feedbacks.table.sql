CREATE TABLE [dbo].[UserRating_Feedbacks](
	[FeedbackId] [int] IDENTITY(1,1) NOT NULL,
	[FromUserId] [uniqueidentifier] NOT NULL,
	[ToUserId] [uniqueidentifier] NOT NULL,
	[FeedbackTypeId] [int] NOT NULL,
	[Comment] [nvarchar](1000) NOT NULL,
	[SellingHistoryId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserRating_Feedbacks] PRIMARY KEY CLUSTERED 
(
	[FeedbackId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]





