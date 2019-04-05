USE [casino]
GO

/****** Object:  UserDefinedFunction [dbo].[PasswordKey]    Script Date: 05/04/2019 12:39:33 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[PasswordKey](@password [nvarchar](max))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [PasswordValidation].[UserDefinedFunctions].[PasswordKey]
GO


