CREATE PROCEDURE [dbo].[p_Offers_GetSellingOfferBuyers]
	@Id int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [Offers_Buyers].BuyerId, UserName as SellerName, [Offers_Buyers].BuyerStatusId
	FROM [Offers_Buyers]
	INNER JOIN aspnet_Users as u ON [Offers_Buyers].BuyerId = [u].UserId
	WHERE [Offers_Buyers].OfferId = @Id
END


