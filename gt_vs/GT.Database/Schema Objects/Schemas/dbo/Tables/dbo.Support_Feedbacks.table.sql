CREATE TABLE [dbo].[Support_Feedbacks]
    (
      FeedbackId INT PRIMARY KEY
                     IDENTITY(1, 1)
    , UserName NVARCHAR(200) NULL
    , UserEmail NVARCHAR(200) NOT NULL
    , Message NVARCHAR(MAX) NOT NULL
    , CreateDate DATETIME NOT NULL
                          DEFAULT ( GETUTCDATE() )
    )
