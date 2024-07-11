select distinct PULPIT.PULPIT_NAME --FACULTY.FACULTY, PROFESSION.PROFESSION_NAME
from PULPIT,FACULTY,PROFESSION
where PULPIT.FACULTY = FACULTY.FACULTY  and FACULTY.FACULTY = PROFESSION.FACULTY and
FACULTY.FACULTY in (select PROFESSION.FACULTY
                         from PROFESSION
                         where PROFESSION_NAME like ('%����������%')
                            or PROFESSION_NAME like ('%����������%'))

select ������.�������������, ������.����������_���������, �����.�����_������
FROM ������, �����
WHERE ������.�����_������ = �����.�����_������ AND 
�����.�����_������ IN (SELECT ������.�����_������ FROM ������ 
							WHERE ����������_��������� LIKE ('10') OR ����������_��������� LIKE ('30'))


-- ������� 2--

select distinct PULPIT_NAME[�������], PROFESSION.PROFESSION_NAME
from PULPIT inner join FACULTY 
on FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
 where PULPIT.FACULTY in (select PROFESSION.FACULTY
                         from PROFESSION
                         where PROFESSION_NAME like ('%����������%')
                            or PROFESSION_NAME like ('%����������%'))

select ������.�������������, ������.����������_���������, �����.�����_������
FROM ������ INNER JOIN �����
ON ������.�����_������ = �����.�����_������ 
WHERE �����.�����_������ IN (SELECT ������.�����_������ FROM ������ 
							WHERE ����������_��������� LIKE ('10') 
							OR ����������_��������� LIKE ('30'))
						

-- ������� 3--

select distinct PULPIT_NAME[�������] , PROFESSION_NAME
from PULPIT inner join FACULTY
on FACULTY.FACULTY = PULPIT.FACULTY inner join PROFESSION
on FACULTY.FACULTY = PROFESSION.FACULTY
where PROFESSION_NAME LIKE '%����������%'
or PROFESSION_NAME like ('%����������%')

select ������.�������������, ������.����������_���������, �����.�����_������
FROM ������ INNER JOIN �����
ON ������.�����_������ = �����.�����_������ 
							WHERE ����������_��������� LIKE ('10') 
							OR ����������_��������� LIKE ('30')



-- ������� 4--

select AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY
from AUDITORIUM aud1
where AUDITORIUM_CAPACITY = (select top(1) AUDITORIUM_CAPACITY from AUDITORIUM as aud2
	where aud2.AUDITORIUM_TYPE = aud1.AUDITORIUM_TYPE
order by aud2.AUDITORIUM_CAPACITY desc) order by aud1.AUDITORIUM_CAPACITY desc


select  ������.�������������, ������.����������_���������
from ������
where ������.����������_��������� = (select  top(1) aa.����������_��������� from ������ as aa
where aa.������������� = ������.�������������
order by aa.����������_��������� desc) order by ������.����������_��������� desc


-- ������� 5 --

select FACULTY.FACULTY_NAME from FACULTY
where not exists (select * from PULPIT WHERE PULPIT.FACULTY = FACULTY.FACULTY)

select ������.�����_������ from ������
where not exists (select * from ����� where �����.�����_������ = ������.�����_������)

-- ������� 6 --

select top (1)
(select avg(NOTE) FROM PROGRESS
WHERE SUBJECT LIKE '����')[����],
(select avg(NOTE) FROM PROGRESS
WHERE SUBJECT LIKE '��')[��],
(select avg(NOTE) FROM PROGRESS
WHERE SUBJECT LIKE '����')[����]
FROM PROGRESS

select top (1)
(select avg(������) from ����� [c��.������]
where ID_����� like 56)
from �����

-- ������� 7 --

SELECT NOTE, SUBJECT FROM PROGRESS
WHERE NOTE >= all (SELECT NOTE FROM PROGRESS WHERE NOTE > 4)

select ������, id_����� from �����
where ������ >= all (select ������ from ����� where ������ > 1000)

-- ������� 8 --

SELECT NOTE, SUBJECT FROM PROGRESS
WHERE NOTE >= any (SELECT NOTE FROM PROGRESS WHERE NOTE > 4)

select ������, id_����� from �����
where ������ <= any (select ������ from ����� where ������ > 700)