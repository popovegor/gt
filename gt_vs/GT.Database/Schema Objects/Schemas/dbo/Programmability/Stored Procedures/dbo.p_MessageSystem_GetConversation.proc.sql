-- =============================================
-- Author:		E.Popov
-- Create date: 2009-09-08
-- Description:	gets correspondence between two users
-- =============================================
CREATE PROCEDURE [dbo].[p_MessageSystem_GetConversation]
	-- Add the parameters for the stored procedure here
    @UserX UNIQUEIDENTIFIER
  , @UserY UNIQUEIDENTIFIER
AS 
    BEGIN
        SET NOCOUNT ON

        DECLARE @Messages udtt_Messages

        INSERT  INTO @Messages
                ( [MessageId]
                , RowNumber
                )
                SELECT  m.MessageId
                      , ROW_NUMBER() OVER ( ORDER BY [CreateDate] DESC ) AS RowNumber
                FROM    [MessageSystem_Messages] AS m
                WHERE   ( m.SenderId = @UserX
                          AND m.RecipientId = @UserY
                        )
                        OR ( m.SenderId = @UserY
                             AND m.RecipientId = @UserX
                           )
        
        EXEC [dbo].[p_MessageSystem_GetMessagesInternal] @Messages = @Messages
        
    
    END
