-- =============================================
-- Author:		E.Popov
-- Create date: 2009-09-29
-- Description:	Get messages by id
-- =============================================
CREATE PROCEDURE [dbo].[p_MessageSystem_GetMessagesInternal]
    @Messages udtt_Messages READONLY
AS 
    BEGIN
	
        SELECT  
                m.Body
              , m.SenderId
              , m.RecipientId
              , m.MessageId
              , m.CreateDate
              , m.[BodyRu]
              , r.UserName AS RecipientName
              , s.UserName AS SenderName
              , m.Unread AS Unread
              , m.Deleted AS Deleted
              , msgs.ConversationId AS ConversationId
        FROM    @Messages AS msgs
        INNER JOIN [MessageSystem_Messages] AS m ON msgs.MessageId = m.MessageId
        INNER JOIN aspnet_Users AS r ON r.UserId = m.RecipientId
        INNER JOIN aspnet_Users AS s ON s.UserId = m.SenderId
        ORDER BY msgs.RowNumber ASC
    END
