USE [msdb]
GO

/****** Object:  Operator [AdminOp]    Script Date: 04-Apr-19 10:49:11 AM ******/
EXEC msdb.dbo.sp_add_operator @name=N'AdminOp', 
		@enabled=1, 
		@weekday_pager_start_time=0, 
		@weekday_pager_end_time=120000, 
		@saturday_pager_start_time=0, 
		@saturday_pager_end_time=120000, 
		@sunday_pager_start_time=0, 
		@sunday_pager_end_time=120000, 
		@pager_days=127, 
		@email_address=N'bentovim.avigail@gmail.com', 
		@pager_address=N'Avigail', 
		@category_name=N'[Uncategorized]'
GO

USE [msdb]
GO

/****** Object:  Operator [AdminOp2]    Script Date: 04-Apr-19 10:47:23 AM ******/
EXEC msdb.dbo.sp_add_operator @name=N'AdminOp2', 
		@enabled=1, 
		@weekday_pager_start_time=120000, 
		@weekday_pager_end_time=115900, 
		@saturday_pager_start_time=120000, 
		@saturday_pager_end_time=115900, 
		@sunday_pager_start_time=120000, 
		@sunday_pager_end_time=115900, 
		@pager_days=127, 
		@email_address=N'barjonya@gmail.com', 
		@pager_address=N'Karina', 
		@category_name=N'[Uncategorized]'
GO

