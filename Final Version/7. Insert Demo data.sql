USE CASINO
GO
--DROP proc usp_create_NewPlayerRegister
create or alter proc usp_create_NewPlayerRegister
as
/*
exec usp_create_NewPlayerRegister
*/
begin
		Declare @fullName varchar(20), @stmtS nvarchar(4000), @lastName varchar(20), @Password [playerPasswordDt],
				@username varchar(20), @email nvarchar(200), @birthdate datetime, @city varchar(20), 
				@Country varchar(20), @gender char, @action varchar(20), @new_id VARCHAR(255), @firstName varchar(20)

			

				DECLARE @start datetime = DATEADD (year , 1 , '1980-05-31' )  
				DECLARE @end datetime = DATEADD (year , 1 , '2000-05-31' )

		Declare Mycursor cursor
		for SELECT [FullName] ,[EmailAddress], preferredName
		FROM [WideWorldImporters].[Application].[People]
		open Mycursor
		Fetch next from Mycursor into @fullName, @email, @username
		while @@FETCH_STATUS=0
		begin 
				SELECT @new_id = (select newid())
				SELECT @Password = CAST((ABS(CHECKSUM(@new_id))%10) AS VARCHAR(1)) + 
						CHAR(ASCII('a')+(ABS(CHECKSUM(@new_id))%25)) +
						CHAR(ASCII('A')+(ABS(CHECKSUM(@new_id))%25)) +
						LEFT(@new_id,3)
				set @username = @username+CAST((ABS(CHECKSUM(@new_id))%10) AS VARCHAR(1))
				set @email = @username+'@gmail.com'
				set @birthdate = (SELECT DATEADD(DAY,ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY,@start,@end)),@start))
				set @firstName = (substring(@fullName , 1, charindex(' ',@fullName)))
				set @lastname = SUBSTRING(@fullName,CHARINDEX(' ',@fullName)+1,LEN(@fullName))
				set @city = 'Oranit'
				set @Country = 'Israel'
				set @gender = 'F'
				set @action ='register'
		
				set @stmtS = 'usp_welcome ' + ''''+@username+''''+', '+''''+CONVERT(NVARCHAR,@Password)+''''+', '+''''+@email+''''+', '+''''+cast(@birthdate as varchar)+''''+', '
								+''''+@firstName+''''+', '+''''+@lastname+''''+', '+''''+@city+''''+', '+''''+@Country+''''+', '+''''+@gender+''''+','+''''+@action+''''
				print @stmtS
				exec (@stmtS)

				--exec usp_welcome  'Avi', '15g1223rD', 'bent.avigail@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','register'
			Fetch next from Mycursor into  @fullName, @email, @username
		end 
		close Mycursor
		Deallocate Mycursor
end

GO
--DROP proc usp_create_NewPlayerlogin
create or alter proc usp_create_NewPlayerlogin
as
/*
exec usp_create_NewPlayerlogin
*/
begin
		Declare @fullName varchar(20), @stmtS nvarchar(4000), @lastName varchar(20), @playerPassword [playerPasswordDt],
				@username varchar(20), @emailAddress nvarchar(200), @birthdate datetime, @city varchar(20), 
				@Country varchar(20), @gender char, @action varchar(20), @new_id VARCHAR(255), @firstName varchar(20)

		Declare Mycursor cursor
		for SELECT username, lastName, playerPassword, emailAddress, birthdate, Country , gender, firstName
		FROM admin.utbl_players
		open Mycursor
		Fetch next from Mycursor into @username, @lastName, @playerPassword, @emailAddress, @birthdate, @country , @gender, @firstName
		while @@FETCH_STATUS=0
		begin 
				set @action ='login'
				set @city = ''
				set @stmtS = 'usp_welcome ' + ''''+@username+''''+', '+''''+@playerPassword+''''+', '+''''+@emailAddress+''''+', '+''''+cast(@birthdate as varchar)+''''+', '
								+''''+@firstName+''''+', '+''''+@lastname+''''+', '+''''+@city+''''+', '+''''+@Country+''''+', '+''''+@gender+''''+','+''''+@action+''''
				print @stmtS
				exec (@stmtS)

				--exec usp_welcome  'Avi', '15g1223rD', 'bent.avigail@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','login'

		Fetch next from Mycursor into @username, @lastName, @playerPassword, @emailAddress, @birthdate, @country , @gender, @firstName		end 
		close Mycursor
		Deallocate Mycursor
end

--exec usp_MoneyDeposit
--           @userName				=	'Avigail',  
--		   @creditCardNumber		=	'4563123498764567',
--		   @expiryDate				=	'072023',
--		   @depositAmmount			=	'100'

GO
--DROP proc  usp_create_insertDeposit
create or alter proc usp_create_insertDeposit
as
/*
exec usp_create_insertDeposit
*/
begin
		Declare @username varchar(20), @stmtS nvarchar(4000), @creditCardNumber nvarchar(100), @transactionAmount int, @expiryDate nvarchar(20)
		Declare Mycursor cursor
		for SELECT username
		FROM admin.utbl_players
		open Mycursor
		Fetch next from Mycursor into @username
		while @@FETCH_STATUS=0
		begin 
				set @creditCardNumber = '4563123498764567'
				set @expiryDate = '072023'
				set @transactionAmount = ABS(CHECKSUM(NEWID()) % 100) + 500	
				set @stmtS = 'usp_MoneyDeposit ' +''''+@username+''''+', '+''''+@creditCardNumber+''''+', '+''''+@expiryDate+''''+', '+cast(@transactionAmount as varchar)
				print @stmtS
				exec (@stmtS)
			Fetch next from Mycursor into  @username
		end 
		close Mycursor
		Deallocate Mycursor
end

GO
--DROP proc usp_play_BlackJack
create or alter proc usp_play_BlackJack
as
/*
exec usp_play_BlackJack
*/
begin
		Declare @username varchar(20), @stmtS nvarchar(4000), @cardNo int, @betAmnt int
		Declare Mycursor cursor
		for SELECT username
		FROM admin.utbl_players
		open Mycursor
		Fetch next from Mycursor into @username
		while @@FETCH_STATUS=0
		begin 
				set @cardNo = ABS(CHECKSUM(NEWID()) % 4) + 1
				set @betAmnt = ABS(CHECKSUM(NEWID()) % 2) + 1	
				set @stmtS = 'usp_blackjack ' +''''+@username+''''+', '+cast(@betAmnt as varchar)+', '+cast(@cardNo as varchar)
				print @stmtS
				exec (@stmtS)
			Fetch next from Mycursor into  @username
		end 
		close Mycursor
		Deallocate Mycursor
end

GO
--DROP PROC usp_play_slotMachine
create or alter proc usp_play_slotMachine
as
/*
exec usp_play_slotMachine
*/
begin
		Declare @username varchar(20), @stmtS nvarchar(4000), @betAmnt int
		Declare Mycursor cursor
		for SELECT username
		FROM admin.utbl_players
		open Mycursor
		Fetch next from Mycursor into @username
		while @@FETCH_STATUS=0
		begin 
				set @betAmnt = ABS(CHECKSUM(NEWID()) % 6) + 1	
				set @stmtS = 'usp_slotMachine ' +''''+@username+''''+', '+cast(@betAmnt as varchar)
				print @stmtS
				exec (@stmtS)
			Fetch next from Mycursor into  @username
		end 
		close Mycursor
		Deallocate Mycursor
end
