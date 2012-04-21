-- =============================================
-- Author:		E. Popov
-- Create date: 2008 12 18
-- Description:	Gets the configuration for CachedEntityBase inheritors
-- =============================================
CREATE PROCEDURE [dbo].[p_Caches_GetConfiguration]
AS
BEGIN
	select dbo.Caches_Configuration.TypeName,
		dbo.Caches_Configuration.ReloadTimeout,		
		dbo.Caches_Configuration.LoadImmediately,
		dbo.Caches_Configuration.LockTimeout,
		dbo.Caches_Configuration.CacheExpiration,
		dbo.Caches_Configuration.PeriodicReloadTimeSpan
	from dbo.Caches_Configuration
END
