----- DB Creation  

USE master

IF EXISTS(select * from sys.databases where name='Casino')
DROP DATABASE [Casino]
GO
declare @dataPath nvarchar(max)
declare @data2Path nvarchar(max)
declare @logPath nvarchar(max)
declare @sql nvarchar(max)
			--CONTAINMENT = NONE
------/****INSERT @dataPath and @logPath variables****/-------

set @dataPath = 'D:\project\casino\Casino_Master.mdf'
set @data2Path = 'D:\project\casino\Casino2_Master.ndf'
set @logPath =	'D:\project\casino\Casino_Log.ldf'

set @sql = 'CREATE DATABASE [Casino]
			ON  PRIMARY 
			(NAME = Casino_Master, 
			FILENAME = '''+ @dataPath+''' , SIZE = 8192KB , 
			MAXSIZE = UNLIMITED, FILEGROWTH = 7168KB), 
			FILEGROUP [SECONDARY] 
			(NAME = Casino2_Master, 
			FILENAME = '''+ @data2Path+''' , SIZE = 8192KB , 
			MAXSIZE = UNLIMITED, FILEGROWTH = 7168KB)
			LOG ON 
			(NAME = Casino_Log, FILENAME = '''+@logPath+''' , SIZE = 5120KB , 
			MAXSIZE = 2048GB , FILEGROWTH = 3072KB)'
print @sql
exec (@sql)
GO

IF NOT EXISTS (SELECT name FROM sys.filegroups 
                WHERE is_default=1 AND name = N'PRIMARY') 
    ALTER DATABASE [Casino] MODIFY FILEGROUP [PRIMARY] DEFAULT

------ SSIS Catalog creation

declare @filePath	nvarchar(max),
		@SQL		nvarchar(max)

------/****INSERT @filePath variable****/-------

SET @filePath = 'D:\TCDBA\GitHub\TCDBA24\Projects\Final Project\'
SET @SQL = 'EXEC xp_cmdshell ''powershell -Command ' + @filePath + 'Create SSIS Catalog.ps1'''
EXEC (@SQL)
GO
------ DataTypes creation
USE [Casino]
GO
--datatype for password 
/****** Object:  UserDefinedDataType [playerPassword]    Script Date: 03-Apr-19 12:27:27 PM ******/
create TYPE [playerPasswordDt] FROM nvarchar(100)
GO
--datatype for username
/****** Object:  UserDefinedDataType [username]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [usernameDt] FROM [nvarchar](10) NOT NULL
GO
--datatype for  firstName
/****** Object:  UserDefinedDataType [firstName]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [firstNameDt] FROM [nvarchar](20) NOT NULL 
GO
--datatype for lastName
/****** Object:  UserDefinedDataType [lastName]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [lastNameDt] FROM [nvarchar](20) NOT NULL 
GO
--datatype for Address
/****** Object:  UserDefinedDataType [address]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [addressDt] FROM [nvarchar](100) NULL 
GO
--datatype for country
/****** Object:  UserDefinedDataType [country]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [countryDt] FROM [nvarchar](15) NOT NULL
GO
--datatype for emailAddress
/****** Object:  UserDefinedDataType [emailAddress]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [emailAddressDt] FROM [nvarchar](100) NOT NULL 
GO
--datatype for gender
/****** Object:  UserDefinedDataType [gender]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [genderDt] FROM [nchar](1) NULL
GO
--datatype for birthDate
/****** Object:  UserDefinedDataType [birthDate]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [birthDateDt] FROM datetime NOT NULL
GO
--datatype for transactionType
/****** Object:  UserDefinedDataType [transactionType]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [transactionTypeDt] FROM [nvarchar](10) NOT NULL
GO
--datatype for transactionAmount
/****** Object:  UserDefinedDataType [transactionAmount]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [transactionAmountDt] FROM [float] NOT NULL
GO
--datatype for gameName
/****** Object:  UserDefinedDataType [gameName]    Script Date: 03-Apr-19 12:27:27 PM ******/
CREATE TYPE [gameNameDt] FROM [nvarchar](15) NOT NULL
GO
SELECT * FROM sys.Types WHERE is_user_defined = 1
