USE [Casino]
GO

CREATE DATABASE AUDIT SPECIFICATION [Audit_Data_Modification_On_All_Tables]
FOR SERVER AUDIT [DataModification_Security_Audit]
ADD (DELETE ON DATABASE::[Casino] BY [public]),
ADD (INSERT ON DATABASE::[Casino] BY [public]),
ADD (UPDATE ON DATABASE::[Casino] BY [public])
WITH (STATE = ON)
GO


