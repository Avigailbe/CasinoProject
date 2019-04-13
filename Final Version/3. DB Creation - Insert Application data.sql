use CASINO
/********* INSERT/CHANGE application deffinition and files path *********/
SELECT *
FROM REFERENCE.UTBL_COUNTRY
INSERT INTO reference.utbl_Country (COUNTRY)
VALUES ('England');
INSERT INTO reference.utbl_Country (COUNTRY)
VALUES ( 'France');
INSERT INTO reference.utbl_Country (COUNTRY)
VALUES ( 'Israel');
INSERT INTO reference.utbl_Country (COUNTRY)
VALUES ( 'USA');
INSERT INTO reference.utbl_Country (COUNTRY)
VALUES ( 'Ireland')

INSERT INTO [Reference].[utbl_Gender] ([Gender])
VALUES ('F');
INSERT INTO [Reference].[utbl_Gender] ([Gender])
VALUES ('M');
GO

-- ======================================================================
-- Procedure to fill symbol table with 6 unique symbols
-- ======================================================================

create or alter proc usp_SymbolTableFiller
as
/*
exec usp_SymbolTableFiller   
*/
begin
	declare 
	@counter		int		=	0, 
	@symbol			char(1), 
	@numSymbols		int		=	6

	--set isolation level
	set transaction isolation level read Committed

	--remove old symbols from table
	DBCC CHECKIDENT ('Reference.utbl_SymbolTable', RESEED, 0)  
	delete from Reference.utbl_SymbolTable
	--populate table with  6 unique symbols 
			WHILE @counter <  @numSymbols BEGIN
				set @counter +=1
				-- insert card 
				set @symbol = (select substring('#@%&*!', @counter, 1))

				insert into Reference.utbl_SymbolTable (symbol) values (@symbol)
			end
			set @counter = 0
end

exec usp_SymbolTableFiller

DBCC CHECKIDENT ('Security.utbl_CasinoManagers', RESEED, 0)
delete from [Security].[utbl_CasinoManagers]
INSERT INTO [Security].[utbl_CasinoManagers] (ManagerName, GameName)
VALUES ('Anne','slotMachine');
INSERT INTO [Security].[utbl_CasinoManagers] (ManagerName, GameName)
VALUES ( 'Avi','blackJack');
INSERT INTO [Security].[utbl_CasinoManagers] (ManagerName, GameName)
VALUES ('Karina','slotMachine');
INSERT INTO [Security].[utbl_CasinoManagers] (ManagerName, GameName)
VALUES ( 'Kari','blackJack');

GO
-- ======================================================================
-- Procedure to insert/update/delete utbl_CompanyDefinitions table 
-- as per request from the Company Management GUI Screen
-- ======================================================================

create or alter proc usp_CompanyDefinitions @action nvarchar(20), @companyKey nvarchar(20), @companyValue nvarchar(50)
as
/*
exec usp_CompanyDefinitions
           @action			= 'insert',
		   @companyKey		= 'welcomeBonus',
		   @companyValue	= '10'	   
*/
begin
	declare @variableString nvarchar(500)
	set @variableString = '@action = '+@action+', @companyKey = '+ @companyKey+', @companyValue = '+@companyValue
	--set isolation level
	set transaction isolation level read Committed

	exec usp_insertAppLog 'usp_CompanyDefinitions', @variableString, 'Before action'
	if (@action = 'insert')
		begin
			exec usp_insertAppLog 'usp_CompanyDefinitions', @variableString, 'Inserting into utbl_CompanyDefinitions table new key and value'
			if ((select count(companyKey) from Admin.utbl_CompanyDefinitions where companyKey = @companyKey)=0)
				begin
					insert into Admin.utbl_CompanyDefinitions (companyKey, companyValue)
					values (@companyKey, @companyValue);
				end
			else
				begin
					exec usp_insertAppLog 'usp_CompanyDefinitions', @variableString, 'Cannot insert into utbl_CompanyDefinitions table an existing key'
				end
		end
	if (@action = 'update')
		begin
			exec usp_insertAppLog 'usp_CompanyDefinitions', @variableString, 'Updating utbl_CompanyDefinitions table new value for key'
			update Admin.utbl_CompanyDefinitions
			set companyvalue = @companyValue
			where companyKey = @companyKey
		end
	if (@action = 'delete')
		begin
			exec usp_insertAppLog 'usp_CompanyDefinitions', @variableString, 'Deleting from utbl_CompanyDefinitions table for requested key'
			delete from Admin.utbl_CompanyDefinitions
			where companyKey = @companyKey
		end

	exec usp_insertAppLog 'usp_CompanyDefinitions', @variableString, 'After action'

end
go

--SELECT *
--  FROM msdb..syspolicy_management_facets
--  WHERE execution_mode % 2 = 1;

--select * from msdb.dbo.syspolicy_policy_execution_history_details_internal


--exec usp_logout  'Avigail', 'avi9B'
go

-- ======================================================================
-- Procedure to insert records to the utbl_ApplicationLog table
-- for the QA department to see detailed log messages
-- ======================================================================
--DROP proc usp_insertAppLog
create or alter proc usp_insertAppLog
           @objectName nvarchar(50), @variables nvarchar(500), @comments nvarchar(500)
as
/*
exec usp_insertAppLog
           @objectName			= 'usp_logout',
		   @variables			= '@userName = Avigail,  @playerPassword = avi9B',
		   @comments			= 'User logged out of the system'
*/
begin
	declare @execTime datetime = getdate()

	--log player out of the system
	insert into Admin.utbl_ApplicationLog (objectName, variables, comments, execTime)
	values (@objectName, @variables, @comments, @execTime)
end 

go

exec usp_CompanyDefinitions 'insert', 'welcomeBonus', '10'
exec usp_CompanyDefinitions 'insert', 'logonTimes', '5'
exec usp_CompanyDefinitions 'insert', 'betBonus', '50'
exec usp_CompanyDefinitions 'insert', 'MinimumAge', '18'
exec usp_CompanyDefinitions 'insert', 'maxDepositAmnt', '1000'
exec usp_CompanyDefinitions 'insert', 'minBetAmntForBonus', '1000'
exec usp_CompanyDefinitions 'insert', 'creditCardDigitAmnt', '16'
exec usp_CompanyDefinitions 'insert', 'adminMailAddress', 'bentovim.avigail@gmail.com'
exec usp_CompanyDefinitions 'insert', 'numConnectionsAlert', '100'
exec usp_CompanyDefinitions 'insert', 'numMinsNoLoginsAlert', '10'
exec usp_CompanyDefinitions 'insert', 'fullBackupDest', 'D:\CourseMaterials\casino\BackupFiles\Full.bak'
exec usp_CompanyDefinitions 'insert', 'fullBackupName', 'New Full backup Casino'
exec usp_CompanyDefinitions 'insert', 'fullBackupDescrb', 'New Daily Full backup for Casino DB'

exec usp_CompanyDefinitions 'insert', 'diffBackupDest', 'D:\CourseMaterials\casino\BackupFiles\Diff.bak'
exec usp_CompanyDefinitions 'insert', 'diffBackupName', 'New Diff backup Casino'
exec usp_CompanyDefinitions 'insert', 'diffBackupDescrb', 'New Diff backup for Casino DB'

exec usp_CompanyDefinitions 'insert', 'logBackupDest', 'D:\CourseMaterials\casino\BackupFiles\Log.bak'
exec usp_CompanyDefinitions 'insert', 'logBackupName', 'New Log backup Casino'
exec usp_CompanyDefinitions 'insert', 'logBackupDescrb', 'New Log backup for Casino DB'
exec usp_CompanyDefinitions 'insert', 'adminActivePlayer', '5'

exec usp_CompanyDefinitions 'insert', 'strongPassLength', '5'

--exec usp_CompanyDefinitions 'update', 'fullBackupDest', 'D:\CourseMaterials\casino\BackupFiles\Full.bak'
--exec usp_CompanyDefinitions 'update', 'diffBackupDest', 'D:\CourseMaterials\casino\BackupFiles\Diff.bak'
--exec usp_CompanyDefinitions 'update', 'logBackupDest', 'D:\CourseMaterials\casino\BackupFiles\Log.bak'

--for testing
--exec usp_CompanyDefinitions 'update', 'numConnectionsAlert', '1'
--exec usp_CompanyDefinitions 'update', 'numMinsNoLoginsAlert', '10'