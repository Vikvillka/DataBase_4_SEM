use UNIVERR

SELECT * FROM TEACHER

CREATE VIEW [ПРЕПОДОВАТЕЛь]([КОД],[КАФЕДРА], [ИМЯ],[ПОЛ] )
AS SELECT
* FROM TEACHER

DROP VIEW [ПРЕПОДОВАТЕЛИ]

use Бычок_MyBase

select * from Группа

create view [группа_представление]
as select
номер_группы [номер],
специальность [специальность],
количество_студентов [количество чел.]
from Группа

DROP VIEW [группа_представление]
---------------- 2 ----------------------
use UNIVERR

CREATE VIEW [Количество кафедр] 
	as SELECT FACULTY.FACULTY_NAME [Название кафедры], COUNT(PULPIT.FACULTY)[Количество]
	FROM FACULTY JOIN PULPIT 
	ON FACULTY.FACULTY = PULPIT.FACULTY
	GROUP BY FACULTY.FACULTY_NAME
	go
	SELECT * FROM [Количество кафедр]

USE Бычок_MyBase

CREATE VIEW [МИНИМАЛЬНЫЙ КУРС]
AS SELECT MIN(КУРСЫ.КОЛИЧЕСТВО_ЧАСОВ)[МИНИМАЛЬНОЕ ПО ВРЕМЕНИ],
КУРСЫ.ID_КУРСА[ID], ГРУППА.НОМЕР_ГРУППЫ[ГРУППА]
FROM КУРСЫ JOIN ГРУППА 
ON КУРСЫ.НОМЕР_ГРУППЫ = ГРУППА.НОМЕР_ГРУППЫ
GROUP BY Курсы.ID_курса,  ГРУППА.НОМЕР_ГРУППЫ
GO 
SELECT * FROM [МИНИМАЛЬНЫЙ КУРС]

------------- 3 ----------------

use UNIVERR

CREATE VIEW [Аудитории](Код, [Наименование аудитории], Вместительность, Аудитория) 
	as SELECT AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_CAPACITY,AUDITORIUM.AUDITORIUM
	FROM AUDITORIUM
	WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE 'ЛК'
	go
SELECT * FROM [Аудитории]

insert Аудитории values('ЛК-К', '100-3a', 40, '100-3a')
update  Аудитории SET  Аудитория = '100-4' WHERE [Вместительность] = 40 
delete Аудитории where [Вместительность] = 40 

DROP VIEW [Аудитории]

USE Бычок_MyBase

SELECT * FROM ГРУППА

CREATE VIEW [ГРУППЫ] (НОМЕР_ГРУППЫ, СПЕЦИАЛЬНОСТЬ, КОЛИЧЕСТВО_СТУД)
	AS SELECT НОМЕР_ГРУППЫ, СПЕЦИАЛЬНОСТЬ, КОЛИЧЕСтвО_СТУДЕНТОВ
	from  Группа
	where специальность like 'ИСИТ'
	GO
SELECT * FROM [ГРУППЫ]

INSERT ГРУППЫ VALUES (25, 'ПОИБЫМС', 25)

----------- 4 ------------

use UNIVERR

CREATE VIEW [Лекционные_аудитории](Код, [Наименование аудитории], Вместительность, Аудитория) 
	as SELECT AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_CAPACITY,AUDITORIUM.AUDITORIUM
	FROM AUDITORIUM
	WHERE AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%'  and AUDITORIUM.AUDITORIUM_CAPACITY > 40 with check option
	go
	SELECT * FROM [Лекционные_аудитории]

insert [Лекционные_аудитории] values('ЛК-К', '200-3а', 60, '200-3а')
delete [Лекционные_аудитории] where [Вместительность] = 60 
insert [Лекционные_аудитории] values('Лаба', '210-3а', 30, '210-3а')

----------- 5 ------------

CREATE VIEW [Дисциплины](Код, [Наименование дисциплины], [Код кафедры])
	as SELECT TOP 100 SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT
	FROM SUBJECT
	ORDER BY SUBJECT.SUBJECT
	go
	SELECT * FROM [Дисциплины]

---------- 6 -------------

ALTER VIEW [Количество кафедр] WITH SCHEMABINDING
	as SELECT FACULTY.FACULTY_NAME, COUNT(PULPIT.FACULTY)[Количество]
	FROM dbo.FACULTY JOIN dbo.PULPIT 
	ON FACULTY.FACULTY = PULPIT.FACULTY
	GROUP BY FACULTY.FACULTY_NAME
	go
SELECT * FROM [Количество кафедр]
 

USE Бычок_MyBase

CREATE VIEW [dbo].[МИНИМАЛЬНЫЙКУРС]
WITH SCHEMABINDING
AS
SELECT MIN(КУРСЫ.КОЛИЧЕСТВО_ЧАСОВ) AS [МИНИМАЛЬНОЕ ПО ВРЕМЕНИ],
       КУРСЫ.ID_КУРСА AS [ID], 
       ГРУППА.НОМЕР_ГРУППЫ AS [ГРУППА]
FROM dbo.КУРСЫ
JOIN dbo.ГРУППА ON КУРСЫ.НОМЕР_ГРУППЫ = ГРУППА.НОМЕР_ГРУППЫ
GROUP BY КУРСЫ.ID_КУРСА, ГРУППА.НОМЕР_ГРУППЫ;
GO

SELECT *
FROM [dbo].[МИНИМАЛЬНЫЙКУРС];


drop view [МИНИМАЛЬНЫЙКУРС]


