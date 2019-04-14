use Casino
go

--drop proc usp_welcome
----*****************REMOVE ALL INPUTS EXCEPT CHOICE?**********************************************

go
-- ================================================
-- Procedure to login or register new player
-- ================================================

create or alter proc usp_welcome
           @username usernameDt, @Password playerPasswordDt, 
		   @Email  emailAddressDt, @birthDate birthDateDt,
		   @FirstName firstNameDt, @LastName lastNameDt, 
		   @PlayerAddress addressDt, @Country countryDt,
		   @Gender genderDt, @choice nvarchar(100)
as
/*
exec usp_welcome
           @username			= 'Avigail', 
		   @Password			= '2yryt23rD',  
		   @Email				= 'bentovim.avigail@gmail.com',
		   @birthdate			= '2000-03-27 12:20:07.420', 
		   @FirstName			= 'avigail', 
		   @LastName			= 'ben', 
		   @PlayerAddress		= 'Dragot 4, Oranit',  
		   @Country				= 'Israel', 
		   @Gender				= 'F',  
		   @choice				= 'REGISTER'
*/
begin
	declare @variableString nvarchar(500)

	set @variableString = '@username = '+@username+', @password = '+@password+', @email = '+@email+
						  ', @firstName = '+@firstName+', @lastName = '+@lastName+', @playerAddress = '+@playerAddress+
						  ', @country = '+@country+', @gender = '+@gender+', @choice = '+@choice

	exec usp_insertAppLog 'usp_welcome', @variableString, 'Start of usp_welcome procedure.'	
	--check if to register or login and send to appropriate handling
	if (@choice = 'register')
		begin
			exec usp_insertAppLog 'usp_welcome', @variableString, 'Registrating new player. Calling usp_validate_playerDetails'	
			print 'Registration GUI Screen - Welcome new player. Please enter your details to register'
			exec usp_validate_playerDetails @username , @Password, @Email, @birthDate,
											@FirstName, @LastName, @PlayerAddress, @Country,
											 @Gender, @choice
			return;
		end
	if (@choice = 'login')
		begin
			exec usp_insertAppLog 'usp_welcome', @variableString, 'Logging in new player. Calling usp_Login'	
			print 'Login GUI Screen - Welcome back. Please provide your username and password to login'
			exec usp_Login @username, @Password 
		end
	exec usp_insertAppLog 'usp_welcome', @variableString, 'End of usp_welcome procedure.'	
end 

go

--exec usp_welcome  'KARINA', 'a9gyfd9xFpd', 'barjonya@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'KARA', 'a9gyd9xFpd', 'baronya@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'KARA', 'a9gyd9xFpd', 'baronya@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','login'

--exec usp_welcome  'Karina2', 'a9gyfdD9xpd', 'bar@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','register'
----exec usp_welcome  'Avigail', '11223rD', 'bentovim.avigail@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'Avigail5', 'a9gyfd9xFpd', 'bentovim.avi@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'Avigail', 'rt45Dy', 'bentovim.avigail@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','login'
--exec usp_welcome  'Avi', '15g1223rD', 'bent.avigail@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'Avi', '15g1223rD', 'bent.avigail@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','login'
--exec usp_welcome  'Aviv', '15g223rD', 'ben.avigail@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'KAR', 'a9gyd9bPpd', 'barnya@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'KAR', 'a9gyd9bPpd', 'barnya@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','login'
--exec usp_welcome  'Avigail5', 'Ail56', 'bentovim.avi@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','login'
--exec usp_welcome  'joel', 'a9gyp9bPpd', 'joa@gmail.com', '2000-03-27 12:20:07.420', 'joa', 'hana', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'mark', 'a9gyp9bPpd', 'markm@gmail.com', '2000-03-27 12:20:07.420', 'mark', 'manny', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'eoin', 'a9gyoyrbPpd', 'eoinb@gmail.com', '2000-03-27 12:20:07.420', 'eoin', 'bar', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'elaine', 'a9gyoptrbPpd', 'elainec@gmail.com', '2000-03-27 12:20:07.420', 'elaine', 'cheka', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'sharon', 'a9ghptrbPpd', 'sharons@gmail.com', '2000-03-27 12:20:07.420', 'sharon', 'saul', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'mai', 'a9ghppobPpd', 'mai@gmail.com', '2000-03-27 12:20:07.420', 'mai', 'saul', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'tanya', 'a9ghptrbPpd', 'tanyas@gmail.com', '2000-03-27 12:20:07.420', 'tanya', 'saul', 'Oranit', 'Israel', 'F','register'
--exec usp_welcome  'malie', 'a9ghptrbPpd', 'malies@gmail.com', '2000-03-27 12:20:07.420', 'malie', 'saul', 'Oranit', 'Ireland', 'F','register'
--exec usp_welcome  'rachel', 'a9ghptrbPpd', 'rachel@gmail.com', '2000-03-27 12:20:07.420', 'rachel', 'cohen', 'Oranit', 'Ireland', 'F','register'
--exec usp_welcome  'patty', 'a9ghptrbPpd', 'pattys@gmail.com', '2000-03-27 12:20:07.420', 'patty', 'sauley', 'Oranit', 'Ireland', 'F','register'
--exec usp_welcome  'harry', 'a9ghptrbPpd', 'harry@gmail.com', '2000-03-27 12:20:07.420', 'harry', 'hamster', 'Oranit', 'Ireland', 'F','register'
--exec usp_welcome  'malie', 'a9ghptrbPpd', 'malies@gmail.com', '2000-03-27 12:20:07.420', 'malie', 'saul', 'Oranit', 'Ireland', 'F','login'

--exec usp_welcome  'tanya', 'a9ghptrbPpd', 'tanyas@gmail.com', '2000-03-27 12:20:07.420', 'tanya', 'saul', 'Oranit', 'Israel', 'F','login'
--exec usp_welcome  'KARINA', 'a9gyfd9xFpd', 'barjonya@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'ben', 'Oranit', 'Israel', 'F','login'

--drop proc usp_validate_playerDetails
--unique username
--password:
--		5 chars
--		small, big chars, digit
--		not equal to existing password in password table
--		not 'password' in any combination
--email address: unique, legal format with @
--birthdate over 18 years

GO
-- ================================================
-- Procedure to validate registration of new player
-- ================================================
--DROP proc usp_validate_playerDetails
create or alter proc usp_validate_playerDetails 
           @username usernameDt, @playerPassword playerPasswordDt, 
		   @email  emailAddressDt, @birthDate birthDateDt,
		   @firstName firstNameDt, @lastName lastNameDt, 
		   @playerAddress addressDt, @country countryDt,
		   @gender genderDt, @choice nvarchar(100)
as
/*
exec usp_validate_playerDetails
           @username			= 'Avigail', 
		   @playerPassword		= '11223rD',  
		   @email				= 'bentovim.avigail@gmail.com',
		   @birthDate			= '2000-03-27 12:20:07.420', 
		   @firstName			= 'avigail', 
		   @lastName			= 'ben', 
		   @playerAddress		= 'Dragot 4, Oranit',  
		   @country				= 'Israel', 
		   @gender				= 'F',  
		   @choice				= 'personalDetailsChange'
*/
begin
    declare 
	@userNameValid			nchar,
	@passwordValid			nchar,
	@emailValid				nchar,
	@birthDateValid			nchar,
	@numFails				smallint			=	0, 
	@isBlocked				nchar				=	'N', 
	@loginTime				datetime			=	getdate(), 
	@isConnected			nchar				=	'N',
	@randomNumber			int,
	@counter				int					=	0, 
	@total					int					=	1,
	@adminMinAge			int,
	@adminBonus				float,
	@transactionType		transactionTypeDt,
	@variableString			nvarchar(500),
	@newLineChar AS CHAR(2) = CHAR(13) + CHAR(10)
	

	set @variableString = '@username = '+@username+', @playerPassword = '+@playerPassword+', @email = '+@email+', @birthDate = '+
										(select cast(@birthDate as varchar(10)))+ ', @firstName = '+@firstName+
										', @lastName = '+@lastName+', @playerAddress = '+@playerAddress+
										', @country = '+@country+', @gender = '+@gender+', @choice = '+@choice

	exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Start of usp_validate_playerDetails procedure.'	
	--check if new user or personal details change
	if (@choice <> 'personalDetailsChange')
	BEGIN
		exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Validating details of new player.'	
		--check if username exists - also case sensitive
		if ((select count(username)
				from Admin.utbl_players
				--where UserName = @username COLLATE SQL_Latin1_General_CP1_CS_AS)=0)
				where userName = @username collate database_default )=0)
				begin
					exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'New username is valid.'	
					set @userNameValid = 'Y'
				end
		else
				--add random number to username to make unique
				--use loop to check if exists before asking user
				begin				
					exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'New username is invalid.'	

					WHILE @counter < @total 
					BEGIN
						set @randomNumber = (select cast(abs(rand()*120)as int))
						set @username = @username+cast(@randomNumber as varchar)
						if ((select count(UserName)
							from Admin.utbl_players
							where username = @username collate database_default)=0)
							--or UserName = lower(@username) COLLATE SQL_Latin1_General_CP1_CS_AS)=0)
							begin
								set @variableString = '@username = '+@username
								exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'New username is invalid. New username provided'	
								BREAK
							end
						else
							begin
								set @counter = @counter+1 
								set @total = @total +1
								exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'New username provided exists. Generating new one.'	
								continue
							end
					END
					print 'The username you requested is already in use. '+@newLineChar+
							'Please choose another or use: '+@username

					--send back to welcome page
					--exec usp_welcome 'Y' , 'N',@username, @Password, @Email, @birthdate, @FirstName, 
					--				@LastName, @PlayerAddress, @Country, @Gender
					set @userNameValid = 'N'
					return
		end


		--check if password is legal
		exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Validating password. Checking is syntax is valid. Calling udf_PasswordSyntaxValid function'	
		if ((select dbo.udf_PasswordSyntaxValid(@playerPassword, @username)) = 'Y')
			begin				
				set @variableString = '@username = '+@username+', @playerPassword = '+@playerPassword
				exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Validating password. Checking if freqently used'	
				--check if password exists in git password table
				if ((select count(EXTPassword) from REFERENCE.utbl_GitPasswords 
						where EXTPassword = @playerPassword COLLATE SQL_Latin1_General_CP1_CS_AS)=0)
					begin
						exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Password is not freqently used - valid'
						--check if password passes external validations
						if ((select dbo.udf_PasswordExtValid (@playerPassword)) = 'Y')
							begin
								exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Password passed external validations - valid'
								set @passwordValid= 'Y'
							end
						else
							begin
								exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Password failed external validations - invalid'
								set @passwordValid= 'N'
							end
					end
				else
					begin
						exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Password is freqently used - invalid'
						set @passwordValid = 'N'
						print 'The password chosen is a frequent password. Please choose another'
						return
					end
			end
		else
			begin
				exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Password syntax is invalid'
				set @passwordValid = 'N';
				print 'Password provided is not strong, is frequently used or is the same as the username. '+@newLineChar+
						'Please enter a new password with: '+@newLineChar+
						'at least 5 characters long, '+@newLineChar+
						'with a combination of at least 1 small letter, '+@newLineChar+
						'1 capital letter, 1 digit'+@newLineChar+
						'not like the word password and not like the username.'
				return
			end
	END
	--check if player over 18
	set @adminMinAge = (select cast(companyValue as int) from Admin.utbl_CompanyDefinitions where companyKey = 'MinimumAge')
	set @variableString = '@username = '+@username+', @birthDate = '+(select cast(@birthDate as varchar(10)))
							+', @adminMinAge = '+(select cast(@adminMinAge as varchar(10)))
	exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Validating age.'	
	if (iif(datediff(dd, datediff(dd,getdate(), DATEADD (dd, -1, (DATEADD(yy, (DATEDIFF(yy, 0, GETDATE()) +1), 0)))),
			   datediff(dd,@birthDate, DATEADD (dd, -1, (DATEADD(yy, (DATEDIFF(yy, 0, @birthDate ) +1), 0))))) < 0,
			   datediff(yy,@birthDate,getdate())-1, datediff(yy,@birthDate,getdate())) >= @adminMinAge)
		begin
			set @birthDateValid = 'Y'
			exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Player age is valid.'	
		end
	else
		begin
			set @birthDateValid = 'N'
			print 'Players can only be over '+CONVERT(NVARCHAR,@adminMinAge)
			exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Player age is invalid.'	
			--exec usp_welcome 'N' , 'N', @username, @Password, @Email, @birthdate, @FirstName, 
			--				@LastName, @PlayerAddress, @Country, @Gender
			return
		end

	--check if email is legal and doesn't already exist
	set @variableString = '@username = '+@username+', @email = '+@email
	exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Validating email address.'	
	if ((@email <> '' AND @email LIKE '_%@__%.__%')
		and (select count(emailAddress) from Admin.utbl_players
			where emailAddress = @email)=0)
		begin
			exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Email address is valid.'	
			set @emailValid = 'Y'
		end
	else
		begin
			set @emailValid = 'N'
			exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Email address is invalid or already exists with another player.'	
			print 'Your email is invalid or already exists with another player. Please enter another'
			--exec usp_welcome 'Y' , 'N', @username, @Password, @Email, @birthdate, @FirstName, 
			--				@LastName, @PlayerAddress, @Country, @Gender
			return
		end

	--if all inputs are valid, insert new user to Admin.utbl_players table
	if (@birthDateValid = 'Y' and @emailValid = 'Y' and @passwordValid= 'Y' 
					and @usernameValid = 'Y' and @choice <> 'personalDetailsChange')
	begin
		set @variableString = '@username = '+@username+', @email = '+@email+', @birthDate = '+(select cast(@birthDate as varchar(10)))+', @playerPassword = '+@playerPassword
		exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'New registration details are valid. Adding new player to utbl_players'
		
		--OPEN SYMMETRIC KEY Password_key  
		--	DECRYPTION BY CERTIFICATE Password_certificate; 	

		insert into Admin.utbl_players (username, playerPassword, firstName, lastName, playerAddress, country,
									emailAddress, gender, birthDate, numFails, isBlocked, loginTime, isConnected)
						values (@username,@playerPassword, @firstName, @lastName, @playerAddress, @country,
								@email, @gender, @birthdate, @numFails, @isBlocked, @loginTime, @isConnected)

		--CLOSE SYMMETRIC KEY Password_key

		exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'New registration details are valid. Giving new player welcome bonus'	
		set @adminBonus = (select cast(companyValue as int) from Admin.utbl_CompanyDefinitions where companyKey = 'welcomeBonus')
		set @transactionType = 'Bonus'
		exec usp_insertTransactions @username, @adminBonus, @transactionType 
		

	--	exec usp_Login @username, @PlayerPassword
	end
	--if personal details change
	if (@birthDateValid = 'Y' and @emailValid = 'Y'
					and @choice = 'personalDetailsChange')
	begin
		set @variableString = '@username = '+@username
		exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'Personal details change is valid. Updating details for player in utbl_players'	
		update Admin.utbl_players 
		set firstName =@firstName, lastName = @lastName, playerAddress =@playerAddress, 
			country =@country, emailAddress = @email, gender = @gender
		where username = @username
		--exec usp_Login @username, @PlayerPassword
	end
	exec usp_insertAppLog 'usp_validate_playerDetails', @variableString, 'End of procedure'	
END
go

--drop proc usp_Login
--exec usp_Login 'Avigail5', '1MNhi'
--login existing user
-- ================================================
-- Procedure to login player
-- ================================================

create or alter proc usp_Login
           @username usernameDt, @playerPassword playerPasswordDt
as
/*
exec usp_Login
           @username			= 'Avigail5', 
		   @playerPassword		= 'a9gyfd9xFp'
*/
begin
    declare 
	@numTries			int, 
	@adminNumTries		int, 
	@loginTime			dateTime, 
	@numFails			int, 
	@variableString		nvarchar(500),
	@currentBankRoll	int

	set @loginTime = (select getdate())
	set @numFails = (select numFails from Admin.utbl_players where userName = @username)
	set @adminNumTries = (select cast(companyValue as int) from Admin.utbl_CompanyDefinitions where companyKey = 'logonTimes')
	set @variableString = '@username = '+@username+', @playerPassword = '+@playerPassword+', @numFails = '+(select cast(@numFails as nvarchar(50)) )
							+', @adminNumTries = '+(select cast(@adminNumTries as nvarchar(50)) )

	exec usp_insertAppLog 'usp_Login', @variableString, 'Start of usp_Login procedure. checking if player blocked'	

	--validate username. if exists, see if blocked. if not, validate password
	if ((select count(*) from Admin.utbl_players where username = @username) >0)
	begin
		exec usp_insertAppLog 'usp_Login', @variableString, 'Checking if player already logged in'	
		--check if user already logged in. If so deny login
		if ((select isConnected from Admin.utbl_players where username=@username)='Y')
		begin
			exec usp_insertAppLog 'usp_Login', @variableString, 'Player already logged in'	
			print 'You are already logged in. You cannot log in twice.'
			return;
		end
		--check if user blocked
		if ((select isBlocked from Admin.utbl_players where username=@username)='Y')
		begin
			exec usp_insertAppLog 'usp_Login', @variableString, 'Player blocked should contact support'	
			print 'You are currently blocked please contact support'
			return;
		end

		--password validation - see if right password for user
		exec usp_insertAppLog 'usp_Login', @variableString, 'Checking if right password for player.'	
		if ((select count(Username) from Admin.utbl_players where playerPassword= @playerPassword 
			and username =@username) =0)
		begin
			set @numFails = @numFails+1
			set @variableString = '@username = '+@username+', @playerPassword = '+@playerPassword+', @numFails = '+(select cast(@numFails as nvarchar(50)) )
							+', @adminNumTries = '+(select cast(@adminNumTries as nvarchar(50)) )
			exec usp_insertAppLog 'usp_Login', @variableString, 'Wrong password for player. A fail has been added'	
			--if exceeded number of allowed tries for password, send to support
			if (@numFails = @adminNumTries)
				begin
					exec usp_insertAppLog 'usp_Login', @variableString, 'Exceeded amount of allowed fails. Player will be blocked'	
					update Admin.utbl_players 
					set isBlocked = 'Y',
					isConnected = 'N',
					numFails = @adminNumTries
					where username=@username
					print 'You have entered the wrong password too many times and are now blocked. 
							Please contact support'
					return
				end  
			else
				begin
					exec usp_insertAppLog 'usp_Login', @variableString, 'Amount of fails is updated in utbl_players table. Player should try to login again with different password'	
					update Admin.utbl_players  
					set numFails = @numFails
					where username =@username
					print 'The password entered is invalid. Please try again'
					--send back to Login GUI Screen 
					return;
				end
		end
		else
			begin
			--if login successful, change NumFails = 0 and connect player
				exec usp_insertAppLog 'usp_Login', @variableString, 'Player has entered correct password and will be connected.'	
				update Admin.utbl_players
				set loginTime = @loginTime, 
				isConnected = 'Y', numFails = 0
				where username=@username
				exec usp_insertAppLog 'usp_Login', @variableString, 'Player is connected.'
			
				--send to lobby gui screen
				set @currentBankRoll= (select [Admin].[udf_Bankroll](@username))
				set @variableString = '@username = '+@username+', @currentBankRoll = '+(select cast(@currentBankRoll as nvarchar(50)) )
				exec usp_insertAppLog 'usp_Login', @variableString, 'Player is connected and going to lobby.'
	--**********for testing begin
				--exec usp_lobby @username, 'games'
	--**********for testing end
			end
	end
END
go


--drop proc usp_autoPasswordChange
--exec usp_autoPasswordChange 'Avigail5'
--password reset and send email to player with new password
--accessed from the Support GUI Screen
-- ======================================================================
-- Procedure to password reset and send email to player with new password
-- ======================================================================

create or alter proc usp_autoPasswordChange (@username usernameDt)
as
/*
exec usp_autoPasswordChange
           @username			= 'Avigail'
*/

begin
	declare
	@randomNumber			int,	
	@randomUpperCase		nvarchar(20),
	@randomLowerCase		nvarchar(20), 
	@newPassword			playerPasswordDt,
	@emailToAddress			emailAddressDt, 
	@playerSubject			nvarchar(100), 
	@playerBody				nvarchar(500),
	@count					int					=		0, 
	@total					int					=		1,	
	@variableString			nvarchar(500)

	set @variableString = '@username = '+@username

	exec usp_insertAppLog 'usp_autoPasswordChange', @variableString, 'Creating random password that conforms to validation rules. Begin'	
	--create random password that conforms to validation rules
	--while loop to check again if random password already exists
	WHILE (@count < @total)
		BEGIN
			set @randomNumber = cast((select cast(abs(rand()*120)as int))as varchar)
			set @randomUpperCase = (select substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', (abs(checksum(newid())) % 26)+1, 2))
			set @randomLowerCase = (SELECT substring('abcdefghijklmnopqrstuvwxyz', (abs(checksum(newid())) % 26)+1, 2))
			set @newPassword = CONCAT(@randomNumber, @randomUpperCase, @randomLowerCase)
			
			--check if player already used the passsword in the past or in frequent passwords
			set @variableString = '@username = '+@username+', @newPassword = '+@newPassword
			exec usp_insertAppLog 'usp_autoPasswordChange', @variableString, 'Validating password. Calling udf_IsPasswordInPast and udf_PasswordSyntaxValid functions'	

			if (((select dbo.udf_IsPasswordInPast(@username, @newPassword)) = 'Y') or
				((select dbo.udf_PasswordSyntaxValid(@newPassword, @username )) = 'N') or
				((select dbo.udf_PasswordExtValid (@newPassword)) = 'N'))
				begin
					set @variableString = '@username = '+@username+', @newPassword = '+@newPassword
					exec usp_insertAppLog 'usp_autoPasswordChange', @variableString, 'New random password has been used or is frequent. Trying again'	
					set @count = @count+1
					set @total = @total+1
				end
			else
				begin
					print @newPassword
					exec usp_insertAppLog 'usp_autoPasswordChange', @variableString, 'New random password is valid. Updating utbl_players table'	
					--update player with new password
					OPEN SYMMETRIC KEY Password_key  
							DECRYPTION BY CERTIFICATE Password_certificate;
					update Admin.utbl_players set playerPassword = @newPassword,
							isBlocked = 'N',
							numFails = 0
							where userName=@username
					CLOSE SYMMETRIC KEY Password_key
					--send mail to player with new password
					--create account and profile for player
					set @emailToAddress = (select emailAddress from Admin.utbl_players where username = @username)
					set @variableString = '@username = '+@username+', @newPassword = '+@newPassword+', @emailToAddress = '+@emailToAddress
					exec usp_insertAppLog 'usp_autoPasswordChange', @variableString, 'Sending player notification mail'	

					--exec usp_createEmailAccountProfile @emailPassword, @emailusername, @emailToAddress, @emailFromAddress

					--send mail notification of password change
					set @playerSubject = 'Password reset for Casino player: '+@username
					set @playerBody = 'Your new password is '+@newPassword
					exec msdb.dbo.sp_send_dbmail 
										@profile_name = 'Casino Support Team',
										@recipients=@emailToAddress,
										@subject=@playerSubject,
										@body=@playerBody
				break
				end
		END
			exec usp_insertAppLog 'usp_autoPasswordChange', @variableString, 'End of usp_validate_playerDetails procedure'	
end 
go

--drop function udf_IsPasswordInPast

--select dbo.udf_IsPasswordInPast('avigail','11223rD')
--select dbo.udf_IsPasswordInPast('avigail','10XYlm')
-- ======================================================================
-- Procedure to check if new password was used in the past or is 
-- one of the familiar passwords
-- ======================================================================

create or alter function udf_IsPasswordInPast ( @username usernameDt, @newPassword playerPasswordDt) returns char
as
/*
select dbo.udf_IsPasswordInPast
(
            'Avigail', 
		   'c5676vSi9B'
)
*/
begin
		if (((select count(p.playerPassword) from Admin.utbl_playersHistory ph 
												inner join Admin.utbl_players p 
												on p.UserName = ph.UserName
				where p.playerPassword = @newPassword COLLATE SQL_Latin1_General_CP1_CS_AS 
				or ph.playerPassword = @newPassword COLLATE SQL_Latin1_General_CP1_CS_AS 
				and p.username = @username)>0) OR
			((select count(EXTPassword) from REFERENCE.utbl_GitPasswords 
				where EXTPassword = @newPassword COLLATE SQL_Latin1_General_CP1_CS_AS)>0))
			begin
				return ('Y')
			end
	return ('N')
end

--drop function udf_passwordSyntaxValid

--select dbo.udf_passwordSyntaxValid ('Avigailassword9', 'avigail')
-- ======================================================================
-- Procedure to check if the new password syntax is valid
-- ======================================================================
GO

create or alter function udf_PasswordSyntaxValid (@playerPassword [playerPasswordDt],  @username usernameDt) returns char
as
/*
select dbo.udf_PasswordSyntaxValid
(
           'Ad9sdsdxr#$%%', 
		   'Avigail!@#'

)
*/
begin
	declare @strongPassLength		int

		set @strongPassLength = (select cast(companyValue as int) from Admin.utbl_CompanyDefinitions where companyKey = 'strongPassLength')

		if (len(@playerPassword) >= @strongPassLength 
			and (PATINDEX(N'%[ABCDEFGHIJKLMNOPQRSTUVWXYZ]%' , 
									@playerPassword collate SQL_Latin1_General_CP1_CS_AS)> 0)
			and (PATINDEX(N'%[abcdefghijklmnopqrstuvwxyz]%' , 
										@PlayerPassword COLLATE SQL_Latin1_General_CP1_CS_AS)> 0)
			and (@playerPassword like '%[0-9]%' )
			and (@playerPassword not like N'%password%')
			and (@playerPassword not like N'%p%assword%')
			and (@playerPassword not like N'%pa%ssword%')
			and (@playerPassword not like N'%pas%sword%')
			and (@playerPassword not like N'%pass%word%')
			and (@playerPassword not like N'%passw%ord%')
			and (@playerPassword not like N'%passwo%rd%')
			and (@playerPassword not like N'%passwor%d%')
			and (@playerPassword not like @username))
			begin
				return ('Y');
			end
	return ('N');
end;

go

sp_configure 'clr enabled' , 1
GO
	reconfigure
	go

-- ======================================================================
-- Procedure to check if the new password syntax is valid according
-- to additional external customer requests
-- ======================================================================
--DROP function udf_PasswordExtValid
create or alter function udf_PasswordExtValid (@playerPassword playerPasswordDt) 
returns char
as
/*
select dbo.udf_PasswordExtValid
(
           'Avalasord9'		   
)
*/
begin
	declare 
	@isExPasswordValid			varchar(1)

	set @isExPasswordValid = (select dbo.PasswordKey (@playerPassword))

	if @isExPasswordValid = '1'
		begin
			return 'Y'
		end
	else
		begin
			return 'N'
		end
	return ''
end

go
sp_configure 'clr enabled' , 0
go
reconfigure

--drop proc usp_lobby

--exec usp_lobby 'avigail7', 'game ground' 
--in the Lobby GUI Screen.
--send player to games/cashier/admin
-- ======================================================================
-- Procedure to check player request when entering lobby
-- player can choose between games/cashier/admin
-- ======================================================================
GO
create or alter proc usp_lobby @username usernameDt, @action nvarchar(100)
as
/*
exec usp_lobby
           @username			= 'elaine', 
		   --@action				= 'game ground'
		   @action				='cashier'
*/

begin
	DECLARE @variableString nvarchar(500)

	set @variableString = '@username = '+@username+', @action = '+@action

	exec usp_insertAppLog 'usp_lobby', @variableString, 'Start of usp_lobby procedure.'	
	
	--check if player logged in
	if ((select isConnected from Admin.utbl_players where username=@username)='N')
		begin
			exec usp_insertAppLog 'usp_lobby', @variableString, 'Player is not logged in. Exiting'
			print 'Player is not logged in. Exiting'
			return	
		end

	if (@action='game ground') 
		begin
			exec usp_insertAppLog 'usp_lobby', @variableString, 'Before sending to game ground.'	
			print 'show game ground GUI screen'
--**********for testing begin
			exec usp_gameGround @username, 50, 'BlackJack'
--**********for testing end
		end
	else if (@action='cashier') 
		begin
			exec usp_insertAppLog 'usp_lobby', @variableString, 'Before sending to Cashier.'	
			print 'show Cashier GUI screen'
--**********for testing begin
			exec usp_cashier @username, 'Deposit'
--**********for testing end
		end
	else if (@action='administration office') 
		begin
			exec usp_insertAppLog 'usp_lobby', @variableString, 'Before sending to administration office.'	
			print 'show Administration Office GUI Screen'
--**********for testing begin
			exec usp_admin 'Avigail', 'passwordChange', '', '', '', '', '', '', '','avi9B'
--**********for testing end
		end
	else return
end
go

--drop proc usp_admin

--exec usp_admin 'Avigail', 'PersonalDetailsChange', 'barja@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'bent', 'Oranit', 'Israel', 'F',''
--exec usp_admin 'Avigail', 'PersonalDetailsChange', 'avi@gmail.com', '2000-03-27 12:20:07.420', 'avigail', 'bent', 'Oranit', 'Israel', 'M',''
--exec usp_admin 'Avigail', 'passwordChange', '', '', '', '', '', '', '','c5676vSi9B'

--Administration Office GUI Screen send output if PersonalDetailsChange or passwordChange
--if PersonalDetailsChange gets input from Personal Details Change GUI Screen 
--if passwordChange gets input from Password Change GUI Screen 
-- ======================================================================
-- Procedure to check player request when in Administration Office
-- if to change personal details or password
-- ======================================================================

create or alter proc usp_admin @username usernameDt, @choice nvarchar(100), @email emailAddressDt, @birthDate birthDateDt,
	@firstName firstNameDt, @lastName lastNameDt, @playerAddress nvarchar(60), 
	@country countryDt,  @gender genderDt, @newPassword NVARCHAR(50)
as
/*
exec usp_admin
           @username			= 'Avigail', 
		   @choice				= 'PersonalDetailsChange',
		   @email				= 'avi@gmail.com',
		   @birthdate			= '2000-03-27 12:20:07.420', 
		   @firstName			= 'avigail', 
		   @lastName			= 'bent', 
		   @playerAddress		= 'Dragot 4, Oranit',  
		   @country				= 'Israel', 
		   @gender				= 'F', 
		   @newPassword			= '11dfg3rD'  		   
*/

begin
	declare
	@newEmail				emailAddressDt, 
	@newBirthDate			birthDateDt,  
	@password				playerPasswordDt,
	@newFirstName			firstNameDt, 
	@newLastName			lastNameDt, 
	@newPlayerAddress		nvarchar(60), 
	@newCountry				countryDt,  
	@newGender				genderDt, 
	@variableString			nvarchar(500),
	@newLineChar AS CHAR(2) = CHAR(13) + CHAR(10)					
	
	set @variableString = '@username = '+@username+', @choice = '+@choice+', @email = '+@email+', @birthDate = '+(select cast(@birthDate as varchar(10)))+
						  ', @firstName = '+@firstName+', @lastName = '+@lastName+', @playerAddress = '+@playerAddress+
						  ', @country = '+@country+', @gender = '+@gender+', @newPassword = '+@newPassword

	exec usp_insertAppLog 'usp_admin', @variableString, 'Start of usp_admin procedure.'	

	--check if player logged in
	if ((select isConnected from Admin.utbl_players where username=@username)='N')
		begin
			exec usp_insertAppLog 'usp_admin', @variableString, 'Player is not logged in. Exiting'
			print 'Player is not logged in. Exiting'
			return	
		end

	set @password = (select playerPassword from Admin.utbl_players where username = @username)

	if (@choice = 'PersonalDetailsChange') 
		begin
			--update only what was changed
			if (@email <> (select emailAddress from Admin.utbl_players where username = @username)) 
				begin
					set @newEmail = @email
					set @variableString = '@username = '+@username+', @choice = '+@choice+', @newEmail = '+@newEmail
					exec usp_insertAppLog 'usp_admin', @variableString, 'Email was changed. Before sending to usp_validate_playerDetails procedure.'
				end
			if (@birthDate <> (select birthDate from Admin.utbl_players where username = @username))  
				begin
					set @newBirthDate = @birthDate
					set @variableString = '@username = '+@username+', @choice = '+@choice+', @newEmail = '+@newEmail
					exec usp_insertAppLog 'usp_admin', @variableString, 'BirthDate was changed. Before sending to usp_validate_playerDetails procedure.'
				end
			if (@FirstName <> (select FirstName from Admin.utbl_players where username = @username)) 
				begin
					set @newFirstName = @firstName
					set @variableString = '@username = '+@username+', @choice = '+@choice+', @newFirstName = '+@newFirstName
					exec usp_insertAppLog 'usp_admin', @variableString, 'FirstName was changed. Before sending to usp_validate_playerDetails procedure.'
				end
			if (@lastName <> (select lastName from Admin.utbl_players where username = @username)) 
				begin
					set @newLastName = @lastName 
					set @variableString = '@username = '+@username+', @choice = '+@choice+', @newLastName = '+@newLastName
					exec usp_insertAppLog 'usp_admin', @variableString, 'LastName was changed. Before sending to usp_validate_playerDetails procedure.'
				end
			if (@playerAddress <> (select playerAddress from Admin.utbl_players where username = @username)) 
				begin
					set @newPlayerAddress = @playerAddress 
					set @variableString = '@username = '+@username+', @choice = '+@choice+', @newPlayerAddress = '+@newPlayerAddress
					exec usp_insertAppLog 'usp_admin', @variableString, 'PlayerAddress was changed. Before sending to usp_validate_playerDetails procedure.'
				end
			if (@country <> (select country from Admin.utbl_players where username = @username)) 
				begin
					set @newCountry = @country
					set @variableString = '@username = '+@username+', @choice = '+@choice+', @newCountry = '+@newCountry
					exec usp_insertAppLog 'usp_admin', @variableString, 'Country was changed. Before sending to usp_validate_playerDetails procedure.'
				end
			if (@Gender <> (select gender from Admin.utbl_players where username = @username)) 
				begin
					set @newGender = @gender
					set @variableString = '@username = '+@username+', @choice = '+@choice+',@newGender = '+@newGender
					exec usp_insertAppLog 'usp_admin', @variableString, 'Gender was changed. Before sending to usp_validate_playerDetails procedure.'
				end

			set @variableString = '@username = '+@username+', @choice = '+@choice+', @newEmail = '+@newEmail+', @newbirthdate = '+(select cast(@newbirthdate as varchar(10)))+
						  ', @newFirstName = '+@newFirstName+', @newLastName = '+@newLastName+', @newPlayerAddress = '+@newPlayerAddress+
						  ', @newCountry = '+@newCountry+', @newGender = '+@newGender
			exec usp_insertAppLog 'usp_admin', @variableString, 'Before sending to usp_validate_playerDetails procedure.'	

			exec usp_validate_playerDetails
			   @username, @password, @email, @birthdate, @firstName, @lastName, 
				   @playerAddress, @country, @gender, @choice
		end
	if (@choice = 'passwordChange')
		begin
			set @variableString = '@username = '+@username+', @choice = '+@choice+',  @newPassword = '+@newPassword
			exec usp_insertAppLog 'usp_admin', @variableString, 'Checking validation of new password. Sending to udf_IsPasswordInPast and udf_PasswordSyntaxValid'	

			--check validation of password
			if (((select dbo.udf_IsPasswordInPast(@username,@newPassword)) = 'N') and 
				((select dbo.udf_PasswordSyntaxValid (@newPassword,  @username)) = 'Y') and
				((select dbo.udf_PasswordExtValid (@newPassword)) = 'Y'))
				begin
					exec usp_insertAppLog 'usp_admin', @variableString, 'Password is valid. Updating Admin.utbl_players table.'	
					--update player with new password
					OPEN SYMMETRIC KEY Password_key  
							DECRYPTION BY CERTIFICATE Password_certificate; 
					update Admin.utbl_players set playerPassword = @newPassword where username = @username
					CLOSE SYMMETRIC KEY Password_key
				end
			else
				begin
					exec usp_insertAppLog 'usp_admin', @variableString, 'Password has failed validation and is invalid.'	
					print 'The password you requested is not strong, has been used by you in the past or is frequently used. '+@NewLineChar+
						'Please enter a new password with: '+@newLineChar+
						'at least 5 characters long, '+@newLineChar+
						'with a combination of at least 1 small letter, '+@newLineChar+
						'1 capital letter, 1 digit'+@newLineChar+
						'and not like the word password.'
				end
		end
	else return
end
go

--drop proc usp_gameGround
--called from the Game Ground GUI Screen 
-- ======================================================================
-- Procedure to check player request when in Game Ground
-- if to play blackjack or slotmachine
-- ======================================================================

create or alter proc usp_gameGround
           @username usernameDt, @gameRequest nvarchar(20)
as
/*
exec usp_gameGround
           @username			= 'eoin', 
		   @gameRequest			= 'SlotMachine'	   
*/
begin
	declare @variableString nvarchar(500)

	set @variableString = '@username = '+@username+', @gameRequest= '+@gameRequest
	exec usp_insertAppLog 'usp_gameGround', @variableString, 'Start of usp_gameGround procedure.'	

	--check if player logged in
	if ((select isConnected from Admin.utbl_players where username=@username)='N')
		begin
			exec usp_insertAppLog 'usp_gameGround', @variableString, 'Player is not logged in. Exiting'
			print 'Player is not logged in. Exiting'
			return	
		end

	--check what game to Play and send to game
	if(@gameRequest='BlackJack')
		begin
			exec usp_insertAppLog 'usp_gameRequest', @variableString, 'Player has chosen the blackJack game.'	
			--test start
			exec usp_blackjack @username, 10, 4
			--test end
		end
	else if (@gameRequest='SlotMachine')
		begin	
			exec usp_insertAppLog 'usp_gameRequest', @variableString, 'Player has chosen the slotMachine game.'	
			--test start
			exec usp_SlotMachine  @username, 10
			--test end
		end
	else print 'Game not valid, please choose BlackJack or SlotMachine';
end
go


--exec usp_blackjack 'Avigail', 5, 4
--exec usp_blackjack 'Avigail', 30, 2
--drop proc usp_blackjack
--blackjack game
--BlackJack GUI Screen called from the Game Forum GUI Screen 
--after checking bet amount validation and starts game according to inputted game request 
-- ======================================================================
-- Procedure to play the blackjack game
-- ======================================================================

create or alter proc usp_blackjack
           @username usernameDt, @BetAmnt float, @numCards int
as
/*
exec usp_blackJack
           @username			= 'Abhoy1', 
		   @BetAmnt				= 6,
		   @numCards			= 2 		   
*/
begin
    declare 
	@betAmountValid				char,
	@counter					int					=	0,
	@dealerCardTotal			int					=	0,
	@dealerCurrentCard			int					=	0,
	@dealerCurrentCardID		int					=	0,
	@playerCardTotal			int					=	0,
	@playerCurrentCard			int					=	0,
	@playerCurrentCardID		int					=	0,
	@isWin						char,	
	@transactionType			transactionTypeDt,
	@gameName					gameNameDt			=	'blackjack',
	@currentBankRoll			int,
	@transactionIdOutput		int,
	@transactionId				int,

	@variableString				nvarchar(500)

	set @variableString = '@username = '+@username+', @numCards = '+(select cast(@numCards as varchar(10)))+
						  ', @BetAmnt = '+(select CONVERT (VARCHAR(50), @BetAmnt,3))

	exec usp_insertAppLog 'usp_blackJack', @variableString, 'Start of blackJack game. Checking if bet amount <= current bankroll '

	--check if player logged in
	if ((select isConnected from Admin.utbl_players where username=@username)='N')
		begin
			exec usp_insertAppLog 'usp_blackJack', @variableString, 'Player is not logged in. Exiting'
			print 'Player is not logged in. Exiting'
			return	
		end

	--check if bet amount <= current bankroll
	set @currentBankRoll= (select [Admin].[udf_Bankroll](@username))
	if(@BetAmnt <= @currentBankRoll)
		begin	
			exec usp_insertAppLog 'usp_blackJack', @variableString, 'Inserting bet to utbl_bankroll table'
			set @transactionType = 'Bet'
			exec usp_insertTransactions @username, @BetAmnt, @transactionType, @transactionIdOutput output
			set @transactionId = (SELECT @transactionIdOutput)
			exec udf_updateGame @username, @isWin, @gameName, @transactionId

			--populate card table
			exec usp_insertAppLog 'usp_blackJack', @variableString, 'Calling on usp_CardTableFiller to fill card table'
			exec usp_CardTableFiller

			--get player cards
			WHILE @counter < @numCards 
			BEGIN
				SET @counter += 1

				-- Get next card id as random
				set @playerCurrentCardID = (SELECT TOP 1 id FROM Games.utbl_cardtable ORDER BY newid())

				--select from Games.utbl_CardTable the CardNum where id = random number between 1 and 53
				set @playerCurrentCard = (select cardnum
										  from Games.utbl_cardtable	
										  where id = @playerCurrentCardID)

				--remove card from table so can't be used again
				delete from Games.utbl_cardtable
				where id = @playerCurrentCardID

				-- get total sum of cards
				set @playerCardTotal = @playerCardTotal+@playerCurrentCard 
			END
			print 'get total sum of cards'
			exec usp_insertAppLog 'usp_blackJack', @variableString, 'After sum of player cards in blackJack game'	

			--if sum of player cards>21, player looses, end of game
			if (@playerCardTotal > 21) 
				begin
					set @isWin = 'N'
					set @transactionType = 'Loss'
					exec usp_insertTransactions @username, @BetAmnt, @transactionType, @transactionIdOutput output
					set @transactionId = (SELECT @transactionIdOutput)
					exec udf_updateGame @username, @isWin, @gameName, @transactionId
					print 'Player cards exceed 21, player looses'  
					return; 
					exec usp_insertAppLog 'usp_blackJack', @variableString, 'Sum for player cards is more than 21 in blackJack game. Player lost.'	
				end

			WHILE (@dealerCardTotal<@playerCardTotal and @dealerCardTotal<21 )
			begin
				if (@dealerCardTotal=@playerCardTotal)
					begin
						set @isWin = 'N'
						set @transactionType = 'Loss'
						exec usp_insertTransactions @username, @BetAmnt, @transactionType, @transactionIdOutput output
						set @transactionId = (SELECT @transactionIdOutput)
						exec udf_updateGame @username, @isWin, @gameName, @transactionId
						print 'Dealer has more than Player. Player looses'
						exec usp_insertAppLog 'usp_blackJack', @variableString, 'Sum for player cards equal to dealer cards in blackJack game. Player lost.'	
						return; 
					end
				--get dealer cards
				set @dealerCurrentCardID = (SELECT TOP 1 id FROM Games.utbl_cardtable ORDER BY newid())--cast(abs(rand()*(@MaxBound-1)+1)as int)

				--select the CardNum from Games.utbl_CardTable where id = random
				set @dealerCurrentCard = (select cardnum
											from Games.utbl_cardtable	
											where id = @DealerCurrentCardID)
				--remove card from table so can't be used again
				delete from Games.utbl_cardtable
				where id = @dealerCurrentCardID

				-- get total sum of cards
				set @dealerCardTotal = @dealerCardTotal+@dealerCurrentCard 

				--if sumdealer cards>21 and @PlayerCardTotal<=21, player wins, end of game 
				if (@dealerCardTotal>21) 
				begin
					set @isWin = 'Y'
					set @transactionType = 'Win'
					--if wins, player gets bet amount*2 added on CurrentBankRoll from last transaction and WinAmt
					set @BetAmnt = @BetAmnt + @BetAmnt
					exec usp_insertTransactions	@username, @BetAmnt, @transactionType, @transactionIdOutput output
					set @transactionId = (SELECT @transactionIdOutput)
					exec udf_updateGame @username, @isWin, @gameName, @transactionId
					print 'Player wins'
					exec usp_insertAppLog 'usp_blackJack', @variableString, 'Sum for player cards is lower than 21 and dealer cards is more in blackJack game. Player won.'	
					return; 
				end

				--if sumplayer cards<sumdealer player looses, end of game 
				if (@dealerCardTotal>@playerCardTotal) 
				begin
					set @IsWin = 'N'
					set @transactionId = (SELECT @transactionIdOutput)
					exec udf_updateGame @username, @isWin, @gameName, @transactionId
					set @transactionType = 'Loss'
					exec usp_insertTransactions @username, @BetAmnt, @transactionType, @transactionIdOutput output
					print 'Dealer has more than Player. Player looses'
					exec usp_insertAppLog 'usp_blackJack', @variableString, 'Sum for dealer cards is lower than 21 and higher than player cards in blackJack game. Player lost.'	
					return; 
				end
			END 
		end
	else
		begin
			print 'Bet amount is higher than current bankroll. Player cannot play'
			set @variableString = '@username = '+@username+', @numCards = '+(select cast(@numCards as varchar(10)))
			exec usp_insertAppLog 'usp_blackJack', @variableString, 'Bet amount is higher than current bankroll. Player cannot play'	
		end
end

go


--drop proc usp_slotMachine

--exec usp_slotMachine 'Avigail', 10

--slot machine game
--Slot Machine GUI Screen called from the Game Forum GUI Screen 
--after checking bet amount validation and starts game according to inputted game request 
-- ======================================================================
-- Procedure to play the slotmachine game
-- ======================================================================

create or alter proc usp_slotMachine
           @username usernameDt, @BetAmnt transactionAmountDt
as
/*
exec usp_slotMachine
           @username			= 'Abhoy1'	 ,  
		   @BetAmnt			=8
*/
begin
    declare 
	@isWin					nvarchar(1),
	@wheel1Symbol			nvarchar(1),
	@wheel2Symbol			nvarchar(20),
	@wheel3Symbol			nvarchar(20),
	@transactionType		transactionTypeDt,
	@gameName				gameNameDt			 = 'slotMachine',
	@currentBankRoll		float,
	@transactionId			int,
	@transactionIdOutput	int,
	@variableString			nvarchar(500)

	set @variableString = '@username = '+@username+', @BetAmnt = '+ (select CONVERT (VARCHAR(50), @BetAmnt,3))

	exec usp_insertAppLog 'usp_slotMachine', @variableString, 'Start of SlotMachine game. Checking if bet amount <= current bankroll '

	--check if player logged in
	if ((select isConnected from Admin.utbl_players where username=@username)='N')
		begin
			exec usp_insertAppLog 'usp_slotMachine', @variableString, 'Player is not logged in. Exiting'
			print 'Player is not logged in. Exiting'
			return	
		end

	--check if bet amount <= current bankroll
	set @currentBankRoll= (select [Admin].[udf_Bankroll](@username))
	if(@BetAmnt <= @currentBankRoll)
		begin	
			exec usp_insertAppLog 'usp_slotMachine', @variableString, 'Inserting bet to utbl_bankroll table'
			set @transactionType = 'Bet'
			exec usp_insertTransactions	@username, @BetAmnt, @transactionType, @transactionIdOutput output
			set @transactionId = (SELECT @transactionIdOutput)
			--get symbols
			set @wheel1Symbol = (SELECT TOP 1 Symbol FROM Reference.utbl_symboltable ORDER BY newid())
			set @wheel2Symbol = (SELECT TOP 1 Symbol FROM Reference.utbl_symboltable ORDER BY newid())
			set @wheel3Symbol = (SELECT TOP 1 Symbol FROM Reference.utbl_symboltable ORDER BY newid())

			--check if symbols are equal
			exec usp_insertAppLog 'usp_slotMachine', @variableString, 'Checking symbols if win/loose'
			if (@wheel1Symbol = @wheel2Symbol and @wheel1Symbol = @wheel3Symbol) 
				begin
					set @isWin = 'Y'
					set @variableString = '@username = '+@username+', @isWin = '+@isWin
					exec usp_insertAppLog 'usp_slotMachine', @variableString, 'There is a win for SlotMachine game. Inserting Win to utbl_bankroll table. End of game.'
					set @transactionType = 'Win'
					--if wins, player gets bet amount*2 added on CurrentBankRoll from last transaction and WinAmt
					set @BetAmnt = @BetAmnt + @BetAmnt
					exec usp_insertTransactions	@username, @BetAmnt, @transactionType, @transactionIdOutput output
					set @transactionId = (SELECT @transactionIdOutput)
					exec udf_updateGame @username, @isWin, @gameName, @transactionId
				end
			else 
				begin
					set @isWin = 'N'
					set @variableString = '@username = '+@username+',  @isWin = '+@isWin
					exec usp_insertAppLog 'usp_slotMachine', @variableString, 'There is a loss for SlotMachine game. Inserting bet to utbl_bankroll table. End of game.'
					set @transactionType = 'Loss'
					exec usp_insertTransactions @username, @BetAmnt, @transactionType, @transactionIdOutput output
					set @transactionId = (SELECT @transactionIdOutput)
					exec udf_updateGame @username, @isWin, @gameName, @transactionId
				end
			print @wheel1Symbol+', '+@wheel2Symbol+', '+@wheel3Symbol+'->  '+@isWin
		end
	else
		begin
			print 'you cannot play. bet amount > current bankroll '
			exec usp_insertAppLog 'usp_blackJack', @variableString, 'End of blackJack game.  bet amount > current bankroll '
		end
end

go

-- ======================================================================
-- Procedure to update utbl_Transactions table
-- ======================================================================
--DROP proc usp_insertTransactions
create or alter proc usp_insertTransactions 
		@username usernameDt, @transactionAmount transactionAmountDt, @transactionType transactionTypeDt,
		@transactionIdOutput int output
as
/*
exec usp_insertTransactions
           @username			= 'karina',
		   @transactionAmount	= 100,
		   @transactionType		= 'Deposit',	   
		   @transactionIdOutput =  1
*/
begin
    declare 
	@transDate				datetime,
	@variableString			nvarchar(500)

	set @transDate = getdate()
	set @variableString = '@username = '+@username+', @transactionAmount = '+ (select cast(@transactionAmount as varchar(10)))+', @transactionType = '
							+@transactionType+', @transDate = '+ (select cast(@transDate as varchar(10)))

	exec usp_insertAppLog 'usp_insertTransactions', @variableString, 'Before insert into utbl_transactions'
	
	insert into Admin.utbl_transactions (transactionType, transactionAmount, username, transDate)
			values (@transactionType, @transactionAmount, @username, @transDate)
	
	set @transactionIdOutput = (SELECT SCOPE_IDENTITY())
	exec usp_insertAppLog 'usp_insertTransactions', @variableString, 'After insert into utbl_transactions'

end
GO
--drop proc udf_updateGame

-- ======================================================================
-- Procedure to update the utbl_Games table 
-- ======================================================================

create or alter proc udf_updateGame
		@username usernameDt, @isWin nvarchar(1), @gameName gameNameDt, @transactionId int
as

begin
    declare 
	@gameDate				datetime,
	@winNum					int,
	@lossNum				int,
	@roundNum				int,
	@todayDay				int,
	@loginDay				int,
	@variableString			nvarchar(500)

	set @variableString = '@username = '+@username+', @isWin = '+ @isWin+', @gameName = '+@gameName

	exec usp_insertAppLog 'udf_updateGame', @variableString, 'Start of procedure. Checking if win or loss. '
	set @gameDate = (select getdate())
	set @todayDay = (select (datepart(dd,@gameDate)))
	set @loginDay = (select datepart(dd,logintime) from admin.utbl_players where username = @username)

	if ((select count(roundNum) from Games.utbl_Games where username = @username and gameName = @gameName) =0)
		begin
			set @roundNum = 1
		end
	--keep track of number of todays rounds
	else if ((@todayDay - @loginDay) =0)
		begin
			set @roundNum = (select max(roundNum) from Games.utbl_Games where username = @username and gameName = @gameName)
			set @roundNum = @roundNum +1
		end
	else
		begin
			set @roundNum = 1
		end


	if (@IsWin = 'Y')
		begin			
			if ((select count(*) from Games.utbl_Games where username = @username and gameName = @gameName) > 0)
				begin
					set @winNum = (select win from Games.utbl_Games where username = @username and gameName = @gameName)
					set @winNum = @winNum +1	
					update Games.utbl_Games
						set win = @winNum,
						transactionId = @transactionId,
						roundNum =@roundNum
						where username = @username 
						and gameName = @gameName
					set @variableString = '@username = '+@username+', @isWin = '+ @isWin+', @gameName = '+@gameName+', 
											@winNum = '+(select cast(@winNum as varchar(10)))
					exec usp_insertAppLog 'udf_updateGame', @variableString, 'Updating number of wins for user in utbl_Games. '
				end
			else
				begin
					set @winNum = 1
					set @lossNum = 0	
					insert into Games.utbl_Games (GameName, UserName, win, roundNum, GameDate, transactionId)
						values (@gameName, @username, @winNum,@roundNum, @gameDate, @transactionId)
					set @variableString = '@username = '+@username+', @isWin = '+ @isWin+', @gameName = '+@gameName+', @winNum = '+(select cast(@winNum as varchar(10)))
					exec usp_insertAppLog 'udf_updateGame', @variableString, 'Inserting win for user to utbl_Games. '
				end
		end
	 else if (@IsWin = 'N')
		begin
			
				set @winNum = 0	
				insert into Games.utbl_Games (GameName, UserName, win, roundNum, gameDate, transactionId)
					values (@gameName, @username, @winNum, @roundNum, @gameDate, @transactionId)
				set @variableString = '@username = '+@username+', @isWin = '+ @isWin+', @gameName = '+
										@gameName
				exec usp_insertAppLog 'udf_updateGame', @variableString, 'Inserting loss for user to utbl_Games. '
				
			end


end

go 
--drop proc usp_CardTableFiller

--exec usp_CardTableFiller
-- ======================================================================
-- Procedure to fill card table with 4 sets of 13 consecutive numbers
-- ======================================================================

create or alter proc usp_CardTableFiller
as
/*
exec usp_CardTableFiller		   
*/
begin
declare 
@counter			int				=	0, 
@numCards			int				=	4, 
@cardNum			int, 
@innerCounter		int				=	0, 
@innerNumCards		int				=	13,
@variableString		nvarchar(500)

set @variableString = '@innerNumCards = '+(select cast(@innerNumCards as varchar(10)))+', @numCards = '+(select cast(@numCards as varchar(10)))

exec usp_insertAppLog 'usp_CardTableFiller', @variableString, 'Before table fill'

--remove old cards from table
DBCC CHECKIDENT ('Games.utbl_CardTable', RESEED, 0)  
delete from Games.utbl_cardtable

--populate table with 4 sets of 13 consecutive numbers 
	WHILE @counter < @numCards BEGIN
		SET @counter += 1
		WHILE @innerCounter < @innerNumCards BEGIN
			set @innerCounter +=1
			-- insert card 
			set @cardNum = @innerCounter
			insert into Games.utbl_CardTable (cardNum) values (@cardNum)
		end
		set @innerCounter = 0
	end
exec usp_insertAppLog 'usp_CardTableFiller', @variableString, 'After table fill'
end

go

--drop proc usp_SymbolTableFiller
--exec usp_SymbolTableFiller



-- ======================================================================
-- Procedure to allow the player to logout
-- ======================================================================
--DROP proc usp_logout
create or alter proc usp_logout
           @username usernameDt
as
/*
exec usp_logout
           @userName			= 'Avigail'
*/
begin
	declare @variableString nvarchar(500)
	set @variableString = '@userName = '+@userName

	exec usp_insertAppLog 'usp_logout', @variableString, 'User requests to logout of the system. begin'

	--check if player logged in
	if ((select isConnected from Admin.utbl_players where username=@username)='N')
		begin
			exec usp_insertAppLog 'usp_logout', @variableString, 'Player is not logged in. Exiting'
			print 'Player is not logged in. Exiting'
			return	
		end

	--check player exists
	if ((select count(username) from Admin.utbl_players where username =@username) >0)
		begin
			exec usp_insertAppLog 'usp_logout', @variableString, 'User requests to logout of the system'
			--log player out of the system
			update Admin.utbl_players 
			set isConnected = 'N',
			numFails = 0, 
			loginTime = 0
			where username=@username
			exec usp_insertAppLog 'usp_logout', @variableString, 'User logged out of the system'
			print 'You have been successfully logged out of the system. Please login to access again'
			return
		end  
end 

go
-- ======================================================================
-- Procedure to retreive the players bankroll
-- bankroll = deposit - withdrawal - bet + win + bonus
-- ======================================================================
--DROP FUNCTION [Admin].[udf_Bankroll]
CREATE or alter FUNCTION [Admin].[udf_Bankroll]
(
	-- Add the parameters for the function here
	@UserName usernameDt
)
RETURNS FLOAT
AS
/*
select admin.udf_Bankroll
(
			'Afshin3'
 )
*/
BEGIN
	-- Declare the return variable here
	DECLARE @bankroll	FLOAT = 0,
			@deposit	FLOAT = 0,
			@withdrawal FLOAT = 0,
			@bet		FLOAT = 0,
			@win		FLOAT = 0,
			@bonus		FLOAT = 0

	-- Add the T-SQL statements to compute the return value here
	SELECT @deposit = ISNULL(SUM(transactionAmount),0) from [Admin].utbl_transactions where [transactionType] = 'Deposit' and username = @userName
	SELECT @withdrawal = ISNULL(SUM(transactionAmount),0) from [Admin].utbl_transactions where [transactionType] = 'Withdrawal' and username = @userName
	SELECT @bet = ISNULL(SUM(transactionAmount),0) from [Admin].utbl_transactions where [transactionType] = 'Bet' and username = @userName
	SELECT @win = ISNULL(SUM(transactionAmount),0) from [Admin].utbl_transactions where [transactionType] = 'Win' and username = @userName
	SELECT @bonus = ISNULL(SUM(transactionAmount),0) from [Admin].utbl_transactions where [transactionType] = 'Bonus' and username = @userName

	select @bankroll = @deposit - @withdrawal - @bet + @win + @bonus

	-- Return the result of the function
	
	RETURN (@Bankroll)

END
GO

-- ================================================
-- Procedure to insert deposit transaction
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS usp_MoneyDeposit
GO
CREATE PROCEDURE usp_MoneyDeposit
	@userName				usernameDt	, 
	@creditCardNumber		nvarchar(20)	,
	@expiryDate				nvarchar(10)	,
	@depositAmmount			transactionAmountDt			
AS

/*
exec usp_MoneyDeposit
           @userName				=	'Avigail',  
		   @creditCardNumber		=	'4563123498764567',
		   @expiryDate				=	'072023',
		   @depositAmmount			=	'100'
*/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Check parameters and ammount

    -- Validate Expiry Date
	DECLARE @Month		INT,
			@Year		INT,
			@variableString nvarchar(500)

	set @variableString = '@Month = '+(select cast(@Month as varchar(10)))+', @Year = '+ (select cast(@Year as varchar(10)))
	select @Month = CONVERT(INT,LEFT(@ExpiryDate,2))
	select @Year  = CONVERT(INT,RIGHT(@ExpiryDate,4))
	PRINT @Month
	PRINT @Year
	exec usp_insertAppLog 'usp_MoneyDeposit', @variableString, 'Deposit procedure - begin'

	--check if player logged in
	if ((select isConnected from Admin.utbl_players where username=@username)='N')
		begin
			exec usp_insertAppLog 'usp_MoneyDeposit', @variableString, 'Player is not logged in. Exiting'
			print 'Player is not logged in. Exiting'
			return	
		end


IF @userName is NULL or @creditCardNumber is NULL or @ExpiryDate is NULL or @depositAmmount is NULL or ISNUMERIC(@Month) = 0 or ISNUMERIC(@Year) = 0 or ISNUMERIC(@creditCardNumber) = 0
		BEGIN 
			PRINT 'Please insert correct parameters.'
			RETURN
		END
	ELSE
	-- Check that the deposit ammount is smaller than 1000
		BEGIN
			IF @depositAmmount>'1000'
				BEGIN
					PRINT 'Please insert deposit ammount smaller than 1000.'
					RETURN
				END
			ELSE
    -- Validate that exiry date is correct date
				BEGIN
					IF CONVERT(int,@Month) not between 1 and 12 or CONVERT(int,@Year) not between 1900 and 9999
						BEGIN 
							PRINT 'Invalid expiry date. Please check.'
							RETURN
						END
					ELSE
	-- Check that the card isn't expired
						BEGIN
							IF (@Month< MONTH(GETDATE()) and  @Year <= YEAR(GETDATE()))
								BEGIN
									PRINT 'Your credit card is expired. Please use another card.'
									RETURN
								END
							ELSE

	-- Insert deposit into Cretit Card and Transactions tables
								BEGIN
									OPEN SYMMETRIC KEY CreditCard_key  
										DECRYPTION BY CERTIFICATE CreditCards_certificate

									INSERT INTO [Admin].utbl_CreditCard
									VALUES
										(@userName, EncryptByKey(Key_GUID('CreditCard_key'), @creditCardNumber), @ExpiryDate)
									
									CLOSE SYMMETRIC KEY CreditCard_key 

									INSERT INTO [Admin].[utbl_Transactions]
									VALUES
										('Deposit', @depositAmmount, @userName,GETDATE())

									PRINT  'Your current balance ' + CONVERT(nvarchar, ADMIN.[udf_Bankroll](@userName))
								END
						END
				END
		END

		exec usp_insertAppLog 'usp_MoneyDeposit', @variableString, 'Deposit procedure - end'

END

GO

-- ======================================================================
-- Procedure that sends the player to the cashier
-- and does the appropriate action for players request for 
-- deposit or withdrawal
-- ======================================================================

--DROP PROCEDURE usp_Cashier
CREATE OR ALTER PROCEDURE usp_Cashier 
	@userName	usernameDt, 
	@action		transactionTypeDt
AS
/*
exec usp_Cashier
           @userName				=	'Avigail',  
		   @action					=	'Deposit'
*/
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @variableString nvarchar(500)
	set @variableString = '@userName = '+@userName+', @action = '+@action
	exec usp_insertAppLog 'usp_Cashier', @variableString, 'Cashier procedure. getting credit details - begin'

	--check if player logged in
	if ((select isConnected from Admin.utbl_players where username=@username)='N')
		begin
			exec usp_insertAppLog 'usp_Cashier', @variableString, 'Player is not logged in. Exiting'
			print 'Player is not logged in. Exiting'
			return	
		end

    -- Insert statements for procedure here
	IF  @action = 'Deposit'
		BEGIN
			exec usp_insertAppLog 'usp_Cashier', @variableString, 'Cashier procedure. getting credit details'
			PRINT 'Please insert credit card number, expiry date and deposit amount'
			DECLARE
				@creditCardNumber	nvarchar(20)	,
				@ExpiryDate			nvarchar(10)	,
				@depositAmmount		transactionAmountDt		
			--EXEC usp_MoneyDeposit @userName = @userName, @creditCardNumber = @creditCardNumber, @ExpiryDate = @ExpiryDate, @depositAmmount = @depositAmmount
		END
	ELSE
		BEGIN
			IF  @action = 'Withdrawal'
				BEGIN
					exec usp_insertAppLog 'usp_Cashier', @variableString, 'Cashier procedure. getting shipping details'
					PRINT 'Please insert shippingAddress and withdrawal amount'
					DECLARE
						@withdrawalAmmount		FLOAT			,
						@shippingAdress			NVARCHAR(500)
					--EXEC usp_MoneyWithdrawal @userName = @userName, @withdrawalAmmount = @withdrawalAmmount, @shippingAdress = @shippingAdress
				END
	exec usp_insertAppLog 'usp_Cashier', @variableString, 'Cashier procedure - end'
			
		END
END
GO

-- ======================================================================
-- Procedure that does the appropriate action for players request for 
-- withdrawal
-- ======================================================================

--DROP PROCEDURE IF EXISTS usp_MoneyWithdrawal
GO
CREATE OR ALTER PROCEDURE usp_MoneyWithdrawal
	-- Add the parameters for the stored procedure here
	@userName				usernameDt,
	@withdrawalAmount		transactionAmountDt	,
	@shippingAddress		NVARCHAR(500)
AS
/*
exec usp_MoneyWithdrawal
           @userName				=	'avigail',  
		   @withdrawalAmount		=	100,
		   @shippingAddress			=	'123 beni brak telaviv, UK'
*/
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @variableString nvarchar(500)
	set @variableString = '@userName = '+@userName
	exec usp_insertAppLog 'usp_MoneyWithdrawal', @variableString, 'MoneyWithdrawal procedure. Updateing bankroll - begin'

	--check if player logged in
	if ((select isConnected from Admin.utbl_players where username=@username)='N')
		begin
			exec usp_insertAppLog 'usp_MoneyWithdrawal', @variableString, 'Player is not logged in. Exiting'
			print 'Player is not logged in. Exiting'
			return	
		end

	-- Check that procedure received all parameters and they are correct
	IF @userName is NULL or @withdrawalAmount is NULL or @shippingAddress is NULL
		BEGIN 
			PRINT 'Please insert correct parameters.'
			RETURN
		END
	ELSE
	-- Check that the withdrawal amount is more than bankroll
		BEGIN
			IF @withdrawalAmount> admin.[udf_Bankroll](@userName)
				BEGIN
					PRINT  'Your current balance ' + CONVERT(nvarchar, admin.[udf_Bankroll](@userName)) + '  is too small. Try smaller ammount.'
					RETURN
				END
			ELSE
	-- If all the parameters are correct isert data to Transactions table and show the user current balance
				BEGIN
					INSERT INTO [Admin].[utbl_transactions]
					VALUES
						(@userName, @withdrawalAmount, 'Withdrawal', GETDATE())
					PRINT  'Thank you! Your current balance is ' + CONVERT(nvarchar, admin.[udf_Bankroll](@userName))
					PRINT  'The check will be sent to ' + @shippingAddress + '. Please inform our Support Team at support@casino.com if you didn''t receive the check in 5 post days.'  
				END
		END
		exec usp_insertAppLog 'usp_MoneyWithdrawal', @variableString, 'MoneyWithdrawal procedure. Updateing bankroll - end'

END
GO

-- ======================================================================
-- Procedure that sends a feedback email for players request for 
-- feedback
-- ======================================================================
--DROP PROC usp_Feedback
CREATE OR ALTER PROCEDURE usp_Feedback 
	-- Add the parameters for the stored procedure here
	@userName	usernameDt, 
	@feedback	nvarchar(max) = '',
	@subject	nvarchar(20)
AS
/*
exec usp_Feedback
           @userName					=	'Avigail',  
		   @feedback					=	'great service',
		   @subject						=	'FEEDBACK'
*/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE 
		@email				nvarchar(100),
		@recipientEmail		nvarchar(100),
		@variableString		nvarchar(500)
		
		set @variableString = '@userName = '+@userName
		exec usp_insertAppLog 'usp_Feedback', @variableString, 'In player feedback procedure. Sending mail - begin'

		--check if player logged in
		if ((select isConnected from Admin.utbl_players where username=@username)='N')
			begin
				exec usp_insertAppLog 'usp_Feedback', @variableString, 'Player is not logged in. Exiting'
				print 'Player is not logged in. Exiting'
				return	
			end

		-- Set players email
		SELECT @email = EmailAddress 
		FROM admin.utbl_Players
		where UserName = @userName

		select @recipientEmail = companyValue
		from admin.utbl_companyDefinitions
		where companyKey = 'adminMailAddress'
		-- Send email
		EXEC msdb.dbo.sp_send_dbmail
		--@profile_name = 'Public Profile', 
									@from_address= @email,
									@recipients = @recipientEmail, 
									@subject = @subject,
									@body = @feedback,
									@body_format = 'HTML',
									@query_no_truncate = 1,
									@attach_query_result_as_file = 0;

		exec usp_insertAppLog 'usp_Feedback', @variableString, 'In player feedback procedure. Sending mail - end'
END

/*
Deployment script for casino

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/
go
sp_configure 'clr enabled' , 1
go
reconfigure
go

EXEC sp_configure 'show advanced options', 1 
RECONFIGURE; 
EXEC sp_configure 'clr strict security', 0; 
RECONFIGURE;

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "casino"
:setvar DefaultFilePrefix "casino"
:setvar DefaultDataPath "D:\SQL server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "D:\SQL server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367)) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating [PasswordValidation]...';


GO
CREATE ASSEMBLY [PasswordValidation]
    AUTHORIZATION [dbo]
    FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C010300001BA75C0000000000000000E00002210B010B000006000000060000000000008E2500000020000000400000000000100020000000020000040000000000000006000000000000000080000000020000000000000300608500001000001000000000100000100000000000001000000000000000000000003C2500004F00000000400000D002000000000000000000000000000000000000006000000C000000042400001C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E7465787400000094050000002000000006000000020000000000000000000000000000200000602E72737263000000D0020000004000000004000000080000000000000000000000000000400000402E72656C6F6300000C0000000060000000020000000C000000000000000000000000000040000042000000000000000000000000000000007025000000000000480000000200050074200000900300000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000133001001000000001000011007201000070280500000A0A2B00062A1E02280600000A2A42534A4201000100000000000C00000076342E302E33303331390000000005006C00000030010000237E00009C0100007801000023537472696E6773000000001403000008000000235553001C0300001000000023475549440000002C0300006400000023426C6F620000000000000002000001471502000900000000FA2533001600000100000007000000020000000200000001000000060000000400000001000000010000000200000000000A00010000000000060046003F000A006E0059000600A60093000F00BA0000000600E900C90006000901C9000A0055013A0100000000010000000000010001000100100021000000050001000100502000000000960078000A0001006C20000000008618840011000200000001008A00190084001500290084001B0031008400110039008400110011006A0125000900840011002000230020002E000B0030002E00130039002E001B0042002B0004800000000000000000000000000000000027010000040000000000000000000000010036000000000004000000000000000000000001004D00000000000000003C4D6F64756C653E0050617373776F726456616C69646174696F6E2E646C6C0055736572446566696E656446756E6374696F6E73006D73636F726C69620053797374656D004F626A6563740053797374656D2E446174610053797374656D2E446174612E53716C54797065730053716C537472696E670050617373776F72644B6579002E63746F720070617373776F72640053797374656D2E446961676E6F73746963730044656275676761626C6541747472696275746500446562756767696E674D6F6465730053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300436F6D70696C6174696F6E52656C61786174696F6E734174747269627574650052756E74696D65436F6D7061746962696C6974794174747269627574650050617373776F726456616C69646174696F6E004D6963726F736F66742E53716C5365727665722E5365727665720053716C46756E6374696F6E417474726962757465006F705F496D706C6963697400000000033100000000006AD4BD3E84574141A354BF7DF51B4B3E0008B77A5C561934E08906000111091109032000010520010111110420010108040100000005000111090E04070111090801000701000000000801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F77730100000000000000001BA75C00000000020000001C010000202400002006000052534453584EE10DAD76C54492EC43A0B14FEF1901000000633A5C55736572735C61646D696E5C446F63756D656E74735C56697375616C2053747564696F20323031355C50726F6A656374735C50617373776F726456616C69646174696F6E5C50617373776F726456616C69646174696F6E5C6F626A5C44656275675C50617373776F726456616C69646174696F6E2E70646200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006425000000000000000000007E25000000200000000000000000000000000000000000000000000070250000000000000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF250020001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100100000001800008000000000000000000000000000000100010000003000008000000000000000000000000000000100000000004800000058400000740200000000000000000000740234000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE00000100000000000000000000000000000000003F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B004D4010000010053007400720069006E006700460069006C00650049006E0066006F000000B001000001003000300030003000300034006200300000002C0002000100460069006C0065004400650073006300720069007000740069006F006E000000000020000000300008000100460069006C006500560065007200730069006F006E000000000030002E0030002E0030002E003000000050001700010049006E007400650072006E0061006C004E0061006D0065000000500061007300730077006F0072006400560061006C00690064006100740069006F006E002E0064006C006C00000000002800020001004C006500670061006C0043006F0070007900720069006700680074000000200000005800170001004F0072006900670069006E0061006C00460069006C0065006E0061006D0065000000500061007300730077006F0072006400560061006C00690064006100740069006F006E002E0064006C006C0000000000340008000100500072006F006400750063007400560065007200730069006F006E00000030002E0030002E0030002E003000000038000800010041007300730065006D0062006C0079002000560065007200730069006F006E00000030002E0030002E0030002E00300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000C000000903500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;


GO
ALTER ASSEMBLY [PasswordValidation]
    DROP FILE ALL
    ADD FILE FROM 0x4D6963726F736F667420432F432B2B204D534620372E30300D0A1A4453000000000200000200000017000000740000000000000014000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3800E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0BCA3101380000000010000000100000000000000E00FFFF04000000FFFF03000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BCA3101380000000010000000100000000000000F00FFFF04000000FFFF0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000942E3101001BA75C01000000584EE10DAD76C54492EC43A0B14FEF1900000000000000000100000001000000000000000000000000000000DC51330100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BCA310138000000001000000010000000000000FFFFFFFF04000000FFFF030000000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BCA310138000000001000000010000000000000FFFFFFFF04000000FFFF030000000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F862513FC607D311905300C04FA302A1C4454B99E9E6D211903F00C04FA302A10B9D865A1166D311BD2A0000F80849BD60A66E40CF64824CB6F042D48172A799100000000000000061985951CA11199C099F45F368B94D5F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FEEFFEEF01000000D600000000633A5C55736572735C61646D696E5C446F63756D656E74735C56697375616C2053747564696F20323031355C50726F6A656374735C50617373776F726456616C69646174696F6E5C50617373776F726456616C69646174696F6E5C50617373776F72644B65792E63730000633A5C75736572735C61646D696E5C646F63756D656E74735C76697375616C2073747564696F20323031355C70726F6A656374735C70617373776F726476616C69646174696F6E5C70617373776F726476616C69646174696F6E5C70617373776F72646B65792E637300040000006B00000000000000010000006C00000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001BE23001800000000525281B8FEBD40101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000020000000100000001000000000000006C000000280000001BE2300120CE60A958000000010000006B0000006C0000006500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000036002A110000000020010000000000001000000000000000000000000100000600000000010000000050617373776F72644B6579000000001600031104000000EC0000001000000000000000010000000A0024115553797374656D00120024115553797374656D2E44617461000000001A0024115553797374656D2E446174612E53716C436C69656E7400001A0024115553797374656D2E446174612E53716C54797065730000001E002411554D6963726F736F66742E53716C5365727665722E536572766572001E00201100000000010000110000000000000400435324312430303030000000020006002E000404C93FEAC6B359D649BC250902BBABB460000000004D0044003200000004010000040000000C0000000100050002000600F20000003C000000000000000100010010000000000000000300000030000000000000000B000080010000000D0000800E0000000E000080050006000900140005000600F400000008000000010000000000000008000000000000001C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF1A092FF1100000000C0200001D000000010000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001A0025110000000004000000010050617373776F72644B65790000001600291100000000040000000100303630303030303100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000FFFFFFFF1A092FF10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF77093101010000000B00008E0C0005080D00000060000000200000002C00000078000000000000000000000016000000190000000000EEC00000000000000000FFFF000000000000FFFFFFFF00000000FFFF0000000000000000000000000A00240100000000000054000000010000002025FD04000000000000000055736572446566696E656446756E6374696F6E730037314141414545380000002DBA2EF101000000000000001000000000000000000000000000000000000000020002000D01000000000100FFFFFFFF00000000100000000802000000000000FFFFFFFF00000000FFFFFFFF010001000000010000000000633A5C55736572735C61646D696E5C446F63756D656E74735C56697375616C2053747564696F20323031355C50726F6A656374735C50617373776F726456616C69646174696F6E5C50617373776F726456616C69646174696F6E5C50617373776F72644B65792E6373000000FEEFFEEF010000000100000000010000000000000000000000FFFFFFFFFFFFFFFFFFFF0900FFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000942E3101001BA75C01000000584EE10DAD76C54492EC43A0B14FEF19970000002F4C696E6B496E666F002F6E616D6573002F7372632F686561646572626C6F636B002F7372632F66696C65732F633A5C75736572735C61646D696E5C646F63756D656E74735C76697375616C2073747564696F20323031355C70726F6A656374735C70617373776F726476616C69646174696F6E5C70617373776F726476616C69646174696F6E5C70617373776F72646B65792E6373000400000006000000010000003A0000000000000011000000070000000A000000060000000000000005000000220000000800000000000000DC51330100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E00000020000000F300000038000000930100003800000000000000FA000000800000005800000028000000840100002C0200002C0000003400000003000000120000000600000011000000070000000A0000000B00000008000000090000000C0000000D0000000E000000100000000F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 AS N'PasswordValidation.pdb';


GO
PRINT N'Creating [dbo].[PasswordKey]...';


GO
CREATE FUNCTION [dbo].[PasswordKey]
(@password NVARCHAR (MAX) NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [PasswordValidation].[UserDefinedFunctions].[PasswordKey]


GO
PRINT N'Update complete.';

go
sp_configure 'clr enabled' , 1
go
reconfigure
go
