create table TR_AUDIT(
ID INT IDENTITY, --номер
STMT VARCHAR(20)
    check (STMT in ('INS', 'DEL', 'UPD')),
TRNAME varchar(50), --имя триггера
CC VARCHAR(300))  --комментарий

create trigger TRIG_TEACH_INS 
          on TEACHER after INSERT
as declare @a1 varchar(20), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print 'Insert operation';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 =(select [GENDER] FROM inserted);

SET @in = @a1 + '' + @a2  + '' + @a3 ;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TRIG_TEACH_INS', @in);
return;
drop trigger TRIG_TEACH_INS;


insert into TEACHER (TEACHER, TEACHER_NAME, GENDER) values('ПШЛНХ', 'Полоньев-Шолохов Леонид Харитонович',  'м');

select * from TR_AUDIT;

---------------2
create trigger TRIG_TEACH_DEL 
          on TEACHER after DELETE
as declare @a1 varchar(20), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print 'DELETE operation';
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [TEACHER_NAME] from deleted);
set @a3 =(select [GENDER] FROM deleted);

SET @in = @a1 + '' + @a2  + '' + @a3 ;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TRIG_TEACH_DEL', @in);
return;
drop trigger TRIG_TEACH_INS;


DELETE TEACHER WHERE TEACHER.TEACHER = 'ПШЛНХ'

select * from TR_AUDIT;

-------------------------3

create trigger TR_TEACHER_UPD  
          on TEACHER after update
as declare @a1 varchar(20), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
print 'UPDATE operation';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 =(select [GENDER] FROM inserted);

SET @in = @a1 + '' + @a2  + '' + @a3 ;

set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [TEACHER_NAME] from deleted);
set @a3 =(select [GENDER] FROM deleted);

SET @in = @in + @a1 + '' + @a2  + '' + @a3 ;

insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TRIG_TEACH_UPD', @in);
return;
drop trigger TR_TEACHER_UPD;

SELECT * FROM TEACHER

update TEACHER set TEACHER.TEACHER_NAME = 'ИВАШКЕВИЧ КОНЬ ГРИГОРЬЕВ' where TEACHER.TEACHER = 'ГРН' ;

select * from TR_AUDIT;

---------------------4
-----------ex4-------------
create trigger TR_TEACHER on TEACHER after INSERT, DELETE, UPDATE
as declare @a1 varchar(20), @a2 nvarchar(50), @a3 nvarchar(50), @in varchar(300);
declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print 'Событие: INSERT';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 =(select [GENDER] FROM inserted);

SET @in = @a1 + '' + @a2  + '' + @a3 ;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TRIG_TEACH_INS', @in);
end;
else         
if @ins = 0 and  @del > 0  
begin 
    print 'Событие: DELETE';
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [TEACHER_NAME] from deleted);
set @a3 =(select [GENDER] FROM deleted);

SET @in = @a1 + '' + @a2  + '' + @a3 ;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TRIG_TEACH_DEL', @in);
end;
else
if @ins > 0 and  @del > 0  
begin 
    print 'Событие: UPDATE'; 
  set @a1 = (select [TEACHER] from inserted);
  set @a2 = (select [TEACHER_NAME] from inserted);
  set @a3 =(select [GENDER] FROM inserted);

  SET @in = @a1 + '' + @a2  + '' + @a3 ;

  set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [TEACHER_NAME] from deleted);
set @a3 =(select [GENDER] FROM deleted);


  SET @in = @in + @a1 + '' + @a2  + '' + @a3;
  insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TRIG_TEACH_UPD', @in);
  end;
  return;

  insert into TEACHER (TEACHER, TEACHER_NAME, GENDER) values('ПЖШКЕ', 'ПОМОГИТЕ БОЖЕ',  'м');
  delete from TEACHER where TEACHER.TEACHER = 'ПЖШКЕ';
  update TEACHER set TEACHER.TEACHER_NAME = 'ИВАШКЕВИЧ КОЗЕЛ ГРИГОРЬЕВ' where TEACHER.TEACHER = 'ГРН';
 select * from TR_AUDIT;

  drop trigger TR_TEACHER;

-------------------5
      insert into TEACHER (TEACHER, TEACHER_NAME, GENDER) values('ПЖШКЕ', 'ПОМОГИТЕ БОЖЕ',  'l');
      select * from TR_AUDIT;

-----------------6
go
create trigger TR_TEACHER_DEL1 on TEACHER after delete
as declare @TEACHER char(10), @TEACHER_NAME varchar(100),
       @GENDER char(1), @PULPIT char(20), @IN varchar(300)
print 'DELETE Trigger 1'
set @IN = 'Trigger Normal Priority'
insert into TR_AUDIT (STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL1', @IN)

go
create trigger TR_TEACHER_DEL2 on TEACHER after delete
as declare @TEACHER char(10), @TEACHER_NAME varchar(100),
       @GENDER char(1), @PULPIT char(20), @IN varchar(300)
print 'DELETE Trigger 2'
set @IN = 'Trigger Low Priority'
insert into TR_AUDIT (STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL2', @IN)

go
create trigger TR_TEACHER_DEL3 on TEACHER after delete
as declare @TEACHER char(10), @TEACHER_NAME varchar(100),
       @GENDER char(1), @PULPIT char(20), @IN varchar(300)
print 'DELETE Trigger 3'
set @IN = 'Trigger Highest Priority'
insert into TR_AUDIT (STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL3', @IN)

go
select t.name, e.type_desc 
from sys.triggers t join  sys.trigger_events e  
on t.object_id = e.object_id  
where OBJECT_NAME(t.parent_id) = 'TEACHER' and e.type_desc = 'DELETE'

go
exec SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', @order = 'First', @stmttype = 'DELETE'
exec SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', @order = 'Last',  @stmttype = 'DELETE'

go
insert into TEACHER values ('ГГВП', 'Бычек Виктория Александровна', 'ж', 'ИСиТ')
delete from TEACHER where TEACHER = 'ГГВП'
select * from TEACHER
select * from TR_AUDIT order by ID

----------------------7
create trigger Tov_Tran
        on TEACHER after insert, delete, update
  as declare @c int = (select COUNT(TEACHER) from TEACHER);
  if(@c < 10)
  begin 
  raiserror('Их видимо не может быть больше 10', 10, 1);
  rollback;
  end;
  return;
  go
insert into TEACHER values ('ТЕСТ', 'Просто для теста', 'м', 'ИСиТ')
select * from TEACHER
select * from TR_AUDIT 

drop trigger Tov_Tran;

-------------------------8
go 
create trigger TOV_ISTED_OF on FACULTY instead of delete
as raiserror (N'УДАЛЯТЬ НЕЛЬЗЯ ',10,1);
return;
GO
select * from FACULTY;
delete from FACULTY where FACULTY = 'ИТ';

SELECT * FROM GROUPS
go 



CREATE TRIGGER TOV_ISTED_OFFFFF 
ON GROUPS 
INSTEAD OF DELETE
AS
BEGIN
IF EXISTS (SELECT 1 FROM deleted WHERE IDGROUP = 27) 
BEGIN
 raiserror (N'УДАЛЯТЬ 27 НЕЛЬЗЯ ',10,1);
  ROLLBACK TRANSACTION;
 return;
END
 DELETE FROM GROUPS
    WHERE IDGROUP IN (SELECT IDGROUP FROM deleted);
    
END

--DROP TRIGGER TOV_ISTED_OFFFFF;

GO
select * from GROUPS;
delete from GROUPS where IDGROUP = 28;


--------------------9

go
create trigger TR_TEACHER_DDL on database 
for DDL_DATABASE_LEVEL_EVENTS  as   
declare @EVENT_TYPE varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)')
declare @OBJ_NAME varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)')
declare @OBJ_TYPE varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)')
if @OBJ_NAME = 'TEACHER' 
begin
  print 'Тип события: ' + cast(@EVENT_TYPE as varchar)
  print 'Имя объекта: ' + cast(@OBJ_NAME as varchar)
  print 'Тип объекта: ' + cast(@OBJ_TYPE as varchar)
  raiserror('Операции с таблицей TEACHER запрещены.', 16, 1)
  rollback  
end

go
alter table TEACHER drop column TEACHER_NAME


DROP TRIGGER TR_TEACHER_DDL 
ON DATABASE;
GO




select * from TEACHER
go
drop procedure EditPrep
go
Create procedure EditPrep @fio varchar(30), @newfio varchar(30)
as 
 begin
  declare @surname varchar(10) = substring(@fio, 1, charindex(' ', @fio)-1);
  declare @rest varchar(20) = substring(@newfio, charindex(' ', @newfio)+1, LEN(@newfio));
  update TEACHER set TEACHER_NAME = @surname + ' ' + @rest where TEACHER_NAME=@fio;
  return 1;
 end;
go
declare @k varchar(10), @fio varchar(30) = 'Смелов Владимир Владиславович', @newfio varchar(30) = 'Неверов Александр Васильевич';
EXEC @k = EditPrep @fio, @newfio;

select * from TEACHER;
update TEACHER set TEACHER_NAME='Смелов Владимир Владиславович' where TEACHER='СМЛВ'


