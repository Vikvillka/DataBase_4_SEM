use UNIVER;

select AUDITORIUM.AUDITORIUM[Номер аудитории], AUDITORIUM_TYPE.AUDITORIUM_TYPE[Тип аудитории]
from AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE

use Бычок_MyBase

select Преподаватель.Код_преподавателя[код препода], Связь.Код_преподавателя[код в связи]
from Преподаватель inner join Связь
on Преподаватель.Код_преподавателя = Связь.Код_преподавателя