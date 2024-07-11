use UNIVERR

------------------ex 1
create function count_student(@faculty varchar(20)) returns int
as 
begin declare @count int = (select count(*) from STUDENT s 
			join GROUPS g  ON s.IDGROUP = g.IDGROUP 
			join FACULTY f on f.FACULTY = g.FACULTY 
			where g.FACULTY = @faculty)
return @count
end 

go 
declare @RES int = dbo.count_student('ТОВ')
PRINT 'Количество студентов ' + cast (@RES as varchar);

alter function count_student(@faculty varchar(20)= null, @prof varchar(20) = null) returns int
as 
begin declare @count  int = (select count(*) from STUDENT s 
			join GROUPS g  ON s.IDGROUP = g.IDGROUP 
			join FACULTY f on f.FACULTY = g.FACULTY 
			where g.FACULTY = @faculty and g.PROFESSION = @prof)
return @count
end 

select PROFESSION, FACULTY from GROUPS

go 
declare @RES int = dbo.count_student('ТОВ', '1-48 01 05')
PRINT 'Количество студентов ' + cast (@RES as varchar);

------------ ex2

create function FSUBJECTS (@p varchar(20)) returns char(300)
as 
begin
  declare @OUT varchar(300) = 'Дисциплины: '
  declare @SUBJ varchar(100) = ''
  declare cur cursor local static for
    (select s.SUBJECT 
     from   SUBJECT s 
     where  s.PULPIT = @p)
  open cur
  fetch cur into @SUBJ
  while @@FETCH_STATUS = 0
  begin
    set @OUT += rtrim(ltrim(@SUBJ)) + ', '
    fetch cur into @SUBJ
  end
  return @OUT
end

go 
select PULPIT кафедра, dbo.FSUBJECTS(PULPIT) Дисциплина
from PULPIT

------------ ex3
go
create function FFACPUL (@FACULTY varchar(20), @PULPIT varchar(20)) returns table
as return
  select f.FACULTY Факультет, p.PULPIT Кафедра
  from   FACULTY f left join PULPIT p 
  on     p.FACULTY = f.FACULTY
  where  f.FACULTY = isnull(@FACULTY, f.FACULTY)
  and     p.PULPIT = isnull (@PULPIT, p.PULPIT)

--drop function FFACPUL

go
select * from FFACPUL(null, null)
select * from FFACPUL('ИЭФ', null)
select * from FFACPUL(null, 'ОХ')
select * from FFACPUL('ТТЛП', 'ТЛ')

-------------ex4


go
create function FCTEACHER (@PULPIT varchar(20)) returns int
as begin
  declare @COUNT int = (select count(*)
              from   TEACHER t
              where  t.PULPIT = isnull(@PULPIT, t.PULPIT))
  return @COUNT
end

-- drop function FCTEACHER

go
print 'Кол-во преподавателей всего: ' + cast(dbo.FCTEACHER(null) as varchar)

select PULPIT Кафедра, dbo.FCTEACHER(PULPIT) [Кол-во преподавателей]
from   PULPIT

---------------- ex5
go
create function COUNT_PULPITS (@FACULTY varchar(20)) returns int
as begin
  declare @COUNT int = (select count(PULPIT) from PULPIT where FACULTY = isnull(@FACULTY, FACULTY))
  return @COUNT
end

go
create function COUNT_GROUPS (@FACULTY varchar(20)) returns int
as begin
  declare @COUNT int = (select count(IDGROUP) from GROUPS where FACULTY = isnull(@FACULTY, FACULTY))
  return @COUNT
end

go
create function COUNT_PROFESSIONS (@FACULTY varchar(20)) returns int
as begin
  declare @COUNT int =  (select count(PROFESSION) from PROFESSION where FACULTY = isnull(@FACULTY, FACULTY))
  return @COUNT
end

--drop function COUNT_PULPITS
--drop function COUNT_GROUPS
--drop function COUNT_PROFESSIONS
--drop function FACULTY_REPORT

go
create function FACULTY_REPORT(@c int) returns @fr table
([Факультет] varchar(50), [Кол-во кафедр] int, [Кол-во групп] int, [Кол-во студентов] int, [Кол-во специальностей] int)
as 
begin 
  declare @f varchar(30);
  declare cc CURSOR static for 
  select FACULTY from FACULTY 
  
  where  dbo.count_student(FACULTY) > @c; 

  open cc;  
    fetch cc into @f;
      while @@fetch_status = 0
      begin
              insert @fr values(@f,  dbo.COUNT_PULPITS(@f),
              dbo.COUNT_GROUPS(@f),   dbo.count_student(@f),
              dbo.COUNT_PROFESSIONS(@f)); 
              fetch cc into @f;  
         end;   
  return; 
end;

--drop function FACULTY_REPORT
go
select * from FACULTY_REPORT(0)

SELECT * FROM TEACHER


GO
CREATE FUNCTION COUNT_TEACHER () 
RETURNS INT
AS 
BEGIN
    DECLARE @COUNT INT 
		
		SELECT @COUNT = COUNT(*)FROM TEACHER WHERE SUBSTRING(TEACHER_NAME, CHARINDEX(' ', TEACHER_NAME) + 1, 1) = 'В';
    RETURN @COUNT;
END;
GO

DROP FUNCTION COUNT_TEACHER
go 
declare @RES int = dbo.COUNT_TEACHER()
PRINT 'Количество ПРЕПОДОВ ' + cast (@RES as varchar);
