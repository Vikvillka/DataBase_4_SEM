USE [UNIVERR]
GO
/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 19.05.2024 16:22:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter procedure [dbo].[PSUBJECT] @p varchar(20), @c int output
as
begin
	set nocount on;
	select s.SUBJECT Код, s.SUBJECT_NAME Дисциплина, s.PULPIT Кафедра from SUBJECT s
	set @c = (select count(*) from SUBJECT where SUBJECT.PULPIT = @p);

	print 'параметры: @p = ' + @p + ',@c = ' + cast(@c as varchar(3));
	declare @k int = (select count(*) from SUBJECT);
	return @k ;
end

