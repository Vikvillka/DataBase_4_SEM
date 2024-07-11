use UNIVER;

select AUDITORIUM.AUDITORIUM[Номер аудитории], AUDITORIUM_TYPE.AUDITORIUM_TYPENAME[Имя с компьютером]
from AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%компьютер%'

use Бычок_MyBase

select Курсы.Номер_группы[курсы], Группа.Номер_группы[группа]
from Курсы inner join Группа
on Курсы.Номер_группы = Группа.Номер_группы and Группа.Номер_группы like '1206'