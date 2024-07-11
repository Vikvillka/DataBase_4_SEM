use UNIVERR

exec SP_HELPINDEX 'AUDITORIUM' 
exec SP_HELPINDEX 'AUDITORIUM_TYPE'
exec SP_HELPINDEX 'FACULTY'
exec SP_HELPINDEX 'GROUPS'
exec SP_HELPINDEX 'PROFESSION'
exec SP_HELPINDEX 'PROGRESS'
exec SP_HELPINDEX 'PULPIT'
exec SP_HELPINDEX 'STUDENT'
exec SP_HELPINDEX 'SUBJECT'
exec SP_HELPINDEX 'TEACHER'

CREATE TABLE #EX1
(	
	ID int identity(1,1),
	STRING varchar(13)
)

set nocount on
declare @I int = 0
while @I < 1000
begin
	insert #EX1
	values ('str ' + cast(@I as char))
	set @I += 1
end

--0.006

SELECT * FROM #EX1 WHERE ID BETWEEN 20 AND 60;

checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

create clustered index #EX1_CL on #EX1(ID asc)

-- 0,0033
drop index #EX1_CL on #EX1
drop table #EX1

--------------------ЗАДАНИЕ 2-----------------------

create table #EX2
(
	TKEY int, 
    ID int identity(1, 1),
    TF varchar(100)
);

set nocount on;
declare @iter int = 0;
while @iter < 15000
begin
	INSERT #EX2(TKEY, TF) values(floor(30000 * RAND()), replicate('строка ', 10));
	set @iter += 1;
end

-- без индексов 0.159
select count(*)[Количество строк] from #EX2;
select * from #EX2

--некластеризованный неуникальный составной индекс
CREATE index #EX2_NONCLU on #EX2(TKEY, ID)

checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

--этот индекс не применяется оптимизатором ни при фильтрации 
--ни при сортировке строк таблицы #EX2
SELECT * from  #EX2 where  TKEY > 1500 and ID < 4500;  
SELECT * from  #EX2 order by  TKEY, ID

-- некласетризированный составной 
-- индекс подключается при фиксированном значении
-- 0,15 без индекса, 0,0068 с индексом
select * from #EX2 where TKEY = 556 and ID > 3

drop index #EX2_NONCLU on #EX2
drop table #EX2

------------------- ЗАДАНИЕ 3-------------------
create table #EX3
(
	TKEY int, 
    ID int identity(1, 1),
    TF varchar(100)
);

set nocount on;
declare @iterat int = 0;
while @iterat < 20000
begin
	INSERT #EX3(TKEY, TF) values(floor(30000 * RAND()), replicate('строка ', 10));
	set @iterat += 1;
end

--  0,199
select ID, TKEY from #EX3 where TKEY > 15000

checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

--Некластеризованный индекс покрытия 
--  0,03
create index #EX3_TKEY_ID on #EX3(TKEY) include (ID)

drop index #EX3_TKEY_ID on #EX3
drop table #EX3

------------------- ЗАДАНИЕ 4 -------------------

create table #EX4
(
	TKEY int, 
    ID int identity(1, 1),
    TF varchar(50)
);

set nocount on;
declare @it int = 0;
while @it < 15000
begin
	INSERT #EX4(TKEY, TF) values(floor(30000 * RAND()), replicate('строка ', 5));
	set @it += 1;
end

-- некластеризированный фильтруемный индекс используется
-- при фильтрации в секции where ..без индекса везде 0,1
select TKEY from #EX4 where TKEY between 5000 and 19999 
select TKEY from #EX4 where TKEY > 14000 and  TKEY < 20000  
select TKEY from #EX4 where TKEY = 17000

checkpoint;  --фиксация БД
DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

-- фильтруемый индекс...... 0.005
create index #EX4_WHERE on #EX4 (TKEY) where (TKEY > 15000 and TKEY < 20000)

drop index #EX4_WHERE on #EX4
drop table #EX4

------------ЗАДАНИЕ 5-6--------------
use tempdb;
create table #EX5
(
	TKEY int, 
    ID int identity(1, 1),
    TF varchar(100)
);

set nocount on;
declare @iterR int = 0;
while @iterR < 15000
begin
	INSERT #EX5(TKEY, TF) values(floor(30000 * RAND()), replicate('строка ', 10));
	set @iterR += 1;
end

create index #EX5_TKEY on #EX5(TKEY)

SELECT NAME [Индекс], AVG_FRAGMENTATION_IN_PERCENT [Фрагментация (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;

INSERT top(10000) #EX5(TKEY, TF) select TKEY, TF from #EX5;

-- фрагментация индекса 50%
SELECT NAME [Индекс], AVG_FRAGMENTATION_IN_PERCENT [Фрагментация (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;

-- реорганизация 0%
alter index #EX5_TKEY on #EX5 reorganize

-- перестройка  0%
alter index  #EX5_TKEY on #EX5 rebuild with (online = off)

drop index #EX5_TKEY on #EX5

----------  Задание 6

create index #EX5_TKEY on #EX5(TKEY) with (fillfactor = 65)

set nocount on
declare @ITE int = 0
while @ITE < 15000
begin
	insert #EX5(TKEY, TF) 
	values (floor(30000 * rand()), replicate ('строка ', 10))
	set @ITE += 1
end

SELECT NAME [Индекс], AVG_FRAGMENTATION_IN_PERCENT [Фрагментация (%)]
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#EX5'), NULL, NULL, NULL) SS
JOIN SYS.INDEXES II ON SS.OBJECT_ID = II.OBJECT_ID
AND SS.INDEX_ID = II.INDEX_ID WHERE NAME IS NOT NULL;

drop index #EX5_TKEY on #EX5
drop table #EX5



