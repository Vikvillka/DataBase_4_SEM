use UNIVER;

SELECT isnull (TEACHER.TEACHER_NAME, '***') [Преподаватель],
	PULPIT.PULPIT_NAME
	FROM PULPIT left outer join TEACHER
		ON PULPIT.PULPIT = TEACHER.PULPIT

use Бычок_MyBase

select ISNULL (Группа.Количество_студентов, 0)[Выжившие],
Группа.Номер_группы
from Группа right outer join Курсы
on Группа.Номер_группы = Курсы.Номер_группы