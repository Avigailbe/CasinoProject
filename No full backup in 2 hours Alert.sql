USE [msdb]
GO

/****** Object:  Alert [No Full Backup in 24 Hours]    Script Date: 04-Apr-19 11:19:45 AM ******/
EXEC msdb.dbo.sp_add_alert @name=N'No Full Backup in 24 Hours', 
		@message_id=0, 
		@severity=16, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@database_name=N'Casino', 
		@event_description_keyword=N'BACKUP DATABASE is terminating abnormally', 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO


