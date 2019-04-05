
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