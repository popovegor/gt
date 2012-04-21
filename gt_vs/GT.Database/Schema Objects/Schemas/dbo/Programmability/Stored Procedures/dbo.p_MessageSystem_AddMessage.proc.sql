CREATE PROCEDURE [dbo].[p_MessageSystem_AddMessage] @Message XML
AS 
    BEGIN

        SET XACT_ABORT ON
        
        DECLARE @RecipientId UNIQUEIDENTIFIER = @Message.value('(/m/@rid)[1]', 'uniqueidentifier')
        declare @SenderId UNIQUEIDENTIFIER = @Message.value('(/m/@sid)[1]', 'uniqueidentifier')
        
        BEGIN TRY
        
            BEGIN TRANSACTION

            INSERT  INTO [MessageSystem_Messages]
                    ( SenderId
                    , RecipientId
                    , Body
                    , CreateDate
                    , [BodyRu]
                    )
            VALUES  ( @SenderId
                    , @RecipientId
                    , @Message.value('(/m/@b)[1]', 'nvarchar(max)')
                    , GETUTCDATE()
                    , @Message.value('(/m/@bru)[1]', 'nvarchar(max)')
                    ) ;
	
            DECLARE @Messages udtt_Messages
	
            INSERT  INTO @Messages
                    ( MessageId, RowNumber )
            VALUES  ( SCOPE_IDENTITY(), 1 )
	
            UPDATE TOP (1) [dbo].[Users_Dynamics] SET MessagesIn += 1, MessagesUnread += 1
            WHERE [dbo].[Users_Dynamics].[UserId] = @RecipientId
            
            UPDATE TOP (1) [dbo].[Users_Dynamics] SET MessagesOut += 1
            WHERE [dbo].[Users_Dynamics].[UserId] = @SenderId
	
            EXEC [p_MessageSystem_GetMessagesInternal] @Messages = @Messages
        
            IF @@TRANCOUNT > 0 
                BEGIN 
                    COMMIT TRANSACTION
                END 
        
        END TRY 
        BEGIN CATCH
            IF @@TRANCOUNT > 0 
                BEGIN 
                    ROLLBACK TRANSACTION
                END
        END CATCH 
	
    END
