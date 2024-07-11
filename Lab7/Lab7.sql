use UNIVERR;

select faculty.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
	JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
	JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
	JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT

SELECT FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
		JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
		JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY ROLLUP (FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT)

------------ ������� 2--------------
select  FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
	JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
	JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
	JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT WITH CUBE;


------------ ������� 3--------------
select * from groups

SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
		JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
		JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
	UNION
SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
		JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
		JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT

------------ ������� 3.1 --------------

SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
		JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
		JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
	UNION ALL
SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
		JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
		JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT

--------------- ������� 4----------------
SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
		JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
		JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
	INTERSECT
SELECT TOP(1)GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
		JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
		JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT

--------------------- ������� 5 ----------------

SELECT GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
		JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
		JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT
	EXCEPT
SELECT TOP(1) GROUPS.PROFESSION, PROGRESS.SUBJECT, ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT(4))), 2) AS [������� ������]
FROM GROUPS
		JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
		JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		JOIN FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
WHERE FACULTY.FACULTY LIKE '����'
GROUP BY FACULTY.FACULTY, GROUPS.PROFESSION, PROGRESS.SUBJECT

------------ ������� ���� �� ---------------

USE �����_MyBase
SELECT * FROM ������

SELECT ������.�����_������, SUM(������.����������_���������)[�����] 
FROM ������
WHERE ������.������������� IN ('����')
GROUP BY ������.�����_������

SELECT ������.�����_������, SUM(������.����������_���������)[�����] 
FROM ������
WHERE ������.������������� IN ('����')
GROUP  BY ROLLUP (������.�����_������)

SELECT ������.�����_������, SUM(������.����������_���������)[�����] 
FROM ������
WHERE ������.������������� IN ('����')
GROUP BY ������.�����_������ WITH CUBE

SELECT ������.�������������, ������.����������_���������
FROM ������ WHERE ������.����������_��������� < 15
UNION
SELECT ������.�������������, ������.����������_���������
FROM ������ WHERE ������.����������_��������� < 40

SELECT ������.�������������, ������.����������_���������
FROM ������ WHERE ������.����������_��������� < 15
UNION ALL
SELECT ������.�������������, ������.����������_���������
FROM ������ WHERE ������.����������_��������� < 40

SELECT ������.�������������, ������.����������_���������
FROM ������ WHERE ������.����������_��������� < 15
INTERSECT
SELECT ������.�������������, ������.����������_���������
FROM ������ WHERE ������.����������_��������� < 40

SELECT ������.�������������, ������.����������_���������
FROM ������ WHERE ������.����������_��������� < 15
EXCEPT
SELECT ������.�������������, ������.����������_���������
FROM ������ WHERE ������.����������_��������� > 5
