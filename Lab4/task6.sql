select AUDITORIUM.AUDITORIUM[Номер аудитории], AUDITORIUM_TYPE.AUDITORIUM_TYPE[Тип аудитории]
from AUDITORIUM cross join AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;

use Бычок_MyBase

select Преподаватель.Код_преподавателя[код препода], Связь.Код_преподавателя[код в связи]
from Преподаватель cross join Связь
where Преподаватель.Код_преподавателя = Связь.Код_преподавателя