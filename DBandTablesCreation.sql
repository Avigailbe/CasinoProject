/****** Object:  Database [Casino]    Script Date: 19-Mar-19 12:36:39 PM ******/
USE master
IF EXISTS(select * from sys.databases where name='Casino')
DROP DATABASE [Casino]
declare @dataPath nvarchar(max)
declare @logPath nvarchar(max)
declare @sql nvarchar(max)

set @dataPath = 'D:\CourseMaterials\eDate\eDate_new_Master.mdf'
set @logPath = 'D:\CourseMaterials\eDate\eDate_new_Log.ldf'

set @sql = 'CREATE DATABASE [Casino]
			CONTAINMENT = NONE
			ON  PRIMARY 
			(NAME = ''fgMaster'', 
			FILENAME = '''+ @dataPath+''' , SIZE = 8192KB , 
			MAXSIZE = UNLIMITED, FILEGROWTH = 7168KB) 
			LOG ON 
			(NAME = ''Fg_log_Log'', FILENAME = '''+@logPath+''' , SIZE = 5120KB , 
			MAXSIZE = 2048GB , FILEGROWTH = 3072KB)'
print @sql
exec (@sql)


USE [Casino]
GO

IF EXISTS (SELECT name FROM sys.schemas WHERE name = N'Reference')
   BEGIN
      PRINT 'Dropping the DB schema'
      DROP SCHEMA [Reference]
END
GO
PRINT '    Creating the Reference schema'
GO
CREATE SCHEMA [Reference] AUTHORIZATION [dbo]
GO

IF EXISTS (SELECT name FROM sys.schemas WHERE name = N'Games')
   BEGIN
      PRINT 'Dropping the Games schema'
      DROP SCHEMA [Games]
END
GO
PRINT '    Creating the Games schema'
GO
CREATE SCHEMA [Games] AUTHORIZATION [dbo]
GO

IF EXISTS (SELECT name FROM sys.schemas WHERE name = N'Admin')
   BEGIN
      PRINT 'Dropping the Admin schema'
      DROP SCHEMA [Admin]
END
GO
PRINT '    Creating the Admin schema'
GO
CREATE SCHEMA [Admin] AUTHORIZATION [dbo]
GO
/****** Object:  Table [dbo].[utbl_CardTable]    Script Date: 21-Mar-19 5:12:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [Games].[utbl_CardTable]
CREATE TABLE [Games].[utbl_CardTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CardNum] [int] NOT NULL
) ON [PRIMARY]
GO

USE [Casino]
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [Reference].[utbl_SymbolTable]
CREATE TABLE [Reference].[utbl_SymbolTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Symbol] [char] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[utbl_CompanyDefinitions]    Script Date: 21-Mar-19 5:12:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [Admin].[utbl_CompanyDefinitions]
CREATE TABLE [Admin].[utbl_CompanyDefinitions](
	[CompanyKey] [nvarchar](20) NOT NULL,
	[CompanyValue] [nvarchar] (100) NOT NULL,
 CONSTRAINT [PK_utbl_CompanyDefinitions] PRIMARY KEY CLUSTERED 
(
	[CompanyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [Casino]
GO

/****** Object:  Table [dbo].[utbl_Country]    Script Date: 21-Mar-19 5:12:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [Reference].[utbl_Country]
CREATE TABLE [Reference].[utbl_Country](
	[Country] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO

USE [Casino]
GO

/****** Object:  Table [dbo].[utbl_CreditCard]    Script Date: 21-Mar-19 5:12:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [Admin].[utbl_CreditCard]
CREATE TABLE [Admin].[utbl_CreditCard](
	[CreditCardNumber] [int] NOT NULL,
	[ExpiryDate] [datetime] NOT NULL,
 CONSTRAINT [PK_utbl_CreditCard] PRIMARY KEY CLUSTERED 
(
	[CreditCardNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [Casino]
GO

/****** Object:  Table [dbo].[utbl_Games]    Script Date: 21-Mar-19 5:12:45 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--DROP TABLE IF EXISTS [Games].[utbl_Games]
--CREATE TABLE [Games].[utbl_Games](
--	[ID] [int] IDENTITY(1,1) NOT NULL,
--	[GameName] [nvarchar](50) NOT NULL,
--	[UserName] usernameDt,
--	[BetAmnt] transactionAmountDt,
--	[NumWins] [int] NULL,
--	[NumLosses] [int] NULL,
--	[GameDate] [datetime] NULL,
-- CONSTRAINT [PK_utbl_Games] PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

SET ANSI_NULLS ON
GO

DROP SECURITY POLICY IF EXISTS GamesPolicyFilter
drop function IF EXISTS Security.udf_securitypredicate


ALTER TABLE [Games].[utbl_Games] SET ( SYSTEM_VERSIONING = OFF )
GO
DROP TABLE IF EXISTS [Games].[utbl_Games]
DROP TABLE IF EXISTS [Games].[utbl_GamesHistory]
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Games].[utbl_Games](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[gameName] [nvarchar](50) NOT NULL,
	[userName] usernameDt,
	[winNum] [int] NULL,
	[lossNum] [int] NULL,
	[roundNum] [int] NOT NULL,
	[gameDate] [datetime] NULL,
	[transactionId] [int] NOT NULL,
  CONSTRAINT ID_PK PRIMARY KEY (ID),
    ValidFrom datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo datetime2 GENERATED ALWAYS AS ROW END NOT NULL,
  PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)) 
  WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = Games.utbl_GamesHistory, 
  DATA_CONSISTENCY_CHECK = ON));
GO

USE [Casino]
GO

/****** Object:  Table [dbo].[utbl_Gender]    Script Date: 21-Mar-19 5:12:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [Reference].[utbl_Gender]
CREATE TABLE [Reference].[utbl_Gender](
	[Gender] [nchar](1) NOT NULL
) ON [PRIMARY]
GO

USE [Casino]
GO

--/****** Object:  Table [dbo].[utbl_transatioms]    Script Date: 21-Mar-19 5:13:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

USE [Casino]
GO

--/****** Object:  Table [Security].[utbl_CasinoManagers]    Script Date: 21-Mar-19 5:13:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS [Security].[utbl_CasinoManagers]
CREATE TABLE [Security].[utbl_CasinoManagers](
	[CasinoManagerID] [int] IDENTITY(1,1) NOT NULL,
	[ManagerName] [nvarchar](50) NOT NULL,
	[GameName] [nvarchar](20) NOT NULL
) ON [PRIMARY] 

USE [Casino]
GO

DROP TABLE IF EXISTS [Admin].[utbl_ApplicationLog]
CREATE TABLE [Admin].[utbl_ApplicationLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[objectName] [nvarchar](50) NOT NULL,
	[variables] [nvarchar](500) NULL,
	[comments] [nvarchar](500) NOT NULL,
	[execTime] [datetime]
) ON [PRIMARY] 

DROP TABLE IF EXISTS [Admin].[utbl_transactions]
CREATE TABLE [Admin].[utbl_transactions](
	[transactionId] [int] IDENTITY(1,1) NOT NULL,
	[transactionType] transactionTypeDt NOT NULL,
	[transactionAmount] transactionAmountDt NOT NULL,
	[username] usernameDt,
	[transDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[utbl_Players]    Script Date: 21-Mar-19 5:13:38 PM ******/
SET ANSI_NULLS ON
GO
ALTER TABLE [admin].[utbl_Players] SET ( SYSTEM_VERSIONING = OFF )
GO
DROP TABLE IF EXISTS [admin].[utbl_Players]
DROP TABLE IF EXISTS [admin].[utbl_PlayersHistory]
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [admin].[utbl_Players](
	[UserName] usernameDt,
	[PlayerPassword] playerPasswordDt,
	[FirstName] firstNameDt,
	[LastName] lastNameDt,
	[PlayerAddress] addressDt,
	[Country] countryDt,
	[EmailAddress] emailAddressDt,
	[Gender] genderDt,
	[BirthDate] birthDateDt,
	[NumFails] [int] NULL,
	[IsBlocked] [nchar](1) NULL,
	[LoginTime] [datetime] NULL,
	[IsConnected] [nchar](1) NULL,
  CONSTRAINT PLR_PK PRIMARY KEY (UserName),
    ValidFrom datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo datetime2 GENERATED ALWAYS AS ROW END NOT NULL,
  PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)) 
  WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = Admin.utbl_PlayersHistory, 
  DATA_CONSISTENCY_CHECK = ON));
GO

IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'Security' ) 
    EXEC('CREATE SCHEMA [Security] AUTHORIZATION [dbo]');
GO
select user_name()
go





----TEST
--CREATE USER Archer WITHOUT LOGIN
----GRANT SELECT ON Sales.Orders TO Archer		
--EXECUTE AS USER = 'Archer'								-- Run as Airi
--select user_name()
--select * from utbl_games
--select * from security.utbl_casinoManagers
--REVERT	