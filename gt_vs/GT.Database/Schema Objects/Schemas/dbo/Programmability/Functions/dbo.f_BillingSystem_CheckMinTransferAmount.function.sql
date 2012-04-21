CREATE FUNCTION [dbo].[f_BillingSystem_CheckMinTransferAmount] ( @TransferId INT )
RETURNS BIT
AS 
    BEGIN
        DECLARE @Success BIT = 1
	
        DECLARE @MoneySourceId INT
        DECLARE @transferAmount MONEY
	      
	    --minimum amount of any transfer in payment system must be above or equa an identified value in the realsourcemoney table for the specified payment system
        IF EXISTS ( SELECT TOP 1
                            1
                    FROM    [dbo].[BillingSystem_Transfers] AS t
                    WHERE   t.[Amount] - t.[OurCommission] - t.[Commission] <= 0 ) 
            BEGIN 
                SET @Success = 0
			
            END 

        RETURN @Success


    END