-- =============================================
-- Author:		E.Popov
-- Create date: 2009-08-28
-- Description:	Get all senders by the specified recipient
-- =============================================
CREATE PROCEDURE [dbo].[p_MessageSystem_GetMessageSenders]
    @RecipientId UNIQUEIDENTIFIER
AS 
    BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        SET NOCOUNT ON ;

        SELECT DISTINCT
                m.SenderId AS [SenderId]
              , u.UserName AS [SenderName]
        FROM    [MessageSystem_Messages] AS m
        INNER JOIN aspnet_Users AS u ON u.UserId = m.SenderId
        WHERE   m.RecipientId = @RecipientId
        ORDER BY u.UserName ASC
    END
