--系统版本表
delete from appversion
go

insert into appversion values (N'6.0.0.0')
go

--系统功能表

--生成脚本
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
insert into SysFunction values (1010,N'录入纸发货计划',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1020,N'客户录入纸发货计划',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1021,N'录入纸直发货计划',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1022,N'客户录入纸直发货计划',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1028,N'录入罐发货计划',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1030,N'录入罐直发货计划',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1040,N'录入方便面发货计划',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1041,N'录入其它发货计划',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (1050,N'提交计划',1,1,1,1,0,0,0,1,0,0,0,0,0,null,null)
go
insert into SysFunction values (1060,N'客户审批纸发货计划',1,0,0,0,0,0,0,0,1,0,0,0,0,null,null)
go
insert into SysFunction values (1061,N'审批发货计划',1,0,0,0,0,0,0,0,1,0,0,0,0,null,null)
go
insert into SysFunction values (1070,N'查询计划',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (2010,N'调度计划',1,0,0,0,1,0,1,0,0,1,0,0,0,null,null)
go
insert into SysFunction values (2020,N'提交调度单',1,1,1,1,0,0,0,1,0,0,0,0,0,null,null)
go
insert into SysFunction values (3010,N'打印调度出仓单',1,0,0,0,0,0,0,0,0,1,0,0,1,null,null)
go
insert into SysFunction values (3020,N'打印划拨出仓单',1,0,0,0,0,0,0,0,0,0,0,0,1,null,null)
go
insert into SysFunction values (3030,N'提交出仓单',1,0,1,0,1,0,0,1,0,0,0,0,0,null,null)
go
insert into SysFunction values (3040,N'打印送货单',1,0,1,0,1,0,0,0,0,0,0,0,1,null,null)
go
insert into SysFunction values (3045,N'查询送货单',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (3050,N'接收送货单回单',1,0,1,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (3060,N'查询送货单回单',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (3070,N'补打出仓单',1,0,0,0,0,0,1,0,0,0,0,0,1,null,null)
go
insert into SysFunction values (3080,N'补打送货单',1,0,0,0,0,0,1,0,0,0,0,0,1,null,null)
go
insert into SysFunction values (4010,N'录入合同',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (4020,N'提交合同',1,0,1,1,0,0,0,1,0,0,0,0,0,null,null)
go
insert into SysFunction values (4030,N'打印合同',1,0,0,0,0,0,0,1,0,0,0,0,1,null,null)
go
insert into SysFunction values (4040,N'审批合同',1,0,0,0,0,0,0,0,1,0,0,0,0,null,null)
go
insert into SysFunction values (4050,N'冲帐处理',1,0,1,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (4051,N'查询冲帐记录',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (4060,N'罚款处理',1,0,1,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (4070,N'查询罚款记录',1,0,0,1,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (4080,N'查询合同审批信息',1,0,0,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5010,N'货物入库',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5011,N'货物出库',0,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5020,N'货物移库',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5030,N'查询入库记录',1,0,1,1,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (5040,N'查询出库记录',1,0,0,1,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (5041,N'查询移库记录',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5050,N'汇总收发存',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (5060,N'统计仓储力支费',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (5061,N'查询仓储力支费结算记录',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5070,N'查询寄库计划',1,0,0,0,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5080,N'打印盘点表',1,0,0,0,0,0,1,0,0,0,1,0,1,null,null)
go
insert into SysFunction values (5090,N'查询库存尾差',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (5100,N'尾差入库',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (5110,N'尾差出库',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6010,N'客户对帐',1,1,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (6020,N'承运单位对帐',1,1,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (6021,N'录入特殊结算价格',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6022,N'录入特殊承运价格',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6030,N'查询客户运费结算记录',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6040,N'查询承运单位运费结算记录',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6050,N'查询特殊结算价格',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (6060,N'查询特殊承运价格',1,0,0,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (7010,N'统计办事处总产值',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (7011,N'统计办事处毛利率',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (7020,N'统计客户总产值',1,0,0,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (7030,N'综合查询',1,0,1,0,0,0,1,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (9010,N'设置组织结构',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9020,N'设置岗位',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9030,N'设置员工档案',1,1,1,1,0,1,0,0,0,0,1,0,0,null,null)
go
insert into SysFunction values (9040,N'设置客户档案',1,1,1,1,0,0,0,0,0,0,1,1,0,null,null)
go
insert into SysFunction values (9050,N'设置登录帐号',1,1,1,1,1,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9060,N'设置权限组',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9070,N'分配权限',1,0,1,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9071,N'设置计划审批流程',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9072,N'设置价格审批流程',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9080,N'设置国家',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9090,N'设置省/州/自治区/直辖市',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9100,N'设置市/县/区/镇',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9110,N'设置货物类别',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9120,N'设置货物档案',1,1,1,1,0,0,1,0,0,0,1,1,0,null,null)
go
insert into SysFunction values (9130,N'设置承运单位档案',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9140,N'设置仓库',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9150,N'设置运费限价',1,1,1,1,0,0,1,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9151,N'设置收货单位档案',1,1,1,1,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9160,N'修改密码',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go
insert into SysFunction values (9170,N'初始化密码',1,0,0,0,0,0,0,0,0,0,0,0,0,null,null)
go

--组织结构表
delete from Organization
go
insert into Organization values (1,0,N'XXX公司',N'XXX公司',N'1\',N'',N'',N'',N'',N'',N'',null,null)
go

--岗位表
delete from Position
go
insert into Position values (1,N'系统管理员',N'',null,null)
go

--员工表
delete from staff
go
insert into staff values (1,N'',N'Admin',N'男',1,N'XXX公司',N'1\',1,N'系统管理员',N'',N'',N'',N'',N'',N'',N'',N'',0,0,0,getdate(),null,null)
go

--权限组表
delete from SysGroup
go
insert into SysGroup values (1,N'系统管理员组',N'',null,null)
go

--组权限表
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

--帐号表
delete from account
go
insert into account values (1,N'admin',N'f19b8dc2029cf707939e886e4b164681',N'员工',1,N'XXX公司',1,N'Admin',0,10000,1000000001,getdate(),null,null)
go

--帐号权限表
delete from AccountPermission 
go
insert into AccountPermission values (1,1,1,null,null)
go

--ID表
delete from IdGenerator
go
insert into IdGenerator values (NEWID(),1,N'admin',1,10000,10000,10000,1000000000,null,null)
go
insert into IdGenerator values (NEWID(),1,N'admin',0,1000000001,1000000001,1000000001,2000000000,null,null)
go

--国家表
delete from Country
go
insert into Country values (1,N'中国',N'',null,null)
go

--省份表
delete from Province
go
insert into Province values (1,N'台湾省',N'中国',N'',null,null)
go
insert into Province values (2,N'河南省',N'中国',N'',null,null)
go
insert into Province values (3,N'贵州省',N'中国',N'',null,null)
go
insert into Province values (4,N'海南省',N'中国',N'',null,null)
go
insert into Province values (5,N'新疆维吾尔自治区',N'中国',N'',null,null)
go
insert into Province values (6,N'黑龙江省',N'中国',N'',null,null)
go
insert into Province values (7,N'江西省',N'中国',N'',null,null)
go
insert into Province values (8,N'内蒙古自治区',N'中国',N'',null,null)
go
insert into Province values (9,N'宁夏回族自治区',N'中国',N'',null,null)
go
insert into Province values (10,N'广西壮族自治区',N'中国',N'',null,null)
go
insert into Province values (11,N'四川省',N'中国',N'',null,null)
go
insert into Province values (12,N'湖南省',N'中国',N'',null,null)
go
insert into Province values (13,N'安徽省',N'中国',N'',null,null)
go
insert into Province values (14,N'天津市',N'中国',N'',null,null)
go
insert into Province values (15,N'陕西省',N'中国',N'',null,null)
go
insert into Province values (16,N'湖北省',N'中国',N'',null,null)
go
insert into Province values (17,N'吉林省',N'中国',N'',null,null)
go
insert into Province values (18,N'上海市',N'中国',N'',null,null)
go
insert into Province values (19,N'北京市',N'中国',N'',null,null)
go
insert into Province values (20,N'山东省',N'中国',N'',null,null)
go
insert into Province values (21,N'西藏自治区',N'中国',N'',null,null)
go
insert into Province values (22,N'辽宁省',N'中国',N'',null,null)
go
insert into Province values (23,N'浙江省',N'中国',N'',null,null)
go
insert into Province values (24,N'澳门特别行政区',N'中国',N'',null,null)
go
insert into Province values (25,N'福建省',N'中国',N'',null,null)
go
insert into Province values (26,N'广东省',N'中国',N'',null,null)
go
insert into Province values (27,N'山西省',N'中国',N'',null,null)
go
insert into Province values (28,N'河北省',N'中国',N'',null,null)
go
insert into Province values (29,N'甘肃省',N'中国',N'',null,null)
go
insert into Province values (30,N'重庆市',N'中国',N'',null,null)
go
insert into Province values (31,N'青海省',N'中国',N'',null,null)
go
insert into Province values (32,N'香港特别行政区',N'中国',N'',null,null)
go
insert into Province values (33,N'江苏省',N'中国',N'',null,null)
go
insert into Province values (34,N'云南省',N'中国',N'',null,null)
go

--城市表
delete from City
go

insert into City values (1,N'安庆市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (2,N'蚌埠市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (3,N'亳州市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (4,N'长丰县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (5,N'巢湖市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (6,N'池州市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (7,N'滁州市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (8,N'枞阳县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (9,N'当涂县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (10,N'砀山县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (11,N'定远县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (12,N'东至县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (13,N'繁昌县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (14,N'肥东县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (15,N'肥西县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (16,N'凤台县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (17,N'凤阳县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (18,N'阜南县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (19,N'阜阳市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (20,N'固镇县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (21,N'广德县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (22,N'含山县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (23,N'合肥市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (24,N'和县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (25,N'怀宁县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (26,N'怀远县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (27,N'淮北市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (28,N'淮南市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (29,N'黄山市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (30,N'霍邱县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (31,N'霍山县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (32,N'绩溪县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (33,N'界首市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (34,N'金寨县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (35,N'泾县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (36,N'旌德县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (37,N'来安县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (38,N'郎溪县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (39,N'利辛县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (40,N'临泉县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (41,N'灵璧县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (42,N'六安市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (43,N'庐江县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (44,N'马鞍山市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (45,N'蒙城县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (46,N'明光市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (47,N'南陵县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (48,N'宁国市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (49,N'祁门县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (50,N'潜山县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (51,N'青阳县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (52,N'全椒县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (53,N'石台县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (54,N'寿县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (55,N'舒城县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (56,N'泗县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (57,N'宿松县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (58,N'宿州市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (59,N'濉溪县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (60,N'太和县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (61,N'太湖县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (62,N'天长市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (63,N'桐城市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (64,N'铜陵市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (65,N'铜陵县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (66,N'望江县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (67,N'涡阳县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (68,N'无为县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (69,N'芜湖市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (70,N'芜湖县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (71,N'五河县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (72,N'歙县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (73,N'萧县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (74,N'休宁县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (75,N'宣城市',N'中国',N'安徽省',N'',null,null)
go
insert into City values (76,N'黟县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (77,N'颍上县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (78,N'岳西县',N'中国',N'安徽省',N'',null,null)
go
insert into City values (79,N'澳门特别行政区',N'中国',N'澳门特别行政区',N'',null,null)
go
insert into City values (80,N'北京市',N'中国',N'北京市',N'',null,null)
go
insert into City values (81,N'密云县',N'中国',N'北京市',N'',null,null)
go
insert into City values (82,N'延庆县',N'中国',N'北京市',N'',null,null)
go
insert into City values (83,N'安溪县',N'中国',N'福建省',N'',null,null)
go
insert into City values (84,N'长乐市',N'中国',N'福建省',N'',null,null)
go
insert into City values (85,N'长泰县',N'中国',N'福建省',N'',null,null)
go
insert into City values (86,N'长汀县',N'中国',N'福建省',N'',null,null)
go
insert into City values (87,N'大田县',N'中国',N'福建省',N'',null,null)
go
insert into City values (88,N'德化县',N'中国',N'福建省',N'',null,null)
go
insert into City values (89,N'东山县',N'中国',N'福建省',N'',null,null)
go
insert into City values (90,N'福安市',N'中国',N'福建省',N'',null,null)
go
insert into City values (91,N'福鼎市',N'中国',N'福建省',N'',null,null)
go
insert into City values (92,N'福清市',N'中国',N'福建省',N'',null,null)
go
insert into City values (93,N'福州市',N'中国',N'福建省',N'',null,null)
go
insert into City values (94,N'古田县',N'中国',N'福建省',N'',null,null)
go
insert into City values (95,N'光泽县',N'中国',N'福建省',N'',null,null)
go
insert into City values (96,N'华安县',N'中国',N'福建省',N'',null,null)
go
insert into City values (97,N'惠安县',N'中国',N'福建省',N'',null,null)
go
insert into City values (98,N'建宁县',N'中国',N'福建省',N'',null,null)
go
insert into City values (99,N'建瓯市',N'中国',N'福建省',N'',null,null)
go
insert into City values (100,N'建阳市',N'中国',N'福建省',N'',null,null)
go
insert into City values (101,N'将乐县',N'中国',N'福建省',N'',null,null)
go
insert into City values (102,N'金门县',N'中国',N'福建省',N'',null,null)
go
insert into City values (103,N'晋江市',N'中国',N'福建省',N'',null,null)
go
insert into City values (104,N'连城县',N'中国',N'福建省',N'',null,null)
go
insert into City values (105,N'连江县',N'中国',N'福建省',N'',null,null)
go
insert into City values (106,N'龙海市',N'中国',N'福建省',N'',null,null)
go
insert into City values (107,N'龙岩市',N'中国',N'福建省',N'',null,null)
go
insert into City values (108,N'罗源县',N'中国',N'福建省',N'',null,null)
go
insert into City values (109,N'闽侯县',N'中国',N'福建省',N'',null,null)
go
insert into City values (110,N'闽清县',N'中国',N'福建省',N'',null,null)
go
insert into City values (111,N'明溪县',N'中国',N'福建省',N'',null,null)
go
insert into City values (112,N'南安市',N'中国',N'福建省',N'',null,null)
go
insert into City values (113,N'南靖县',N'中国',N'福建省',N'',null,null)
go
insert into City values (114,N'南平市',N'中国',N'福建省',N'',null,null)
go
insert into City values (115,N'宁德市',N'中国',N'福建省',N'',null,null)
go
insert into City values (116,N'宁化县',N'中国',N'福建省',N'',null,null)
go
insert into City values (117,N'平和县',N'中国',N'福建省',N'',null,null)
go
insert into City values (118,N'平潭县',N'中国',N'福建省',N'',null,null)
go
insert into City values (119,N'屏南县',N'中国',N'福建省',N'',null,null)
go
insert into City values (120,N'莆田市',N'中国',N'福建省',N'',null,null)
go
insert into City values (121,N'浦城县',N'中国',N'福建省',N'',null,null)
go
insert into City values (122,N'清流县',N'中国',N'福建省',N'',null,null)
go
insert into City values (123,N'泉州市',N'中国',N'福建省',N'',null,null)
go
insert into City values (124,N'三明市',N'中国',N'福建省',N'',null,null)
go
insert into City values (125,N'沙县',N'中国',N'福建省',N'',null,null)
go
insert into City values (126,N'上杭县',N'中国',N'福建省',N'',null,null)
go
insert into City values (127,N'邵武市',N'中国',N'福建省',N'',null,null)
go
insert into City values (128,N'石狮市',N'中国',N'福建省',N'',null,null)
go
insert into City values (129,N'寿宁县',N'中国',N'福建省',N'',null,null)
go
insert into City values (130,N'顺昌县',N'中国',N'福建省',N'',null,null)
go
insert into City values (131,N'松溪县',N'中国',N'福建省',N'',null,null)
go
insert into City values (132,N'泰宁县',N'中国',N'福建省',N'',null,null)
go
insert into City values (133,N'武平县',N'中国',N'福建省',N'',null,null)
go
insert into City values (134,N'武夷山市',N'中国',N'福建省',N'',null,null)
go
insert into City values (135,N'霞浦县',N'中国',N'福建省',N'',null,null)
go
insert into City values (136,N'厦门市',N'中国',N'福建省',N'',null,null)
go
insert into City values (137,N'仙游县',N'中国',N'福建省',N'',null,null)
go
insert into City values (138,N'永安市',N'中国',N'福建省',N'',null,null)
go
insert into City values (139,N'永春县',N'中国',N'福建省',N'',null,null)
go
insert into City values (140,N'永定县',N'中国',N'福建省',N'',null,null)
go
insert into City values (141,N'永泰县',N'中国',N'福建省',N'',null,null)
go
insert into City values (142,N'尤溪县',N'中国',N'福建省',N'',null,null)
go
insert into City values (143,N'云霄县',N'中国',N'福建省',N'',null,null)
go
insert into City values (144,N'漳平市',N'中国',N'福建省',N'',null,null)
go
insert into City values (145,N'漳浦县',N'中国',N'福建省',N'',null,null)
go
insert into City values (146,N'漳州市',N'中国',N'福建省',N'',null,null)
go
insert into City values (147,N'诏安县',N'中国',N'福建省',N'',null,null)
go
insert into City values (148,N'柘荣县',N'中国',N'福建省',N'',null,null)
go
insert into City values (149,N'政和县',N'中国',N'福建省',N'',null,null)
go
insert into City values (150,N'周宁县',N'中国',N'福建省',N'',null,null)
go
insert into City values (151,N'阿克塞哈萨克族自治县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (152,N'白银市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (153,N'成县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (154,N'崇信县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (155,N'宕昌县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (156,N'迭部县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (157,N'定西市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (158,N'东乡族自治县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (159,N'敦煌市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (160,N'甘谷县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (161,N'甘南藏族自治州',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (162,N'皋兰县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (163,N'高台县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (164,N'古浪县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (165,N'瓜州县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (166,N'广河县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (167,N'合水县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (168,N'合作市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (169,N'和政县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (170,N'华池县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (171,N'华亭县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (172,N'环县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (173,N'徽县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (174,N'会宁县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (175,N'积石山保安族东乡族撒拉族自治县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (176,N'嘉峪关市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (177,N'金昌市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (178,N'金塔县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (179,N'泾川县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (180,N'景泰县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (181,N'靖远县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (182,N'静宁县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (183,N'酒泉市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (184,N'康乐县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (185,N'康县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (186,N'兰州市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (187,N'礼县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (188,N'两当县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (189,N'临潭县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (190,N'临洮县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (191,N'临夏回族自治州',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (192,N'临夏市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (193,N'临夏县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (194,N'临泽县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (195,N'灵台县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (196,N'陇南市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (197,N'陇西县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (198,N'碌曲县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (199,N'玛曲县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (200,N'民乐县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (201,N'民勤县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (202,N'岷县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (203,N'宁县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (204,N'平凉市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (205,N'秦安县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (206,N'清水县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (207,N'庆城县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (208,N'庆阳市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (209,N'山丹县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (210,N'肃北蒙古族自治县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (211,N'肃南裕固族自治县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (212,N'天水市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (213,N'天祝藏族自治县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (214,N'通渭县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (215,N'渭源县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (216,N'文县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (217,N'武山县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (218,N'武威市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (219,N'西和县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (220,N'夏河县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (221,N'永昌县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (222,N'永登县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (223,N'永靖县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (224,N'榆中县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (225,N'玉门市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (226,N'张家川回族自治县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (227,N'张掖市',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (228,N'漳县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (229,N'镇原县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (230,N'正宁县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (231,N'舟曲县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (232,N'庄浪县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (233,N'卓尼县',N'中国',N'甘肃省',N'',null,null)
go
insert into City values (234,N'博罗县',N'中国',N'广东省',N'',null,null)
go
insert into City values (235,N'潮安县',N'中国',N'广东省',N'',null,null)
go
insert into City values (236,N'潮州市',N'中国',N'广东省',N'',null,null)
go
insert into City values (237,N'从化市',N'中国',N'广东省',N'',null,null)
go
insert into City values (238,N'大埔县',N'中国',N'广东省',N'',null,null)
go
insert into City values (239,N'德庆县',N'中国',N'广东省',N'',null,null)
go
insert into City values (240,N'电白县',N'中国',N'广东省',N'',null,null)
go
insert into City values (241,N'东莞市',N'中国',N'广东省',N'',null,null)
go
insert into City values (242,N'东源县',N'中国',N'广东省',N'',null,null)
go
insert into City values (243,N'恩平市',N'中国',N'广东省',N'',null,null)
go
insert into City values (244,N'丰顺县',N'中国',N'广东省',N'',null,null)
go
insert into City values (245,N'封开县',N'中国',N'广东省',N'',null,null)
go
insert into City values (246,N'佛冈县',N'中国',N'广东省',N'',null,null)
go
insert into City values (247,N'佛山市',N'中国',N'广东省',N'',null,null)
go
insert into City values (248,N'高要市',N'中国',N'广东省',N'',null,null)
go
insert into City values (249,N'高州市',N'中国',N'广东省',N'',null,null)
go
insert into City values (250,N'广宁县',N'中国',N'广东省',N'',null,null)
go
insert into City values (251,N'广州市',N'中国',N'广东省',N'',null,null)
go
insert into City values (252,N'海丰县',N'中国',N'广东省',N'',null,null)
go
insert into City values (253,N'和平县',N'中国',N'广东省',N'',null,null)
go
insert into City values (254,N'河源市',N'中国',N'广东省',N'',null,null)
go
insert into City values (255,N'鹤山市',N'中国',N'广东省',N'',null,null)
go
insert into City values (256,N'化州市',N'中国',N'广东省',N'',null,null)
go
insert into City values (257,N'怀集县',N'中国',N'广东省',N'',null,null)
go
insert into City values (258,N'惠东县',N'中国',N'广东省',N'',null,null)
go
insert into City values (259,N'惠来县',N'中国',N'广东省',N'',null,null)
go
insert into City values (260,N'惠州市',N'中国',N'广东省',N'',null,null)
go
insert into City values (261,N'江门市',N'中国',N'广东省',N'',null,null)
go
insert into City values (262,N'蕉岭县',N'中国',N'广东省',N'',null,null)
go
insert into City values (263,N'揭东县',N'中国',N'广东省',N'',null,null)
go
insert into City values (264,N'揭西县',N'中国',N'广东省',N'',null,null)
go
insert into City values (265,N'揭阳市',N'中国',N'广东省',N'',null,null)
go
insert into City values (266,N'开平市',N'中国',N'广东省',N'',null,null)
go
insert into City values (267,N'乐昌市',N'中国',N'广东省',N'',null,null)
go
insert into City values (268,N'雷州市',N'中国',N'广东省',N'',null,null)
go
insert into City values (269,N'连南瑶族自治县',N'中国',N'广东省',N'',null,null)
go
insert into City values (270,N'连平县',N'中国',N'广东省',N'',null,null)
go
insert into City values (271,N'连山壮族瑶族自治县',N'中国',N'广东省',N'',null,null)
go
insert into City values (272,N'连州市',N'中国',N'广东省',N'',null,null)
go
insert into City values (273,N'廉江市',N'中国',N'广东省',N'',null,null)
go
insert into City values (274,N'龙川县',N'中国',N'广东省',N'',null,null)
go
insert into City values (275,N'龙门县',N'中国',N'广东省',N'',null,null)
go
insert into City values (276,N'陆丰市',N'中国',N'广东省',N'',null,null)
go
insert into City values (277,N'陆河县',N'中国',N'广东省',N'',null,null)
go
insert into City values (278,N'罗定市',N'中国',N'广东省',N'',null,null)
go
insert into City values (279,N'茂名市',N'中国',N'广东省',N'',null,null)
go
insert into City values (280,N'梅县',N'中国',N'广东省',N'',null,null)
go
insert into City values (281,N'梅州市',N'中国',N'广东省',N'',null,null)
go
insert into City values (282,N'南澳县',N'中国',N'广东省',N'',null,null)
go
insert into City values (283,N'南雄市',N'中国',N'广东省',N'',null,null)
go
insert into City values (284,N'平远县',N'中国',N'广东省',N'',null,null)
go
insert into City values (285,N'普宁市',N'中国',N'广东省',N'',null,null)
go
insert into City values (286,N'清新县',N'中国',N'广东省',N'',null,null)
go
insert into City values (287,N'清远市',N'中国',N'广东省',N'',null,null)
go
insert into City values (288,N'饶平县',N'中国',N'广东省',N'',null,null)
go
insert into City values (289,N'仁化县',N'中国',N'广东省',N'',null,null)
go
insert into City values (290,N'乳源瑶族自治县',N'中国',N'广东省',N'',null,null)
go
insert into City values (291,N'汕头市',N'中国',N'广东省',N'',null,null)
go
insert into City values (292,N'汕尾市',N'中国',N'广东省',N'',null,null)
go
insert into City values (293,N'韶关市',N'中国',N'广东省',N'',null,null)
go
insert into City values (294,N'深圳市',N'中国',N'广东省',N'',null,null)
go
insert into City values (295,N'始兴县',N'中国',N'广东省',N'',null,null)
go
insert into City values (296,N'四会市',N'中国',N'广东省',N'',null,null)
go
insert into City values (297,N'遂溪县',N'中国',N'广东省',N'',null,null)
go
insert into City values (298,N'台山市',N'中国',N'广东省',N'',null,null)
go
insert into City values (299,N'翁源县',N'中国',N'广东省',N'',null,null)
go
insert into City values (300,N'吴川市',N'中国',N'广东省',N'',null,null)
go
insert into City values (301,N'五华县',N'中国',N'广东省',N'',null,null)
go
insert into City values (302,N'新丰县',N'中国',N'广东省',N'',null,null)
go
insert into City values (303,N'新兴县',N'中国',N'广东省',N'',null,null)
go
insert into City values (304,N'信宜市',N'中国',N'广东省',N'',null,null)
go
insert into City values (305,N'兴宁市',N'中国',N'广东省',N'',null,null)
go
insert into City values (306,N'徐闻县',N'中国',N'广东省',N'',null,null)
go
insert into City values (307,N'阳春市',N'中国',N'广东省',N'',null,null)
go
insert into City values (308,N'阳东县',N'中国',N'广东省',N'',null,null)
go
insert into City values (309,N'阳江市',N'中国',N'广东省',N'',null,null)
go
insert into City values (310,N'阳山县',N'中国',N'广东省',N'',null,null)
go
insert into City values (311,N'阳西县',N'中国',N'广东省',N'',null,null)
go
insert into City values (312,N'英德市',N'中国',N'广东省',N'',null,null)
go
insert into City values (313,N'郁南县',N'中国',N'广东省',N'',null,null)
go
insert into City values (314,N'云安县',N'中国',N'广东省',N'',null,null)
go
insert into City values (315,N'云浮市',N'中国',N'广东省',N'',null,null)
go
insert into City values (316,N'增城市',N'中国',N'广东省',N'',null,null)
go
insert into City values (317,N'湛江市',N'中国',N'广东省',N'',null,null)
go
insert into City values (318,N'肇庆市',N'中国',N'广东省',N'',null,null)
go
insert into City values (319,N'中山市',N'中国',N'广东省',N'',null,null)
go
insert into City values (320,N'珠海市',N'中国',N'广东省',N'',null,null)
go
insert into City values (321,N'紫金县',N'中国',N'广东省',N'',null,null)
go
insert into City values (322,N'巴马瑶族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (323,N'百色市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (324,N'北海市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (325,N'北流市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (326,N'宾阳县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (327,N'博白县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (328,N'苍梧县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (329,N'岑溪市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (330,N'崇左市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (331,N'大化瑶族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (332,N'大新县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (333,N'德保县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (334,N'东兰县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (335,N'东兴市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (336,N'都安瑶族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (337,N'防城港市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (338,N'凤山县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (339,N'扶绥县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (340,N'富川瑶族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (341,N'恭城瑶族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (342,N'灌阳县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (343,N'贵港市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (344,N'桂林市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (345,N'桂平市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (346,N'合浦县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (347,N'合山市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (348,N'河池市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (349,N'贺州市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (350,N'横县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (351,N'环江毛南族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (352,N'金秀瑶族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (353,N'靖西县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (354,N'来宾市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (355,N'乐业县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (356,N'荔蒲县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (357,N'临桂县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (358,N'灵川县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (359,N'灵山县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (360,N'凌云县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (361,N'柳城县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (362,N'柳江县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (363,N'柳州市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (364,N'龙胜各族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (365,N'龙州县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (366,N'隆安县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (367,N'隆林各族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (368,N'陆川县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (369,N'鹿寨县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (370,N'罗城仫佬族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (371,N'马山县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (372,N'蒙山县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (373,N'那坡县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (374,N'南丹县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (375,N'南宁市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (376,N'宁明县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (377,N'平果县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (378,N'平乐县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (379,N'平南县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (380,N'凭祥市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (381,N'浦北县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (382,N'钦州市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (383,N'全州县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (384,N'容县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (385,N'融安县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (386,N'融水苗族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (387,N'三江侗族自治县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (388,N'上林县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (389,N'上思县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (390,N'藤县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (391,N'天等县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (392,N'天峨县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (393,N'田东县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (394,N'田林县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (395,N'田阳县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (396,N'梧州市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (397,N'武鸣县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (398,N'武宣县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (399,N'西林县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (400,N'象州县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (401,N'忻城县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (402,N'兴安县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (403,N'兴业县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (404,N'阳朔县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (405,N'宜州市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (406,N'永福县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (407,N'玉林市',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (408,N'昭平县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (409,N'钟山县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (410,N'资源县',N'中国',N'广西壮族自治区',N'',null,null)
go
insert into City values (411,N'安龙县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (412,N'安顺市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (413,N'毕节市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (414,N'册亨县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (415,N'岑巩县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (416,N'长顺县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (417,N'赤水市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (418,N'从江县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (419,N'大方县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (420,N'丹寨县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (421,N'道真仡佬族苗族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (422,N'德江县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (423,N'都匀市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (424,N'独山县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (425,N'凤冈县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (426,N'福泉市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (427,N'关岭布依族苗族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (428,N'贵定县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (429,N'贵阳市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (430,N'赫章县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (431,N'黄平县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (432,N'惠水县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (433,N'剑河县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (434,N'江口县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (435,N'金沙县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (436,N'锦屏县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (437,N'开阳县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (438,N'凯里市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (439,N'雷山县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (440,N'黎平县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (441,N'荔波县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (442,N'六盘水市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (443,N'龙里县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (444,N'罗甸县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (445,N'麻江县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (446,N'湄潭县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (447,N'纳雍县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (448,N'盘县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (449,N'平坝县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (450,N'平塘县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (451,N'普安县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (452,N'普定县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (453,N'黔东南苗族侗族自治州',N'中国',N'贵州省',N'',null,null)
go
insert into City values (454,N'黔南布依族苗族自治州',N'中国',N'贵州省',N'',null,null)
go
insert into City values (455,N'黔西南布依族苗族自治州',N'中国',N'贵州省',N'',null,null)
go
insert into City values (456,N'黔西县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (457,N'清镇市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (458,N'晴隆县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (459,N'仁怀市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (460,N'榕江县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (461,N'三都水族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (462,N'三穗县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (463,N'施秉县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (464,N'石阡县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (465,N'水城县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (466,N'思南县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (467,N'松桃苗族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (468,N'绥阳县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (469,N'台江县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (470,N'天柱县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (471,N'桐梓县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (472,N'铜仁市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (473,N'万山特区',N'中国',N'贵州省',N'',null,null)
go
insert into City values (474,N'望谟县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (475,N'威宁彝族回族苗族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (476,N'瓮安县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (477,N'务川仡佬族苗族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (478,N'息烽县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (479,N'习水县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (480,N'兴仁县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (481,N'兴义市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (482,N'修文县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (483,N'沿河土家族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (484,N'印江土家族苗族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (485,N'余庆县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (486,N'玉屏侗族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (487,N'贞丰县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (488,N'镇宁布依族苗族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (489,N'镇远县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (490,N'正安县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (491,N'织金县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (492,N'紫云苗族布依族自治县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (493,N'遵义市',N'中国',N'贵州省',N'',null,null)
go
insert into City values (494,N'遵义县',N'中国',N'贵州省',N'',null,null)
go
insert into City values (495,N'白沙黎族自治县',N'中国',N'海南省',N'',null,null)
go
insert into City values (496,N'保亭黎族苗族自治县',N'中国',N'海南省',N'',null,null)
go
insert into City values (497,N'昌江黎族自治县',N'中国',N'海南省',N'',null,null)
go
insert into City values (498,N'澄迈县',N'中国',N'海南省',N'',null,null)
go
insert into City values (499,N'儋州市',N'中国',N'海南省',N'',null,null)
go
insert into City values (500,N'定安县',N'中国',N'海南省',N'',null,null)
go
insert into City values (501,N'东方市',N'中国',N'海南省',N'',null,null)
go
insert into City values (502,N'海口市',N'中国',N'海南省',N'',null,null)
go
insert into City values (503,N'乐东黎族自治县',N'中国',N'海南省',N'',null,null)
go
insert into City values (504,N'临高县',N'中国',N'海南省',N'',null,null)
go
insert into City values (505,N'陵水黎族自治县',N'中国',N'海南省',N'',null,null)
go
insert into City values (506,N'南沙群岛',N'中国',N'海南省',N'',null,null)
go
insert into City values (507,N'琼海市',N'中国',N'海南省',N'',null,null)
go
insert into City values (508,N'琼中黎族苗族自治县',N'中国',N'海南省',N'',null,null)
go
insert into City values (509,N'三亚市',N'中国',N'海南省',N'',null,null)
go
insert into City values (510,N'屯昌县',N'中国',N'海南省',N'',null,null)
go
insert into City values (511,N'万宁市',N'中国',N'海南省',N'',null,null)
go
insert into City values (512,N'文昌市',N'中国',N'海南省',N'',null,null)
go
insert into City values (513,N'五指山市',N'中国',N'海南省',N'',null,null)
go
insert into City values (514,N'西沙群岛',N'中国',N'海南省',N'',null,null)
go
insert into City values (515,N'中沙群岛的岛礁及其海域',N'中国',N'海南省',N'',null,null)
go
insert into City values (516,N'安国市',N'中国',N'河北省',N'',null,null)
go
insert into City values (517,N'安平县',N'中国',N'河北省',N'',null,null)
go
insert into City values (518,N'安新县',N'中国',N'河北省',N'',null,null)
go
insert into City values (519,N'霸州市',N'中国',N'河北省',N'',null,null)
go
insert into City values (520,N'柏乡县',N'中国',N'河北省',N'',null,null)
go
insert into City values (521,N'保定市',N'中国',N'河北省',N'',null,null)
go
insert into City values (522,N'泊头市',N'中国',N'河北省',N'',null,null)
go
insert into City values (523,N'博野县',N'中国',N'河北省',N'',null,null)
go
insert into City values (524,N'沧县',N'中国',N'河北省',N'',null,null)
go
insert into City values (525,N'沧州市',N'中国',N'河北省',N'',null,null)
go
insert into City values (526,N'昌黎县',N'中国',N'河北省',N'',null,null)
go
insert into City values (527,N'成安县',N'中国',N'河北省',N'',null,null)
go
insert into City values (528,N'承德市',N'中国',N'河北省',N'',null,null)
go
insert into City values (529,N'承德县',N'中国',N'河北省',N'',null,null)
go
insert into City values (530,N'赤城县',N'中国',N'河北省',N'',null,null)
go
insert into City values (531,N'崇礼县',N'中国',N'河北省',N'',null,null)
go
insert into City values (532,N'磁县',N'中国',N'河北省',N'',null,null)
go
insert into City values (533,N'大厂回族自治县',N'中国',N'河北省',N'',null,null)
go
insert into City values (534,N'大城县',N'中国',N'河北省',N'',null,null)
go
insert into City values (535,N'大名县',N'中国',N'河北省',N'',null,null)
go
insert into City values (536,N'定兴县',N'中国',N'河北省',N'',null,null)
go
insert into City values (537,N'定州市',N'中国',N'河北省',N'',null,null)
go
insert into City values (538,N'东光县',N'中国',N'河北省',N'',null,null)
go
insert into City values (539,N'肥乡县',N'中国',N'河北省',N'',null,null)
go
insert into City values (540,N'丰宁满族自治县',N'中国',N'河北省',N'',null,null)
go
insert into City values (541,N'抚宁县',N'中国',N'河北省',N'',null,null)
go
insert into City values (542,N'阜城县',N'中国',N'河北省',N'',null,null)
go
insert into City values (543,N'阜平县',N'中国',N'河北省',N'',null,null)
go
insert into City values (544,N'高碑店市',N'中国',N'河北省',N'',null,null)
go
insert into City values (545,N'高阳县',N'中国',N'河北省',N'',null,null)
go
insert into City values (546,N'高邑县',N'中国',N'河北省',N'',null,null)
go
insert into City values (547,N'藁城市',N'中国',N'河北省',N'',null,null)
go
insert into City values (548,N'沽源县',N'中国',N'河北省',N'',null,null)
go
insert into City values (549,N'固安县',N'中国',N'河北省',N'',null,null)
go
insert into City values (550,N'故城县',N'中国',N'河北省',N'',null,null)
go
insert into City values (551,N'馆陶县',N'中国',N'河北省',N'',null,null)
go
insert into City values (552,N'广平县',N'中国',N'河北省',N'',null,null)
go
insert into City values (553,N'广宗县',N'中国',N'河北省',N'',null,null)
go
insert into City values (554,N'海兴县',N'中国',N'河北省',N'',null,null)
go
insert into City values (555,N'邯郸市',N'中国',N'河北省',N'',null,null)
go
insert into City values (556,N'邯郸县',N'中国',N'河北省',N'',null,null)
go
insert into City values (557,N'河间市',N'中国',N'河北省',N'',null,null)
go
insert into City values (558,N'衡水市',N'中国',N'河北省',N'',null,null)
go
insert into City values (559,N'怀安县',N'中国',N'河北省',N'',null,null)
go
insert into City values (560,N'怀来县',N'中国',N'河北省',N'',null,null)
go
insert into City values (561,N'黄骅市',N'中国',N'河北省',N'',null,null)
go
insert into City values (562,N'鸡泽县',N'中国',N'河北省',N'',null,null)
go
insert into City values (563,N'冀州市',N'中国',N'河北省',N'',null,null)
go
insert into City values (564,N'晋州市',N'中国',N'河北省',N'',null,null)
go
insert into City values (565,N'井陉县',N'中国',N'河北省',N'',null,null)
go
insert into City values (566,N'景县',N'中国',N'河北省',N'',null,null)
go
insert into City values (567,N'巨鹿县',N'中国',N'河北省',N'',null,null)
go
insert into City values (568,N'康保县',N'中国',N'河北省',N'',null,null)
go
insert into City values (569,N'宽城满族自治县',N'中国',N'河北省',N'',null,null)
go
insert into City values (570,N'涞水县',N'中国',N'河北省',N'',null,null)
go
insert into City values (571,N'涞源县',N'中国',N'河北省',N'',null,null)
go
insert into City values (572,N'廊坊市',N'中国',N'河北省',N'',null,null)
go
insert into City values (573,N'乐亭县',N'中国',N'河北省',N'',null,null)
go
insert into City values (574,N'蠡县',N'中国',N'河北省',N'',null,null)
go
insert into City values (575,N'临城县',N'中国',N'河北省',N'',null,null)
go
insert into City values (576,N'临西县',N'中国',N'河北省',N'',null,null)
go
insert into City values (577,N'临漳县',N'中国',N'河北省',N'',null,null)
go
insert into City values (578,N'灵寿县',N'中国',N'河北省',N'',null,null)
go
insert into City values (579,N'隆化县',N'中国',N'河北省',N'',null,null)
go
insert into City values (580,N'隆尧县',N'中国',N'河北省',N'',null,null)
go
insert into City values (581,N'卢龙县',N'中国',N'河北省',N'',null,null)
go
insert into City values (582,N'鹿泉市',N'中国',N'河北省',N'',null,null)
go
insert into City values (583,N'栾城县',N'中国',N'河北省',N'',null,null)
go
insert into City values (584,N'滦南县',N'中国',N'河北省',N'',null,null)
go
insert into City values (585,N'滦平县',N'中国',N'河北省',N'',null,null)
go
insert into City values (586,N'滦县',N'中国',N'河北省',N'',null,null)
go
insert into City values (587,N'满城县',N'中国',N'河北省',N'',null,null)
go
insert into City values (588,N'孟村回族自治县',N'中国',N'河北省',N'',null,null)
go
insert into City values (589,N'内丘县',N'中国',N'河北省',N'',null,null)
go
insert into City values (590,N'南宫市',N'中国',N'河北省',N'',null,null)
go
insert into City values (591,N'南和县',N'中国',N'河北省',N'',null,null)
go
insert into City values (592,N'南皮县',N'中国',N'河北省',N'',null,null)
go
insert into City values (593,N'宁晋县',N'中国',N'河北省',N'',null,null)
go
insert into City values (594,N'平泉县',N'中国',N'河北省',N'',null,null)
go
insert into City values (595,N'平山县',N'中国',N'河北省',N'',null,null)
go
insert into City values (596,N'平乡县',N'中国',N'河北省',N'',null,null)
go
insert into City values (597,N'迁安市',N'中国',N'河北省',N'',null,null)
go
insert into City values (598,N'迁西县',N'中国',N'河北省',N'',null,null)
go
insert into City values (599,N'秦皇岛市',N'中国',N'河北省',N'',null,null)
go
insert into City values (600,N'青龙满族自治县',N'中国',N'河北省',N'',null,null)
go
insert into City values (601,N'青县',N'中国',N'河北省',N'',null,null)
go
insert into City values (602,N'清河县',N'中国',N'河北省',N'',null,null)
go
insert into City values (603,N'清苑县',N'中国',N'河北省',N'',null,null)
go
insert into City values (604,N'邱县',N'中国',N'河北省',N'',null,null)
go
insert into City values (605,N'曲阳县',N'中国',N'河北省',N'',null,null)
go
insert into City values (606,N'曲周县',N'中国',N'河北省',N'',null,null)
go
insert into City values (607,N'饶阳县',N'中国',N'河北省',N'',null,null)
go
insert into City values (608,N'任丘市',N'中国',N'河北省',N'',null,null)
go
insert into City values (609,N'任县',N'中国',N'河北省',N'',null,null)
go
insert into City values (610,N'容城县',N'中国',N'河北省',N'',null,null)
go
insert into City values (611,N'三河市',N'中国',N'河北省',N'',null,null)
go
insert into City values (612,N'沙河市',N'中国',N'河北省',N'',null,null)
go
insert into City values (613,N'尚义县',N'中国',N'河北省',N'',null,null)
go
insert into City values (614,N'涉县',N'中国',N'河北省',N'',null,null)
go
insert into City values (615,N'深泽县',N'中国',N'河北省',N'',null,null)
go
insert into City values (616,N'深州市',N'中国',N'河北省',N'',null,null)
go
insert into City values (617,N'石家庄市',N'中国',N'河北省',N'',null,null)
go
insert into City values (618,N'顺平县',N'中国',N'河北省',N'',null,null)
go
insert into City values (619,N'肃宁县',N'中国',N'河北省',N'',null,null)
go
insert into City values (620,N'唐海县',N'中国',N'河北省',N'',null,null)
go
insert into City values (621,N'唐山市',N'中国',N'河北省',N'',null,null)
go
insert into City values (622,N'唐县',N'中国',N'河北省',N'',null,null)
go
insert into City values (623,N'万全县',N'中国',N'河北省',N'',null,null)
go
insert into City values (624,N'望都县',N'中国',N'河北省',N'',null,null)
go
insert into City values (625,N'威县',N'中国',N'河北省',N'',null,null)
go
insert into City values (626,N'围场满族蒙古族自治县',N'中国',N'河北省',N'',null,null)
go
insert into City values (627,N'蔚县',N'中国',N'河北省',N'',null,null)
go
insert into City values (628,N'魏县',N'中国',N'河北省',N'',null,null)
go
insert into City values (629,N'文安县',N'中国',N'河北省',N'',null,null)
go
insert into City values (630,N'无极县',N'中国',N'河北省',N'',null,null)
go
insert into City values (631,N'吴桥县',N'中国',N'河北省',N'',null,null)
go
insert into City values (632,N'武安市',N'中国',N'河北省',N'',null,null)
go
insert into City values (633,N'武强县',N'中国',N'河北省',N'',null,null)
go
insert into City values (634,N'武邑县',N'中国',N'河北省',N'',null,null)
go
insert into City values (635,N'献县',N'中国',N'河北省',N'',null,null)
go
insert into City values (636,N'香河县',N'中国',N'河北省',N'',null,null)
go
insert into City values (637,N'辛集市',N'中国',N'河北省',N'',null,null)
go
insert into City values (638,N'新河县',N'中国',N'河北省',N'',null,null)
go
insert into City values (639,N'新乐市',N'中国',N'河北省',N'',null,null)
go
insert into City values (640,N'兴隆县',N'中国',N'河北省',N'',null,null)
go
insert into City values (641,N'行唐县',N'中国',N'河北省',N'',null,null)
go
insert into City values (642,N'邢台市',N'中国',N'河北省',N'',null,null)
go
insert into City values (643,N'邢台县',N'中国',N'河北省',N'',null,null)
go
insert into City values (644,N'雄县',N'中国',N'河北省',N'',null,null)
go
insert into City values (645,N'徐水县',N'中国',N'河北省',N'',null,null)
go
insert into City values (646,N'宣化县',N'中国',N'河北省',N'',null,null)
go
insert into City values (647,N'盐山县',N'中国',N'河北省',N'',null,null)
go
insert into City values (648,N'阳原县',N'中国',N'河北省',N'',null,null)
go
insert into City values (649,N'易县',N'中国',N'河北省',N'',null,null)
go
insert into City values (650,N'永年县',N'中国',N'河北省',N'',null,null)
go
insert into City values (651,N'永清县',N'中国',N'河北省',N'',null,null)
go
insert into City values (652,N'玉田县',N'中国',N'河北省',N'',null,null)
go
insert into City values (653,N'元氏县',N'中国',N'河北省',N'',null,null)
go
insert into City values (654,N'赞皇县',N'中国',N'河北省',N'',null,null)
go
insert into City values (655,N'枣强县',N'中国',N'河北省',N'',null,null)
go
insert into City values (656,N'张北县',N'中国',N'河北省',N'',null,null)
go
insert into City values (657,N'张家口市',N'中国',N'河北省',N'',null,null)
go
insert into City values (658,N'赵县',N'中国',N'河北省',N'',null,null)
go
insert into City values (659,N'正定县',N'中国',N'河北省',N'',null,null)
go
insert into City values (660,N'涿鹿县',N'中国',N'河北省',N'',null,null)
go
insert into City values (661,N'涿州市',N'中国',N'河北省',N'',null,null)
go
insert into City values (662,N'遵化市',N'中国',N'河北省',N'',null,null)
go
insert into City values (663,N'安阳市',N'中国',N'河南省',N'',null,null)
go
insert into City values (664,N'安阳县',N'中国',N'河南省',N'',null,null)
go
insert into City values (665,N'宝丰县',N'中国',N'河南省',N'',null,null)
go
insert into City values (666,N'博爱县',N'中国',N'河南省',N'',null,null)
go
insert into City values (667,N'长葛市',N'中国',N'河南省',N'',null,null)
go
insert into City values (668,N'长垣县',N'中国',N'河南省',N'',null,null)
go
insert into City values (669,N'郸城县',N'中国',N'河南省',N'',null,null)
go
insert into City values (670,N'登封市',N'中国',N'河南省',N'',null,null)
go
insert into City values (671,N'邓州市',N'中国',N'河南省',N'',null,null)
go
insert into City values (672,N'范县',N'中国',N'河南省',N'',null,null)
go
insert into City values (673,N'方城县',N'中国',N'河南省',N'',null,null)
go
insert into City values (674,N'封丘县',N'中国',N'河南省',N'',null,null)
go
insert into City values (675,N'扶沟县',N'中国',N'河南省',N'',null,null)
go
insert into City values (676,N'巩义市',N'中国',N'河南省',N'',null,null)
go
insert into City values (677,N'固始县',N'中国',N'河南省',N'',null,null)
go
insert into City values (678,N'光山县',N'中国',N'河南省',N'',null,null)
go
insert into City values (679,N'鹤壁市',N'中国',N'河南省',N'',null,null)
go
insert into City values (680,N'滑县',N'中国',N'河南省',N'',null,null)
go
insert into City values (681,N'淮滨县',N'中国',N'河南省',N'',null,null)
go
insert into City values (682,N'淮阳县',N'中国',N'河南省',N'',null,null)
go
insert into City values (683,N'潢川县',N'中国',N'河南省',N'',null,null)
go
insert into City values (684,N'辉县市',N'中国',N'河南省',N'',null,null)
go
insert into City values (685,N'获嘉县',N'中国',N'河南省',N'',null,null)
go
insert into City values (686,N'济源市',N'中国',N'河南省',N'',null,null)
go
insert into City values (687,N'郏县',N'中国',N'河南省',N'',null,null)
go
insert into City values (688,N'焦作市',N'中国',N'河南省',N'',null,null)
go
insert into City values (689,N'浚县',N'中国',N'河南省',N'',null,null)
go
insert into City values (690,N'开封市',N'中国',N'河南省',N'',null,null)
go
insert into City values (691,N'开封县',N'中国',N'河南省',N'',null,null)
go
insert into City values (692,N'兰考县',N'中国',N'河南省',N'',null,null)
go
insert into City values (693,N'林州市',N'中国',N'河南省',N'',null,null)
go
insert into City values (694,N'临颍县',N'中国',N'河南省',N'',null,null)
go
insert into City values (695,N'灵宝市',N'中国',N'河南省',N'',null,null)
go
insert into City values (696,N'卢氏县',N'中国',N'河南省',N'',null,null)
go
insert into City values (697,N'鲁山县',N'中国',N'河南省',N'',null,null)
go
insert into City values (698,N'鹿邑县',N'中国',N'河南省',N'',null,null)
go
insert into City values (699,N'栾川县',N'中国',N'河南省',N'',null,null)
go
insert into City values (700,N'罗山县',N'中国',N'河南省',N'',null,null)
go
insert into City values (701,N'洛宁县',N'中国',N'河南省',N'',null,null)
go
insert into City values (702,N'洛阳市',N'中国',N'河南省',N'',null,null)
go
insert into City values (703,N'漯河市',N'中国',N'河南省',N'',null,null)
go
insert into City values (704,N'孟津县',N'中国',N'河南省',N'',null,null)
go
insert into City values (705,N'孟州市',N'中国',N'河南省',N'',null,null)
go
insert into City values (706,N'泌阳县',N'中国',N'河南省',N'',null,null)
go
insert into City values (707,N'民权县',N'中国',N'河南省',N'',null,null)
go
insert into City values (708,N'内黄县',N'中国',N'河南省',N'',null,null)
go
insert into City values (709,N'内乡县',N'中国',N'河南省',N'',null,null)
go
insert into City values (710,N'南乐县',N'中国',N'河南省',N'',null,null)
go
insert into City values (711,N'南阳市',N'中国',N'河南省',N'',null,null)
go
insert into City values (712,N'南召县',N'中国',N'河南省',N'',null,null)
go
insert into City values (713,N'宁陵县',N'中国',N'河南省',N'',null,null)
go
insert into City values (714,N'平顶山市',N'中国',N'河南省',N'',null,null)
go
insert into City values (715,N'平舆县',N'中国',N'河南省',N'',null,null)
go
insert into City values (716,N'濮阳市',N'中国',N'河南省',N'',null,null)
go
insert into City values (717,N'濮阳县',N'中国',N'河南省',N'',null,null)
go
insert into City values (718,N'淇县',N'中国',N'河南省',N'',null,null)
go
insert into City values (719,N'杞县',N'中国',N'河南省',N'',null,null)
go
insert into City values (720,N'沁阳市',N'中国',N'河南省',N'',null,null)
go
insert into City values (721,N'清丰县',N'中国',N'河南省',N'',null,null)
go
insert into City values (722,N'确山县',N'中国',N'河南省',N'',null,null)
go
insert into City values (723,N'汝南县',N'中国',N'河南省',N'',null,null)
go
insert into City values (724,N'汝阳县',N'中国',N'河南省',N'',null,null)
go
insert into City values (725,N'汝州市',N'中国',N'河南省',N'',null,null)
go
insert into City values (726,N'三门峡市',N'中国',N'河南省',N'',null,null)
go
insert into City values (727,N'陕县',N'中国',N'河南省',N'',null,null)
go
insert into City values (728,N'商城县',N'中国',N'河南省',N'',null,null)
go
insert into City values (729,N'商丘市',N'中国',N'河南省',N'',null,null)
go
insert into City values (730,N'商水县',N'中国',N'河南省',N'',null,null)
go
insert into City values (731,N'上蔡县',N'中国',N'河南省',N'',null,null)
go
insert into City values (732,N'社旗县',N'中国',N'河南省',N'',null,null)
go
insert into City values (733,N'沈丘县',N'中国',N'河南省',N'',null,null)
go
insert into City values (734,N'渑池县',N'中国',N'河南省',N'',null,null)
go
insert into City values (735,N'嵩县',N'中国',N'河南省',N'',null,null)
go
insert into City values (736,N'睢县',N'中国',N'河南省',N'',null,null)
go
insert into City values (737,N'遂平县',N'中国',N'河南省',N'',null,null)
go
insert into City values (738,N'台前县',N'中国',N'河南省',N'',null,null)
go
insert into City values (739,N'太康县',N'中国',N'河南省',N'',null,null)
go
insert into City values (740,N'汤阴县',N'中国',N'河南省',N'',null,null)
go
insert into City values (741,N'唐河县',N'中国',N'河南省',N'',null,null)
go
insert into City values (742,N'通许县',N'中国',N'河南省',N'',null,null)
go
insert into City values (743,N'桐柏县',N'中国',N'河南省',N'',null,null)
go
insert into City values (744,N'卫辉市',N'中国',N'河南省',N'',null,null)
go
insert into City values (745,N'尉氏县',N'中国',N'河南省',N'',null,null)
go
insert into City values (746,N'温县',N'中国',N'河南省',N'',null,null)
go
insert into City values (747,N'武陟县',N'中国',N'河南省',N'',null,null)
go
insert into City values (748,N'舞钢市',N'中国',N'河南省',N'',null,null)
go
insert into City values (749,N'舞阳县',N'中国',N'河南省',N'',null,null)
go
insert into City values (750,N'西华县',N'中国',N'河南省',N'',null,null)
go
insert into City values (751,N'西平县',N'中国',N'河南省',N'',null,null)
go
insert into City values (752,N'西峡县',N'中国',N'河南省',N'',null,null)
go
insert into City values (753,N'息县',N'中国',N'河南省',N'',null,null)
go
insert into City values (754,N'淅川县',N'中国',N'河南省',N'',null,null)
go
insert into City values (755,N'夏邑县',N'中国',N'河南省',N'',null,null)
go
insert into City values (756,N'襄城县',N'中国',N'河南省',N'',null,null)
go
insert into City values (757,N'项城市',N'中国',N'河南省',N'',null,null)
go
insert into City values (758,N'新安县',N'中国',N'河南省',N'',null,null)
go
insert into City values (759,N'新蔡县',N'中国',N'河南省',N'',null,null)
go
insert into City values (760,N'新密市',N'中国',N'河南省',N'',null,null)
go
insert into City values (761,N'新县',N'中国',N'河南省',N'',null,null)
go
insert into City values (762,N'新乡市',N'中国',N'河南省',N'',null,null)
go
insert into City values (763,N'新乡县',N'中国',N'河南省',N'',null,null)
go
insert into City values (764,N'新野县',N'中国',N'河南省',N'',null,null)
go
insert into City values (765,N'新郑市',N'中国',N'河南省',N'',null,null)
go
insert into City values (766,N'信阳市',N'中国',N'河南省',N'',null,null)
go
insert into City values (767,N'修武县',N'中国',N'河南省',N'',null,null)
go
insert into City values (768,N'许昌市',N'中国',N'河南省',N'',null,null)
go
insert into City values (769,N'许昌县',N'中国',N'河南省',N'',null,null)
go
insert into City values (770,N'鄢陵县',N'中国',N'河南省',N'',null,null)
go
insert into City values (771,N'延津县',N'中国',N'河南省',N'',null,null)
go
insert into City values (772,N'偃师市',N'中国',N'河南省',N'',null,null)
go
insert into City values (773,N'叶县',N'中国',N'河南省',N'',null,null)
go
insert into City values (774,N'伊川县',N'中国',N'河南省',N'',null,null)
go
insert into City values (775,N'宜阳县',N'中国',N'河南省',N'',null,null)
go
insert into City values (776,N'义马市',N'中国',N'河南省',N'',null,null)
go
insert into City values (777,N'荥阳市',N'中国',N'河南省',N'',null,null)
go
insert into City values (778,N'永城市',N'中国',N'河南省',N'',null,null)
go
insert into City values (779,N'虞城县',N'中国',N'河南省',N'',null,null)
go
insert into City values (780,N'禹州市',N'中国',N'河南省',N'',null,null)
go
insert into City values (781,N'原阳县',N'中国',N'河南省',N'',null,null)
go
insert into City values (782,N'柘城县',N'中国',N'河南省',N'',null,null)
go
insert into City values (783,N'镇平县',N'中国',N'河南省',N'',null,null)
go
insert into City values (784,N'正阳县',N'中国',N'河南省',N'',null,null)
go
insert into City values (785,N'郑州市',N'中国',N'河南省',N'',null,null)
go
insert into City values (786,N'中牟县',N'中国',N'河南省',N'',null,null)
go
insert into City values (787,N'周口市',N'中国',N'河南省',N'',null,null)
go
insert into City values (788,N'驻马店市',N'中国',N'河南省',N'',null,null)
go
insert into City values (789,N'安达市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (790,N'巴彦县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (791,N'拜泉县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (792,N'宝清县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (793,N'北安市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (794,N'宾县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (795,N'勃利县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (796,N'大庆市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (797,N'大兴安岭地区',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (798,N'东宁县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (799,N'杜尔伯特蒙古族自治县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (800,N'方正县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (801,N'抚远县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (802,N'富锦市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (803,N'富裕县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (804,N'甘南县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (805,N'哈尔滨市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (806,N'海林市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (807,N'海伦市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (808,N'鹤岗市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (809,N'黑河市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (810,N'呼玛县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (811,N'虎林市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (812,N'桦川县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (813,N'桦南县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (814,N'鸡东县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (815,N'鸡西市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (816,N'集贤县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (817,N'佳木斯市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (818,N'嘉荫县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (819,N'克东县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (820,N'克山县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (821,N'兰西县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (822,N'林甸县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (823,N'林口县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (824,N'龙江县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (825,N'萝北县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (826,N'密山市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (827,N'明水县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (828,N'漠河县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (829,N'牡丹江市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (830,N'木兰县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (831,N'穆棱市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (832,N'讷河市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (833,N'嫩江县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (834,N'宁安市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (835,N'七台河市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (836,N'齐齐哈尔市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (837,N'青冈县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (838,N'庆安县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (839,N'饶河县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (840,N'尚志市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (841,N'双城市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (842,N'双鸭山市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (843,N'绥滨县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (844,N'绥芬河市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (845,N'绥化市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (846,N'绥棱县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (847,N'孙吴县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (848,N'塔河县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (849,N'泰来县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (850,N'汤原县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (851,N'铁力市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (852,N'通河县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (853,N'同江市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (854,N'望奎县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (855,N'五常市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (856,N'五大连池市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (857,N'逊克县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (858,N'延寿县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (859,N'伊春市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (860,N'依安县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (861,N'依兰县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (862,N'友谊县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (863,N'肇东市',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (864,N'肇源县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (865,N'肇州县',N'中国',N'黑龙江省',N'',null,null)
go
insert into City values (866,N'安陆市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (867,N'巴东县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (868,N'保康县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (869,N'长阳土家族自治县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (870,N'赤壁市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (871,N'崇阳县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (872,N'大悟县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (873,N'大冶市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (874,N'丹江口市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (875,N'当阳市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (876,N'鄂州市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (877,N'恩施市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (878,N'恩施土家族苗族自治州',N'中国',N'湖北省',N'',null,null)
go
insert into City values (879,N'房县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (880,N'公安县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (881,N'谷城县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (882,N'广水市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (883,N'汉川市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (884,N'鹤峰县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (885,N'红安县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (886,N'洪湖市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (887,N'黄冈市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (888,N'黄梅县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (889,N'黄石市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (890,N'嘉鱼县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (891,N'监利县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (892,N'建始县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (893,N'江陵县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (894,N'京山县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (895,N'荆门市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (896,N'荆州市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (897,N'来凤县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (898,N'老河口市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (899,N'利川市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (900,N'罗田县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (901,N'麻城市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (902,N'南漳县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (903,N'蕲春县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (904,N'潜江市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (905,N'沙洋县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (906,N'神农架林区',N'中国',N'湖北省',N'',null,null)
go
insert into City values (907,N'省直辖县级行政单位',N'中国',N'湖北省',N'',null,null)
go
insert into City values (908,N'十堰市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (909,N'石首市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (910,N'松滋市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (911,N'随州市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (912,N'天门市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (913,N'通城县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (914,N'通山县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (915,N'团风县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (916,N'五峰土家族自治县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (917,N'武汉市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (918,N'武穴市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (919,N'浠水县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (920,N'仙桃市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (921,N'咸丰县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (922,N'咸宁市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (923,N'襄樊市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (924,N'孝昌县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (925,N'孝感市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (926,N'兴山县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (927,N'宣恩县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (928,N'阳新县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (929,N'宜昌市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (930,N'宜城市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (931,N'宜都市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (932,N'应城市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (933,N'英山县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (934,N'远安县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (935,N'云梦县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (936,N'郧西县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (937,N'郧县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (938,N'枣阳市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (939,N'枝江市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (940,N'钟祥市',N'中国',N'湖北省',N'',null,null)
go
insert into City values (941,N'竹山县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (942,N'竹溪县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (943,N'秭归县',N'中国',N'湖北省',N'',null,null)
go
insert into City values (944,N'安化县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (945,N'安仁县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (946,N'安乡县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (947,N'保靖县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (948,N'茶陵县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (949,N'长沙市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (950,N'长沙县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (951,N'常德市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (952,N'常宁市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (953,N'郴州市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (954,N'辰溪县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (955,N'城步苗族自治县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (956,N'慈利县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (957,N'道县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (958,N'东安县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (959,N'洞口县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (960,N'凤凰县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (961,N'古丈县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (962,N'桂东县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (963,N'桂阳县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (964,N'汉寿县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (965,N'衡东县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (966,N'衡南县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (967,N'衡山县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (968,N'衡阳市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (969,N'衡阳县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (970,N'洪江市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (971,N'花垣县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (972,N'华容县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (973,N'怀化市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (974,N'会同县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (975,N'吉首市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (976,N'嘉禾县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (977,N'江华瑶族自治县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (978,N'江永县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (979,N'津市市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (980,N'靖州苗族侗族自治县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (981,N'蓝山县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (982,N'耒阳市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (983,N'冷水江市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (984,N'澧县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (985,N'醴陵市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (986,N'涟源市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (987,N'临澧县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (988,N'临武县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (989,N'临湘市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (990,N'浏阳市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (991,N'龙山县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (992,N'隆回县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (993,N'娄底市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (994,N'泸溪县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (995,N'麻阳苗族自治县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (996,N'汨罗市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (997,N'南县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (998,N'宁乡县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (999,N'宁远县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1000,N'平江县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1001,N'祁东县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1002,N'祁阳县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1003,N'汝城县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1004,N'桑植县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1005,N'韶山市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1006,N'邵东县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1007,N'邵阳市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1008,N'邵阳县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1009,N'石门县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1010,N'双峰县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1011,N'双牌县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1012,N'绥宁县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1013,N'桃江县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1014,N'桃源县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1015,N'通道侗族自治县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1016,N'望城县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1017,N'武冈市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1018,N'湘潭市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1019,N'湘潭县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1020,N'湘西土家族苗族自治州',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1021,N'湘乡市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1022,N'湘阴县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1023,N'新化县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1024,N'新晃侗族自治县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1025,N'新宁县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1026,N'新邵县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1027,N'新田县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1028,N'溆浦县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1029,N'炎陵县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1030,N'宜章县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1031,N'益阳市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1032,N'永顺县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1033,N'永兴县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1034,N'永州市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1035,N'攸县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1036,N'沅江市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1037,N'沅陵县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1038,N'岳阳市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1039,N'岳阳县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1040,N'张家界市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1041,N'芷江侗族自治县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1042,N'中方县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1043,N'株洲市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1044,N'株洲县',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1045,N'资兴市',N'中国',N'湖南省',N'',null,null)
go
insert into City values (1046,N'安图县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1047,N'白城市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1048,N'白山市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1049,N'长白朝鲜族自治县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1050,N'长春市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1051,N'长岭县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1052,N'大安市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1053,N'德惠市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1054,N'东丰县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1055,N'东辽县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1056,N'敦化市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1057,N'扶余县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1058,N'抚松县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1059,N'公主岭市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1060,N'和龙市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1061,N'桦甸市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1062,N'珲春市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1063,N'辉南县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1064,N'吉林市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1065,N'集安市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1066,N'蛟河市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1067,N'靖宇县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1068,N'九台市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1069,N'梨树县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1070,N'辽源市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1071,N'临江市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1072,N'柳河县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1073,N'龙井市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1074,N'梅河口市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1075,N'农安县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1076,N'磐石市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1077,N'前郭尔罗斯蒙古族自治县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1078,N'乾安县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1079,N'舒兰市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1080,N'双辽市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1081,N'四平市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1082,N'松原市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1083,N'洮南市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1084,N'通化市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1085,N'通化县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1086,N'通榆县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1087,N'图们市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1088,N'汪清县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1089,N'延边朝鲜族自治州',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1090,N'延吉市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1091,N'伊通满族自治县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1092,N'永吉县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1093,N'榆树市',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1094,N'镇赉县',N'中国',N'吉林省',N'',null,null)
go
insert into City values (1095,N'宝应县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1096,N'滨海县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1097,N'常熟市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1098,N'常州市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1099,N'大丰市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1100,N'丹阳市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1101,N'东海县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1102,N'东台市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1103,N'丰县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1104,N'阜宁县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1105,N'赣榆县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1106,N'高淳县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1107,N'高邮市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1108,N'灌南县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1109,N'灌云县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1110,N'海安县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1111,N'海门市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1112,N'洪泽县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1113,N'淮安市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1114,N'建湖县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1115,N'江都市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1116,N'江阴市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1117,N'姜堰市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1118,N'金湖县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1119,N'金坛市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1120,N'靖江市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1121,N'句容市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1122,N'昆山市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1123,N'溧水县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1124,N'溧阳市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1125,N'连云港市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1126,N'涟水县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1127,N'南京市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1128,N'南通市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1129,N'沛县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1130,N'邳州市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1131,N'启东市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1132,N'如东县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1133,N'如皋市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1134,N'射阳县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1135,N'沭阳县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1136,N'泗洪县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1137,N'泗阳县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1138,N'苏州市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1139,N'宿迁市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1140,N'睢宁县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1141,N'太仓市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1142,N'泰兴市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1143,N'泰州市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1144,N'通州市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1145,N'铜山县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1146,N'无锡市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1147,N'吴江市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1148,N'响水县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1149,N'新沂市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1150,N'兴化市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1151,N'盱眙县',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1152,N'徐州市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1153,N'盐城市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1154,N'扬中市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1155,N'扬州市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1156,N'仪征市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1157,N'宜兴市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1158,N'张家港市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1159,N'镇江市',N'中国',N'江苏省',N'',null,null)
go
insert into City values (1160,N'安福县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1161,N'安义县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1162,N'安远县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1163,N'崇仁县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1164,N'崇义县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1165,N'大余县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1166,N'德安县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1167,N'德兴市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1168,N'定南县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1169,N'东乡县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1170,N'都昌县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1171,N'分宜县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1172,N'丰城市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1173,N'奉新县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1174,N'浮梁县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1175,N'抚州市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1176,N'赣县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1177,N'赣州市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1178,N'高安市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1179,N'广昌县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1180,N'广丰县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1181,N'贵溪市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1182,N'横峰县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1183,N'湖口县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1184,N'会昌县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1185,N'吉安市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1186,N'吉安县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1187,N'吉水县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1188,N'金溪县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1189,N'进贤县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1190,N'井冈山市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1191,N'景德镇市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1192,N'靖安县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1193,N'九江市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1194,N'九江县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1195,N'乐安县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1196,N'乐平市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1197,N'黎川县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1198,N'莲花县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1199,N'龙南县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1200,N'芦溪县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1201,N'南昌市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1202,N'南昌县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1203,N'南城县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1204,N'南丰县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1205,N'南康市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1206,N'宁都县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1207,N'彭泽县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1208,N'萍乡市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1209,N'鄱阳县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1210,N'铅山县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1211,N'全南县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1212,N'瑞昌市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1213,N'瑞金市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1214,N'上高县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1215,N'上栗县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1216,N'上饶市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1217,N'上饶县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1218,N'上犹县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1219,N'石城县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1220,N'遂川县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1221,N'泰和县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1222,N'铜鼓县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1223,N'万安县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1224,N'万年县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1225,N'万载县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1226,N'武宁县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1227,N'婺源县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1228,N'峡江县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1229,N'新干县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1230,N'新建县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1231,N'新余市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1232,N'信丰县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1233,N'兴国县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1234,N'星子县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1235,N'修水县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1236,N'寻乌县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1237,N'宜春市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1238,N'宜丰县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1239,N'宜黄县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1240,N'弋阳县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1241,N'鹰潭市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1242,N'永丰县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1243,N'永新县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1244,N'永修县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1245,N'于都县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1246,N'余干县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1247,N'余江县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1248,N'玉山县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1249,N'樟树市',N'中国',N'江西省',N'',null,null)
go
insert into City values (1250,N'资溪县',N'中国',N'江西省',N'',null,null)
go
insert into City values (1251,N'鞍山市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1252,N'北票市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1253,N'北镇市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1254,N'本溪满族自治县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1255,N'本溪市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1256,N'昌图县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1257,N'长海县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1258,N'朝阳市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1259,N'朝阳县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1260,N'大连市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1261,N'大石桥市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1262,N'大洼县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1263,N'丹东市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1264,N'灯塔市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1265,N'调兵山市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1266,N'东港市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1267,N'法库县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1268,N'凤城市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1269,N'抚顺市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1270,N'抚顺县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1271,N'阜新蒙古族自治县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1272,N'阜新市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1273,N'盖州市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1274,N'海城市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1275,N'黑山县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1276,N'葫芦岛市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1277,N'桓仁满族自治县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1278,N'建昌县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1279,N'建平县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1280,N'锦州市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1281,N'喀喇沁左翼蒙古族自治县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1282,N'开原市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1283,N'康平县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1284,N'宽甸满族自治县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1285,N'辽阳市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1286,N'辽阳县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1287,N'辽中县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1288,N'凌海市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1289,N'凌源市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1290,N'盘锦市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1291,N'盘山县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1292,N'普兰店市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1293,N'清原满族自治县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1294,N'沈阳市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1295,N'绥中县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1296,N'台安县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1297,N'铁岭市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1298,N'铁岭县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1299,N'瓦房店市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1300,N'西丰县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1301,N'新宾满族自治县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1302,N'新民市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1303,N'兴城市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1304,N'岫岩满族自治县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1305,N'义县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1306,N'营口市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1307,N'彰武县',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1308,N'庄河市',N'中国',N'辽宁省',N'',null,null)
go
insert into City values (1309,N'阿巴嘎旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1310,N'阿尔山市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1311,N'阿拉善盟',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1312,N'阿拉善右旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1313,N'阿拉善左旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1314,N'阿鲁科尔沁旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1315,N'阿荣旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1316,N'敖汉旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1317,N'巴林右旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1318,N'巴林左旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1319,N'巴彦淖尔市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1320,N'包头市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1321,N'察哈尔右翼后旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1322,N'察哈尔右翼前旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1323,N'察哈尔右翼中旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1324,N'陈巴尔虎旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1325,N'赤峰市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1326,N'达尔罕茂明安联合旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1327,N'达拉特旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1328,N'磴口县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1329,N'东乌珠穆沁旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1330,N'多伦县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1331,N'额尔古纳市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1332,N'额济纳旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1333,N'鄂尔多斯市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1334,N'鄂伦春自治旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1335,N'鄂托克旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1336,N'鄂托克前旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1337,N'鄂温克族自治旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1338,N'二连浩特市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1339,N'丰镇市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1340,N'根河市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1341,N'固阳县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1342,N'杭锦后旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1343,N'杭锦旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1344,N'和林格尔县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1345,N'呼和浩特市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1346,N'呼伦贝尔市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1347,N'化德县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1348,N'霍林郭勒市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1349,N'喀喇沁旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1350,N'开鲁县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1351,N'科尔沁右翼前旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1352,N'科尔沁右翼中旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1353,N'科尔沁左翼后旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1354,N'科尔沁左翼中旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1355,N'克什克腾旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1356,N'库伦旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1357,N'凉城县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1358,N'林西县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1359,N'满洲里市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1360,N'莫力达瓦达斡尔族自治旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1361,N'奈曼旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1362,N'宁城县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1363,N'清水河县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1364,N'商都县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1365,N'四子王旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1366,N'苏尼特右旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1367,N'苏尼特左旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1368,N'太仆寺旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1369,N'通辽市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1370,N'突泉县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1371,N'土默特右旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1372,N'土默特左旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1373,N'托克托县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1374,N'翁牛特旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1375,N'乌海市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1376,N'乌拉特后旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1377,N'乌拉特前旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1378,N'乌拉特中旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1379,N'乌兰察布市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1380,N'乌兰浩特市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1381,N'乌审旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1382,N'五原县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1383,N'武川县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1384,N'西乌珠穆沁旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1385,N'锡林郭勒盟',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1386,N'锡林浩特市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1387,N'镶黄旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1388,N'新巴尔虎右旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1389,N'新巴尔虎左旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1390,N'兴安盟',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1391,N'兴和县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1392,N'牙克石市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1393,N'伊金霍洛旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1394,N'扎赉特旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1395,N'扎兰屯市',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1396,N'扎鲁特旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1397,N'正蓝旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1398,N'正镶白旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1399,N'准格尔旗',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1400,N'卓资县',N'中国',N'内蒙古自治区',N'',null,null)
go
insert into City values (1401,N'固原市',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1402,N'海原县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1403,N'贺兰县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1404,N'泾源县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1405,N'灵武市',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1406,N'隆德县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1407,N'宁夏回族自治区',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1408,N'彭阳县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1409,N'平罗县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1410,N'青铜峡市',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1411,N'石嘴山市',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1412,N'同心县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1413,N'吴忠市',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1414,N'西吉县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1415,N'盐池县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1416,N'银川市',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1417,N'永宁县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1418,N'中宁县',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1419,N'中卫市',N'中国',N'宁夏回族自治区',N'',null,null)
go
insert into City values (1420,N'班玛县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1421,N'称多县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1422,N'达日县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1423,N'大通回族土族自治县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1424,N'德令哈市',N'中国',N'青海省',N'',null,null)
go
insert into City values (1425,N'都兰县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1426,N'甘德县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1427,N'刚察县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1428,N'格尔木市',N'中国',N'青海省',N'',null,null)
go
insert into City values (1429,N'共和县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1430,N'贵德县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1431,N'贵南县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1432,N'果洛藏族自治州',N'中国',N'青海省',N'',null,null)
go
insert into City values (1433,N'海北藏族自治州',N'中国',N'青海省',N'',null,null)
go
insert into City values (1434,N'海东地区',N'中国',N'青海省',N'',null,null)
go
insert into City values (1435,N'海南藏族自治州',N'中国',N'青海省',N'',null,null)
go
insert into City values (1436,N'海西蒙古族藏族自治州',N'中国',N'青海省',N'',null,null)
go
insert into City values (1437,N'海晏县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1438,N'河南蒙古族自治县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1439,N'互助土族自治县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1440,N'化隆回族自治县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1441,N'黄南藏族自治州',N'中国',N'青海省',N'',null,null)
go
insert into City values (1442,N'湟源县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1443,N'湟中县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1444,N'尖扎县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1445,N'久治县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1446,N'乐都县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1447,N'玛多县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1448,N'玛沁县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1449,N'门源回族自治县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1450,N'民和回族土族自治县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1451,N'囊谦县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1452,N'平安县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1453,N'祁连县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1454,N'曲麻莱县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1455,N'天峻县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1456,N'同德县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1457,N'同仁县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1458,N'乌兰县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1459,N'西宁市',N'中国',N'青海省',N'',null,null)
go
insert into City values (1460,N'兴海县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1461,N'循化撒拉族自治县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1462,N'玉树藏族自治州',N'中国',N'青海省',N'',null,null)
go
insert into City values (1463,N'玉树县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1464,N'杂多县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1465,N'泽库县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1466,N'治多县',N'中国',N'青海省',N'',null,null)
go
insert into City values (1467,N'安丘市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1468,N'滨州市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1469,N'博兴县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1470,N'苍山县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1471,N'曹县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1472,N'昌乐县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1473,N'昌邑市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1474,N'长岛县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1475,N'成武县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1476,N'茌平县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1477,N'单县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1478,N'德州市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1479,N'定陶县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1480,N'东阿县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1481,N'东明县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1482,N'东平县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1483,N'东营市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1484,N'肥城市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1485,N'费县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1486,N'高密市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1487,N'高青县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1488,N'高唐县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1489,N'冠县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1490,N'广饶县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1491,N'海阳市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1492,N'菏泽市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1493,N'桓台县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1494,N'惠民县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1495,N'即墨市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1496,N'济南市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1497,N'济宁市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1498,N'济阳县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1499,N'嘉祥县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1500,N'胶南市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1501,N'胶州市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1502,N'金乡县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1503,N'莒南县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1504,N'莒县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1505,N'巨野县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1506,N'鄄城县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1507,N'垦利县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1508,N'莱芜市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1509,N'莱西市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1510,N'莱阳市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1511,N'莱州市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1512,N'乐陵市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1513,N'利津县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1514,N'梁山县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1515,N'聊城市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1516,N'临清市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1517,N'临朐县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1518,N'临沭县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1519,N'临沂市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1520,N'临邑县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1521,N'陵县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1522,N'龙口市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1523,N'蒙阴县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1524,N'宁津县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1525,N'宁阳县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1526,N'蓬莱市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1527,N'平度市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1528,N'平邑县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1529,N'平阴县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1530,N'平原县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1531,N'栖霞市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1532,N'齐河县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1533,N'青岛市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1534,N'青州市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1535,N'庆云县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1536,N'曲阜市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1537,N'日照市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1538,N'荣成市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1539,N'乳山市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1540,N'商河县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1541,N'寿光市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1542,N'泗水县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1543,N'泰安市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1544,N'郯城县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1545,N'滕州市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1546,N'威海市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1547,N'微山县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1548,N'潍坊市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1549,N'文登市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1550,N'汶上县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1551,N'无棣县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1552,N'五莲县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1553,N'武城县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1554,N'夏津县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1555,N'莘县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1556,N'新泰市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1557,N'烟台市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1558,N'兖州市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1559,N'阳谷县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1560,N'阳信县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1561,N'沂南县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1562,N'沂水县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1563,N'沂源县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1564,N'鱼台县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1565,N'禹城市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1566,N'郓城县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1567,N'枣庄市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1568,N'沾化县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1569,N'章丘市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1570,N'招远市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1571,N'诸城市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1572,N'淄博市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1573,N'邹城市',N'中国',N'山东省',N'',null,null)
go
insert into City values (1574,N'邹平县',N'中国',N'山东省',N'',null,null)
go
insert into City values (1575,N'安泽县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1576,N'保德县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1577,N'长治市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1578,N'长治县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1579,N'长子县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1580,N'大宁县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1581,N'大同市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1582,N'大同县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1583,N'代县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1584,N'定襄县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1585,N'繁峙县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1586,N'方山县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1587,N'汾西县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1588,N'汾阳市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1589,N'浮山县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1590,N'高平市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1591,N'古交市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1592,N'古县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1593,N'广灵县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1594,N'和顺县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1595,N'河津市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1596,N'河曲县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1597,N'洪洞县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1598,N'侯马市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1599,N'壶关县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1600,N'怀仁县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1601,N'浑源县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1602,N'霍州市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1603,N'吉县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1604,N'稷山县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1605,N'绛县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1606,N'交城县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1607,N'交口县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1608,N'介休市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1609,N'晋城市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1610,N'晋中市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1611,N'静乐县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1612,N'岢岚县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1613,N'岚县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1614,N'黎城县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1615,N'临汾市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1616,N'临县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1617,N'临猗县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1618,N'灵丘县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1619,N'灵石县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1620,N'陵川县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1621,N'柳林县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1622,N'娄烦县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1623,N'潞城市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1624,N'吕梁市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1625,N'宁武县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1626,N'偏关县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1627,N'平定县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1628,N'平陆县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1629,N'平顺县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1630,N'平遥县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1631,N'蒲县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1632,N'祁县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1633,N'沁水县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1634,N'沁县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1635,N'沁源县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1636,N'清徐县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1637,N'曲沃县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1638,N'芮城县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1639,N'山阴县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1640,N'神池县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1641,N'石楼县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1642,N'寿阳县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1643,N'朔州市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1644,N'太谷县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1645,N'太原市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1646,N'天镇县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1647,N'屯留县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1648,N'万荣县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1649,N'文水县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1650,N'闻喜县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1651,N'五台县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1652,N'五寨县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1653,N'武乡县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1654,N'昔阳县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1655,N'隰县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1656,N'夏县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1657,N'乡宁县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1658,N'襄汾县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1659,N'襄垣县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1660,N'孝义市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1661,N'忻州市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1662,N'新绛县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1663,N'兴县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1664,N'阳城县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1665,N'阳高县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1666,N'阳曲县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1667,N'阳泉市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1668,N'翼城县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1669,N'应县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1670,N'永和县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1671,N'永济市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1672,N'右玉县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1673,N'盂县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1674,N'榆社县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1675,N'垣曲县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1676,N'原平市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1677,N'运城市',N'中国',N'山西省',N'',null,null)
go
insert into City values (1678,N'泽州县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1679,N'中阳县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1680,N'左权县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1681,N'左云县',N'中国',N'山西省',N'',null,null)
go
insert into City values (1682,N'安康市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1683,N'安塞县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1684,N'白河县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1685,N'白水县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1686,N'宝鸡市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1687,N'彬县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1688,N'长武县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1689,N'城固县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1690,N'澄城县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1691,N'淳化县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1692,N'大荔县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1693,N'丹凤县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1694,N'定边县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1695,N'凤县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1696,N'凤翔县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1697,N'佛坪县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1698,N'扶风县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1699,N'府谷县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1700,N'富平县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1701,N'富县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1702,N'甘泉县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1703,N'高陵县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1704,N'韩城市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1705,N'汉阴县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1706,N'汉中市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1707,N'合阳县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1708,N'横山县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1709,N'户县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1710,N'华县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1711,N'华阴市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1712,N'黄陵县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1713,N'黄龙县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1714,N'佳县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1715,N'泾阳县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1716,N'靖边县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1717,N'岚皋县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1718,N'蓝田县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1719,N'礼泉县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1720,N'麟游县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1721,N'留坝县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1722,N'陇县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1723,N'略阳县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1724,N'洛川县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1725,N'洛南县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1726,N'眉县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1727,N'米脂县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1728,N'勉县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1729,N'南郑县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1730,N'宁强县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1731,N'宁陕县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1732,N'平利县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1733,N'蒲城县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1734,N'岐山县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1735,N'千阳县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1736,N'乾县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1737,N'清涧县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1738,N'三原县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1739,N'山阳县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1740,N'商洛市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1741,N'商南县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1742,N'神木县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1743,N'石泉县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1744,N'绥德县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1745,N'太白县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1746,N'铜川市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1747,N'潼关县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1748,N'渭南市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1749,N'吴堡县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1750,N'吴起县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1751,N'武功县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1752,N'西安市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1753,N'西乡县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1754,N'咸阳市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1755,N'兴平市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1756,N'旬阳县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1757,N'旬邑县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1758,N'延安市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1759,N'延长县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1760,N'延川县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1761,N'洋县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1762,N'宜川县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1763,N'宜君县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1764,N'永寿县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1765,N'榆林市',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1766,N'镇安县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1767,N'镇巴县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1768,N'镇坪县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1769,N'志丹县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1770,N'周至县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1771,N'子长县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1772,N'子洲县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1773,N'紫阳县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1774,N'柞水县',N'中国',N'陕西省',N'',null,null)
go
insert into City values (1775,N'上海市',N'中国',N'上海市',N'',null,null)
go
insert into City values (1776,N'崇明县',N'中国',N'上海市',N'',null,null)
go
insert into City values (1777,N'阿坝藏族羌族自治州',N'中国',N'四川省',N'',null,null)
go
insert into City values (1778,N'阿坝县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1779,N'安县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1780,N'安岳县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1781,N'巴塘县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1782,N'巴中市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1783,N'白玉县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1784,N'宝兴县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1785,N'北川羌族自治县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1786,N'布拖县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1787,N'苍溪县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1788,N'长宁县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1789,N'成都市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1790,N'崇州市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1791,N'达县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1792,N'达州市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1793,N'大邑县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1794,N'大英县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1795,N'大竹县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1796,N'丹巴县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1797,N'丹棱县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1798,N'道孚县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1799,N'稻城县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1800,N'得荣县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1801,N'德昌县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1802,N'德格县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1803,N'德阳市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1804,N'都江堰市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1805,N'峨边彝族自治县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1806,N'峨眉山市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1807,N'富顺县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1808,N'甘洛县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1809,N'甘孜藏族自治州',N'中国',N'四川省',N'',null,null)
go
insert into City values (1810,N'甘孜县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1811,N'高县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1812,N'珙县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1813,N'古蔺县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1814,N'广安市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1815,N'广汉市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1816,N'广元市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1817,N'汉源县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1818,N'合江县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1819,N'黑水县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1820,N'红原县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1821,N'洪雅县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1822,N'华蓥市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1823,N'会东县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1824,N'会理县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1825,N'夹江县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1826,N'犍为县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1827,N'简阳市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1828,N'剑阁县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1829,N'江安县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1830,N'江油市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1831,N'金川县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1832,N'金堂县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1833,N'金阳县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1834,N'井研县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1835,N'九龙县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1836,N'九寨沟县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1837,N'筠连县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1838,N'开江县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1839,N'康定县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1840,N'阆中市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1841,N'乐山市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1842,N'乐至县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1843,N'雷波县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1844,N'理塘县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1845,N'理县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1846,N'凉山彝族自治州',N'中国',N'四川省',N'',null,null)
go
insert into City values (1847,N'邻水县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1848,N'隆昌县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1849,N'芦山县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1850,N'泸定县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1851,N'泸县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1852,N'泸州市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1853,N'炉霍县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1854,N'罗江县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1855,N'马边彝族自治县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1856,N'马尔康县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1857,N'茂县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1858,N'眉山市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1859,N'美姑县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1860,N'米易县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1861,N'绵阳市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1862,N'绵竹市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1863,N'冕宁县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1864,N'名山县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1865,N'木里藏族自治县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1866,N'沐川县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1867,N'内江市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1868,N'南部县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1869,N'南充市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1870,N'南江县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1871,N'南溪县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1872,N'宁南县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1873,N'攀枝花市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1874,N'彭山县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1875,N'彭州市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1876,N'蓬安县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1877,N'蓬溪县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1878,N'郫县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1879,N'平昌县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1880,N'平武县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1881,N'屏山县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1882,N'蒲江县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1883,N'普格县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1884,N'青川县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1885,N'青神县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1886,N'邛崃市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1887,N'渠县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1888,N'壤塘县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1889,N'仁寿县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1890,N'荣县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1891,N'若尔盖县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1892,N'三台县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1893,N'色达县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1894,N'射洪县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1895,N'什邡市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1896,N'石棉县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1897,N'石渠县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1898,N'双流县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1899,N'松潘县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1900,N'遂宁市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1901,N'天全县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1902,N'通江县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1903,N'万源市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1904,N'旺苍县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1905,N'威远县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1906,N'汶川县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1907,N'武胜县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1908,N'西昌市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1909,N'西充县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1910,N'喜德县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1911,N'乡城县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1912,N'小金县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1913,N'新津县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1914,N'新龙县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1915,N'兴文县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1916,N'叙永县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1917,N'宣汉县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1918,N'雅安市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1919,N'雅江县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1920,N'盐边县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1921,N'盐亭县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1922,N'盐源县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1923,N'仪陇县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1924,N'宜宾市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1925,N'宜宾县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1926,N'荥经县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1927,N'营山县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1928,N'岳池县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1929,N'越西县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1930,N'昭觉县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1931,N'中江县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1932,N'资阳市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1933,N'资中县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1934,N'梓潼县',N'中国',N'四川省',N'',null,null)
go
insert into City values (1935,N'自贡市',N'中国',N'四川省',N'',null,null)
go
insert into City values (1936,N'高雄市',N'中国',N'台湾省',N'',null,null)
go
insert into City values (1937,N'基隆市',N'中国',N'台湾省',N'',null,null)
go
insert into City values (1938,N'台北市',N'中国',N'台湾省',N'',null,null)
go
insert into City values (1939,N'台南市',N'中国',N'台湾省',N'',null,null)
go
insert into City values (1940,N'台中市',N'中国',N'台湾省',N'',null,null)
go
insert into City values (1941,N'桃源市',N'中国',N'台湾省',N'',null,null)
go
insert into City values (1942,N'新竹市',N'中国',N'台湾省',N'',null,null)
go
insert into City values (1943,N'宜兰市',N'中国',N'台湾省',N'',null,null)
go
insert into City values (1944,N'蓟县',N'中国',N'天津市',N'',null,null)
go
insert into City values (1945,N'静海县',N'中国',N'天津市',N'',null,null)
go
insert into City values (1946,N'宁河县',N'中国',N'天津市',N'',null,null)
go
insert into City values (1947,N'天津市',N'中国',N'天津市',N'',null,null)
go
insert into City values (1948,N'阿里地区',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1949,N'安多县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1950,N'昂仁县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1951,N'八宿县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1952,N'巴青县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1953,N'白朗县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1954,N'班戈县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1955,N'比如县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1956,N'边坝县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1957,N'波密县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1958,N'察雅县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1959,N'察隅县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1960,N'昌都地区',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1961,N'昌都县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1962,N'措美县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1963,N'措勤县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1964,N'错那县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1965,N'达孜县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1966,N'当雄县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1967,N'丁青县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1968,N'定结县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1969,N'定日县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1970,N'堆龙德庆县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1971,N'噶尔县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1972,N'改则县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1973,N'岗巴县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1974,N'革吉县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1975,N'工布江达县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1976,N'贡嘎县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1977,N'贡觉县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1978,N'吉隆县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1979,N'加查县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1980,N'嘉黎县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1981,N'江达县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1982,N'江孜县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1983,N'康马县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1984,N'拉萨市',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1985,N'拉孜县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1986,N'朗县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1987,N'浪卡子县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1988,N'类乌齐县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1989,N'林芝地区',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1990,N'林芝县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1991,N'林周县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1992,N'隆子县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1993,N'洛隆县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1994,N'洛扎县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1995,N'芒康县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1996,N'米林县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1997,N'墨脱县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1998,N'墨竹工卡县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (1999,N'那曲地区',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2000,N'那曲县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2001,N'乃东县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2002,N'南木林县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2003,N'尼玛县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2004,N'尼木县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2005,N'聂拉木县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2006,N'聂荣县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2007,N'普兰县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2008,N'琼结县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2009,N'曲水县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2010,N'曲松县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2011,N'仁布县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2012,N'日喀则地区',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2013,N'日喀则市',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2014,N'日土县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2015,N'萨嘎县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2016,N'萨迦县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2017,N'桑日县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2018,N'山南地区',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2019,N'申扎县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2020,N'索县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2021,N'谢通门县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2022,N'亚东县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2023,N'扎囊县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2024,N'札达县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2025,N'仲巴县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2026,N'左贡县',N'中国',N'西藏自治区',N'',null,null)
go
insert into City values (2027,N'香港特别行政区',N'中国',N'香港特别行政区',N'',null,null)
go
insert into City values (2028,N'阿合奇县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2029,N'阿克苏地区',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2030,N'阿克苏市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2031,N'阿克陶县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2032,N'阿拉尔市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2033,N'阿勒泰地区',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2034,N'阿勒泰市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2035,N'阿图什市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2036,N'阿瓦提县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2037,N'巴楚县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2038,N'巴里坤哈萨克自治县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2039,N'巴音郭楞蒙古自治州',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2040,N'拜城县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2041,N'博尔塔拉蒙古自治州',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2042,N'博湖县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2043,N'博乐市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2044,N'布尔津县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2045,N'策勒县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2046,N'察布查尔锡伯自治县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2047,N'昌吉回族自治州',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2048,N'昌吉市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2049,N'额敏县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2050,N'福海县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2051,N'阜康市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2052,N'富蕴县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2053,N'伽师县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2054,N'巩留县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2055,N'哈巴河县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2056,N'哈密地区',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2057,N'哈密市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2058,N'和布克赛尔蒙古自治县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2059,N'和静县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2060,N'和硕县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2061,N'和田地区',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2062,N'和田市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2063,N'和田县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2064,N'呼图壁县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2065,N'霍城县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2066,N'吉木乃县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2067,N'吉木萨尔县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2068,N'精河县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2069,N'喀什地区',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2070,N'喀什市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2071,N'柯坪县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2072,N'克拉玛依市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2073,N'克孜勒苏柯尔克孜自治州',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2074,N'库车县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2075,N'库尔勒市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2076,N'奎屯市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2077,N'轮台县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2078,N'洛浦县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2079,N'玛纳斯县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2080,N'麦盖提县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2081,N'民丰县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2082,N'墨玉县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2083,N'木垒哈萨克自治县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2084,N'尼勒克县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2085,N'皮山县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2086,N'奇台县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2087,N'且末县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2088,N'青河县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2089,N'若羌县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2090,N'沙湾县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2091,N'沙雅县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2092,N'莎车县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2093,N'鄯善县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2094,N'石河子市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2095,N'疏附县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2096,N'疏勒县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2097,N'塔城地区',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2098,N'塔城市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2099,N'塔什库尔干塔吉克自治县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2100,N'特克斯县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2101,N'图木舒克市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2102,N'吐鲁番地区',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2103,N'吐鲁番市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2104,N'托克逊县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2105,N'托里县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2106,N'尉犁县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2107,N'温泉县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2108,N'温宿县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2109,N'乌鲁木齐市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2110,N'乌鲁木齐县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2111,N'乌恰县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2112,N'乌什县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2113,N'乌苏市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2114,N'五家渠市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2115,N'新和县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2116,N'新源县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2117,N'焉耆回族自治县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2118,N'叶城县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2119,N'伊犁哈萨克自治州',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2120,N'伊宁市',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2121,N'伊宁县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2122,N'伊吾县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2123,N'英吉沙县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2124,N'于田县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2125,N'裕民县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2126,N'岳普湖县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2127,N'泽普县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2128,N'昭苏县',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2129,N'自治区直辖县级行政单位',N'中国',N'新疆维吾尔自治区',N'',null,null)
go
insert into City values (2130,N'安宁市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2131,N'保山市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2132,N'宾川县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2133,N'沧源佤族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2134,N'昌宁县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2135,N'呈贡县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2136,N'澄江县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2137,N'楚雄市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2138,N'楚雄彝族自治州',N'中国',N'云南省',N'',null,null)
go
insert into City values (2139,N'大关县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2140,N'大理白族自治州',N'中国',N'云南省',N'',null,null)
go
insert into City values (2141,N'大理市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2142,N'大姚县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2143,N'德宏傣族景颇族自治州',N'中国',N'云南省',N'',null,null)
go
insert into City values (2144,N'德钦县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2145,N'迪庆藏族自治州',N'中国',N'云南省',N'',null,null)
go
insert into City values (2146,N'峨山彝族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2147,N'洱源县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2148,N'凤庆县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2149,N'福贡县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2150,N'富民县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2151,N'富宁县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2152,N'富源县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2153,N'个旧市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2154,N'耿马傣族佤族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2155,N'贡山独龙族怒族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2156,N'广南县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2157,N'河口瑶族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2158,N'鹤庆县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2159,N'红河哈尼族彝族自治州',N'中国',N'云南省',N'',null,null)
go
insert into City values (2160,N'红河县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2161,N'华宁县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2162,N'华坪县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2163,N'会泽县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2164,N'建水县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2165,N'剑川县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2166,N'江城哈尼族彝族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2167,N'江川县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2168,N'金平苗族瑶族傣族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2169,N'晋宁县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2170,N'景东彝族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2171,N'景谷傣族彝族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2172,N'景洪市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2173,N'开远市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2174,N'昆明市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2175,N'兰坪白族普米族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2176,N'澜沧拉祜族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2177,N'丽江市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2178,N'梁河县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2179,N'临沧市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2180,N'龙陵县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2181,N'陇川县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2182,N'泸水县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2183,N'泸西县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2184,N'鲁甸县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2185,N'陆良县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2186,N'禄丰县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2187,N'禄劝彝族苗族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2188,N'潞西市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2189,N'绿春县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2190,N'罗平县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2191,N'麻栗坡县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2192,N'马关县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2193,N'马龙县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2194,N'勐海县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2195,N'勐腊县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2196,N'蒙自县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2197,N'孟连傣族拉祜族佤族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2198,N'弥渡县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2199,N'弥勒县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2200,N'墨江哈尼族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2201,N'牟定县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2202,N'南华县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2203,N'南涧彝族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2204,N'宁洱哈尼族彝族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2205,N'宁蒗彝族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2206,N'怒江傈僳族自治州',N'中国',N'云南省',N'',null,null)
go
insert into City values (2207,N'屏边苗族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2208,N'普洱市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2209,N'巧家县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2210,N'丘北县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2211,N'曲靖市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2212,N'瑞丽市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2213,N'师宗县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2214,N'施甸县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2215,N'石林彝族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2216,N'石屏县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2217,N'双柏县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2218,N'双江拉祜族佤族布朗族傣族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2219,N'水富县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2220,N'嵩明县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2221,N'绥江县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2222,N'腾冲县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2223,N'通海县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2224,N'威信县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2225,N'巍山彝族回族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2226,N'维西傈僳族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2227,N'文山县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2228,N'文山壮族苗族自治州',N'中国',N'云南省',N'',null,null)
go
insert into City values (2229,N'武定县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2230,N'西畴县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2231,N'西盟佤族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2232,N'西双版纳傣族自治州',N'中国',N'云南省',N'',null,null)
go
insert into City values (2233,N'香格里拉县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2234,N'祥云县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2235,N'新平彝族傣族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2236,N'宣威市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2237,N'寻甸回族彝族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2238,N'盐津县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2239,N'砚山县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2240,N'漾濞彝族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2241,N'姚安县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2242,N'宜良县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2243,N'彝良县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2244,N'易门县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2245,N'盈江县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2246,N'永德县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2247,N'永平县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2248,N'永仁县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2249,N'永善县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2250,N'永胜县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2251,N'玉龙纳西族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2252,N'玉溪市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2253,N'元江哈尼族彝族傣族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2254,N'元谋县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2255,N'元阳县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2256,N'云龙县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2257,N'云县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2258,N'沾益县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2259,N'昭通市',N'中国',N'云南省',N'',null,null)
go
insert into City values (2260,N'镇康县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2261,N'镇雄县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2262,N'镇沅彝族哈尼族拉祜族自治县',N'中国',N'云南省',N'',null,null)
go
insert into City values (2263,N'安吉县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2264,N'苍南县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2265,N'长兴县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2266,N'常山县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2267,N'淳安县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2268,N'慈溪市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2269,N'岱山县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2270,N'德清县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2271,N'东阳市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2272,N'洞头县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2273,N'奉化市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2274,N'富阳市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2275,N'海宁市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2276,N'海盐县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2277,N'杭州市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2278,N'湖州市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2279,N'嘉善县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2280,N'嘉兴市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2281,N'建德市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2282,N'江山市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2283,N'金华市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2284,N'缙云县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2285,N'景宁畲族自治县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2286,N'开化县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2287,N'兰溪市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2288,N'乐清市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2289,N'丽水市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2290,N'临安市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2291,N'临海市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2292,N'龙泉市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2293,N'龙游县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2294,N'宁波市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2295,N'宁海县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2296,N'磐安县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2297,N'平湖市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2298,N'平阳县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2299,N'浦江县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2300,N'青田县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2301,N'庆元县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2302,N'衢州市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2303,N'瑞安市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2304,N'三门县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2305,N'上虞市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2306,N'绍兴市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2307,N'绍兴县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2308,N'嵊泗县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2309,N'嵊州市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2310,N'松阳县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2311,N'遂昌县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2312,N'台州市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2313,N'泰顺县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2314,N'天台县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2315,N'桐庐县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2316,N'桐乡市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2317,N'温岭市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2318,N'温州市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2319,N'文成县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2320,N'武义县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2321,N'仙居县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2322,N'象山县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2323,N'新昌县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2324,N'义乌市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2325,N'永嘉县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2326,N'永康市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2327,N'余姚市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2328,N'玉环县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2329,N'云和县',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2330,N'舟山市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2331,N'诸暨市',N'中国',N'浙江省',N'',null,null)
go
insert into City values (2332,N'璧山县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2333,N'城口县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2334,N'大足县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2335,N'垫江县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2336,N'丰都县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2337,N'奉节县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2338,N'开县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2339,N'梁平县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2340,N'彭水苗族土家族自治县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2341,N'綦江县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2342,N'荣昌县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2343,N'石柱土家族自治县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2344,N'铜梁县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2345,N'潼南县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2346,N'巫山县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2347,N'巫溪县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2348,N'武隆县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2349,N'秀山土家族苗族自治县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2350,N'酉阳土家族苗族自治县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2351,N'云阳县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2352,N'忠县',N'中国',N'重庆市',N'',null,null)
go
insert into City values (2353,N'重庆市',N'中国',N'重庆市',N'',null,null)
go
