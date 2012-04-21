CREATE PROCEDURE [dbo].[p_Offers_AddSuggested]
@BuyingId INT, @Suggested INT, @ResultCode INT OUTPUT
AS
BEGIN
	
	begin tran
	
	select [SellingId] From [Offers_Selling] 
	inner join Offers_Buying on [Offers_Buying].GameServerId = [Offers_Selling].GameServerId
	where [SellingId] = @Suggested and TransactionPhaseId = 1 and [Offers_Buying].BuyingOfferId = @BuyingId
	
	if (@@ROWCOUNT <= 0)
		goto failedOffer;
	
	select [Offers_SuggestedSelling].BuyingOfferId from Offers_SuggestedSelling Where [Offers_SuggestedSelling].SellingId = @Suggested
	
	if (@@ROWCOUNT > 0)
		goto failedOffer;
	
	insert into [Offers_SuggestedSelling]
	values (@Suggested, @BuyingId, GETUTCDATE() )
	
	if (@@TRANCOUNT > 0)
		commit tran;
		
	set @ResultCode = 1;
	return @ResultCode;
	
	failedOffer:
		if (@@TRANCOUNT > 0)
			rollback tran;
		set @ResultCode = -1;
		return @ResultCode;	
	
END





