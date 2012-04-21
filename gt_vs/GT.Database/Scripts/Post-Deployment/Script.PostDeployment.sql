--IF N'$(RecreateData)' = 'True'
--BEGIN

  :setvar ApplicationId N'92070af6-1e8a-4ae2-bef3-5d2bbe740edb'
  :setvar UserId N'ffffffff-ffff-ffff-ffff-ffffffffffff'
  
	:r .\DATA\aspnet_Applications.sql
	:r .\DATA\aspnet_SchemaVersions.sql
  :r .\DATA\aspnet_Users.sql
  :r .\DATA\aspnet_Membership.SQL
  :r .\DATA\aspnet_Roles.SQL
  :r .\DATA\Dictionaries_Languages.SQL
	:r .\DATA\Dictionaries_Games.SQL
	:r .\DATA\Dictionaries_FeedbackTypes.sql
	:r .\DATA\Caches_Configuration.sql
	:r .\DATA\Dictionaries_BuyerStatuses.sql
	:r .\DATA\SiteMap.sql
	:r .\DATA\Dictionaries_RealMoneySources.sql
	:r .\DATA\Dictionaries_TransactionPhases.sql
	:r .\DATA\Dictionaries_GameServers.sql
	:r .\DATA\Dictionaries_MessageTemplates.SQL
	:r .\DATA\Dictionaries_TransferStatuses.SQL
	:r .\DATA\Dictionaries_TimeZones.SQL
	:r .\DATA\Dictionaries_WebMoneyMessagesTypes.SQL
	:r .\DATA\Dictionaries_WebMoneyMessages.SQL
	:r .\DATA\Dictionaries_ProductCategories.sql
	
--END