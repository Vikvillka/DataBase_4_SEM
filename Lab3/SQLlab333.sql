CREATE database �����_MyBase;
use �����_MyBase
CREATE table ������
(	�����_������ int primary key,
	������������� nvarchar(50),
	����������_��������� int not null
);
CREATE table �����
(	ID_����� int primary key,
	�����_������ int foreign key references ������(�����_������),
	����������_����� int not null,
	������ money not null
);
CREATE table �������������
(	���_������������� int primary key,
	������� nvarchar(50),
	��� nvarchar(50),
	�������� nvarchar(50),
	�����_�������� nvarchar(50),
	������� nvarchar(50),
	����������_����� int not null,
);
CREATE table �����
(	ID_����� int primary key references �����(ID_�����),
	���_������������� int foreign key references �������������(���_�������������),
	���_������� nvarchar(50),
);

ALTER Table ������ ADD ��������� nchar(10) default '���' check (��������� in ('���', '��'));
alter table ������ drop column ���������

INSERT into ������(�����_������,�������������,����������_���������)
	Values(1206,'����',30);
INSERT into �����(ID_�����,�����_������,����������_�����,������)
	Values(233,1206,120,1200);
INSERT into �������������(���_�������������,�������,���,��������, �����_��������, �������, ����������_�����)
	Values(26,'����������','�����','��������������','+375-29-616-22-33', '����� �� ��������', 30);
INSERT into �����(ID_�����, ���_�������������, ���_�������)
	Values(233, 26, '������');

SELECT ID_�����, �����_������ From �����;
SELECT count(*) [count] From �����;
SELECT ������ [�����] FROM �����
	where ������ <2000

UPDATE ������������� set ������� = '������ �� ��������';
SELECT ������� From �������������;

INSERT into �������������(���_�������������,�������,���,��������, �����_��������, �������, ����������_�����)
	Values(26,'�����','�����','��������������','+375-29-616-22-33', '����� �� ��������', 30);
INSERT into �����(ID_�����, ���_�������������, ���_�������)
	Values(190, 26, '������'),(56, 26, '������');
INSERT into �����(ID_�����,�����_������,����������_�����,������)
	Values(190,1205,110,1100),
	(56,311,80,600);
INSERT into ������(�����_������,�������������,����������_���������)
	Values(1205,'����',30),(311,'���',10);

INSERT into ������(�����_������,�������������,����������_���������)
	Values(12,'����',2),(31,'���',10);

