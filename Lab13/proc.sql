--ex.1
use UNIVERR
go
create procedure PSUBJECT	
as
begin
	set nocount on;
	declare @count int = (select count(*) from SUBJECT)
	select s.SUBJECT Код, s.SUBJECT_NAME Дисциплина, s.PULPIT Кафедра from SUBJECT s
	return @count
end

go
declare @COUNT_OUTPUT int = 0
exec @COUNT_OUTPUT = PSUBJECT
print 'Количество дисциплин: ' + cast(@COUNT_OUTPUT as varchar(10))

drop proc PSUBJECT

--ex.2

declare @k int = 0, @r int = 0, @p varchar(20);
exec @k = PSUBJECT @p = 'ИСиТ', @c = @r output;
print 'Кол-во дисциплин на кафедре ' + cast(@p as varchar(3)) + ' = ' + cast(@r as varchar(3))
print 'Кол-во дисциплин всего: ' + cast(@k as varchar(3))

--drop proc PSUBJECT

--ex.3
alter proc PSUBJECT @PULPIT varchar(20)
as 
begin
	select * from SUBJECT where SUBJECT.PULPIT != @PULPIT
end

create table #SUBJECTS
(
	Код varchar(10) primary key,
	Дисциплина varchar(50) not null,
	Кафедра varchar(10) not null
);
insert #SUBJECTS exec PSUBJECT @PULPIT = 'ИСиТ'
select * from #SUBJECTS

drop table #SUBJECTS
--drop proc PSUBJECT

--ex.4
use UNIVERR
go
create proc PAUDITORIUM_INSERT @AUD char(20), @NAME varchar(50), @CAPACITY int = 0, @TYPE char(10)
as
begin
	begin try
		insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
		values (@AUD, @NAME, @CAPACITY, @TYPE)
		return 1
	end try
	begin catch
		print 'Номер ошибка:  ' + cast(ERROR_NUMBER() as varchar(6))
		print 'Уровень: ' + cast(ERROR_SEVERITY() as varchar(6))
		print 'Сообщение:   ' + ERROR_MESSAGE()
		return -1
	end catch
end

go
declare @RETURN int
exec @RETURN = PAUDITORIUM_INSERT @AUD = '500-1', @NAME = '500-1', @CAPACITY = 20, @TYPE = 'ЛК'
print 'Процедура завершилась с кодом ' + cast(@RETURN as varchar)

select * from AUDITORIUM
select * from AUDITORIUM_TYPE

delete AUDITORIUM where AUDITORIUM = '500-1'
drop proc PAUDITORIUM_INSERT

--ex.5
go
create proc SUBJECT_REPORT @PULPIT varchar(20)
as
begin try
	declare @SUBJ_OUT varchar(200) = ''
	declare @SUBJ_ONE varchar(20) = ''
	declare @ROWCOUNT int = 0
	declare cur cursor local static for (select SUBJECT from SUBJECT where SUBJECT.PULPIT = @PULPIT)
	if not exists (select SUBJECT from SUBJECT where SUBJECT.PULPIT = @PULPIT)
		raiserror('Ошибка! ', 11, 1)
	else
	open cur
		fetch cur into @SUBJ_ONE
		while @@FETCH_STATUS = 0
		begin
			set @SUBJ_OUT += rtrim(@SUBJ_ONE) + ', '
			set @ROWCOUNT = @ROWCOUNT + 1
			fetch cur into @SUBJ_ONE
		end
	print @SUBJ_OUT
	close cur
	return @ROWCOUNT
end try
begin catch
	print 'Ошибка в параметрах!'
	print 'Сообщение: ' + cast(ERROR_MESSAGE() as varchar(max))
	print 'Номер строки: ' + cast(@ROWCOUNT as varchar) 
end catch

go
declare @COUNT int = 0
exec @COUNT = SUBJECT_REPORT @PULPIT = 'ИСиТ'
print 'Количество дисциплин: ' + cast(@COUNT as varchar)

drop proc SUBJECT_REPORT

--ex7
use UNIVERR;
go
create procedure PAUDITORIUM_INSERTX @AUD char(20), @NAME varchar(50), @CAPACITY int = 0, @TYPE char(10),  @TYPENAME varchar(50)  
as
begin try 
    set transaction isolation level SERIALIZABLE;          
  begin tran
		insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
		values (@TYPE, @TYPENAME)
		exec PAUDITORIUM_INSERT @AUD, @NAME, @CAPACITY, @TYPE
	commit tran
	 return 1;
end try

begin catch
	print 'Код ошибки:  ' + cast(ERROR_NUMBER() as varchar)
	print 'Серьёзность: ' + cast(ERROR_SEVERITY() as varchar)
	print 'Сообщение:   ' + cast(ERROR_MESSAGE() as varchar)
	if @@TRANCOUNT > 0 
		rollback tran
	return -1
end catch

go
exec PAUDITORIUM_INSERTX @AUD = '325-1', @NAME = '325-1', @CAPACITY = 50, @TYPE = 'ЛР-К', @TYPENAME = 'Лабораторный кабинет'

select * from AUDITORIUM
select * from AUDITORIUM_TYPE

delete AUDITORIUM where AUDITORIUM = '325-1'
delete AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛР-К'

drop proc PAUDITORIUM_INSERTX 