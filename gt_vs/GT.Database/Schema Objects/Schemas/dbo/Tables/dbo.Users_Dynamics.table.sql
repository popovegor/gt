CREATE TABLE [dbo].[Users_Dynamics]
    (
      [DynamicsId] INT IDENTITY(1, 1)
                       NOT NULL
    , [UserId] UNIQUEIDENTIFIER NOT NULL
    , [MoneyAvailable] MONEY NOT NULL
    , [MoneyBlocked] MONEY NOT NULL
    , [MoneyTotal] AS ( [MoneyAvailable] + [MoneyBlocked] )
    , [DealsStarted] INT NOT NULL
    , [DealsSellerFinished] INT NOT NULL
    , [DealsSellerAccepted] INT NOT NULL
    , [DealsSellerSubmitted] INT NOT NULL
    , [DealsSellerConflicted] INT NOT NULL
    , [DealsSellerTotal] AS ( ( ( ( [DealsSellerSubmitted] + [DealsSellerConflicted] ) + [DealsSellerAccepted] ) + [DealsSellerFinished] ) + [DealsStarted] )
    , [DealsBuyerFinished] INT NOT NULL
    , [DealsBuyerAccepted] INT NOT NULL
    , [DealsBuyerSubmitted] INT NOT NULL
    , [DealsBuyerConflicted] INT NOT NULL
    , [DealsBuyerTotal] AS ( ( ( ( [DealsBuyerSubmitted] + [DealsBuyerConflicted] ) + [DealsBuyerAccepted] ) + [DealsBuyerFinished] ) )
    , [DealsTotal] AS ( ( ( ( ( [DealsSellerSubmitted] + [DealsSellerConflicted] ) + [DealsSellerAccepted] ) + [DealsSellerFinished] ) + [DealsStarted] )
                        + ( ( ( [DealsBuyerSubmitted] + [DealsBuyerConflicted] ) + [DealsBuyerAccepted] ) + [DealsBuyerFinished] ) )
    , [FeedbacksPositive] INT NOT NULL
    , [FeedbacksNegative] INT NOT NULL
    , [FeedbacksNeutral] INT NOT NULL
    , [FeedbacksTotal] AS ( [FeedbacksPositive] + [FeedbacksNegative] + [FeedbacksNeutral] )
    , [FeedbacksForOthers] INT NOT NULL
                               DEFAULT ( 0 )
    , [FeedbacksAsBuyer] INT NOT NULL
                             DEFAULT ( 0 )
    , [FeedbacksAsSeller] INT NOT NULL
                              DEFAULT ( 0 )
    , [MessagesIn] int NOT NULL DEFAULT(0)
    , [MessagesOut] int NOT NULL DEFAULT(0)
    , [MessagesTotal] AS ([MessagesIn] + [MessagesOut])
    , [MessagesUnread] INT NOT NULL DEFAULT(0)
    , [BuyingTotal] int NOT NULL DEFAULT(0)
    , [FeedbacksUnused] int NOT NULL DEFAULT(0)
    )

