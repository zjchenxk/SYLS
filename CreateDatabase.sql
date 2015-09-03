print '正在创建数据库...'
go

use master
go

if exists (select * from sys.server_principals where name = N'innosoft')
drop login innosoft
go

create login innosoft with password = 'ChenXK#88899899';
go

if exists (select name from sys.databases where name = N'InnoLS')
drop database InnoLS
go

create database InnoLS
go

use InnoLS
go

create user innosoft for login innosoft with default_schema = dbo
go

exec sp_addrolemember 'db_owner', 'innosoft'
go
