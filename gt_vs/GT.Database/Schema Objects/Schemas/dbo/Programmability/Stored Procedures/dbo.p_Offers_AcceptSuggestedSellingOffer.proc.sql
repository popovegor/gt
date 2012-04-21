CREATE PROCEDURE [dbo].[p_Offers_AcceptSuggestedSellingOffer]
@BuyingId INT, @SuggestedId INT, @ResultCode INT OUTPUT
AS
BEGIN

	begin tran
	
	DECLARE	@return_value int, @buyerId uniqueidentifier, @temp int

	Select @buyerId = BuyerId From Offers_Buying Where BuyingOfferId = @BuyingId

	-- Buyers accept always right!
	DELETE FROM [Offers_Buyers] WHERE [BuyerId] = @buyerId AND [OfferId] = @SuggestedId

	EXEC	@return_value = [dbo].[p_Offers_SelectSellingOffer]
			@UserId = @buyerId,
			@OfferId = @SuggestedId,
			@ResultCode = @ResultCode OUTPUT
	
	if (@ResultCode < 0)
		goto failedUser;
		
	EXEC	@return_value = [dbo].[p_Offers_AcceptSellingOffer]
			@OfferId = @SuggestedId,
			@UserId = @buyerId,
			@Resultcode = @ResultCode OUTPUT,
			@HistoryId = @temp OUTPUT
		
	if (@ResultCode < 0)
		goto failedOffer;
	
	-- Already delete in p_Offers_AcceptSellingOffer	
	--Delete From Offers_SuggestedSelling Where [Offers_SuggestedSelling].BuyingOfferId = @BuyingId and [Offers_SuggestedSelling].SellingOfferId = @SuggestedId
		
	if (@@TRANCOUNT > 0)
			commit tran;
	set @ResultCode = 1;
	return @ResultCode;
       
    failedOffer:
		if @@TRANCOUNT > 0
			rollback tran;
		set	@ResultCode = -1;
		return @ResultCode; 
		
	failedUser:
		if @@TRANCOUNT > 0
				rollback tran;
		set @ResultCode = -2;
		return @ResultCode;
		
END


