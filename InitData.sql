--ϵͳ�汾��
delete from appversion
go

insert into appversion values (N'6.0.0.0')
go

--ϵͳ���ܱ�

--���ɽű�
--select 'insert into SysFunction values (' + 
--	CONVERT(nvarchar,Id) + ',N''' + 
--	Name + ''',' + 
--	CONVERT(nvarchar,AllowOpen) + ',' +
--	CONVERT(nvarchar,AllowNew) + ',' +
--	CONVERT(nvarchar,AllowModify) + ',' +
--	CONVERT(nvarchar,AllowDelete) + ',' +
--	CONVERT(nvarchar,AllowCancel) + ',' +
--	CONVERT(nvarchar,AllowDetail) + ',' +
--	CONVERT(nvarchar,AllowSearch) + ',' +
--	CONVERT(nvarchar,AllowSubmit) + ',' +
--	CONVERT(nvarchar,AllowApprove) + ',' +
--	CONVERT(nvarchar,AllowDispatch) + ',' +
--	CONVERT(nvarchar,AllowExport) + ',' +
--	CONVERT(nvarchar,AllowImport) + ',' +
--	CONVERT(nvarchar,AllowPrint) + ',' +
--	'null,null)'
--from 
--	SysFunction 
--order by 
--	Id

delete from Sysfunction
go
insert into SysFunction values (1010,N'¼��ֽ�����ƻ�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1020,N'�ͻ�¼��ֽ�����ƻ�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1021,N'¼��ֱֽ�����ƻ�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1022,N'�ͻ�¼��ֱֽ�����ƻ�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1028,N'¼��޷����ƻ�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1030,N'¼���ֱ�����ƻ�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1040,N'¼�뷽���淢���ƻ�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1041,N'¼�����������ƻ�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1050,N'�ύ�ƻ�',1,1,1,1,0,0,0,1,0,0,0,0,0,null,null)
go
insert into SysFunction values (1060,N'�ͻ�����ֽ�����ƻ�',1,0,0,0,0,0,0,0,1,0,0,0,0,null,null)
go
insert into SysFunction values (1061,N'���������ƻ�',1,0,0,0,0,0,0,0,1,0,0,0,0,null,null)
go
insert into SysFunction values (1070,N'��ѯ�ƻ�',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (2010,N'���ȼƻ�',1,0,0,0,1,0,1,0,0,1,0,0,0,null,null)
go
insert into SysFunction values (2020,N'�ύ���ȵ�',1,1,1,1,0,0,0,1,0,0,0,0,0,null,null)
go
insert into SysFunction values (3010,N'��ӡ���ȳ��ֵ�',1,0,0,0,0,0,0,0,0,1,0,0,1,null,null)
go
insert into SysFunction values (3020,N'��ӡ�������ֵ�',1,0,0,0,0,0,0,0,0,0,0,0,1,null,null)
go
insert into SysFunction values (3030,N'�ύ���ֵ�',1,0,1,0,1,0,0,1,0,0,0,0,0,null,null)
go
insert into SysFunction values (3040,N'��ӡ�ͻ���',1,0,1,0,1,0,0,0,0,0,0,0,1,null,null)
go
insert into SysFunction values (3045,N'��ѯ�ͻ���',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (3050,N'�����ͻ����ص�',1,0,1,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (3060,N'��ѯ�ͻ����ص�',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (3070,N'������ֵ�',1,0,0,0,0,0,1,0,0,0,0,0,1,null,null)
go
insert into SysFunction values (3080,N'�����ͻ���',1,0,0,0,0,0,1,0,0,0,0,0,1,null,null)
go
insert into SysFunction values (4010,N'¼���ͬ',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (4020,N'�ύ��ͬ',1,0,1,1,0,0,0,1,0,0,0,0,0,null,null)
go
insert into SysFunction values (4030,N'��ӡ��ͬ',1,0,0,0,0,0,0,1,0,0,0,0,1,null,null)
go
insert into SysFunction values (4040,N'������ͬ',1,0,0,0,0,0,0,0,1,0,0,0,0,null,null)
go
insert into SysFunction values (4050,N'���ʴ���',1,0,1,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (4051,N'��ѯ���ʼ�¼',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (4060,N'�����',1,0,1,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (4070,N'��ѯ�����¼',1,0,0,1,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (4080,N'��ѯ��ͬ������Ϣ',1,0,0,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5010,N'�������',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5011,N'�������',0,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5020,N'�����ƿ�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5030,N'��ѯ����¼',1,0,1,1,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (5040,N'��ѯ�����¼',1,0,0,1,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (5041,N'��ѯ�ƿ��¼',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5050,N'�����շ���',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (5060,N'ͳ�Ʋִ���֧��',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (5061,N'��ѯ�ִ���֧�ѽ����¼',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5070,N'��ѯ�Ŀ�ƻ�',1,0,0,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5080,N'��ӡ�̵��',1,0,0,0,0,0,1,0,0,0,1,0,1,null,null)
go
insert into SysFunction values (5090,N'��ѯ���β��',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (5100,N'β�����',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5110,N'β�����',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6010,N'�ͻ�����',1,1,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (6020,N'���˵�λ����',1,1,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (6021,N'¼���������۸�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6022,N'¼��������˼۸�',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6030,N'��ѯ�ͻ��˷ѽ����¼',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6040,N'��ѯ���˵�λ�˷ѽ����¼',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6050,N'��ѯ�������۸�',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6060,N'��ѯ������˼۸�',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (7010,N'ͳ�ư��´��ܲ�ֵ',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (7011,N'ͳ�ư��´�ë����',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (7020,N'ͳ�ƿͻ��ܲ�ֵ',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (7030,N'�ۺϲ�ѯ',1,0,1,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (9010,N'������֯�ṹ',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9020,N'���ø�λ',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9030,N'����Ա������',1,1,1,1,0,1,0,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (9040,N'���ÿͻ�����',1,1,1,1,0,0,0,0,0,0,1,1,0,null,null)
go
insert into SysFunction values (9050,N'���õ�¼�ʺ�',1,1,1,1,1,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9060,N'����Ȩ����',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9070,N'����Ȩ��',1,0,1,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9071,N'���üƻ���������',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9072,N'���ü۸���������',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9080,N'���ù���',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9090,N'����ʡ/��/������/ֱϽ��',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9100,N'������/��/��/��',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9110,N'���û������',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9120,N'���û��ﵵ��',1,1,1,1,0,0,1,0,0,0,1,1,0,null,null)
go
insert into SysFunction values (9130,N'���ó��˵�λ����',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9140,N'���òֿ�',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9150,N'�����˷��޼�',1,1,1,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9151,N'�����ջ���λ����',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9160,N'�޸�����',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9170,N'��ʼ������',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go

--��֯�ṹ��
delete from Organization
go
insert into Organization values (1,0,N'XXX��˾',N'XXX��˾',N'1\',N'',N'',N'',N'',N'',N'',null,null)
go

--��λ��
delete from Position
go
insert into Position values (1,N'ϵͳ����Ա',N'',null,null)
go

--Ա����
delete from staff
go
insert into staff values (1,N'',N'Admin',N'��',1,N'XXX��˾',N'1\',1,N'ϵͳ����Ա',N'',N'',N'',N'',N'',N'',N'',N'',0,0,0,getdate(),null,null)
go

--Ȩ�����
delete from SysGroup
go
insert into SysGroup values (1,N'ϵͳ����Ա��',N'',null,null)
go

--��Ȩ�ޱ�
--select 'insert into SysGroupPermission values (0,1,' + 
--	CONVERT(nvarchar,Id) + ',' + 
--	CONVERT(nvarchar,AllowOpen) + ',' +
--	CONVERT(nvarchar,AllowNew) + ',' +
--	CONVERT(nvarchar,AllowModify) + ',' +
--	CONVERT(nvarchar,AllowDelete) + ',' +
--	CONVERT(nvarchar,AllowCancel) + ',' +
--	CONVERT(nvarchar,AllowDetail) + ',' +
--	CONVERT(nvarchar,AllowSearch) + ',' +
--	CONVERT(nvarchar,AllowSubmit) + ',' +
--	CONVERT(nvarchar,AllowApprove) + ',' +
--	CONVERT(nvarchar,AllowDispatch) + ',' +
--	CONVERT(nvarchar,AllowExport) + ',' +
--	CONVERT(nvarchar,AllowImport) + ',' +
--	CONVERT(nvarchar,AllowPrint) + ',' +
--	'null,null)'
--from 
--	SysFunction 
--order by 
--	Id

delete from SysGroupPermission
go
insert into SysGroupPermission values (1,1,1010,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (2,1,1020,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (3,1,1021,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (4,1,1022,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (5,1,1028,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (6,1,1030,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (7,1,1040,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (8,1,1041,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (9,1,1050,1,1,1,1,0,0,0,1,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (10,1,1060,1,0,0,0,0,0,0,0,1,0,0,0,0,null,null)
go
insert into SysGroupPermission values (11,1,1061,1,0,0,0,0,0,0,0,1,0,0,0,0,null,null)
go
insert into SysGroupPermission values (12,1,1070,1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (13,1,2010,1,0,0,0,1,0,1,0,0,1,0,0,0,null,null)
go
insert into SysGroupPermission values (14,1,2020,1,1,1,1,0,0,0,1,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (15,1,3010,1,0,0,0,0,0,0,0,0,1,0,0,1,null,null)
go
insert into SysGroupPermission values (16,1,3020,1,0,0,0,0,0,0,0,0,0,0,0,1,null,null)
go
insert into SysGroupPermission values (17,1,3030,1,0,1,0,1,0,0,1,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (18,1,3040,1,0,1,0,1,0,0,0,0,0,0,0,1,null,null)
go
insert into SysGroupPermission values (19,1,3045,1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (20,1,3050,1,0,1,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (21,1,3060,1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (22,1,3070,1,0,0,0,0,0,1,0,0,0,0,0,1,null,null)
go
insert into SysGroupPermission values (23,1,3080,1,0,0,0,0,0,1,0,0,0,0,0,1,null,null)
go
insert into SysGroupPermission values (24,1,4010,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (25,1,4020,1,0,1,1,0,0,0,1,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (26,1,4030,1,0,0,0,0,0,0,1,0,0,0,0,1,null,null)
go
insert into SysGroupPermission values (27,1,4040,1,0,0,0,0,0,0,0,1,0,0,0,0,null,null)
go
insert into SysGroupPermission values (28,1,4050,1,0,1,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (29,1,4051,1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (30,1,4060,1,0,1,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (31,1,4070,1,0,0,1,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (32,1,4080,1,0,0,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (33,1,5010,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (34,1,5011,0,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (35,1,5020,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (36,1,5030,1,0,1,1,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (37,1,5040,1,0,0,1,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (38,1,5041,1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (39,1,5050,1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (40,1,5060,1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (41,1,5061,1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (42,1,5070,1,0,0,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (43,1,5080,1,0,0,0,0,0,1,0,0,0,1,0,1,null,null)
go
insert into SysGroupPermission values (44,1,5090,1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (45,1,5100,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (46,1,5110,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (47,1,6010,1,1,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (48,1,6020,1,1,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (49,1,6021,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (50,1,6030,1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (51,1,6040,1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (52,1,6050,1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (53,1,7010,1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (54,1,7011,1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (55,1,7020,1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (56,1,7030,1,0,1,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (57,1,9010,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (58,1,9020,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (59,1,9030,1,1,1,1,0,1,0,0,0,0,1,0,0,null,null)
go
insert into SysGroupPermission values (60,1,9040,1,1,1,1,0,0,0,0,0,0,1,1,0,null,null)
go
insert into SysGroupPermission values (61,1,9050,1,1,1,1,1,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (62,1,9060,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (63,1,9070,1,0,1,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (64,1,9071,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (65,1,9072,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (66,1,9080,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (67,1,9090,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (68,1,9100,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (69,1,9110,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (70,1,9120,1,1,1,1,0,0,1,0,0,0,1,1,0,null,null)
go
insert into SysGroupPermission values (71,1,9130,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (72,1,9140,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (73,1,9150,1,1,1,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (74,1,9151,1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (75,1,9160,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysGroupPermission values (76,1,9170,1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go

--�ʺű�
delete from account
go
insert into account values (1,N'admin',N'f19b8dc2029cf707939e886e4b164681',N'Ա��',1,N'XXX��˾',1,N'Admin',0,10000,1000000001,getdate(),null,null)
go

--�ʺ�Ȩ�ޱ�
delete from AccountPermission 
go
insert into AccountPermission values (1,1,1,null,null)
go

--ID��
delete from IdGenerator
go
insert into IdGenerator values (NEWID(),1,N'admin',1,10000,10000,10000,1000000000,null,null)
go
insert into IdGenerator values (NEWID(),1,N'admin',0,1000000001,1000000001,1000000001,2000000000,null,null)
go

--���ұ�
delete from Country
go
insert into Country values (1,N'�й�',N'',null,null)
go

--ʡ�ݱ�
delete from Province
go
insert into Province values (1,N'̨��ʡ',N'�й�',N'',null,null)
go
insert into Province values (2,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (3,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (4,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (5,N'�½�ά���������',N'�й�',N'',null,null)
go
insert into Province values (6,N'������ʡ',N'�й�',N'',null,null)
go
insert into Province values (7,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (8,N'���ɹ�������',N'�й�',N'',null,null)
go
insert into Province values (9,N'���Ļ���������',N'�й�',N'',null,null)
go
insert into Province values (10,N'����׳��������',N'�й�',N'',null,null)
go
insert into Province values (11,N'�Ĵ�ʡ',N'�й�',N'',null,null)
go
insert into Province values (12,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (13,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (14,N'�����',N'�й�',N'',null,null)
go
insert into Province values (15,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (16,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (17,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (18,N'�Ϻ���',N'�й�',N'',null,null)
go
insert into Province values (19,N'������',N'�й�',N'',null,null)
go
insert into Province values (20,N'ɽ��ʡ',N'�й�',N'',null,null)
go
insert into Province values (21,N'����������',N'�й�',N'',null,null)
go
insert into Province values (22,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (23,N'�㽭ʡ',N'�й�',N'',null,null)
go
insert into Province values (24,N'�����ر�������',N'�й�',N'',null,null)
go
insert into Province values (25,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (26,N'�㶫ʡ',N'�й�',N'',null,null)
go
insert into Province values (27,N'ɽ��ʡ',N'�й�',N'',null,null)
go
insert into Province values (28,N'�ӱ�ʡ',N'�й�',N'',null,null)
go
insert into Province values (29,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (30,N'������',N'�й�',N'',null,null)
go
insert into Province values (31,N'�ຣʡ',N'�й�',N'',null,null)
go
insert into Province values (32,N'����ر�������',N'�й�',N'',null,null)
go
insert into Province values (33,N'����ʡ',N'�й�',N'',null,null)
go
insert into Province values (34,N'����ʡ',N'�й�',N'',null,null)
go

--���б�
delete from City
go

insert into City values (1,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (3,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (4,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (5,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (6,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (7,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (8,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (9,N'��Ϳ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (10,N'�ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (11,N'��Զ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (12,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (13,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (14,N'�ʶ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (15,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (16,N'��̨��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (17,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (18,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (19,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (20,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (21,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (22,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (23,N'�Ϸ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (24,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (25,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (26,N'��Զ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (27,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (28,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (29,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (30,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (31,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (32,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (33,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (34,N'��կ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (35,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (36,N'캵���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (37,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (38,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (39,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (40,N'��Ȫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (41,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (42,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (43,N'®����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (44,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (45,N'�ɳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (46,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (47,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (48,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (49,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (50,N'Ǳɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (51,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (52,N'ȫ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (53,N'ʯ̨��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (54,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (55,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (56,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (57,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (58,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (59,N'�Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (60,N'̫����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (61,N'̫����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (62,N'�쳤��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (63,N'ͩ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (64,N'ͭ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (65,N'ͭ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (66,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (67,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (68,N'��Ϊ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (69,N'�ߺ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (70,N'�ߺ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (71,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (72,N'���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (73,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (74,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (75,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (76,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (77,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (78,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (79,N'�����ر�������',N'�й�',N'�����ر�������',N'',null,null)
go
insert into City values (80,N'������',N'�й�',N'������',N'',null,null)
go
insert into City values (81,N'������',N'�й�',N'������',N'',null,null)
go
insert into City values (82,N'������',N'�й�',N'������',N'',null,null)
go
insert into City values (83,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (84,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (85,N'��̩��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (86,N'��͡��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (87,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (88,N'�»���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (89,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (90,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (91,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (92,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (93,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (94,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (95,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (96,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (97,N'�ݰ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (98,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (99,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (100,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (101,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (102,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (103,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (104,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (105,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (106,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (107,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (108,N'��Դ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (109,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (110,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (111,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (112,N'�ϰ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (113,N'�Ͼ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (114,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (115,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (116,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (117,N'ƽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (118,N'ƽ̶��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (119,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (120,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (121,N'�ֳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (122,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (123,N'Ȫ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (124,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (125,N'ɳ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (126,N'�Ϻ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (127,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (128,N'ʯʨ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (129,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (130,N'˳����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (131,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (132,N'̩����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (133,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (134,N'����ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (135,N'ϼ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (136,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (137,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (138,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (139,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (140,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (141,N'��̩��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (142,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (143,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (144,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (145,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (146,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (147,N'گ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (148,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (149,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (150,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (151,N'��������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (152,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (153,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (154,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (155,N'崲���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (156,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (157,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (158,N'������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (159,N'�ػ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (160,N'�ʹ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (161,N'���ϲ���������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (162,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (163,N'��̨��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (164,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (165,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (166,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (167,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (168,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (169,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (170,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (171,N'��ͤ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (172,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (173,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (174,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (175,N'��ʯɽ�����嶫����������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (176,N'��������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (177,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (178,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (179,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (180,N'��̩��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (181,N'��Զ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (182,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (183,N'��Ȫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (184,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (185,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (186,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (187,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (188,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (189,N'��̶��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (190,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (191,N'���Ļ���������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (192,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (193,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (194,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (195,N'��̨��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (196,N'¤����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (197,N'¤����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (198,N'µ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (199,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (200,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (201,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (202,N'���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (203,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (204,N'ƽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (205,N'�ذ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (206,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (207,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (208,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (209,N'ɽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (210,N'�౱�ɹ���������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (211,N'����ԣ����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (212,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (213,N'��ף����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (214,N'ͨμ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (215,N'μԴ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (216,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (217,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (218,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (219,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (220,N'�ĺ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (221,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (222,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (223,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (224,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (225,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (226,N'�żҴ�����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (227,N'��Ҵ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (228,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (229,N'��ԭ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (230,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (231,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (232,N'ׯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (233,N'׿����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (234,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (235,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (236,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (237,N'�ӻ���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (238,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (239,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (240,N'�����',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (241,N'��ݸ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (242,N'��Դ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (243,N'��ƽ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (244,N'��˳��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (245,N'�⿪��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (246,N'�����',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (247,N'��ɽ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (248,N'��Ҫ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (249,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (250,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (251,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (252,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (253,N'��ƽ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (254,N'��Դ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (255,N'��ɽ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (256,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (257,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (258,N'�ݶ���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (259,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (260,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (261,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (262,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (263,N'�Ҷ���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (264,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (265,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (266,N'��ƽ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (267,N'�ֲ���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (268,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (269,N'��������������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (270,N'��ƽ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (271,N'��ɽ׳������������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (272,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (273,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (274,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (275,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (276,N'½����',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (277,N'½����',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (278,N'�޶���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (279,N'ï����',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (280,N'÷��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (281,N'÷����',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (282,N'�ϰ���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (283,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (284,N'ƽԶ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (285,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (286,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (287,N'��Զ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (288,N'��ƽ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (289,N'�ʻ���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (290,N'��Դ����������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (291,N'��ͷ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (292,N'��β��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (293,N'�ع���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (294,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (295,N'ʼ����',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (296,N'�Ļ���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (297,N'��Ϫ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (298,N'̨ɽ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (299,N'��Դ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (300,N'�⴨��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (301,N'�廪��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (302,N'�·���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (303,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (304,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (305,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (306,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (307,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (308,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (309,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (310,N'��ɽ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (311,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (312,N'Ӣ����',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (313,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (314,N'�ư���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (315,N'�Ƹ���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (316,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (317,N'տ����',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (318,N'������',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (319,N'��ɽ��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (320,N'�麣��',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (321,N'�Ͻ���',N'�й�',N'�㶫ʡ',N'',null,null)
go
insert into City values (322,N'��������������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (323,N'��ɫ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (324,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (325,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (326,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (327,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (328,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (329,N'�Ϫ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (330,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (331,N'������������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (332,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (333,N'�±���',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (334,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (335,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (336,N'��������������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (337,N'���Ǹ���',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (338,N'��ɽ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (339,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (340,N'��������������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (341,N'��������������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (342,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (343,N'�����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (344,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (345,N'��ƽ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (346,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (347,N'��ɽ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (348,N'�ӳ���',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (349,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (350,N'����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (351,N'����ë����������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (352,N'��������������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (353,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (354,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (355,N'��ҵ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (356,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (357,N'�ٹ���',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (358,N'�鴨��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (359,N'��ɽ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (360,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (361,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (362,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (363,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (364,N'��ʤ����������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (365,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (366,N'¡����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (367,N'¡�ָ���������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (368,N'½����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (369,N'¹կ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (370,N'�޳�������������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (371,N'��ɽ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (372,N'��ɽ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (373,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (374,N'�ϵ���',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (375,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (376,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (377,N'ƽ����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (378,N'ƽ����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (379,N'ƽ����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (380,N'ƾ����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (381,N'�ֱ���',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (382,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (383,N'ȫ����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (384,N'����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (385,N'�ڰ���',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (386,N'��ˮ����������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (387,N'��������������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (388,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (389,N'��˼��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (390,N'����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (391,N'�����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (392,N'�����',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (393,N'�ﶫ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (394,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (395,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (396,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (397,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (398,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (399,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (400,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (401,N'�ó���',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (402,N'�˰���',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (403,N'��ҵ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (404,N'��˷��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (405,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (406,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (407,N'������',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (408,N'��ƽ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (409,N'��ɽ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (410,N'��Դ��',N'�й�',N'����׳��������',N'',null,null)
go
insert into City values (411,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (412,N'��˳��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (413,N'�Ͻ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (414,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (415,N'᯹���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (416,N'��˳��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (417,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (418,N'�ӽ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (419,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (420,N'��կ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (421,N'��������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (422,N'�½���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (423,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (424,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (425,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (426,N'��Ȫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (427,N'���벼��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (428,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (429,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (430,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (431,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (432,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (433,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (434,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (435,N'��ɳ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (436,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (437,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (438,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (439,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (440,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (441,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (442,N'����ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (443,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (444,N'�޵���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (445,N'�齭��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (446,N'��̶��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (447,N'��Ӻ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (448,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (449,N'ƽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (450,N'ƽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (451,N'�հ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (452,N'�ն���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (453,N'ǭ�������嶱��������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (454,N'ǭ�ϲ���������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (455,N'ǭ���ϲ���������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (456,N'ǭ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (457,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (458,N'��¡��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (459,N'�ʻ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (460,N'�Ž���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (461,N'����ˮ��������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (462,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (463,N'ʩ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (464,N'ʯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (465,N'ˮ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (466,N'˼����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (467,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (468,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (469,N'̨����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (470,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (471,N'ͩ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (472,N'ͭ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (473,N'��ɽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (474,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (475,N'���������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (476,N'�Ͱ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (477,N'������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (478,N'Ϣ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (479,N'ϰˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (480,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (481,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (482,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (483,N'�غ�������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (484,N'ӡ������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (485,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (486,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (487,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (488,N'��������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (489,N'��Զ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (490,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (491,N'֯����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (492,N'�������岼����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (493,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (494,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (495,N'��ɳ����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (496,N'��ͤ��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (497,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (498,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (499,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (500,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (501,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (502,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (503,N'�ֶ�����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (504,N'�ٸ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (505,N'��ˮ����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (506,N'��ɳȺ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (507,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (508,N'������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (509,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (510,N'�Ͳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (511,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (512,N'�Ĳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (513,N'��ָɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (514,N'��ɳȺ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (515,N'��ɳȺ���ĵ������亣��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (516,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (517,N'��ƽ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (518,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (519,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (520,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (521,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (522,N'��ͷ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (523,N'��Ұ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (524,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (525,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (526,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (527,N'�ɰ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (528,N'�е���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (529,N'�е���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (530,N'�����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (531,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (532,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (533,N'�󳧻���������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (534,N'�����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (535,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (536,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (537,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (538,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (539,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (540,N'��������������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (541,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (542,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (543,N'��ƽ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (544,N'�߱�����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (545,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (546,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (547,N'޻����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (548,N'��Դ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (549,N'�̰���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (550,N'�ʳ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (551,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (552,N'��ƽ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (553,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (554,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (555,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (556,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (557,N'�Ӽ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (558,N'��ˮ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (559,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (560,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (561,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (562,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (563,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (564,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (565,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (566,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (567,N'��¹��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (568,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (569,N'�������������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (570,N'�ˮ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (571,N'�Դ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (572,N'�ȷ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (573,N'��ͤ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (574,N'���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (575,N'�ٳ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (576,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (577,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (578,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (579,N'¡����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (580,N'¡Ң��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (581,N'¬����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (582,N'¹Ȫ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (583,N'�����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (584,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (585,N'��ƽ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (586,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (587,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (588,N'�ϴ����������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (589,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (590,N'�Ϲ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (591,N'�Ϻ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (592,N'��Ƥ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (593,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (594,N'ƽȪ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (595,N'ƽɽ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (596,N'ƽ����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (597,N'Ǩ����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (598,N'Ǩ����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (599,N'�ػʵ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (600,N'��������������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (601,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (602,N'�����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (603,N'��Է��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (604,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (605,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (606,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (607,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (608,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (609,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (610,N'�ݳ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (611,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (612,N'ɳ����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (613,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (614,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (615,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (616,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (617,N'ʯ��ׯ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (618,N'˳ƽ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (619,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (620,N'�ƺ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (621,N'��ɽ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (622,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (623,N'��ȫ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (624,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (625,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (626,N'Χ�������ɹ���������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (627,N'ε��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (628,N'κ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (629,N'�İ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (630,N'�޼���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (631,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (632,N'�䰲��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (633,N'��ǿ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (634,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (635,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (636,N'�����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (637,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (638,N'�º���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (639,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (640,N'��¡��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (641,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (642,N'��̨��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (643,N'��̨��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (644,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (645,N'��ˮ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (646,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (647,N'��ɽ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (648,N'��ԭ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (649,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (650,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (651,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (652,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (653,N'Ԫ����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (654,N'�޻���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (655,N'��ǿ��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (656,N'�ű���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (657,N'�żҿ���',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (658,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (659,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (660,N'��¹��',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (661,N'������',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (662,N'����',N'�й�',N'�ӱ�ʡ',N'',null,null)
go
insert into City values (663,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (664,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (665,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (666,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (667,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (668,N'��ԫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (669,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (670,N'�Ƿ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (671,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (672,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (673,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (674,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (675,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (676,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (677,N'��ʼ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (678,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (679,N'�ױ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (680,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (681,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (682,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (683,N'�괨��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (684,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (685,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (686,N'��Դ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (687,N'ۣ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (688,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (689,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (690,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (691,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (692,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (693,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (694,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (695,N'�鱦��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (696,N'¬����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (697,N'³ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (698,N'¹����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (699,N'�ﴨ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (700,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (701,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (702,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (703,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (704,N'�Ͻ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (705,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (706,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (707,N'��Ȩ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (708,N'�ڻ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (709,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (710,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (711,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (712,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (713,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (714,N'ƽ��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (715,N'ƽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (716,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (717,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (718,N'���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (719,N'���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (720,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (721,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (722,N'ȷɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (723,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (724,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (725,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (726,N'����Ͽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (727,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (728,N'�̳���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (729,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (730,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (731,N'�ϲ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (732,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (733,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (734,N'�ų���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (735,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (736,N'���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (737,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (738,N'̨ǰ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (739,N'̫����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (740,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (741,N'�ƺ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (742,N'ͨ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (743,N'ͩ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (744,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (745,N'ξ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (746,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (747,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (748,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (749,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (750,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (751,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (752,N'��Ͽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (753,N'Ϣ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (754,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (755,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (756,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (757,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (758,N'�°���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (759,N'�²���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (760,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (761,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (762,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (763,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (764,N'��Ұ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (765,N'��֣��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (766,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (767,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (768,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (769,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (770,N'۳����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (771,N'�ӽ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (772,N'��ʦ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (773,N'Ҷ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (774,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (775,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (776,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (777,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (778,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (779,N'�ݳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (780,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (781,N'ԭ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (782,N'�ϳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (783,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (784,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (785,N'֣����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (786,N'��Ĳ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (787,N'�ܿ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (788,N'פ�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (789,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (790,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (791,N'��Ȫ��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (792,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (793,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (794,N'����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (795,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (796,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (797,N'���˰������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (798,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (799,N'�Ŷ������ɹ���������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (800,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (801,N'��Զ��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (802,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (803,N'��ԣ��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (804,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (805,N'��������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (806,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (807,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (808,N'�׸���',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (809,N'�ں���',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (810,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (811,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (812,N'�봨��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (813,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (814,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (815,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (816,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (817,N'��ľ˹��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (818,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (819,N'�˶���',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (820,N'��ɽ��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (821,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (822,N'�ֵ���',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (823,N'�ֿ���',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (824,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (825,N'�ܱ���',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (826,N'��ɽ��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (827,N'��ˮ��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (828,N'Į����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (829,N'ĵ������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (830,N'ľ����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (831,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (832,N'ګ����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (833,N'�۽���',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (834,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (835,N'��̨����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (836,N'���������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (837,N'�����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (838,N'�찲��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (839,N'�ĺ���',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (840,N'��־��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (841,N'˫����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (842,N'˫Ѽɽ��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (843,N'�����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (844,N'��Һ���',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (845,N'�绯��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (846,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (847,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (848,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (849,N'̩����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (850,N'��ԭ��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (851,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (852,N'ͨ����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (853,N'ͬ����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (854,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (855,N'�峣��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (856,N'���������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (857,N'ѷ����',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (858,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (859,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (860,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (861,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (862,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (863,N'�ض���',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (864,N'��Դ��',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (865,N'������',N'�й�',N'������ʡ',N'',null,null)
go
insert into City values (866,N'��½��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (867,N'�Ͷ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (868,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (869,N'����������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (870,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (871,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (872,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (873,N'��ұ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (874,N'��������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (875,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (876,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (877,N'��ʩ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (878,N'��ʩ����������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (879,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (880,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (881,N'�ȳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (882,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (883,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (884,N'�׷���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (885,N'�찲��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (886,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (887,N'�Ƹ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (888,N'��÷��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (889,N'��ʯ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (890,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (891,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (892,N'��ʼ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (893,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (894,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (895,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (896,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (897,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (898,N'�Ϻӿ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (899,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (900,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (901,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (902,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (903,N'ޭ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (904,N'Ǳ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (905,N'ɳ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (906,N'��ũ������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (907,N'ʡֱϽ�ؼ�������λ',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (908,N'ʮ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (909,N'ʯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (910,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (911,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (912,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (913,N'ͨ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (914,N'ͨɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (915,N'�ŷ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (916,N'���������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (917,N'�人��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (918,N'��Ѩ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (919,N'�ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (920,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (921,N'�̷���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (922,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (923,N'�差��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (924,N'Т����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (925,N'Т����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (926,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (927,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (928,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (929,N'�˲���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (930,N'�˳���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (931,N'�˶���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (932,N'Ӧ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (933,N'Ӣɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (934,N'Զ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (935,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (936,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (937,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (938,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (939,N'֦����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (940,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (941,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (942,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (943,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (944,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (945,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (946,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (947,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (948,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (949,N'��ɳ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (950,N'��ɳ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (951,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (952,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (953,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (954,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (955,N'�ǲ�����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (956,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (957,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (958,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (959,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (960,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (961,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (962,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (963,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (964,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (965,N'�ⶫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (966,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (967,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (968,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (969,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (970,N'�齭��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (971,N'��ԫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (972,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (973,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (974,N'��ͬ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (975,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (976,N'�κ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (977,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (978,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (979,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (980,N'�������嶱��������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (981,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (982,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (983,N'��ˮ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (984,N'���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (985,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (986,N'��Դ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (987,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (988,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (989,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (990,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (991,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (992,N'¡����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (993,N'¦����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (994,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (995,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (996,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (997,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (998,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (999,N'��Զ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1000,N'ƽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1001,N'���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1002,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1003,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1004,N'ɣֲ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1005,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1006,N'�۶���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1007,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1008,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1009,N'ʯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1010,N'˫����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1011,N'˫����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1012,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1013,N'�ҽ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1014,N'��Դ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1015,N'ͨ������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1016,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1017,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1018,N'��̶��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1019,N'��̶��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1020,N'��������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1021,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1022,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1023,N'�»���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1024,N'�»ζ���������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1025,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1026,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1027,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1028,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1029,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1030,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1031,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1032,N'��˳��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1033,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1034,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1035,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1036,N'�佭��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1037,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1038,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1039,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1040,N'�żҽ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1041,N'�ƽ�����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1042,N'�з���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1043,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1044,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1045,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1046,N'��ͼ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1047,N'�׳���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1048,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1049,N'���׳�����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1050,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1051,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1052,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1053,N'�»���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1054,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1055,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1056,N'�ػ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1057,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1058,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1059,N'��������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1060,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1061,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1062,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1063,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1064,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1065,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1066,N'�Ժ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1067,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1068,N'��̨��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1069,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1070,N'��Դ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1071,N'�ٽ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1072,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1073,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1074,N'÷�ӿ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1075,N'ũ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1076,N'��ʯ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1077,N'ǰ������˹�ɹ���������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1078,N'Ǭ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1079,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1080,N'˫����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1081,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1082,N'��ԭ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1083,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1084,N'ͨ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1085,N'ͨ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1086,N'ͨ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1087,N'ͼ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1088,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1089,N'�ӱ߳�����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1090,N'�Ӽ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1091,N'��ͨ����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1092,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1093,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1094,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1095,N'��Ӧ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1096,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1097,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1098,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1099,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1100,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1101,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1102,N'��̨��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1103,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1104,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1105,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1106,N'�ߴ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1107,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1108,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1109,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1110,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1111,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1112,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1113,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1114,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1115,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1116,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1117,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1118,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1119,N'��̳��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1120,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1121,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1122,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1123,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1124,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1125,N'���Ƹ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1126,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1127,N'�Ͼ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1128,N'��ͨ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1129,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1130,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1131,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1132,N'�綫��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1133,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1134,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1135,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1136,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1137,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1138,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1139,N'��Ǩ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1140,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1141,N'̫����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1142,N'̩����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1143,N'̩����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1144,N'ͨ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1145,N'ͭɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1146,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1147,N'�⽭��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1148,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1149,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1150,N'�˻���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1151,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1152,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1153,N'�γ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1154,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1155,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1156,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1157,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1158,N'�żҸ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1159,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1160,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1161,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1162,N'��Զ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1163,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1164,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1165,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1166,N'�°���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1167,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1168,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1169,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1170,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1171,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1172,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1173,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1174,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1175,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1176,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1177,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1178,N'�߰���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1179,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1180,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1181,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1182,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1183,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1184,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1185,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1186,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1187,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1188,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1189,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1190,N'����ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1191,N'��������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1192,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1193,N'�Ž���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1194,N'�Ž���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1195,N'�ְ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1196,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1197,N'�质��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1198,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1199,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1200,N'«Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1201,N'�ϲ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1202,N'�ϲ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1203,N'�ϳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1204,N'�Ϸ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1205,N'�Ͽ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1206,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1207,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1208,N'Ƽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1209,N'۶����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1210,N'Ǧɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1211,N'ȫ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1212,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1213,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1214,N'�ϸ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1215,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1216,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1217,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1218,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1219,N'ʯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1220,N'�촨��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1221,N'̩����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1222,N'ͭ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1223,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1224,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1225,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1226,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1227,N'��Դ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1228,N'Ͽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1229,N'�¸���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1230,N'�½���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1231,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1232,N'�ŷ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1233,N'�˹���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1234,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1235,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1236,N'Ѱ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1237,N'�˴���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1238,N'�˷���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1239,N'�˻���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1240,N'߮����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1241,N'ӥ̶��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1242,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1243,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1244,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1245,N'�ڶ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1246,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1247,N'�཭��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1248,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1249,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1250,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1251,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1252,N'��Ʊ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1253,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1254,N'��Ϫ����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1255,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1256,N'��ͼ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1257,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1258,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1259,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1260,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1261,N'��ʯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1262,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1263,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1264,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1265,N'����ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1266,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1267,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1268,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1269,N'��˳��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1270,N'��˳��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1271,N'�����ɹ���������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1272,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1273,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1274,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1275,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1276,N'��«����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1277,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1278,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1279,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1280,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1281,N'�����������ɹ���������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1282,N'��ԭ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1283,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1284,N'�������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1285,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1286,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1287,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1288,N'�躣��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1289,N'��Դ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1290,N'�̽���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1291,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1292,N'��������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1293,N'��ԭ����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1294,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1295,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1296,N'̨����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1297,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1298,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1299,N'�߷�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1300,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1301,N'�±�����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1302,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1303,N'�˳���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1304,N'�������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1305,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1306,N'Ӫ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1307,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1308,N'ׯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1309,N'���͸���',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1310,N'����ɽ��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1311,N'��������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1312,N'����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1313,N'����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1314,N'��³�ƶ�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1315,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1316,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1317,N'��������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1318,N'��������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1319,N'�����׶���',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1320,N'��ͷ��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1321,N'������������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1322,N'���������ǰ��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1323,N'�������������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1324,N'�°Ͷ�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1325,N'�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1326,N'�����ï����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1327,N'��������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1328,N'�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1329,N'������������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1330,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1331,N'���������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1332,N'�������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1333,N'������˹��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1334,N'���״�������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1335,N'���п���',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1336,N'���п�ǰ��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1337,N'���¿���������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1338,N'����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1339,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1340,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1341,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1342,N'��������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1343,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1344,N'���ָ����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1345,N'���ͺ�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1346,N'���ױ�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1347,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1348,N'���ֹ�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1349,N'��������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1350,N'��³��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1351,N'�ƶ�������ǰ��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1352,N'�ƶ�����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1353,N'�ƶ����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1354,N'�ƶ�����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1355,N'��ʲ������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1356,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1357,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1358,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1359,N'��������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1360,N'Ī�����ߴ��Ӷ���������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1361,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1362,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1363,N'��ˮ����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1364,N'�̶���',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1365,N'��������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1366,N'����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1367,N'����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1368,N'̫������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1369,N'ͨ����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1370,N'ͻȪ��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1371,N'��Ĭ������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1372,N'��Ĭ������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1373,N'�п�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1374,N'��ţ����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1375,N'�ں���',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1376,N'�����غ���',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1377,N'������ǰ��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1378,N'����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1379,N'�����첼��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1380,N'����������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1381,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1382,N'��ԭ��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1383,N'�䴨��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1384,N'������������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1385,N'���ֹ�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1386,N'���ֺ�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1387,N'�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1388,N'�°Ͷ�������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1389,N'�°Ͷ�������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1390,N'�˰���',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1391,N'�˺���',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1392,N'����ʯ��',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1393,N'���������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1394,N'��������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1395,N'��������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1396,N'��³����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1397,N'������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1398,N'�������',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1399,N'׼�����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1400,N'׿����',N'�й�',N'���ɹ�������',N'',null,null)
go
insert into City values (1401,N'��ԭ��',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1402,N'��ԭ��',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1403,N'������',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1404,N'��Դ��',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1405,N'������',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1406,N'¡����',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1407,N'���Ļ���������',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1408,N'������',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1409,N'ƽ����',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1410,N'��ͭϿ��',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1411,N'ʯ��ɽ��',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1412,N'ͬ����',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1413,N'������',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1414,N'������',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1415,N'�γ���',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1416,N'������',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1417,N'������',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1418,N'������',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1419,N'������',N'�й�',N'���Ļ���������',N'',null,null)
go
insert into City values (1420,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1421,N'�ƶ���',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1422,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1423,N'��ͨ��������������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1424,N'�������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1425,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1426,N'�ʵ���',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1427,N'�ղ���',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1428,N'���ľ��',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1429,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1430,N'�����',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1431,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1432,N'�������������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1433,N'��������������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1434,N'��������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1435,N'���ϲ���������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1436,N'�����ɹ������������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1437,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1438,N'�����ɹ���������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1439,N'��������������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1440,N'��¡����������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1441,N'���ϲ���������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1442,N'��Դ��',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1443,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1444,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1445,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1446,N'�ֶ���',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1447,N'�����',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1448,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1449,N'��Դ����������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1450,N'��ͻ�������������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1451,N'��ǫ��',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1452,N'ƽ����',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1453,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1454,N'��������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1455,N'�����',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1456,N'ͬ����',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1457,N'ͬ����',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1458,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1459,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1460,N'�˺���',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1461,N'ѭ��������������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1462,N'��������������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1463,N'������',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1464,N'�Ӷ���',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1465,N'�����',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1466,N'�ζ���',N'�й�',N'�ຣʡ',N'',null,null)
go
insert into City values (1467,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1468,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1469,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1470,N'��ɽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1471,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1472,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1473,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1474,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1475,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1476,N'��ƽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1477,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1478,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1479,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1480,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1481,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1482,N'��ƽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1483,N'��Ӫ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1484,N'�ʳ���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1485,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1486,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1487,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1488,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1489,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1490,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1491,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1492,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1493,N'��̨��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1494,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1495,N'��ī��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1496,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1497,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1498,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1499,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1500,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1501,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1502,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1503,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1504,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1505,N'��Ұ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1506,N'۲����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1507,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1508,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1509,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1510,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1511,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1512,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1513,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1514,N'��ɽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1515,N'�ĳ���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1516,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1517,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1518,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1519,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1520,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1521,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1522,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1523,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1524,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1525,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1526,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1527,N'ƽ����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1528,N'ƽ����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1529,N'ƽ����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1530,N'ƽԭ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1531,N'��ϼ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1532,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1533,N'�ൺ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1534,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1535,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1536,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1537,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1538,N'�ٳ���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1539,N'��ɽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1540,N'�̺���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1541,N'�ٹ���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1542,N'��ˮ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1543,N'̩����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1544,N'۰����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1545,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1546,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1547,N'΢ɽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1548,N'Ϋ����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1549,N'�ĵ���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1550,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1551,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1552,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1553,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1554,N'�Ľ���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1555,N'ݷ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1556,N'��̩��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1557,N'��̨��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1558,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1559,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1560,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1561,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1562,N'��ˮ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1563,N'��Դ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1564,N'��̨��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1565,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1566,N'۩����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1567,N'��ׯ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1568,N'մ����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1569,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1570,N'��Զ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1571,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1572,N'�Ͳ���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1573,N'�޳���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1574,N'��ƽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1575,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1576,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1577,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1578,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1579,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1580,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1581,N'��ͬ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1582,N'��ͬ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1583,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1584,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1585,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1586,N'��ɽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1587,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1588,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1589,N'��ɽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1590,N'��ƽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1591,N'�Ž���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1592,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1593,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1594,N'��˳��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1595,N'�ӽ���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1596,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1597,N'�鶴��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1598,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1599,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1600,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1601,N'��Դ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1602,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1603,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1604,N'�ɽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1605,N'���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1606,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1607,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1608,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1609,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1610,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1611,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1612,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1613,N'���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1614,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1615,N'�ٷ���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1616,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1617,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1618,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1619,N'��ʯ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1620,N'�괨��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1621,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1622,N'¦����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1623,N'º����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1624,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1625,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1626,N'ƫ����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1627,N'ƽ����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1628,N'ƽ½��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1629,N'ƽ˳��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1630,N'ƽң��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1631,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1632,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1633,N'��ˮ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1634,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1635,N'��Դ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1636,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1637,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1638,N'�ǳ���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1639,N'ɽ����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1640,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1641,N'ʯ¥��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1642,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1643,N'˷����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1644,N'̫����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1645,N'̫ԭ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1646,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1647,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1648,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1649,N'��ˮ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1650,N'��ϲ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1651,N'��̨��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1652,N'��կ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1653,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1654,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1655,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1656,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1657,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1658,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1659,N'��ԫ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1660,N'Т����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1661,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1662,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1663,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1664,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1665,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1666,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1667,N'��Ȫ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1668,N'�����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1669,N'Ӧ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1670,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1671,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1672,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1673,N'����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1674,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1675,N'ԫ����',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1676,N'ԭƽ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1677,N'�˳���',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1678,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1679,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1680,N'��Ȩ��',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1681,N'������',N'�й�',N'ɽ��ʡ',N'',null,null)
go
insert into City values (1682,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1683,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1684,N'�׺���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1685,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1686,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1687,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1688,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1689,N'�ǹ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1690,N'�γ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1691,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1692,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1693,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1694,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1695,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1696,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1697,N'��ƺ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1698,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1699,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1700,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1701,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1702,N'��Ȫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1703,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1704,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1705,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1706,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1707,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1708,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1709,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1710,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1711,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1712,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1713,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1714,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1715,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1716,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1717,N'᰸���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1718,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1719,N'��Ȫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1720,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1721,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1722,N'¤��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1723,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1724,N'�崨��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1725,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1726,N'ü��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1727,N'��֬��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1728,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1729,N'��֣��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1730,N'��ǿ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1731,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1732,N'ƽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1733,N'�ѳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1734,N'�ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1735,N'ǧ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1736,N'Ǭ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1737,N'�彧��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1738,N'��ԭ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1739,N'ɽ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1740,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1741,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1742,N'��ľ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1743,N'ʯȪ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1744,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1745,N'̫����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1746,N'ͭ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1747,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1748,N'μ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1749,N'�Ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1750,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1751,N'�书��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1752,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1753,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1754,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1755,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1756,N'Ѯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1757,N'Ѯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1758,N'�Ӱ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1759,N'�ӳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1760,N'�Ӵ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1761,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1762,N'�˴���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1763,N'�˾���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1764,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1765,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1766,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1767,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1768,N'��ƺ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1769,N'־����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1770,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1771,N'�ӳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1772,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1773,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1774,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (1775,N'�Ϻ���',N'�й�',N'�Ϻ���',N'',null,null)
go
insert into City values (1776,N'������',N'�й�',N'�Ϻ���',N'',null,null)
go
insert into City values (1777,N'���Ӳ���Ǽ��������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1778,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1779,N'����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1780,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1781,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1782,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1783,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1784,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1785,N'����Ǽ��������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1786,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1787,N'��Ϫ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1788,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1789,N'�ɶ���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1790,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1791,N'����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1792,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1793,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1794,N'��Ӣ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1795,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1796,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1797,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1798,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1799,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1800,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1801,N'�²���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1802,N'�¸���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1803,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1804,N'��������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1805,N'�������������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1806,N'��üɽ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1807,N'��˳��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1808,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1809,N'���β���������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1810,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1811,N'����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1812,N'����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1813,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1814,N'�㰲��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1815,N'�㺺��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1816,N'��Ԫ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1817,N'��Դ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1818,N'�Ͻ���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1819,N'��ˮ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1820,N'��ԭ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1821,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1822,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1823,N'�ᶫ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1824,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1825,N'�н���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1826,N'��Ϊ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1827,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1828,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1829,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1830,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1831,N'����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1832,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1833,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1834,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1835,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1836,N'��կ����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1837,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1838,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1839,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1840,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1841,N'��ɽ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1842,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1843,N'�ײ���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1844,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1845,N'����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1846,N'��ɽ����������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1847,N'��ˮ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1848,N'¡����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1849,N'«ɽ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1850,N'����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1851,N'����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1852,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1853,N'¯����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1854,N'�޽���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1855,N'�������������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1856,N'�������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1857,N'ï��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1858,N'üɽ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1859,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1860,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1861,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1862,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1863,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1864,N'��ɽ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1865,N'ľ�����������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1866,N'�崨��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1867,N'�ڽ���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1868,N'�ϲ���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1869,N'�ϳ���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1870,N'�Ͻ���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1871,N'��Ϫ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1872,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1873,N'��֦����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1874,N'��ɽ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1875,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1876,N'���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1877,N'��Ϫ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1878,N'ۯ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1879,N'ƽ����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1880,N'ƽ����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1881,N'��ɽ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1882,N'�ѽ���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1883,N'�ո���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1884,N'�ന��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1885,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1886,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1887,N'����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1888,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1889,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1890,N'����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1891,N'��������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1892,N'��̨��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1893,N'ɫ����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1894,N'�����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1895,N'ʲ����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1896,N'ʯ����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1897,N'ʯ����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1898,N'˫����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1899,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1900,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1901,N'��ȫ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1902,N'ͨ����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1903,N'��Դ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1904,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1905,N'��Զ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1906,N'�봨��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1907,N'��ʤ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1908,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1909,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1910,N'ϲ����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1911,N'�����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1912,N'С����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1913,N'�½���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1914,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1915,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1916,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1917,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1918,N'�Ű���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1919,N'�Ž���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1920,N'�α���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1921,N'��ͤ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1922,N'��Դ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1923,N'��¤��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1924,N'�˱���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1925,N'�˱���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1926,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1927,N'Ӫɽ��',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1928,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1929,N'Խ����',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1930,N'�Ѿ���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1931,N'�н���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1932,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1933,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1934,N'������',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1935,N'�Թ���',N'�й�',N'�Ĵ�ʡ',N'',null,null)
go
insert into City values (1936,N'������',N'�й�',N'̨��ʡ',N'',null,null)
go
insert into City values (1937,N'��¡��',N'�й�',N'̨��ʡ',N'',null,null)
go
insert into City values (1938,N'̨����',N'�й�',N'̨��ʡ',N'',null,null)
go
insert into City values (1939,N'̨����',N'�й�',N'̨��ʡ',N'',null,null)
go
insert into City values (1940,N'̨����',N'�й�',N'̨��ʡ',N'',null,null)
go
insert into City values (1941,N'��Դ��',N'�й�',N'̨��ʡ',N'',null,null)
go
insert into City values (1942,N'������',N'�й�',N'̨��ʡ',N'',null,null)
go
insert into City values (1943,N'������',N'�й�',N'̨��ʡ',N'',null,null)
go
insert into City values (1944,N'����',N'�й�',N'�����',N'',null,null)
go
insert into City values (1945,N'������',N'�й�',N'�����',N'',null,null)
go
insert into City values (1946,N'������',N'�й�',N'�����',N'',null,null)
go
insert into City values (1947,N'�����',N'�й�',N'�����',N'',null,null)
go
insert into City values (1948,N'�������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1949,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1950,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1951,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1952,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1953,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1954,N'�����',N'�й�',N'����������',N'',null,null)
go
insert into City values (1955,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1956,N'�߰���',N'�й�',N'����������',N'',null,null)
go
insert into City values (1957,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1958,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1959,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1960,N'��������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1961,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1962,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1963,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1964,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1965,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1966,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1967,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1968,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1969,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1970,N'����������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1971,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1972,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1973,N'�ڰ���',N'�й�',N'����������',N'',null,null)
go
insert into City values (1974,N'�Ｊ��',N'�й�',N'����������',N'',null,null)
go
insert into City values (1975,N'����������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1976,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1977,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1978,N'��¡��',N'�й�',N'����������',N'',null,null)
go
insert into City values (1979,N'�Ӳ���',N'�й�',N'����������',N'',null,null)
go
insert into City values (1980,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1981,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1982,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1983,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1984,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1985,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1986,N'����',N'�й�',N'����������',N'',null,null)
go
insert into City values (1987,N'�˿�����',N'�й�',N'����������',N'',null,null)
go
insert into City values (1988,N'��������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1989,N'��֥����',N'�й�',N'����������',N'',null,null)
go
insert into City values (1990,N'��֥��',N'�й�',N'����������',N'',null,null)
go
insert into City values (1991,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1992,N'¡����',N'�й�',N'����������',N'',null,null)
go
insert into City values (1993,N'��¡��',N'�й�',N'����������',N'',null,null)
go
insert into City values (1994,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1995,N'â����',N'�й�',N'����������',N'',null,null)
go
insert into City values (1996,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (1997,N'ī����',N'�й�',N'����������',N'',null,null)
go
insert into City values (1998,N'ī�񹤿���',N'�й�',N'����������',N'',null,null)
go
insert into City values (1999,N'��������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2000,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2001,N'�˶���',N'�й�',N'����������',N'',null,null)
go
insert into City values (2002,N'��ľ����',N'�й�',N'����������',N'',null,null)
go
insert into City values (2003,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2004,N'��ľ��',N'�й�',N'����������',N'',null,null)
go
insert into City values (2005,N'����ľ��',N'�й�',N'����������',N'',null,null)
go
insert into City values (2006,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2007,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2008,N'�����',N'�й�',N'����������',N'',null,null)
go
insert into City values (2009,N'��ˮ��',N'�й�',N'����������',N'',null,null)
go
insert into City values (2010,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2011,N'�ʲ���',N'�й�',N'����������',N'',null,null)
go
insert into City values (2012,N'�տ������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2013,N'�տ�����',N'�й�',N'����������',N'',null,null)
go
insert into City values (2014,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2015,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2016,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2017,N'ɣ����',N'�й�',N'����������',N'',null,null)
go
insert into City values (2018,N'ɽ�ϵ���',N'�й�',N'����������',N'',null,null)
go
insert into City values (2019,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2020,N'����',N'�й�',N'����������',N'',null,null)
go
insert into City values (2021,N'лͨ����',N'�й�',N'����������',N'',null,null)
go
insert into City values (2022,N'�Ƕ���',N'�й�',N'����������',N'',null,null)
go
insert into City values (2023,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2024,N'������',N'�й�',N'����������',N'',null,null)
go
insert into City values (2025,N'�ٰ���',N'�й�',N'����������',N'',null,null)
go
insert into City values (2026,N'����',N'�й�',N'����������',N'',null,null)
go
insert into City values (2027,N'����ر�������',N'�й�',N'����ر�������',N'',null,null)
go
insert into City values (2028,N'��������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2029,N'�����յ���',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2030,N'��������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2031,N'��������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2032,N'��������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2033,N'����̩����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2034,N'����̩��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2035,N'��ͼʲ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2036,N'��������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2037,N'�ͳ���',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2038,N'������������������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2039,N'���������ɹ�������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2040,N'�ݳ���',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2041,N'���������ɹ�������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2042,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2043,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2044,N'��������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2045,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2046,N'�첼�������������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2047,N'��������������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2048,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2049,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2050,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2051,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2052,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2053,N'٤ʦ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2054,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2055,N'���ͺ���',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2056,N'���ܵ���',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2057,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2058,N'�Ͳ��������ɹ�������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2059,N'�;���',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2060,N'��˶��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2061,N'�������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2062,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2063,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2064,N'��ͼ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2065,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2066,N'��ľ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2067,N'��ľ������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2068,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2069,N'��ʲ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2070,N'��ʲ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2071,N'��ƺ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2072,N'����������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2073,N'�������տ¶�����������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2074,N'�⳵��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2075,N'�������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2076,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2077,N'��̨��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2078,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2079,N'����˹��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2080,N'�������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2081,N'�����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2082,N'ī����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2083,N'ľ�ݹ�����������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2084,N'���տ���',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2085,N'Ƥɽ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2086,N'��̨��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2087,N'��ĩ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2088,N'�����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2089,N'��Ǽ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2090,N'ɳ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2091,N'ɳ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2092,N'ɯ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2093,N'۷����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2094,N'ʯ������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2095,N'�踽��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2096,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2097,N'���ǵ���',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2098,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2099,N'��ʲ�����������������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2100,N'�ؿ�˹��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2101,N'ͼľ�����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2102,N'��³������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2103,N'��³����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2104,N'�п�ѷ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2105,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2106,N'ξ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2107,N'��Ȫ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2108,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2109,N'��³ľ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2110,N'��³ľ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2111,N'��ǡ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2112,N'��ʲ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2113,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2114,N'�������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2115,N'�º���',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2116,N'��Դ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2117,N'���Ȼ���������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2118,N'Ҷ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2119,N'���������������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2120,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2121,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2122,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2123,N'Ӣ��ɳ��',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2124,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2125,N'ԣ����',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2126,N'���պ���',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2127,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2128,N'������',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2129,N'������ֱϽ�ؼ�������λ',N'�й�',N'�½�ά���������',N'',null,null)
go
insert into City values (2130,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2131,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2132,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2133,N'��Դ����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2134,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2135,N'�ʹ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2136,N'�ν���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2137,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2138,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2139,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2140,N'�������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2141,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2142,N'��Ҧ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2143,N'�º���徰����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2144,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2145,N'�������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2146,N'��ɽ����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2147,N'��Դ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2148,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2149,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2150,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2151,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2152,N'��Դ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2153,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2154,N'�����������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2155,N'��ɽ������ŭ��������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2156,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2157,N'�ӿ�����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2158,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2159,N'��ӹ���������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2160,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2161,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2162,N'��ƺ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2163,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2164,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2165,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2166,N'���ǹ���������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2167,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2168,N'��ƽ�����������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2169,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2170,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2171,N'���ȴ�������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2172,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2173,N'��Զ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2174,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2175,N'��ƺ����������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2176,N'����������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2177,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2178,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2179,N'�ٲ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2180,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2181,N'¤����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2182,N'��ˮ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2183,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2184,N'³����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2185,N'½����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2186,N'»����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2187,N'»Ȱ��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2188,N'º����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2189,N'�̴���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2190,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2191,N'��������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2192,N'�����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2193,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2194,N'�º���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2195,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2196,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2197,N'������������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2198,N'�ֶ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2199,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2200,N'ī��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2201,N'Ĳ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2202,N'�ϻ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2203,N'�Ͻ�����������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2204,N'��������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2205,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2206,N'ŭ��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2207,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2208,N'�ն���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2209,N'�ɼ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2210,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2211,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2212,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2213,N'ʦ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2214,N'ʩ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2215,N'ʯ������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2216,N'ʯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2217,N'˫����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2218,N'˫�����������岼�������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2219,N'ˮ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2220,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2221,N'�罭��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2222,N'�ڳ���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2223,N'ͨ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2224,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2225,N'Ρɽ�������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2226,N'ά��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2227,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2228,N'��ɽ׳������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2229,N'�䶨��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2230,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2231,N'��������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2232,N'��˫���ɴ���������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2233,N'���������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2234,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2235,N'��ƽ�������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2236,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2237,N'Ѱ���������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2238,N'�ν���',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2239,N'��ɽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2240,N'�������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2241,N'Ҧ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2242,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2243,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2244,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2245,N'ӯ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2246,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2247,N'��ƽ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2248,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2249,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2250,N'��ʤ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2251,N'����������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2252,N'��Ϫ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2253,N'Ԫ���������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2254,N'Ԫı��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2255,N'Ԫ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2256,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2257,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2258,N'մ����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2259,N'��ͨ��',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2260,N'����',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2261,N'������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2262,N'�������������������������',N'�й�',N'����ʡ',N'',null,null)
go
insert into City values (2263,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2264,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2265,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2266,N'��ɽ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2267,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2268,N'��Ϫ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2269,N'�ɽ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2270,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2271,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2272,N'��ͷ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2273,N'���',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2274,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2275,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2276,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2277,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2278,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2279,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2280,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2281,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2282,N'��ɽ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2283,N'����',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2284,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2285,N'�������������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2286,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2287,N'��Ϫ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2288,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2289,N'��ˮ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2290,N'�ٰ���',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2291,N'�ٺ���',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2292,N'��Ȫ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2293,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2294,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2295,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2296,N'�Ͱ���',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2297,N'ƽ����',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2298,N'ƽ����',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2299,N'�ֽ���',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2300,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2301,N'��Ԫ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2302,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2303,N'����',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2304,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2305,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2306,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2307,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2308,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2309,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2310,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2311,N'�����',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2312,N'̨����',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2313,N'̩˳��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2314,N'��̨��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2315,N'ͩ®��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2316,N'ͩ����',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2317,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2318,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2319,N'�ĳ���',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2320,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2321,N'�ɾ���',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2322,N'��ɽ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2323,N'�²���',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2324,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2325,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2326,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2327,N'��Ҧ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2328,N'����',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2329,N'�ƺ���',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2330,N'��ɽ��',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2331,N'������',N'�й�',N'�㽭ʡ',N'',null,null)
go
insert into City values (2332,N'�ɽ��',N'�й�',N'������',N'',null,null)
go
insert into City values (2333,N'�ǿ���',N'�й�',N'������',N'',null,null)
go
insert into City values (2334,N'������',N'�й�',N'������',N'',null,null)
go
insert into City values (2335,N'�潭��',N'�й�',N'������',N'',null,null)
go
insert into City values (2336,N'�ᶼ��',N'�й�',N'������',N'',null,null)
go
insert into City values (2337,N'�����',N'�й�',N'������',N'',null,null)
go
insert into City values (2338,N'����',N'�й�',N'������',N'',null,null)
go
insert into City values (2339,N'��ƽ��',N'�й�',N'������',N'',null,null)
go
insert into City values (2340,N'��ˮ����������������',N'�й�',N'������',N'',null,null)
go
insert into City values (2341,N'�뽭��',N'�й�',N'������',N'',null,null)
go
insert into City values (2342,N'�ٲ���',N'�й�',N'������',N'',null,null)
go
insert into City values (2343,N'ʯ��������������',N'�й�',N'������',N'',null,null)
go
insert into City values (2344,N'ͭ����',N'�й�',N'������',N'',null,null)
go
insert into City values (2345,N'������',N'�й�',N'������',N'',null,null)
go
insert into City values (2346,N'��ɽ��',N'�й�',N'������',N'',null,null)
go
insert into City values (2347,N'��Ϫ��',N'�й�',N'������',N'',null,null)
go
insert into City values (2348,N'��¡��',N'�й�',N'������',N'',null,null)
go
insert into City values (2349,N'��ɽ����������������',N'�й�',N'������',N'',null,null)
go
insert into City values (2350,N'��������������������',N'�й�',N'������',N'',null,null)
go
insert into City values (2351,N'������',N'�й�',N'������',N'',null,null)
go
insert into City values (2352,N'����',N'�й�',N'������',N'',null,null)
go
insert into City values (2353,N'������',N'�й�',N'������',N'',null,null)
go
