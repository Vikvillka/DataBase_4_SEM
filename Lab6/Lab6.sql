select AUDITORIUM.AUDITORIUM_TYPE, 
max(AUDITORIUM.AUDITORIUM_CAPACITY),
min(AUDITORIUM.AUDITORIUM_CAPACITY),
avg(AUDITORIUM.AUDITORIUM_CAPACITY),
SUM(AUDITORIUM.AUDITORIUM_CAPACITY),
COUNT(AUDITORIUM.AUDITORIUM_TYPE)
FROM AUDITORIUM INNER JOIN AUDITORIUM_TYPE
ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE GROUP BY AUDITORIUM.AUDITORIUM_TYPE

USE �����_MyBase 

SELECT * FROM ������

SELECT ������.�����_������,
MAX(������.����������_���������),
avg(������.����������_���������),
min(������.����������_���������)
from ������ inner join �����
on ������.�����_������ = �����.�����_������ group by ������.�����_������

--------------- ������� 2----------------------
SELECT * FROM PROGRESS

SELECT *
FROM
	(SELECT CASE 
		WHEN PROGRESS.NOTE BETWEEN 1 AND 4 THEN '������� < 4'
		ELSE'������� > 4' 
		END [�������], 
		COUNT(*) [����������]
FROM PROGRESS GROUP BY CASE
		WHEN PROGRESS.NOTE BETWEEN 1 AND 4 THEN '������� < 4'
		ELSE'������� > 4' END) AS T
		ORDER BY case [�������]
		WHEN '������� < 4' THEN 1
		WHEN '������� > 4' THEN 2
		ELSE 0
		END

USE �����_MyBase
select * from �����

select * 
	from
	(select case 
		when �����.������ between 500 and 1150 then '������'
		else '������'
		end [����],
		count (*)[����������]
	from ����� group by CASE
		when �����.������ between 500 and 1150 THEN '������'
		ELSE '������' END) AS T
		ORDER BY case [����]
		WHEN '������' THEN 1
		WHEN '������' THEN 2
		ELSE 0
		END

--------------- ������� 3----------------------

select * from GROUPS
SELECT * FROM PROFESSION

select a.FACULTY,
       G.PROFESSION,
	   G.IDGROUP,
       round(avg(cast(NOTE AS float(1))), 2) as [������� ������]
from FACULTY a
         INNER join GROUPS G on a.FACULTY = G.FACULTY
         inner join STUDENT S on G.IDGROUP = S.IDGROUP
         inner join PROGRESS P on S.IDSTUDENT = P.IDSTUDENT
group by a.FACULTY, G.PROFESSION, G.IDGROUP
order by [������� ������] desc

--------------- ������� 4----------------------

select a.FACULTY,
       G.PROFESSION,
	   G.IDGROUP,
	   P.SUBJECT,
       round(avg(cast(NOTE AS float(1))), 2) as [������� ������]
from FACULTY a
         join GROUPS G on a.FACULTY = G.FACULTY
         join STUDENT S on G.IDGROUP = S.IDGROUP
         join PROGRESS P on S.IDSTUDENT = P.IDSTUDENT
		where P.SUBJECT like '����' or P.SUBJECT like '����'
group by a.FACULTY, G.PROFESSION, P.SUBJECT, G.IDGROUP
order by [������� ������] desc

--------------- ������� 5----------------------

select GROUPS.PROFESSION, PROGRESS.SUBJECT, FACULTY.FACULTY,  round(avg(cast(NOTE AS float(1))), 2) as [������� ������]
from GROUPS
inner join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY like '����'
group by GROUPS.PROFESSION, PROGRESS.SUBJECT, FACULTY.FACULTY


--------------- ������� 6----------------------

select PROGRESS.[SUBJECT], 
	   count(PROGRESS.NOTE) as [���������� 8, 9]
from PROGRESS 

group by PROGRESS.[SUBJECT], PROGRESS.NOTE
having PROGRESS.NOTE in (8,9)

use �����_MyBase

select * from ������

select ������.[�������������], 
	   count(������.����������_���������) as [���������� 10,30 �������]
from ������  

group by ������.[�������������], ������.����������_���������
having ������.����������_��������� in (10,30)


