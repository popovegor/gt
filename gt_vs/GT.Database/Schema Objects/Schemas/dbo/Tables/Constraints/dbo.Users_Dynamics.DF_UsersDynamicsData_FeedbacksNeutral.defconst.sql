ALTER TABLE [dbo].[Users_Dynamics]
ADD CONSTRAINT [DF_UsersDynamicsData_FeedbacksNeutral] 
DEFAULT (0)
FOR FeedbacksNeutral


