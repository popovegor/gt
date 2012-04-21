-- =============================================
-- Author:		E.Popov
-- Create date: 2009-09-29
-- Description: get empty guid like .net guid object
-- =============================================
CREATE FUNCTION [dbo].[f_GetEmptyGuid] ()
returns uniqueidentifier
AS
BEGIN
	return '00000000-0000-0000-0000-000000000000';
END
