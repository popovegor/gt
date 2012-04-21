-- =============================================
-- Author:		E.Popov
-- Create date: 2009-11-25
-- Description:	returns user's dynamic data
-- =============================================
CREATE PROCEDURE [dbo].[p_Users_GetDynamicsForUser]
    @UserId UNIQUEIDENTIFIER
AS 
    BEGIN
	
        SET NOCOUNT ON ;

        DECLARE @Dynamics udtt_Dynamics

        INSERT  INTO @Dynamics
                ( DynamicsId
                , RowNumber
                )
                SELECT  [DynamicsId]
                      , 1
                FROM    [Users_Dynamics] AS d
                WHERE   d.UserId = @UserId
	
        EXEC [p_Users_GetDynamicsInternal] @Dynamics = @Dynamics

    END



