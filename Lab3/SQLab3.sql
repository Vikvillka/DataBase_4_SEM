CREATE DATABASE  BCH_MyBase on primary
(name = 'BCH_MyBase_mdf', filename = 'D:\4_SEM_LABS\BD\Lab3\BCH_MyBase_mdf.mdf',
size = 10240Kb,maxsize=UNLIMITED, filegrowth=1024Kb),
( name = 'BCH_MyBase_ndf', filename = 'D:\4_SEM_LABS\BD\Lab3\BCH_MyBase_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG
( name = 'BCH_MyBase_fg1_1', filename = 'D:\4_SEM_LABS\BD\Lab3\BCH_MyBase_fg1_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = 'BCH_MyBase_fg1_2', filename = 'D:\4_SEM_LABS\BD\Lab3\BCH_MyBase_fg1_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = 'BCH_MyBase_log', filename='D:\4_SEM_LABS\BD\Lab3\BCH_MyBase_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%)

   alter database BCH_MyBase add filegroup FGroup;

   create table Курсы
  (
	ID_курса int primary key,
	Количество_часов int not null,
	Оплата money not null
) ON FGroup; 