ALTER TABLE [dbo].[Users_Dynamics]
ADD CONSTRAINT [DF_UsersDynamicsData_FeedbacksPositive] 
DEFAULT (0)
FOR FeedbacksPositive


