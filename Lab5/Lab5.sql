select distinct PULPIT.PULPIT_NAME --FACULTY.FACULTY, PROFESSION.PROFESSION_NAME
from PULPIT,FACULTY,PROFESSION
where PULPIT.FACULTY = FACULTY.FACULTY  and FACULTY.FACULTY = PROFESSION.FACULTY and
FACULTY.FACULTY in (select PROFESSION.FACULTY
                         from PROFESSION
                         where PROFESSION_NAME like ('%технология%')
                            or PROFESSION_NAME like ('%технологии%'))

select ГРУППА.Специальность, ГРУППА.Количество_студентов, КУРСЫ.Номер_группы
FROM ГРУППА, КУРСЫ
WHERE ГРУППА.Номер_группы = КУРСЫ.Номер_группы AND 
КУРСЫ.Номер_группы IN (SELECT ГРУППА.Номер_группы FROM ГРУППА 
							WHERE Количество_студентов LIKE ('10') OR Количество_студентов LIKE ('30'))


-- задание 2--

select distinct PULPIT_NAME[Кафедра], PROFESSION.PROFESSION_NAME
from PULPIT inner join FACULTY 
on FACULTY.FACULTY = PULPIT.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
 where PULPIT.FACULTY in (select PROFESSION.FACULTY
                         from PROFESSION
                         where PROFESSION_NAME like ('%технология%')
                            or PROFESSION_NAME like ('%технологии%'))

select ГРУППА.Специальность, ГРУППА.Количество_студентов, КУРСЫ.Номер_группы
FROM ГРУППА INNER JOIN КУРСЫ
ON ГРУППА.Номер_группы = КУРСЫ.Номер_группы 
WHERE КУРСЫ.Номер_группы IN (SELECT ГРУППА.Номер_группы FROM ГРУППА 
							WHERE Количество_студентов LIKE ('10') 
							OR Количество_студентов LIKE ('30'))
						

-- задание 3--

select distinct PULPIT_NAME[Кафедра] , PROFESSION_NAME
from PULPIT inner join FACULTY
on FACULTY.FACULTY = PULPIT.FACULTY inner join PROFESSION
on FACULTY.FACULTY = PROFESSION.FACULTY
where PROFESSION_NAME LIKE '%технологии%'
or PROFESSION_NAME like ('%технология%')

select ГРУППА.Специальность, ГРУППА.Количество_студентов, КУРСЫ.Номер_группы
FROM ГРУППА INNER JOIN КУРСЫ
ON ГРУППА.Номер_группы = КУРСЫ.Номер_группы 
							WHERE Количество_студентов LIKE ('10') 
							OR Количество_студентов LIKE ('30')



-- задание 4--

select AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY
from AUDITORIUM aud1
where AUDITORIUM_CAPACITY = (select top(1) AUDITORIUM_CAPACITY from AUDITORIUM as aud2
	where aud2.AUDITORIUM_TYPE = aud1.AUDITORIUM_TYPE
order by aud2.AUDITORIUM_CAPACITY desc) order by aud1.AUDITORIUM_CAPACITY desc


select  Группа.Специальность, Группа.Количество_студентов
from группа
where группа.Количество_студентов = (select  top(1) aa.количество_студентов from Группа as aa
where aa.Специальность = Группа.Специальность
order by aa.Количество_студентов desc) order by Группа.Количество_студентов desc


-- задание 5 --

select FACULTY.FACULTY_NAME from FACULTY
where not exists (select * from PULPIT WHERE PULPIT.FACULTY = FACULTY.FACULTY)

select группа.Номер_группы from группа
where not exists (select * from курсы where курсы.Номер_группы = Группа.Номер_группы)

-- задание 6 --

select top (1)
(select avg(NOTE) FROM PROGRESS
WHERE SUBJECT LIKE 'ОАиП')[ОАИП],
(select avg(NOTE) FROM PROGRESS
WHERE SUBJECT LIKE 'БД')[БД],
(select avg(NOTE) FROM PROGRESS
WHERE SUBJECT LIKE 'СУБД')[СУБД]
FROM PROGRESS

select top (1)
(select avg(оплата) from курсы [cре.оплата]
where ID_курса like 56)
from курсы

-- задание 7 --

SELECT NOTE, SUBJECT FROM PROGRESS
WHERE NOTE >= all (SELECT NOTE FROM PROGRESS WHERE NOTE > 4)

select оплата, id_курса from Курсы
where Оплата >= all (select ОПЛАТА from Курсы where оплата > 1000)

-- задание 8 --

SELECT NOTE, SUBJECT FROM PROGRESS
WHERE NOTE >= any (SELECT NOTE FROM PROGRESS WHERE NOTE > 4)

select оплата, id_курса from Курсы
where Оплата <= any (select Оплата from Курсы where оплата > 700)