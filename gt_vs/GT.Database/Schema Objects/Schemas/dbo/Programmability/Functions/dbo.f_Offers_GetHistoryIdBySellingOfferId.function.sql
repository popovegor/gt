-- =============================================
-- Author:		E.Popov
-- Create date: 2010-01-15
-- Description:	Gets a selling history id by the passed offer id
-- =============================================
-- =============================================
-- Author:		E.Popov
-- Create date: 2010-01-15
-- Description:	Gets a selling history id by the passed offer id
-- =============================================
CREATE FUNCTION [dbo].[f_Offers_GetHistoryIdBySellingOfferId] 
(
	@SellingOfferId INT
)
RETURNS INT
AS
BEGIN
	
	DECLARE @SellingHistoryId INT 

	SELECT TOP (1) @SellingHistoryId = h.[HistorySellingId]
	FROM dbo.[Offers_SellingHistory] AS h
	WHERE h.[SellingId] = @SellingOfferId
	ORDER BY h.[HistoryCreateDate] DESC

	-- Return the result of the function
	RETURN NULLIF(@SellingHistoryId, 0)

END





