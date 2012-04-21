CREATE TABLE [dbo].[UserRating_UnusedFeedbacks]
    (
      [UnusedFeedbackId] [int] IDENTITY(1, 1)
                                   NOT NULL
    , [SellingHistoryId] [int] NOT NULL
    , [FromUserId] [uniqueidentifier] NOT NULL
    , [ToUserId] [uniqueidentifier] NOT NULL
    , [CreateDate] [datetime]
        NOT NULL
        CONSTRAINT [PK_UserRating_UnapprovedFeedbacks]
        PRIMARY KEY CLUSTERED ( [UnusedFeedbackId] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY]
