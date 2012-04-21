CREATE PROCEDURE [dbo].[p_Buyers_Reject]
@BuyerId UNIQUEIDENTIFIER, @OfferId INT
AS
BEGIN

	begin tran;
	
	Update [Offers_Buyers]
	Set [BuyerStatusId] = 2
	Where [BuyerId] = @BuyerId and [OfferId] = @OfferId and [BuyerStatusId] = 1

	if @@ROWCOUNT <= 0
		begin
			if @@TRANCOUNT > 0
					rollback tran;
			goto failedUser;
		end;
	
	if @@TRANCOUNT > 0
				commit tran;
	select 1;
	return 1;

	failedUser:
		select -1;
	
END


