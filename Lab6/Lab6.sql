select AUDITORIUM.AUDITORIUM_TYPE, 
max(AUDITORIUM.AUDITORIUM_CAPACITY),
min(AUDITORIUM.AUDITORIUM_CAPACITY),
avg(AUDITORIUM.AUDITORIUM_CAPACITY),
SUM(AUDITORIUM.AUDITORIUM_CAPACITY),
COUNT(AUDITORIUM.AUDITORIUM_TYPE)
FROM AUDITORIUM INNER JOIN AUDITORIUM_TYPE
ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE GROUP BY AUDITORIUM.AUDITORIUM_TYPE

USE Бычок_MyBase 

SELECT * FROM Группа

SELECT Группа.Номер_группы,
MAX(Группа.Количество_студентов),
avg(Группа.Количество_студентов),
min(Группа.Количество_студентов)
from Группа inner join Курсы
on группа.Номер_группы = Курсы.Номер_группы group by Группа.Номер_группы

--------------- ЗАДАНИЕ 2----------------------
SELECT * FROM PROGRESS

SELECT *
FROM
	(SELECT CASE 
		WHEN PROGRESS.NOTE BETWEEN 1 AND 4 THEN 'ОТМЕТКА < 4'
		ELSE'ОТМЕТКА > 4' 
		END [ОТМЕТКА], 
		COUNT(*) [КОЛИЧЕСТВО]
FROM PROGRESS GROUP BY CASE
		WHEN PROGRESS.NOTE BETWEEN 1 AND 4 THEN 'ОТМЕТКА < 4'
		ELSE'ОТМЕТКА > 4' END) AS T
		ORDER BY case [ОТМЕТКА]
		WHEN 'ОТМЕТКА < 4' THEN 1
		WHEN 'ОТМЕТКА > 4' THEN 2
		ELSE 0
		END

USE Бычок_MyBase
select * from курсы

select * 
	from
	(select case 
		when Курсы.Оплата between 500 and 1150 then 'дешево'
		else 'дорого'
		end [цена],
		count (*)[количество]
	from Курсы group by CASE
		when курсы.Оплата between 500 and 1150 THEN 'дешево'
		ELSE 'дорого' END) AS T
		ORDER BY case [цена]
		WHEN 'дешево' THEN 1
		WHEN 'дорого' THEN 2
		ELSE 0
		END

--------------- ЗАДАНИЕ 3----------------------

select * from GROUPS
SELECT * FROM PROFESSION

select a.FACULTY,
       G.PROFESSION,
	   G.IDGROUP,
       round(avg(cast(NOTE AS float(1))), 2) as [Средняя оценка]
from FACULTY a
         INNER join GROUPS G on a.FACULTY = G.FACULTY
         inner join STUDENT S on G.IDGROUP = S.IDGROUP
         inner join PROGRESS P on S.IDSTUDENT = P.IDSTUDENT
group by a.FACULTY, G.PROFESSION, G.IDGROUP
order by [Средняя оценка] desc

--------------- ЗАДАНИЕ 4----------------------

select a.FACULTY,
       G.PROFESSION,
	   G.IDGROUP,
	   P.SUBJECT,
       round(avg(cast(NOTE AS float(1))), 2) as [Средняя оценка]
from FACULTY a
         join GROUPS G on a.FACULTY = G.FACULTY
         join STUDENT S on G.IDGROUP = S.IDGROUP
         join PROGRESS P on S.IDSTUDENT = P.IDSTUDENT
		where P.SUBJECT like 'СУБД' or P.SUBJECT like 'ОАиП'
group by a.FACULTY, G.PROFESSION, P.SUBJECT, G.IDGROUP
order by [Средняя оценка] desc

--------------- ЗАДАНИЕ 5----------------------

select GROUPS.PROFESSION, PROGRESS.SUBJECT, FACULTY.FACULTY,  round(avg(cast(NOTE AS float(1))), 2) as [Средняя оценка]
from GROUPS
inner join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY
inner join STUDENT on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where FACULTY.FACULTY like 'ИДиП'
group by GROUPS.PROFESSION, PROGRESS.SUBJECT, FACULTY.FACULTY


--------------- ЗАДАНИЕ 6----------------------

select PROGRESS.[SUBJECT], 
	   count(PROGRESS.NOTE) as [Количество 8, 9]
from PROGRESS 

group by PROGRESS.[SUBJECT], PROGRESS.NOTE
having PROGRESS.NOTE in (8,9)

use Бычок_MyBase

select * from Группа

select Группа.[Специальность], 
	   count(группа.Количество_студентов) as [Количество 10,30 человек]
from группа  

group by группа.[Специальность], Группа.Количество_студентов
having Группа.Количество_студентов in (10,30)


