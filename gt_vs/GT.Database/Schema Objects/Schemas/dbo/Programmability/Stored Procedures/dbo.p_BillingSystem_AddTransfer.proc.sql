-- =============================================
-- Author:		E.Popov
-- Create date: 2009-11-25
-- Description:	adds transfer
-- -1 : ошибка при добавлении передающего участника перевода
-- -3 : ошибка при добавлении принимающего участника перевода
-- -4 : ошибка при добавлении перевода
-- -5 : ошибка при начислении денег пользователю
-- -6 : ошибка при блокировании денег пользователя
-- -7 : ошибка при разблокировании денег пользователя
-- -2 : ошибка при списании денег пользователя
-- =============================================

CREATE PROCEDURE [dbo].[p_BillingSystem_AddTransfer]
    @Transfer XML
  , @ResultCode INT OUTPUT
AS 
    BEGIN
        SET NOCOUNT ON ;

        DECLARE @Now DATETIME = GETUTCDATE()
        DECLARE @TranCount INT = @@TRANCOUNT
        
        PRINT @TranCount
        
        IF @TranCount <= 0 
            BEGIN TRAN
        ELSE 
            SAVE TRAN [transfer]
            
	
		/*insert from participant*/
        BEGIN TRY
		
            INSERT  INTO [BillingSystem_TransferParticipants]
                    ( UserId
                    , [SellingHistoryId]
                    , RealMoneySourceId
                    )
            VALUES  ( NULLIF(@Transfer.value('(/t/ftp/@uid)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())
                    , dbo.f_Offers_GetHistoryIdBySellingOfferId(NULLIF(@Transfer.value('(/t/ftp/@soid)[1]', 'int'), 0))
                    , NULLIF(@Transfer.value('(/t/ftp/@rmsid)[1]', 'int'), 0)
                    )
			
            DECLARE @fpId INT = SCOPE_IDENTITY()
				
        END TRY
        BEGIN CATCH
					
			--PRINT @@TRANCOUNT   
					    
            IF @TranCount <= 0
                AND @@TRANCOUNT > 0 
                ROLLBACK TRAN 
            ELSE 
                ROLLBACK TRAN [transfer]
            
            --PRINT @@TRANCOUNT    
            
            SET @ResultCode = -1
            RETURN @ResultCode
			
        END CATCH 
		
		/*insert to participant*/
        BEGIN TRY
			
            INSERT  INTO [BillingSystem_TransferParticipants]
                    ( UserId
                    , [SellingHistoryId]
                    , RealMoneySourceId
                    )
            VALUES  ( NULLIF(@Transfer.value('(/t/ttp/@uid)[1]', 'uniqueidentifier'), dbo.f_GetEmptyGuid())
                    , dbo.f_Offers_GetHistoryIdBySellingOfferId(NULLIF(@Transfer.value('(/t/ttp/@soid)[1]', 'int'), 0))
                    , NULLIF(@Transfer.value('(/t/ttp/@rmsid)[1]', 'int'), 0)
                    )
			
            DECLARE @tpId INT = SCOPE_IDENTITY()
			
        END TRY 
        BEGIN CATCH 
			
            IF @TranCount <= 0
                AND @@TRANCOUNT > 0 
                ROLLBACK TRAN 
            ELSE 
                ROLLBACK TRAN [transfer]
                  
            SET @ResultCode = -3
                
            RETURN @ResultCode
                    
              
            
        END CATCH 
		
		/*insert transfer */
        BEGIN TRY
			
            INSERT  INTO [BillingSystem_Transfers]
                    ( Amount
                    , CreateDate
                    , FromTransferParticipantId
                    , ToTransferParticipantId
                    , Note
                    , StatusId
                    , [Commission]
                    , [OurCommission]
                    )
            VALUES  ( @Transfer.value('(/t/@a)[1]', 'money')
                    , @Now
                    , @fpId
                    , @tpId
                    , @Transfer.value('(/t/@n)[1]', 'nvarchar(500)')
                    , @Transfer.value('(/t/@sid)[1]', 'int')
                    , @Transfer.value('(/t/@c)[1]', 'money')
                    , @Transfer.value('(/t/@oc)[1]', 'money')
                    )
		
            DECLARE @tid INT = SCOPE_IDENTITY()
		
        END TRY 
        BEGIN CATCH
	
            
            IF @TranCount <= 0
                AND @@TRANCOUNT > 0 
                ROLLBACK TRAN 
            ELSE 
                ROLLBACK TRAN [transfer]
                  
            SET @ResultCode = -4
                   
            RETURN @ResultCode
            
	
        END CATCH 
	   

		/*to user: add user's money*/
        IF @Transfer.value('(/t/@sid)[1]', 'int') = 1
            AND EXISTS ( SELECT 'to users'
                         FROM   [BillingSystem_TransferParticipants] AS p
                         WHERE  p.UserId IS NOT NULL
                                AND p.TransferParticipantId = @tpId ) 
            BEGIN
			
                BEGIN TRY
                
                    EXEC p_Users_AddMoney @TransferId = @tid
			
                END TRY 
                BEGIN CATCH
			
                    IF @TranCount <= 0
                        AND @@TRANCOUNT > 0 
                        ROLLBACK TRAN 
                    ELSE 
                        ROLLBACK TRAN [transfer]
                  
                    SET @ResultCode = -5
                           
                    RETURN @ResultCode
                        
                    
                END CATCH 
			
            END

		/*to offer: block buyer's money*/
        IF EXISTS ( SELECT  'to offer'
                    FROM    [BillingSystem_TransferParticipants] AS p
                    WHERE   p.TransferParticipantId = @tpId
                            AND p.[SellingHistoryId] IS NOT NULL ) 
            BEGIN
			
                BEGIN TRY
		
                    UPDATE  dbo.Users_Dynamics
                    SET     MoneyBlocked += ISNULL(t.Amount, 0)
                    FROM    [BillingSystem_Transfers] AS t
                    INNER JOIN [BillingSystem_TransferParticipants] AS fp ON fp.TransferParticipantId = t.FromTransferParticipantId
                    INNER JOIN [BillingSystem_TransferParticipants] AS tp ON tp.TransferParticipantId = t.ToTransferParticipantId
                    INNER JOIN dbo.[Offers_SellingHistory] AS o ON o.[HistorySellingId] = tp.[SellingHistoryId]
                    WHERE   dbo.Users_Dynamics.UserId = fp.UserId
                            AND t.TransferId = @tid
		
                END TRY 
                BEGIN CATCH

                    IF @TranCount <= 0
                        AND @@TRANCOUNT > 0 
                        ROLLBACK TRAN 
                    ELSE 
                        ROLLBACK TRAN [transfer]
                  
                    SET @ResultCode = -6
                            
                    RETURN @ResultCode
                        
	
                END CATCH 
  
            END
		
		/*from offer: unblock buyer's money*/
        IF EXISTS ( SELECT  'from offer'
                    FROM    [BillingSystem_TransferParticipants] AS p
                    WHERE   p.TransferParticipantId = @fpId
                            AND p.[SellingHistoryId] IS NOT NULL ) 
            BEGIN
				
				
                BEGIN TRY
				
                    UPDATE  dbo.Users_Dynamics
                    SET     MoneyBlocked -= ISNULL(t.Amount, 0)
                    FROM    [BillingSystem_Transfers] AS t
                    INNER JOIN [BillingSystem_TransferParticipants] AS fp ON fp.TransferParticipantId = t.FromTransferParticipantId
                    INNER JOIN [BillingSystem_TransferParticipants] AS tp ON tp.TransferParticipantId = t.ToTransferParticipantId
                    INNER JOIN dbo.[Offers_SellingHistory] AS o ON o.[HistorySellingId] = fp.[SellingHistoryId]
                    --INNER JOIN [Offers_Buyers] AS b ON b.OfferId = o.[SellingId]
                    WHERE   dbo.Users_Dynamics.UserId = o.BuyerId
                            AND t.TransferId = @tid
		
                END TRY 
                BEGIN CATCH
	
                    IF @TranCount <= 0
                        AND @@TRANCOUNT > 0 
                        ROLLBACK TRAN 
                    ELSE 
                        ROLLBACK TRAN [transfer]
                  
                    SET @ResultCode = -7
                  
                    RETURN @ResultCode
                  
                    
	
                END CATCH 
                
            END		

		/*from user: sub user's money*/
        IF /*@Transfer.value('(/t/@sid)[1]', 'int') = 1 AND*/ EXISTS ( SELECT   'from user'
                                                                       FROM     [BillingSystem_TransferParticipants] AS p
                                                                       WHERE    p.TransferParticipantId = @fpId
                                                                                AND p.UserId IS NOT NULL ) 
            BEGIN

                BEGIN TRY
		
                    EXEC p_Users_SubMoney @TransferId = @tid
		
                END TRY 
                BEGIN CATCH

                    IF @TranCount <= 0
                        AND @@TRANCOUNT > 0 
                        ROLLBACK TRAN 
                    ELSE 
                        ROLLBACK TRAN [transfer]
                  
                  
                    PRINT @@TRANCOUNT
                  
                    SET @ResultCode = -2
                  
                    RETURN @ResultCode
                  
                    
                END CATCH 

            END
		
        IF @TranCount <= 0 AND @@TRANCOUNT > 0 
            COMMIT TRAN 
        /*ELSE 
            COMMIT TRAN [transfer]*/
                  
        SET @ResultCode = 0
                
            
	
        DECLARE @Transfers udtt_Transfers
	
        INSERT  INTO @Transfers
                ( TransferId, RowNumber )
        VALUES  ( @tid, 1 )
	
        EXEC [p_BillingSystem_GetTransfers] @Transfers = @Transfers
        
        RETURN @ResultCode
    
    END

