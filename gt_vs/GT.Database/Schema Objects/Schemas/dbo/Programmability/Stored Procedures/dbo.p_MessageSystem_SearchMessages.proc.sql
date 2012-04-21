-- =============================================
-- Author:		E.Popov
-- Create date: 2009-09-29
-- Description:	search messages for the specified user
-- =============================================
CREATE PROCEDURE [dbo].[p_MessageSystem_SearchMessages] @filter XML
AS 
    BEGIN

        DECLARE @SenderId UNIQUEIDENTIFIER = NULLIF(@filter.value('(/f/@sid)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())
          , @RecipientId UNIQUEIDENTIFIER  = NULLIF(@filter.value('(/f/@rid)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())
          , @FromDate DATE = @filter.value('(/f/@fd)[1]', 'date')
          , @ToDate DATE = @filter.value('(/f/@td)[1]', 'date')
          , @UnreadOnly BIT = @filter.value('(f/@uo)[1]', 'bit')
          , @Count INT = @filter.value('(f/@c)[1]', 'int')
	
	
        DECLARE @Messages udtt_Messages ;
        WITH    m AS ( SELECT   m.MessageId
                              , ROW_NUMBER() OVER ( ORDER BY [CreateDate] DESC ) AS RowNumber
                       FROM     [MessageSystem_Messages] AS m
                       WHERE    ( @SenderId IS NULL
                                  OR m.SenderId = @SenderId
                                )
                                AND ( @RecipientId IS NULL
                                      OR @RecipientId = RecipientId
                                    )
                                AND ( @FromDate IS NULL
                                      OR CAST([CreateDate] AS DATE) >= @FromDate
                                    )
                                AND ( @ToDate IS NULL
                                      OR CAST([CreateDate] AS DATE) <= @ToDate
                                    )
                                AND ( @UnreadOnly = 0
                                      OR m.Unread = 1
                                    )
                                AND ( Deleted = 0 )
                     )
            INSERT  INTO @Messages(MessageId, RowNumber)
                    SELECT  m.MessageId, m.RowNumber
                    FROM    m
                    WHERE   m.RowNumber <= @Count
    
        EXEC [p_MessageSystem_GetMessagesInternal] @Messages = @Messages
    END
