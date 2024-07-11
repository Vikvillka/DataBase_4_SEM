--ex.1
use master;

set nocount on						-- ������������ ��� ���������� ��������� � ���������� ������������ �����, 
									-- ������� ������������ ��� ���������� �������.

if exists (select * from  SYS.OBJECTS where OBJECT_ID = object_id (N'DBO.NewTable') )
begin
	drop table NewTable;
end;

declare @c int, @flag char = 'c';	-- commit ��� rollback?
SET IMPLICIT_TRANSACTIONS  ON		-- �����. ����� ������� ����������

create table NewTable				-- ������ ���������� 
(
	i int identity(1,1),
	word varchar(50) not null
);

declare @tableName NVARCHAR(128)
set @tableName = 'NewTable'

insert newTable (word) values ('�����1'), ('�����2'), ('�����3'), ('�����4');

set @c = (select count(*) from NewTable);

print '���������� ����� � ������� NewTable: ' + cast( @c as varchar(4));
if @flag = 'c'
	commit;							-- ���������� ����������: �������� 
else
	rollback;							-- ���������� ����������: ����� 

SET IMPLICIT_TRANSACTIONS  OFF		-- ������. ����� ������� ����������

if exists (select * from  SYS.OBJECTS where OBJECT_ID = object_id (N'DBO.NewTable') )
begin
	print '������� � ��������� ' + @tableName + ' ����������'
end;
else
begin
	print '������� � ��������� ' + @tableName + ' �� ����������'
end;

--ex.2
use UNIVERR;
begin try
	begin tran						-- ������ ����� ���������� 
		delete AUDITORIUM where AUDITORIUM_NAME = '3017-1';
		insert into AUDITORIUM values('301-1','��-�', '10', '301-1');
		update AUDITORIUM set AUDITORIUM_CAPACITY = '15' where AUDITORIUM_NAME='301-1';
	commit tran;
end try

begin catch
	print '������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0 rollback tran;
end catch

--ex.3
use UNIVERR;
declare @savepoint varchar(30);
begin try
	begin tran
		delete AUDITORIUM where AUDITORIUM_NAME = '301-1';									
		set @savepoint = 'save1'; save transaction @savepoint; -- �� - 1

		insert into AUDITORIUM values('301-1','��-�', '10', '301-1');							
		set @savepoint = 'save2'; save transaction @savepoint; -- �� - 2

		insert into AUDITORIUM values('301-1','��-�', '10', '301-1');
		--delete AUDITORIUM where AUDITORIUM_NAME = '301-1';			
		--update AUDITORIUM set AUDITORIUM_CAPACITY = '15' where AUDITORIUM_NAME='301-1';		
		set @savepoint = 'save3'; save transaction @savepoint; -- �� - 3
	commit tran;
end try

begin catch
	print '������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0
		begin
			print '����������� �����: ' + @savepoint;
			rollback tran @savepoint;
			commit tran;
		end;
end catch;

insert into AUDITORIUM values('301-1','��-�', '15', '301-1');

SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE 
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_NAME LIKE '301-1';

--ex.4
use UNIVERR;

-- ������� A
	set transaction isolation level READ UNCOMMITTED --��������� ����������������, ��������������� � ��������� ������
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID 'SID', 'insert AUDITORIUM' '���������', * from SUBJECT where SUBJECT = '���';
																	             
	select @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM_NAME='301-1';
	commit; 
	-------------------------- t2 -----------------

--- ������� B	
	begin transaction 
	select @@SPID 'SID'; -- SPID - ���������� ��������� ������������� ��������, ����������� �������� �������� �����������
	INSERT into SUBJECT values('���','������ ���������������� �����������','����');   
	update AUDITORIUM set AUDITORIUM_CAPACITY = '16' where AUDITORIUM_NAME = '301-1';	
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;

	delete SUBJECT where SUBJECT = '���';

--ex.5
use UNIVERR;

-- ������� A
    set transaction isolation level READ COMMITTED	-- �� ��������� ����������������� ������, 
													-- �� ��� ���� �������� ��������������� � ������-��� ������
	begin transaction 
	select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY = '39';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select @@SPID 'SID', 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM_NAME='301-1';
	commit; 

	--- ������� B	
	begin transaction 	

	-------------------------- t1 --------------------
    select @@SPID 'SID' update AUDITORIUM set AUDITORIUM_CAPACITY = '31' where AUDITORIUM_NAME='301-1';	

      commit; 
	-------------------------- t2 --------------------	

--ex.6
use UNIVERr;
-- ������� �
   set transaction isolation level  REPEATABLE READ  -- �� ��������� ����������������� ������ � ���������������� ������, 
                            -- �� ��� ���� �������� ��������� ������
  begin transaction 
  select COUNT(*) from SUBJECT;
  -------------------------- t1 ------------------ 
  -------------------------- t2 -----------------
  select COUNT(*) from SUBJECT;
  commit; 

  --- ������� B  
  begin transaction     
  -------------------------- t1 --------------------
            --INSERT into SUBJECT values('���','������ ���������������� �����������','����');  
			update Subject set Subject = '���1' where  Subject = '���'
          commit; 
  -------------------------- t2 --------------------

delete SUBJECT where SUBJECT = '���';


--ex.7
set transaction isolation level SERIALIZABLE;--���������� ����������, ����������������� � ���������������� ������
begin transaction
	select @@SPID, 'insert AUDITORIUM_TYPE' '���������', * from AUDITORIUM_TYPE
															   where AUDITORIUM_TYPE = '��';
	select @@SPID, 'update AUDITORIUM_TYPE' '���������', * from AUDITORIUM_TYPE
															   where AUDITORIUM_TYPE = '��';
commit;
-- ������� A
set transaction isolation level SERIALIZABLE	-- ���������� ����������, ����������������� � ���������������� ������
	begin transaction 
		delete SUBJECT where SUBJECT = '���';
		INSERT into SUBJECT values('���', '������ ���������������� �����������', '����');
        update SUBJECT set SUBJECT_NAME = '������ ���������������� interface' where  SUBJECT = '���';
	    select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = '����';
	-------------------------- t1 -----------------
	 select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = '����';
	-------------------------- t2 ------------------ 
	commit; 	

--- ������� B	
	begin transaction 	  
		delete SUBJECT where SUBJECT = '���';
		INSERT into SUBJECT values('���', '������ ���������������� �����������','����');
        update SUBJECT set SUBJECT_NAME = '������ ���������������� interface' where  SUBJECT = '���';
	    select SUBJECT_NAME from SUBJECT where PULPIT = '����';
     -------------------------- t1 --------------------
     commit; 
     select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = '����';
     -------------------------- t2 --------------------
	 		
	delete SUBJECT where SUBJECT = '���';

--ex.8
delete SUBJECT where SUBJECT = '���';

select * from PULPIT

begin tran
update PULPIT set PULPIT_NAME = '������ � ���������� �������������' where PULPIT.FACULTY = '����'
	begin tran 
	update PULPIT set PULPIT_NAME = '���' where PULPIT.FACULTY = '����'
	commit;
	select * from PULPIT

rollback
select * from PULPIT