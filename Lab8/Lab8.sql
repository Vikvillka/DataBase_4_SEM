use UNIVERR

SELECT * FROM TEACHER

CREATE VIEW [�������������]([���],[�������], [���],[���] )
AS SELECT
* FROM TEACHER

DROP VIEW [�������������]

use �����_MyBase

select * from ������

create view [������_�������������]
as select
�����_������ [�����],
������������� [�������������],
����������_��������� [���������� ���.]
from ������

DROP VIEW [������_�������������]
---------------- 2 ----------------------
use UNIVERR

CREATE VIEW [���������� ������] 
	as SELECT FACULTY.FACULTY_NAME [�������� �������], COUNT(PULPIT.FACULTY)[����������]
	FROM FACULTY JOIN PULPIT 
	ON FACULTY.FACULTY = PULPIT.FACULTY
	GROUP BY FACULTY.FACULTY_NAME
	go
	SELECT * FROM [���������� ������]

USE �����_MyBase

CREATE VIEW [����������� ����]
AS SELECT MIN(�����.����������_�����)[����������� �� �������],
�����.ID_�����[ID], ������.�����_������[������]
FROM ����� JOIN ������ 
ON �����.�����_������ = ������.�����_������
GROUP BY �����.ID_�����,  ������.�����_������
GO 
SELECT * FROM [����������� ����]

------------- 3 ----------------

use UNIVERR

CREATE VIEW [���������](���, [������������ ���������], ���������������, ���������) 
	as SELECT AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_CAPACITY,AUDITORIUM.AUDITORIUM
	FROM AUDITORIUM
	WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE '��'
	go
SELECT * FROM [���������]

insert ��������� values('��-�', '100-3a', 40, '100-3a')
update  ��������� SET  ��������� = '100-4' WHERE [���������������] = 40 
delete ��������� where [���������������] = 40 

DROP VIEW [���������]

USE �����_MyBase

SELECT * FROM ������

CREATE VIEW [������] (�����_������, �������������, ����������_����)
	AS SELECT �����_������, �������������, ����������_���������
	from  ������
	where ������������� like '����'
	GO
SELECT * FROM [������]

INSERT ������ VALUES (25, '�������', 25)

----------- 4 ------------

use UNIVERR

CREATE VIEW [����������_���������](���, [������������ ���������], ���������������, ���������) 
	as SELECT AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_CAPACITY,AUDITORIUM.AUDITORIUM
	FROM AUDITORIUM
	WHERE AUDITORIUM.AUDITORIUM_TYPE like '��%'  and AUDITORIUM.AUDITORIUM_CAPACITY > 40 with check option
	go
	SELECT * FROM [����������_���������]

insert [����������_���������] values('��-�', '200-3�', 60, '200-3�')
delete [����������_���������] where [���������������] = 60 
insert [����������_���������] values('����', '210-3�', 30, '210-3�')

----------- 5 ------------

CREATE VIEW [����������](���, [������������ ����������], [��� �������])
	as SELECT TOP 100 SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT
	FROM SUBJECT
	ORDER BY SUBJECT.SUBJECT
	go
	SELECT * FROM [����������]

---------- 6 -------------

ALTER VIEW [���������� ������] WITH SCHEMABINDING
	as SELECT FACULTY.FACULTY_NAME, COUNT(PULPIT.FACULTY)[����������]
	FROM dbo.FACULTY JOIN dbo.PULPIT 
	ON FACULTY.FACULTY = PULPIT.FACULTY
	GROUP BY FACULTY.FACULTY_NAME
	go
SELECT * FROM [���������� ������]
 

USE �����_MyBase

CREATE VIEW [dbo].[���������������]
WITH SCHEMABINDING
AS
SELECT MIN(�����.����������_�����) AS [����������� �� �������],
       �����.ID_����� AS [ID], 
       ������.�����_������ AS [������]
FROM dbo.�����
JOIN dbo.������ ON �����.�����_������ = ������.�����_������
GROUP BY �����.ID_�����, ������.�����_������;
GO

SELECT *
FROM [dbo].[���������������];


drop view [���������������]


