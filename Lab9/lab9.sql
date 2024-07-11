DECLARE @char CHAR = 'Hello'
DECLARE @varchar VARCHAR = 'World'
DECLARE @datetime DATETIME
DECLARE @time TIME
DECLARE @int INT
DECLARE @smallint SMALLINT
DECLARE @tinyint TINYINT
DECLARE @numeric NUMERIC(12, 5)

SET @datetime = GETDATE()
SET @time = GETDATE()
SET @int = 42
SET @smallint = 100
SET @tinyint = 5
SET @numeric = 12345.67890

SELECT @char AS CharVariable, @varchar AS VarcharVariable
SELECT @datetime AS DatetimeVariable, @time AS TimeVariable, @int AS IntVariable
PRINT 'Smallint to varchar: ' + CAST(@smallint AS VARCHAR)


------------ 2 ----------------
use UNIVERR

DECLARE @capacity int = (select cast(sum(AUDITORIUM_CAPACITY) as int) from AUDITORIUM),		
		@count int = (select cast(count(*) as int) from AUDITORIUM),							
		@avg int = (select cast(avg(AUDITORIUM_CAPACITY) as int) from AUDITORIUM);
set @capacity = 30		
DECLARE @lessavg int = (select cast(count(*) as int) from AUDITORIUM where AUDITORIUM_CAPACITY< @avg);
DECLARE @percent float = cast(cast(@lessavg as float) / cast(@count as float) * 100 as float);

if @capacity > 200
begin 
	select @count '����������', @avg '������� ���������� ����',
	@lessavg '���������� < ��������', cast (@percent as varchar) + '%' '������� ���������'
end
else if @capacity < 200
begin
	print '����������� < 200' + cast(@capacity as varchar)
end

--------- 3 -------------

print '����� ������������ �����: ' + cast(@@ROWCOUNT as varchar(10));
print '������ SQL Server: ' + cast(@@VERSION as varchar(300));
print '��������� ������������� ��������, ����������� �������� �������� �����������: ' + cast(@@SPID as varchar(10));
print '��� ��������� ������: ' + cast(@@ERROR as varchar(30));
print '��� �������: ' + cast(@@SERVERNAME as varchar(30));
print '������� ����������� ����������: ' + cast(@@trancount as varchar(30));
print '�������� ���������� ���������� ����� ��������������� ������: ' + cast(@@FETCH_STATUS as varchar(30));
print '������� ����������� ������� ���������: ' + cast(@@NESTLEVEL as varchar(30));

------------ 4 ---------------

DECLARE @t int = 45, 
		@z float = 10.231,
		@x int = 52;

if @t > @x
begin
	set @z = power(sin(@t),2);
	print 'Z = '+ cast(@z as varchar(15));
end

else if @t < @x
begin
	set @z = 4 * (@t + @x);
	print 'Z = '+ cast(@z as varchar(15));
end

else if @t = @x
begin
	set @z = 1 - exp(@x-2);
	print 'Z = '+ cast(@z as varchar(15));
end

DECLARE @full_name varchar(100) = '���������� �������� �������������';

set @full_name = (select substring(@full_name, 1, charindex(' ', @full_name)) +
substring(@full_name, charindex(' ', @full_name) + 1, 1) + '.' +
substring(@full_name, charindex(' ', @full_name, charindex(' ', @full_name) + 1)+ 1, 1) + '.');

print @full_name;

-- part 3

DECLARE @next_month int = MONTH(GETDATE()) + 1;
SELECT *,DATEDIFF(YEAR, BDAY, GETDATE()) AS Age 
FROM STUDENT
WHERE MONTH(STUDENT.BDAY) = @next_month;

-- part 4
select CASE
	when DATEPART(weekday, PDATE) = 1 then '�����������'
	when DATEPART(weekday, PDATE) = 2 then '�������'
	when DATEPART(weekday, PDATE) = 3 then '�����'
	when DATEPART(weekday, PDATE) = 4 then '�������'
	when DATEPART(weekday, PDATE) = 5 then '�������'
	when DATEPART(weekday, PDATE) = 6 then '�������'
	when DATEPART(weekday, PDATE) = 7 then '�����������'
end
from PROGRESS where SUBJECT = '����'
--select * from PROGRESS

------------ 5 -----------------
DECLARE @averageMark float(4), @coun int;
set @averageMark = (select avg(NOTE) from PROGRESS);
set @coun = (select count(NOTE) from PROGRESS);

print '������� ������: ' + cast(@averageMark as varchar);

if @averageMark < 7
begin
	print '������� ������ ������ 7'
end
else if @averageMark > 7
begin
	print '������� ������ ������ 7'
end

print '���������� ������: '+ cast(@coun as varchar);
select * from PROGRESS
select sum(NOTE) from PROGRESS

---------------- 6 ------------

select PROGRESS.IDSTUDENT, PROGRESS.SUBJECT, 
case
	when AVG(PROGRESS.NOTE) = 4 then '������ 4'
	when AVG(PROGRESS.NOTE) between 5 and 6 then '������ �����������������'
	when AVG(PROGRESS.NOTE) between 7 and 8 then '������ ������'
	when AVG(PROGRESS.NOTE) between 9 and 10 then '������ �������'
	else '������ ���� 4'
end

from PROGRESS
group by IDSTUDENT, SUBJECT

select * from PROGRESS

-------------- 7 ----------------
CREATE TABLE #TEMP1
(
	ID int identity(100,1),
	RANDOM_NUMBER_1 int,
	RANDOM_NUMBER_2 int,
);

DECLARE  @iter int = 0;
WHILE @iter < 10
	begin
	INSERT #TEMP1(RANDOM_NUMBER_1, RANDOM_NUMBER_2)
			values(rand() * 100, rand() * 100);
	SET @iter = @iter + 1;
	end
SELECT * from #TEMP1;
DROP TABLE #TEMP1;

------------- 8 -------------

DECLARE @parm int = 1
print @parm + 1
print @parm + 2
RETURN 

print @parm +4

---------------- 9 -----------
begin try
	UPDATE STUDENT SET IDGROUP = 'string' WHERE IDGROUP = 18
end try
BEGIN CATCH
    PRINT '������ �����: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT '��������� �� ������: ' + ERROR_MESSAGE();
    PRINT '����� ������: ' + CAST(ERROR_LINE() AS VARCHAR);
    PRINT '���������: ' + ISNULL(ERROR_PROCEDURE(), '����������');
    PRINT '����������� ������: ' + CAST(ERROR_SEVERITY() AS VARCHAR);
    PRINT '������ ������: ' + CAST(ERROR_STATE() AS VARCHAR);
END CATCH
select * from STUDENT
