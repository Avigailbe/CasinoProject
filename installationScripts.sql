exec usp_createEmailAccountProfile 'yanivavigail3996','bentovim.avigail@gmail.com', 'bentovim.avigail@gmail.com','bentovim.avigail@gmail.com'

drop proc usp_createEmailAccountProfile
--create profile for sending e-mails
--****PART OF INSTALLATION NOT TO BE RUN TWICE
create proc usp_createEmailAccountProfile (	@emailPassword nvarchar(100), @emailusername nvarchar(100),
											@emailToAddress nvarchar(100), @emailFromAddress nvarchar(100) )
as
begin
-- Create a Database Mail account  
	EXECUTE msdb.dbo.sysmail_add_account_sp  
		@account_name = 'Casino Support Team Public Account',      
		@email_address = @emailToAddress,  
		@display_name = 'Casino Support Team Automated Mailer',
		@replyto_address = @emailFromAddress, 
		@description = 'Mail account for use by all database users.',  
		@mailserver_name = 'smtp.gmail.com',
		@port = 587,
		@enable_ssl = 1,
		@username = @emailusername,
		@password = @emailPassword; 
     
	-- Create a Database Mail profile  
	EXECUTE msdb.dbo.sysmail_add_profile_sp  
		@profile_name = 'Casino Support Team',  
		@description = 'Profile used for support mail.' ;  

	-- Add the account to the profile  
	EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
		@profile_name = 'Casino Support Team',   
		@account_name = 'Casino Support Team Public Account',  
		@sequence_number =1 ;  
  
	-- Grant access to the profile to all users in the msdb database  
	EXECUTE msdb.dbo.sysmail_add_principalprofile_sp  
		@profile_name = 'Casino Support Team',  
		@principal_name = 'public',  
		@is_default = 1 ;  
end


--RLS on Game table - to enable only the game manager to see the rows for their game.
CREATE USER Anne WITHOUT LOGIN
GRANT SELECT ON Games.utbl_Games TO Anne

CREATE USER Avi WITHOUT LOGIN
GRANT SELECT ON Games.utbl_Games TO Avi

CREATE USER Karina WITHOUT LOGIN
GRANT SELECT ON Games.utbl_Games TO Karina

CREATE USER Kari WITHOUT LOGIN
GRANT SELECT ON Games.utbl_Games TO Kari

--drop function Security.udf_securitypredicate
create function [Security].udf_securitypredicate(@GameName as nvarchar(50))
    returns table
with schemabinding
as
    return select 1 as result 
    where @GameName in (select cm.GameName  
								   from Security.utbl_CasinoManagers cm 
								   inner join 
								   Games.utbl_Games g
								   on cm.GameName = g.GameName
								   where cm.managerName 
								   = user_name() or user_name() = 'dbo')

GO
create SECURITY POLICY GamesPolicyFilter
	ADD FILTER PREDICATE Security.udf_securitypredicate(GameName) 
	ON Games.utbl_Games
	WITH (STATE = ON);
go
-- Create and enable a security policy adding the function fn_securitypredicate 
-- as a filter predicate and switching it on
--DROP SECURITY POLICY GamesPolicyFilter
EXECUTE AS USER = 'Anne'
--EXECUTE AS USER = 'Kari'								
select user_name()
select * from Games.utbl_Games
select * from [Security].utbl_CasinoManagers
REVERT	


--bet bonus procedure for Bet Bonus for Casino job

create or alter proc usp_betBonus 	
as
/*
exec usp_betBonus
*/
begin
	declare 
	@transDate						datetime,
	@username						usernameDt,
	@adminBetBonus					int,
	@adminMinBetAmntForBonus		int


	set @transDate = getdate()
	set @adminBetBonus = (select cast(companyValue as int) from Admin.utbl_CompanyDefinitions where companyKey = 'betBonus')
	set @adminMinBetAmntForBonus = (select cast(companyValue as int) from Admin.utbl_CompanyDefinitions where companyKey = 'minBetAmntForBonus')
	set @username = (select distinct out.username 
					from Admin.utbl_transatioms out, (select sum(transactionAmount) as totalBet, username
								from Admin.utbl_Bankroll
								where transactionType = 'Bet'
								and transDate  >= DateAdd(hh, -24, GETDATE())
								group by username) inn
					where out.username = inn.username
					and  transactionType = 'Bet'
					and inn.totalBet >@adminMinBetAmntForBonus)


	insert into Admin.utbl_transatioms (transactionType, transactionAmount, username, transDate)
			values ('Bonus', @adminBetBonus, @username, @transDate);

end


--connections check procedure for connections>100 Casino job

create or alter proc usp_connectionsCheck 
		
as
/*
exec usp_betBonus
*/
begin
	declare 
	@amount				int
	@adminMailAddress	emailAddressDt

	set @adminMailAddress = (select cast(companyValue as int) from Admin.utbl_CompanyDefinitions where companyKey = 'adminMailAddress')
	set @amount = (select count(*)
	from admin.utbl_Players
	where IsConnected = 'Y') 

	if(@amount >100)
	begin
		--send mail notification of connection amount
		set @subject = 'Password reset for Casino playerThe number of : '+@username
		set @playerBody = 'Your new password is '+@newPassword
		exec msdb.dbo.sp_send_dbmail 
							@profile_name = 'Casino Support Team',
							@recipients=@emailToAddress,
							@subject=@playerSubject,
							@body=@playerBody
	end
end
	


Copy
USE master ;  
GO  
-- Create the server audit.
-- Change the path to a path that the SQLServer Service has access to. 
CREATE SERVER AUDIT DataModification_Security_Audit  
    TO FILE ( FILEPATH = 
'D:\HomeWork\casino' ) ; 
GO  
-- Enable the server audit.  
ALTER SERVER AUDIT DataModification_Security_Audit   
WITH (STATE = ON) ;  
GO  
-- Move to the target database.  
USE Casino ;  
GO 
-- Create the database audit specification for the admin schema.  
CREATE DATABASE AUDIT SPECIFICATION Audit_Data_Modification_On_All_Tables  
FOR SERVER AUDIT DataModification_Security_Audit  
ADD ( INSERT, UPDATE, DELETE  
     ON DATABASE::Casino BY PUBLIC )  
WITH (STATE = ON) ;    
GO  