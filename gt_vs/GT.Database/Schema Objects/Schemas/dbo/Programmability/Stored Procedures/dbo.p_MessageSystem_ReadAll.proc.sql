CREATE PROCEDURE [dbo].[p_MessageSystem_ReadAll]
	@UserId uniqueidentifier
AS
	BEGIN 
	  UPDATE [dbo].[Users_Dynamics] SET [MessagesUnread] = 0
	  where UserId = @UserId
	  
	  --UPDATE mess
	END 