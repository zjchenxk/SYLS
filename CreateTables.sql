/*==============================================================*/
/* Database name:  InnoLS                                       */
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2013/2/27 16:04:32                           */
/*==============================================================*/


/*==============================================================*/
/* Domain: ZC_DateTime                                          */
/*==============================================================*/
create type ZC_DateTime
   from datetime
go

/*==============================================================*/
/* Domain: ZC_Flag                                              */
/*==============================================================*/
create type ZC_Flag
   from nchar(1)
go

/*==============================================================*/
/* Domain: ZC_IP                                                */
/*==============================================================*/
create type ZC_IP
   from nvarchar(30)
go

/*==============================================================*/
/* Domain: ZC_Id                                                */
/*==============================================================*/
create type ZC_Id
   from bigint
go

/*==============================================================*/
/* Domain: ZC_Money                                             */
/*==============================================================*/
create type ZC_Money
   from numeric(25,9)
go

/*==============================================================*/
/* Domain: ZC_NO                                                */
/*==============================================================*/
create type ZC_NO
   from nvarchar(30)
go

/*==============================================================*/
/* Domain: ZC_PhoneNum                                          */
/*==============================================================*/
create type ZC_PhoneNum
   from nvarchar(20)
go

/*==============================================================*/
/* Domain: ZC_Text_10                                           */
/*==============================================================*/
create type ZC_Text_10
   from nvarchar(10)
go

/*==============================================================*/
/* Domain: ZC_Text_100                                          */
/*==============================================================*/
create type ZC_Text_100
   from nvarchar(100)
go

/*==============================================================*/
/* Domain: ZC_Text_1000                                         */
/*==============================================================*/
create type ZC_Text_1000
   from nvarchar(1000)
go

/*==============================================================*/
/* Domain: ZC_Text_20                                           */
/*==============================================================*/
create type ZC_Text_20
   from nvarchar(20)
go

/*==============================================================*/
/* Domain: ZC_Text_200                                          */
/*==============================================================*/
create type ZC_Text_200
   from nvarchar(200)
go

/*==============================================================*/
/* Domain: ZC_Text_2000                                         */
/*==============================================================*/
create type ZC_Text_2000
   from nvarchar(2000)
go

/*==============================================================*/
/* Domain: ZC_Text_30                                           */
/*==============================================================*/
create type ZC_Text_30
   from nvarchar(30)
go

/*==============================================================*/
/* Domain: ZC_Text_50                                           */
/*==============================================================*/
create type ZC_Text_50
   from nvarchar(50)
go

/*==============================================================*/
/* Domain: ZC_Text_500                                          */
/*==============================================================*/
create type ZC_Text_500
   from nvarchar(500)
go

/*==============================================================*/
/* Domain: ZC_Text_Max                                          */
/*==============================================================*/
create type ZC_Text_Max
   from nvarchar(Max)
go

/*==============================================================*/
/* Domain: ZC_Url                                               */
/*==============================================================*/
create type ZC_Url
   from nvarchar(255)
go

/*==============================================================*/
/* Domain: ZC_YesNo                                             */
/*==============================================================*/
create type ZC_YesNo
   from bit
go

/*==============================================================*/
/* Table: Account                                               */
/*==============================================================*/
create table dbo.Account (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_20           not null,
   Password             ZC_Text_50           not null,
   AccountType          ZC_Text_20           not null,
   OrganId              ZC_Id                not null default 0,
   OrganFullName        ZC_Text_50           not null default '',
   StaffId              ZC_Id                not null,
   StaffName            ZC_Text_50           not null,
   IsCancel             ZC_YesNo             not null,
   OnlineStartId        ZC_Id                not null,
   OfflineStartId       ZC_Id                not null,
   CreateTime           ZC_DateTime          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ʺű�',
   'user', 'dbo', 'table', 'Account'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ʺű���',
   'user', 'dbo', 'table', 'Account', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ʺ�����',
   'user', 'dbo', 'table', 'Account', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ʺ�����',
   'user', 'dbo', 'table', 'Account', 'column', 'Password'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ʺ����',
   'user', 'dbo', 'table', 'Account', 'column', 'AccountType'
go

execute sp_addextendedproperty 'MS_Description', 
   '������֯���Ż�ͻ��ı���',
   'user', 'dbo', 'table', 'Account', 'column', 'OrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������֯���Ż�ͻ�������',
   'user', 'dbo', 'table', 'Account', 'column', 'OrganFullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������֯����Ա����ͻ���ϵ�˵ı���',
   'user', 'dbo', 'table', 'Account', 'column', 'StaffId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������֯����Ա����ͻ���ϵ�˵�����',
   'user', 'dbo', 'table', 'Account', 'column', 'StaffName'
go

execute sp_addextendedproperty 'MS_Description', 
   'ע����־��1-�ǣ�0-��',
   'user', 'dbo', 'table', 'Account', 'column', 'IsCancel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������ʼID����',
   'user', 'dbo', 'table', 'Account', 'column', 'OnlineStartId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ѻ�������ʼID����',
   'user', 'dbo', 'table', 'Account', 'column', 'OfflineStartId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'Account', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Account', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Account', 'column', '_myUpdate'
go

alter table dbo.Account
   add constraint PK_ACCOUNT primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_Name                                            */
/*==============================================================*/
create unique index Index_Name on dbo.Account (
Name ASC
)
go

/*==============================================================*/
/* Table: AccountPermission                                     */
/*==============================================================*/
create table dbo.AccountPermission (
   Id                   ZC_Id                not null,
   AccountId            ZC_Id                not null,
   GroupId              ZC_Id                not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ʺ�Ȩ�ޱ�',
   'user', 'dbo', 'table', 'AccountPermission'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'AccountPermission', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ʺű��',
   'user', 'dbo', 'table', 'AccountPermission', 'column', 'AccountId'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ȩ������',
   'user', 'dbo', 'table', 'AccountPermission', 'column', 'GroupId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'AccountPermission', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'AccountPermission', 'column', '_myUpdate'
go

alter table dbo.AccountPermission
   add constraint PK_ACCOUNTPERMISSION primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_GroupId_AccountId                               */
/*==============================================================*/
create unique index Index_GroupId_AccountId on dbo.AccountPermission (
GroupId ASC,
AccountId ASC
)
go

/*==============================================================*/
/* Table: AppVersion                                            */
/*==============================================================*/
create table dbo.AppVersion (
   Version              ZC_Text_20           not null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'ϵͳ�汾��',
   'user', 'dbo', 'table', 'AppVersion'
go

execute sp_addextendedproperty 'MS_Description', 
   'ϵͳ�汾��',
   'user', 'dbo', 'table', 'AppVersion', 'column', 'Version'
go

alter table dbo.AppVersion
   add constraint PK_APPVERSION primary key (Version)
go

/*==============================================================*/
/* Table: ApproveFlowStep                                       */
/*==============================================================*/
create table dbo.ApproveFlowStep (
   Id                   ZC_Id                not null,
   StepName             ZC_Text_50           not null,
   StepNum              int                  not null,
   FlowType             ZC_Text_50           not null,
   DisposerId           ZC_Id                not null,
   DisposerName         ZC_Text_50           null,
   ConditionExpression  ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�������̲����',
   'user', 'dbo', 'table', 'ApproveFlowStep'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'ApproveFlowStep', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'ApproveFlowStep', 'column', 'StepName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'ApproveFlowStep', 'column', 'StepNum'
go

execute sp_addextendedproperty 'MS_Description', 
   '���������ƻ��������۸������ȵ�',
   'user', 'dbo', 'table', 'ApproveFlowStep', 'column', 'FlowType'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱��롣ע�⣺������ֶ�ֵΪ0,���ʾ������Ϊ���ž���',
   'user', 'dbo', 'table', 'ApproveFlowStep', 'column', 'DisposerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������������ע�⣺���DisposerIdΪ0,����ֶ�ֵ��Ϊ�����ž���',
   'user', 'dbo', 'table', 'ApproveFlowStep', 'column', 'DisposerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ʽ',
   'user', 'dbo', 'table', 'ApproveFlowStep', 'column', 'ConditionExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'ApproveFlowStep', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'ApproveFlowStep', 'column', '_myUpdate'
go

alter table dbo.ApproveFlowStep
   add constraint PK_APPROVEFLOWSTEP primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_FlowType                                        */
/*==============================================================*/
create index Index_FlowType on dbo.ApproveFlowStep (
FlowType ASC
)
go

/*==============================================================*/
/* Table: ApproveFlowStepCondition                              */
/*==============================================================*/
create table dbo.ApproveFlowStepCondition (
   Id                   ZC_Id                not null,
   StepId               ZC_Id                not null,
   FlowType             ZC_Text_50           not null,
   ConditionNum         int                  not null,
   FieldName            ZC_Text_50           not null,
   CompareOperator      ZC_Text_20           not null,
   FieldValue           ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�������̲���������',
   'user', 'dbo', 'table', 'ApproveFlowStepCondition'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'ApproveFlowStepCondition', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'ApproveFlowStepCondition', 'column', 'StepId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���������ƻ��������۸������ȵ�',
   'user', 'dbo', 'table', 'ApproveFlowStepCondition', 'column', 'FlowType'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'ApproveFlowStepCondition', 'column', 'ConditionNum'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ֶ�����',
   'user', 'dbo', 'table', 'ApproveFlowStepCondition', 'column', 'FieldName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƚ����������>��>=��<��<=��=��<>��',
   'user', 'dbo', 'table', 'ApproveFlowStepCondition', 'column', 'CompareOperator'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ֶ�ֵ',
   'user', 'dbo', 'table', 'ApproveFlowStepCondition', 'column', 'FieldValue'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'ApproveFlowStepCondition', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'ApproveFlowStepCondition', 'column', '_myUpdate'
go

alter table dbo.ApproveFlowStepCondition
   add constraint PK_APPROVEFLOWSTEPCONDITION primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_StepId                                          */
/*==============================================================*/
create index Index_StepId on dbo.ApproveFlowStepCondition (
StepId ASC
)
go

/*==============================================================*/
/* Index: Index_FlowType                                        */
/*==============================================================*/
create index Index_FlowType on dbo.ApproveFlowStepCondition (
FlowType ASC
)
go

/*==============================================================*/
/* Table: Boss                                                  */
/*==============================================================*/
create table dbo.Boss (
   Id                   ZC_Id                identity,
   StaffId              ZC_Id                not null,
   BossId               ZC_Id                not null,
   IsFromLeader         bit                  not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'Ա��������˾��',
   'user', 'dbo', 'table', 'Boss'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Boss', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ա������',
   'user', 'dbo', 'table', 'Boss', 'column', 'StaffId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��˾Ա������',
   'user', 'dbo', 'table', 'Boss', 'column', 'BossId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������֯�����˱�־',
   'user', 'dbo', 'table', 'Boss', 'column', 'IsFromLeader'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Boss', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Boss', 'column', '_myUpdate'
go

alter table dbo.Boss
   add constraint PK_BOSS primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_BossId                                          */
/*==============================================================*/
create clustered index Index_BossId on dbo.Boss (
BossId ASC
)
go

/*==============================================================*/
/* Index: Index_StaffId_BossId                                  */
/*==============================================================*/
create unique index Index_StaffId_BossId on dbo.Boss (
StaffId ASC,
BossId ASC
)
go

/*==============================================================*/
/* Index: Index_StaffId                                         */
/*==============================================================*/
create index Index_StaffId on dbo.Boss (
StaffId ASC
)
go

/*==============================================================*/
/* Table: Carrier                                               */
/*==============================================================*/
create table dbo.Carrier (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_50           not null,
   BusinessType         ZC_Text_10           not null,
   PaymentType          ZC_Text_10           not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ��',
   'user', 'dbo', 'table', 'Carrier'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'Carrier', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'Carrier', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӫ���ʣ���Ӫ�����˺�����',
   'user', 'dbo', 'table', 'Carrier', 'column', 'BusinessType'
go

execute sp_addextendedproperty 'MS_Description', 
   '���㷽ʽ���½���ָ�',
   'user', 'dbo', 'table', 'Carrier', 'column', 'PaymentType'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Carrier', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Carrier', 'column', '_myUpdate'
go

alter table dbo.Carrier
   add constraint PK_CARRIER primary key (Id)
go

/*==============================================================*/
/* Index: Index_Name                                            */
/*==============================================================*/
create unique index Index_Name on dbo.Carrier (
Name ASC
)
go

/*==============================================================*/
/* Table: CarrierCar                                            */
/*==============================================================*/
create table dbo.CarrierCar (
   Id                   ZC_Id                not null,
   CarrierId            ZC_Id                not null,
   CarNo                ZC_Text_20           not null,
   TrailerNo            ZC_Text_10           null,
   CarryingCapacity     int                  null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ������',
   'user', 'dbo', 'table', 'CarrierCar'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'CarrierCar', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'CarrierCar', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'CarrierCar', 'column', 'CarNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ҳ���',
   'user', 'dbo', 'table', 'CarrierCar', 'column', 'TrailerNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'CarrierCar', 'column', 'CarryingCapacity'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CarrierCar', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CarrierCar', 'column', '_myUpdate'
go

alter table dbo.CarrierCar
   add constraint PK_CARRIERCAR primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_CarrierId                                       */
/*==============================================================*/
create clustered index Index_CarrierId on dbo.CarrierCar (
CarrierId ASC
)
go

/*==============================================================*/
/* Index: Index_CarNo                                           */
/*==============================================================*/
create unique index Index_CarNo on dbo.CarrierCar (
CarNo ASC
)
go

/*==============================================================*/
/* Table: CarrierDriver                                         */
/*==============================================================*/
create table dbo.CarrierDriver (
   Id                   ZC_Id                not null,
   CarrierId            ZC_Id                not null,
   CarNo                ZC_Text_Max          not null,
   Name                 ZC_Text_20           not null,
   LicenseNo            ZC_Text_20           not null,
   MobileTel            ZC_Text_20           not null,
   HomeTel              ZC_Text_20           null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ��ʻԱ��',
   'user', 'dbo', 'table', 'CarrierDriver'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'CarrierDriver', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'CarrierDriver', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'CarrierDriver', 'column', 'CarNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'CarrierDriver', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻ֤��',
   'user', 'dbo', 'table', 'CarrierDriver', 'column', 'LicenseNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ֻ�',
   'user', 'dbo', 'table', 'CarrierDriver', 'column', 'MobileTel'
go

execute sp_addextendedproperty 'MS_Description', 
   'סլ�绰',
   'user', 'dbo', 'table', 'CarrierDriver', 'column', 'HomeTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CarrierDriver', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CarrierDriver', 'column', '_myUpdate'
go

alter table dbo.CarrierDriver
   add constraint PK_CARRIERDRIVER primary key nonclustered (Id)
go

/*==============================================================*/
/* Table: CarrierSettlementExpression                           */
/*==============================================================*/
create table dbo.CarrierSettlementExpression (
   Id                   ZC_Id                not null,
   CarrierId            ZC_Id                not null,
   PlanType             ZC_Text_10           not null,
   TransportChargeExpression ZC_Text_100          not null,
   TransportPriceExpression ZC_Text_100          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ���㹫ʽ��',
   'user', 'dbo', 'table', 'CarrierSettlementExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'CarrierSettlementExpression', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'CarrierSettlementExpression', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ����ֽ�����ƻ����޷����ƻ��������淢���ƻ������������ƻ�',
   'user', 'dbo', 'table', 'CarrierSettlementExpression', 'column', 'PlanType'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷ѹ�ʽ',
   'user', 'dbo', 'table', 'CarrierSettlementExpression', 'column', 'TransportChargeExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '���۹�ʽ',
   'user', 'dbo', 'table', 'CarrierSettlementExpression', 'column', 'TransportPriceExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CarrierSettlementExpression', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CarrierSettlementExpression', 'column', '_myUpdate'
go

alter table dbo.CarrierSettlementExpression
   add constraint PK_CARRIERSETTLEMENTEXPRESSION primary key (Id)
go

/*==============================================================*/
/* Table: CarrierTransportChargesSettlement                     */
/*==============================================================*/
create table dbo.CarrierTransportChargesSettlement (
   Id                   ZC_Id                not null,
   CarrierId            ZC_Id                not null,
   CarrierName          ZC_Text_50           not null,
   SettlementAmount     ZC_Money             not null,
   WithholdAmount       ZC_Money             null,
   FactpaymentAmount    ZC_Money             not null,
   Remark               ZC_Text_100          null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateTime           ZC_DateTime          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ�˷ѽ����',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ����',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', 'CarrierName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', 'SettlementAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ۿ���',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', 'WithholdAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   'ʵ�����',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', 'FactpaymentAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlement', 'column', '_myUpdate'
go

alter table dbo.CarrierTransportChargesSettlement
   add constraint PK_CARRIERTRANSPORTCHARGESSETT primary key (Id)
go

/*==============================================================*/
/* Table: CarrierTransportChargesSettlementDetail               */
/*==============================================================*/
create table dbo.CarrierTransportChargesSettlementDetail (
   Id                   ZC_Id                not null,
   CarrierTransportChargesSettlementId ZC_Id                not null,
   DeliverBillId        ZC_Id                not null,
   TransportCharges     ZC_Money             not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ�˷ѽ�����ϸ��',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlementDetail'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ����',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlementDetail', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����¼����',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlementDetail', 'column', 'CarrierTransportChargesSettlementId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�������',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlementDetail', 'column', 'DeliverBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷�',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlementDetail', 'column', 'TransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlementDetail', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CarrierTransportChargesSettlementDetail', 'column', '_myUpdate'
go

alter table dbo.CarrierTransportChargesSettlementDetail
   add constraint PK_CARRIERTRANSPORTCHARGESSETT primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_CustomerTransportChargesSettlementId            */
/*==============================================================*/
create clustered index Index_CustomerTransportChargesSettlementId on dbo.CarrierTransportChargesSettlementDetail (
CarrierTransportChargesSettlementId ASC
)
go

/*==============================================================*/
/* Table: CarrierTransportPrice                                 */
/*==============================================================*/
create table dbo.CarrierTransportPrice (
   Id                   ZC_Id                not null,
   CarrierId            ZC_Id                not null,
   StartCountry         ZC_Text_20           not null,
   StartProvince        ZC_Text_20           not null,
   StartCity            ZC_Text_20           not null,
   DestCountry          ZC_Text_20           not null,
   DestProvince         ZC_Text_20           not null,
   DestCity             ZC_Text_20           not null,
   PlanType             ZC_Text_10           not null,
   StartTime            ZC_DateTime          not null,
   EndTime              ZC_DateTime          not null,
   TransportPrice       ZC_Money             not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ���˼۸��',
   'user', 'dbo', 'table', 'CarrierTransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'StartCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʡ��',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'StartProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'StartCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'DestCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʡ��',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'DestProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'DestCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ����ֽ�����ƻ����޷����ƻ��������淢���ƻ������������ƻ�',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'PlanType'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʼʱ��',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'StartTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֹʱ��',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'EndTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CarrierTransportPrice', 'column', '_myUpdate'
go

alter table dbo.CarrierTransportPrice
   add constraint PK_CARRIERTRANSPORTPRICE primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_CarrierId                                       */
/*==============================================================*/
create clustered index Index_CarrierId on dbo.CarrierTransportPrice (
CarrierId ASC
)
go

/*==============================================================*/
/* Table: City                                                  */
/*==============================================================*/
create table dbo.City (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_20           not null,
   CountryName          ZC_Text_20           not null,
   ProvinceName         ZC_Text_20           null,
   Remark               ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���б�',
   'user', 'dbo', 'table', 'City'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'City', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'City', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'City', 'column', 'CountryName'
go

execute sp_addextendedproperty 'MS_Description', 
   'ʡ������',
   'user', 'dbo', 'table', 'City', 'column', 'ProvinceName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'City', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'City', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'City', 'column', '_myUpdate'
go

alter table dbo.City
   add constraint PK_CITY primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_Country_Province_Name                           */
/*==============================================================*/
create unique index Index_Country_Province_Name on dbo.City (
Name ASC,
CountryName ASC,
ProvinceName ASC
)
go

/*==============================================================*/
/* Index: Index_Country_Province                                */
/*==============================================================*/
create clustered index Index_Country_Province on dbo.City (
CountryName ASC,
ProvinceName ASC
)
go

/*==============================================================*/
/* Table: Contract                                              */
/*==============================================================*/
create table dbo.Contract (
   Id                   ZC_Id                not null,
   DispatchBillId       ZC_Id                not null,
   ContractNo           ZC_Text_20           not null,
   OriginalContractNo   ZC_Text_20           null,
   CarNo                ZC_Text_20           not null,
   TrailerNo            ZC_Text_10           null,
   CarType              ZC_Text_10           null,
   DriverName           ZC_Text_20           not null,
   DriverLicenseNo      ZC_Text_20           not null,
   DriverMobileTel      ZC_Text_20           not null,
   DriverHomeTel        ZC_Text_20           not null,
   CarrierId            ZC_Id                not null,
   CarrierName          ZC_Text_50           not null,
   GoodsName            ZC_Text_500          not null,
   Packing              ZC_Text_50           null,
   StartPlace           ZC_Text_20           not null,
   DestPlace            ZC_Text_200          not null,
   ShipmentTime         ZC_DateTime          not null,
   ArrivalTime          ZC_DateTime          null,
   TotalPackages        int                  null,
   TotalTunnages        ZC_Money             null,
   TotalPiles           ZC_Money             null,
   TotalTenThousands    ZC_Money             null,
   TotalTransportCharges ZC_Money             not null,
   PrepayTransportCharges ZC_Money             not null,
   ResidualTransportCharges ZC_Money             not null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateOrganId        ZC_Id                not null,
   CreateOrganName      ZC_Text_50           not null,
   CreateTime           ZC_DateTime          not null,
   OwnOrganId           ZC_Id                not null,
   OwnOrganName         ZC_Text_50           not null,
   ContractState        ZC_Text_10           not null,
   PrintState           bit                  not null,
   ApproveState         ZC_Text_20           null,
   ApproveFlowStepNum   int                  null,
   ApproveFlowStepName  ZC_Text_50           null,
   ApproverId           ZC_Id                null,
   ApproverName         ZC_Text_20           null,
   FineAmount           ZC_Money             null,
   FineTime             ZC_DateTime          null,
   IsPrestowage         bit                  not null default 1,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ͬ��',
   'user', 'dbo', 'table', 'Contract'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ����',
   'user', 'dbo', 'table', 'Contract', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ�����',
   'user', 'dbo', 'table', 'Contract', 'column', 'DispatchBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ���',
   'user', 'dbo', 'table', 'Contract', 'column', 'ContractNo'
go

execute sp_addextendedproperty 'MS_Description', 
   'ԭʼ��ͬ��',
   'user', 'dbo', 'table', 'Contract', 'column', 'OriginalContractNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Contract', 'column', 'CarNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ҳ���',
   'user', 'dbo', 'table', 'Contract', 'column', 'TrailerNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Contract', 'column', 'CarType'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻԱ����',
   'user', 'dbo', 'table', 'Contract', 'column', 'DriverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻ֤��',
   'user', 'dbo', 'table', 'Contract', 'column', 'DriverLicenseNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻԱ�ֻ�',
   'user', 'dbo', 'table', 'Contract', 'column', 'DriverMobileTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻԱסլ�绰',
   'user', 'dbo', 'table', 'Contract', 'column', 'DriverHomeTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'Contract', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'Contract', 'column', 'CarrierName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'Contract', 'column', 'GoodsName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ��ʽ',
   'user', 'dbo', 'table', 'Contract', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '���λ��',
   'user', 'dbo', 'table', 'Contract', 'column', 'StartPlace'
go

execute sp_addextendedproperty 'MS_Description', 
   '����λ��',
   'user', 'dbo', 'table', 'Contract', 'column', 'DestPlace'
go

execute sp_addextendedproperty 'MS_Description', 
   'װ��ʱ��',
   'user', 'dbo', 'table', 'Contract', 'column', 'ShipmentTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'Contract', 'column', 'ArrivalTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ܼ���',
   'user', 'dbo', 'table', 'Contract', 'column', 'TotalPackages'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ܶ���',
   'user', 'dbo', 'table', 'Contract', 'column', 'TotalTunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ܶ���',
   'user', 'dbo', 'table', 'Contract', 'column', 'TotalPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ֻ',
   'user', 'dbo', 'table', 'Contract', 'column', 'TotalTenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˷�',
   'user', 'dbo', 'table', 'Contract', 'column', 'TotalTransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ԥ���˷�',
   'user', 'dbo', 'table', 'Contract', 'column', 'PrepayTransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   'ʣ���˷�',
   'user', 'dbo', 'table', 'Contract', 'column', 'ResidualTransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'Contract', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'Contract', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'Contract', 'column', 'CreateOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'Contract', 'column', 'CreateOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'Contract', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'Contract', 'column', 'OwnOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'Contract', 'column', 'OwnOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ״̬',
   'user', 'dbo', 'table', 'Contract', 'column', 'ContractState'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ӡ״̬��0����ӡ��1��ӡ�ɹ�',
   'user', 'dbo', 'table', 'Contract', 'column', 'PrintState'
go

execute sp_addextendedproperty 'MS_Description', 
   '����״̬��������/������',
   'user', 'dbo', 'table', 'Contract', 'column', 'ApproveState'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ǰ�����������',
   'user', 'dbo', 'table', 'Contract', 'column', 'ApproveFlowStepNum'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ǰ����������',
   'user', 'dbo', 'table', 'Contract', 'column', 'ApproveFlowStepName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'Contract', 'column', 'ApproverId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'Contract', 'column', 'ApproverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Contract', 'column', 'FineAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'Contract', 'column', 'FineTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƿ�Ϊ���غ�ͬ��־',
   'user', 'dbo', 'table', 'Contract', 'column', 'IsPrestowage'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Contract', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Contract', 'column', '_myUpdate'
go

alter table dbo.Contract
   add constraint PK_CONTRACT primary key (Id)
go

/*==============================================================*/
/* Index: Index_DispatchBillId                                  */
/*==============================================================*/
create unique index Index_DispatchBillId on dbo.Contract (
DispatchBillId ASC
)
go

/*==============================================================*/
/* Table: ContractApproveComment                                */
/*==============================================================*/
create table dbo.ContractApproveComment (
   Id                   ZC_Id                not null,
   ContractId           ZC_Id                not null,
   PlanId               ZC_Id                not null,
   ApprovedTransportPrice ZC_Money             not null,
   ApprovedTransportCharges ZC_Money             not null,
   ApproverId           ZC_Id                not null,
   ApproverName         ZC_Text_50           null,
   ApproveTime          ZC_DateTime          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ���������',
   'user', 'dbo', 'table', 'ContractApproveComment'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'ContractApproveComment', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ����',
   'user', 'dbo', 'table', 'ContractApproveComment', 'column', 'ContractId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'ContractApproveComment', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����۸�',
   'user', 'dbo', 'table', 'ContractApproveComment', 'column', 'ApprovedTransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˷�',
   'user', 'dbo', 'table', 'ContractApproveComment', 'column', 'ApprovedTransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'ContractApproveComment', 'column', 'ApproverId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'ContractApproveComment', 'column', 'ApproverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'ContractApproveComment', 'column', 'ApproveTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'ContractApproveComment', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'ContractApproveComment', 'column', '_myUpdate'
go

alter table dbo.ContractApproveComment
   add constraint PK_CONTRACTAPPROVECOMMENT primary key (Id)
go

/*==============================================================*/
/* Table: ContractDeliverPlan                                   */
/*==============================================================*/
create table dbo.ContractDeliverPlan (
   Id                   ZC_Id                not null,
   ContractId           ZC_Id                not null,
   PlanId               ZC_Id                not null,
   Packages             int                  null,
   Tunnages             ZC_Money             null,
   Piles                ZC_Money             null,
   TenThousands         ZC_Money             null,
   TransportChargeExpression ZC_Text_100          null,
   TransportPriceExpression ZC_Text_100          null,
   KM                   int                  null,
   TransportPrice       ZC_Money             not null,
   TransportCharges     ZC_Money             not null,
   Remark               ZC_Text_500          null,
   ApprovedTransportPrice ZC_Money             null,
   ApprovedTransportCharges ZC_Money             null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ�ƻ���',
   'user', 'dbo', 'table', 'ContractDeliverPlan'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ����',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'ContractId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷ѹ�ʽ',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'TransportChargeExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '���۹�ʽ',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'TransportPriceExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'KM'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷Ѽ۸�',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷�',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'TransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����۸�',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'ApprovedTransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˷�',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', 'ApprovedTransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'ContractDeliverPlan', 'column', '_myUpdate'
go

alter table dbo.ContractDeliverPlan
   add constraint PK_CONTRACTDELIVERPLAN primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_DispatchId                                      */
/*==============================================================*/
create clustered index Index_DispatchId on dbo.ContractDeliverPlan (
ContractId ASC
)
go

/*==============================================================*/
/* Index: Index_DispatchId_PlanId                               */
/*==============================================================*/
create unique index Index_DispatchId_PlanId on dbo.ContractDeliverPlan (
ContractId ASC,
PlanId ASC
)
go

/*==============================================================*/
/* Table: ContractReverse                                       */
/*==============================================================*/
create table dbo.ContractReverse (
   Id                   ZC_Id                not null,
   ReverseAmount        ZC_Money             not null,
   WithholdAmount       ZC_Money             null,
   FactpaymentAmount    ZC_Money             not null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateTime           ZC_DateTime          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ���ʼ�¼��',
   'user', 'dbo', 'table', 'ContractReverse'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'ContractReverse', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʽ��',
   'user', 'dbo', 'table', 'ContractReverse', 'column', 'ReverseAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ۿ���',
   'user', 'dbo', 'table', 'ContractReverse', 'column', 'WithholdAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   'ʵ�����',
   'user', 'dbo', 'table', 'ContractReverse', 'column', 'FactpaymentAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'ContractReverse', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'ContractReverse', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'ContractReverse', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'ContractReverse', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'ContractReverse', 'column', '_myUpdate'
go

alter table dbo.ContractReverse
   add constraint PK_CONTRACTREVERSE primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_CreatorId                                       */
/*==============================================================*/
create clustered index Index_CreatorId on dbo.ContractReverse (
CreatorId ASC
)
go

/*==============================================================*/
/* Table: ContractReverseDetail                                 */
/*==============================================================*/
create table dbo.ContractReverseDetail (
   Id                   ZC_Id                not null,
   ReverseId            ZC_Id                not null,
   ContractId           ZC_Id                not null,
   ReverseAmount        ZC_Money             not null,
   WithholdAmount       ZC_Money             null,
   FactpaymentAmount    ZC_Money             not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ������ϸ��¼��',
   'user', 'dbo', 'table', 'ContractReverseDetail'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'ContractReverseDetail', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼����',
   'user', 'dbo', 'table', 'ContractReverseDetail', 'column', 'ReverseId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ����',
   'user', 'dbo', 'table', 'ContractReverseDetail', 'column', 'ContractId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʽ��',
   'user', 'dbo', 'table', 'ContractReverseDetail', 'column', 'ReverseAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ۿ���',
   'user', 'dbo', 'table', 'ContractReverseDetail', 'column', 'WithholdAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   'ʵ�����',
   'user', 'dbo', 'table', 'ContractReverseDetail', 'column', 'FactpaymentAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'ContractReverseDetail', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'ContractReverseDetail', 'column', '_myUpdate'
go

alter table dbo.ContractReverseDetail
   add constraint PK_CONTRACTREVERSEDETAIL primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_ContractId                                      */
/*==============================================================*/
create clustered index Index_ContractId on dbo.ContractReverseDetail (
ContractId ASC
)
go

/*==============================================================*/
/* Index: Index_ReverseId                                       */
/*==============================================================*/
create index Index_ReverseId on dbo.ContractReverseDetail (
ReverseId ASC
)
go

/*==============================================================*/
/* Table: Country                                               */
/*==============================================================*/
create table dbo.Country (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_20           not null,
   Remark               ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���ұ�',
   'user', 'dbo', 'table', 'Country'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Country', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Country', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '˵��',
   'user', 'dbo', 'table', 'Country', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Country', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Country', 'column', '_myUpdate'
go

alter table dbo.Country
   add constraint PK_COUNTRY primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_Name                                            */
/*==============================================================*/
create unique index Index_Name on dbo.Country (
Name ASC
)
go

/*==============================================================*/
/* Table: Customer                                              */
/*==============================================================*/
create table dbo.Customer (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_50           not null,
   FullName             ZC_Text_50           not null,
   WarningStock         int                  null,
   StopStock            int                  null,
   SettlementExpression ZC_Text_100          not null,
   ValuationMode        ZC_Text_20           not null,
   GrossWeightRate      ZC_Money             not null,
   Remark               ZC_Text_500          null,
   OwnOrganId           ZC_Id                not null,
   OwnOrganName         ZC_Text_50           not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ���',
   'user', 'dbo', 'table', 'Customer'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'Customer', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'Customer', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   'ȫ��',
   'user', 'dbo', 'table', 'Customer', 'column', 'FullName'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ԥ����棨�֣�',
   'user', 'dbo', 'table', 'Customer', 'column', 'WarningStock'
go

execute sp_addextendedproperty 'MS_Description', 
   'ֹͣ������棨�֣�',
   'user', 'dbo', 'table', 'Customer', 'column', 'StopStock'
go

execute sp_addextendedproperty 'MS_Description', 
   '���㹫ʽ',
   'user', 'dbo', 'table', 'Customer', 'column', 'SettlementExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƽ۷�ʽ',
   'user', 'dbo', 'table', 'Customer', 'column', 'ValuationMode'
go

execute sp_addextendedproperty 'MS_Description', 
   'ë����',
   'user', 'dbo', 'table', 'Customer', 'column', 'GrossWeightRate'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'Customer', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'Customer', 'column', 'OwnOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'Customer', 'column', 'OwnOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Customer', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Customer', 'column', '_myUpdate'
go

alter table dbo.Customer
   add constraint PK_CUSTOMER primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_Name                                            */
/*==============================================================*/
create unique index Index_Name on dbo.Customer (
Name ASC
)
go

/*==============================================================*/
/* Table: CustomerForceFeePrice                                 */
/*==============================================================*/
create table dbo.CustomerForceFeePrice (
   Id                   ZC_Id                not null,
   CustomerId           ZC_Id                not null,
   StartTime            ZC_DateTime          not null,
   EndTime              ZC_DateTime          not null,
   LoadingForceFeePrice ZC_Money             null,
   UnloadingForceFeePrice ZC_Money             null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ���֧�ѱ�',
   'user', 'dbo', 'table', 'CustomerForceFeePrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'CustomerForceFeePrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'CustomerForceFeePrice', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʼʱ��',
   'user', 'dbo', 'table', 'CustomerForceFeePrice', 'column', 'StartTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֹʱ��',
   'user', 'dbo', 'table', 'CustomerForceFeePrice', 'column', 'EndTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '����֧��',
   'user', 'dbo', 'table', 'CustomerForceFeePrice', 'column', 'LoadingForceFeePrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '����֧��',
   'user', 'dbo', 'table', 'CustomerForceFeePrice', 'column', 'UnloadingForceFeePrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CustomerForceFeePrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CustomerForceFeePrice', 'column', '_myUpdate'
go

alter table dbo.CustomerForceFeePrice
   add constraint PK_CUSTOMERFORCEFEEPRICE primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_CustomerId                                      */
/*==============================================================*/
create clustered index Index_CustomerId on dbo.CustomerForceFeePrice (
CustomerId ASC
)
go

/*==============================================================*/
/* Table: CustomerStorageAndForceFeeSettlement                  */
/*==============================================================*/
create table dbo.CustomerStorageAndForceFeeSettlement (
   Id                   ZC_Id                not null,
   StartTime            ZC_DateTime          not null,
   EndTime              ZC_DateTime          not null,
   InvoiceNo            ZC_Text_20           not null,
   CustomerId           ZC_Id                not null,
   CustomerName         ZC_Text_50           not null,
   InvoiceType          ZC_Text_10           not null,
   InvoiceAmount        ZC_Money             not null,
   Remark               ZC_Text_100          null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateOrganId        ZC_Id                not null,
   CreateOrganName      ZC_Text_50           not null,
   CreateTime           ZC_DateTime          not null,
   OwnOrganId           ZC_Id                not null,
   OwnOrganName         ZC_Text_50           not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ��ִ���֧�ѽ����',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ����',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʼ����',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'StartTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֹ����',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'EndTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ���',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'InvoiceNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'CustomerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ���࣬��ͨ��Ʊ����ֵ˰��Ʊ',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'InvoiceType'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ���',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'InvoiceAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'CreateOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'CreateOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'OwnOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', 'OwnOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CustomerStorageAndForceFeeSettlement', 'column', '_myUpdate'
go

alter table dbo.CustomerStorageAndForceFeeSettlement
   add constraint PK_CUSTOMERSTORAGEANDFORCEFEES primary key (Id)
go

/*==============================================================*/
/* Table: CustomerStorageFeePrice                               */
/*==============================================================*/
create table dbo.CustomerStorageFeePrice (
   Id                   ZC_Id                not null,
   CustomerId           ZC_Id                not null,
   StartTime            ZC_DateTime          not null,
   EndTime              ZC_DateTime          not null,
   StorageFeePrice      ZC_Money             null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ��ִ��ѱ�',
   'user', 'dbo', 'table', 'CustomerStorageFeePrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'CustomerStorageFeePrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'CustomerStorageFeePrice', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʼʱ��',
   'user', 'dbo', 'table', 'CustomerStorageFeePrice', 'column', 'StartTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֹʱ��',
   'user', 'dbo', 'table', 'CustomerStorageFeePrice', 'column', 'EndTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ִ���',
   'user', 'dbo', 'table', 'CustomerStorageFeePrice', 'column', 'StorageFeePrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CustomerStorageFeePrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CustomerStorageFeePrice', 'column', '_myUpdate'
go

alter table dbo.CustomerStorageFeePrice
   add constraint PK_CUSTOMERSTORAGEFEEPRICE primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_CustomerId                                      */
/*==============================================================*/
create clustered index Index_CustomerId on dbo.CustomerStorageFeePrice (
CustomerId ASC
)
go

/*==============================================================*/
/* Table: CustomerTransportChargesSettlement                    */
/*==============================================================*/
create table dbo.CustomerTransportChargesSettlement (
   Id                   ZC_Id                not null,
   InvoiceNo            ZC_Text_20           not null,
   CustomerId           ZC_Id                not null,
   CustomerName         ZC_Text_50           not null,
   InvoiceType          ZC_Text_10           not null,
   InvoiceAmount        ZC_Money             not null,
   Remark               ZC_Text_100          null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateOrganId        ZC_Id                not null,
   CreateOrganName      ZC_Text_50           not null,
   CreateTime           ZC_DateTime          not null,
   OwnOrganId           ZC_Id                not null,
   OwnOrganName         ZC_Text_50           not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ��˷ѽ����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ���',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'InvoiceNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'CustomerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ���࣬��ͨ��Ʊ����ֵ˰��Ʊ',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'InvoiceType'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ���',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'InvoiceAmount'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'CreateOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'CreateOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'OwnOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', 'OwnOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlement', 'column', '_myUpdate'
go

alter table dbo.CustomerTransportChargesSettlement
   add constraint PK_CUSTOMERTRANSPORTCHARGESSET primary key (Id)
go

/*==============================================================*/
/* Table: CustomerTransportChargesSettlementDetail              */
/*==============================================================*/
create table dbo.CustomerTransportChargesSettlementDetail (
   Id                   ZC_Id                not null,
   CustomerTransportChargesSettlementId ZC_Id                not null,
   DeliverBillId        ZC_Id                not null,
   TransportPrice       ZC_Money             not null,
   TransportCharges     ZC_Money             not null,
   CarpoolFee           ZC_Money             null,
   RiverCrossingCharges ZC_Money             null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ��˷ѽ�����ϸ��',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlementDetail'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlementDetail', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ʊ����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlementDetail', 'column', 'CustomerTransportChargesSettlementId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�������',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlementDetail', 'column', 'DeliverBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlementDetail', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷�',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlementDetail', 'column', 'TransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   'ƴ����',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlementDetail', 'column', 'CarpoolFee'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlementDetail', 'column', 'RiverCrossingCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlementDetail', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CustomerTransportChargesSettlementDetail', 'column', '_myUpdate'
go

alter table dbo.CustomerTransportChargesSettlementDetail
   add constraint PK_CUSTOMERTRANSPORTCHARGESSET primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_CustomerTransportChargesSettlementId            */
/*==============================================================*/
create clustered index Index_CustomerTransportChargesSettlementId on dbo.CustomerTransportChargesSettlementDetail (
CustomerTransportChargesSettlementId ASC
)
go

/*==============================================================*/
/* Table: CustomerTransportPrice                                */
/*==============================================================*/
create table dbo.CustomerTransportPrice (
   Id                   ZC_Id                not null,
   CustomerId           ZC_Id                not null,
   StartCountry         ZC_Text_20           not null,
   StartProvince        ZC_Text_20           not null,
   StartCity            ZC_Text_20           not null,
   DestCountry          ZC_Text_20           not null,
   DestProvince         ZC_Text_20           not null,
   DestCity             ZC_Text_20           not null,
   MinTunnagesOrPiles   numeric(25,9)        not null,
   MaxTunnagesOrPiles   numeric(25,9)        not null,
   StartTime            ZC_DateTime          not null,
   EndTime              ZC_DateTime          not null,
   CarType              ZC_Text_10           not null,
   TransportPrice       ZC_Money             not null,
   RiverCrossingCharges ZC_Money             null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����۸��',
   'user', 'dbo', 'table', 'CustomerTransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'StartCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʡ��',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'StartProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'StartCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'DestCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʡ��',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'DestProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'DestCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ����λ������',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'MinTunnagesOrPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ����λ������',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'MaxTunnagesOrPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʼʱ��',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'StartTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֹʱ��',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'EndTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'CarType'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', 'RiverCrossingCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'CustomerTransportPrice', 'column', '_myUpdate'
go

alter table dbo.CustomerTransportPrice
   add constraint PK_CUSTOMERTRANSPORTPRICE primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_CustomerId                                      */
/*==============================================================*/
create clustered index Index_CustomerId on dbo.CustomerTransportPrice (
CustomerId ASC
)
go

/*==============================================================*/
/* Table: DeliverBill                                           */
/*==============================================================*/
create table dbo.DeliverBill (
   Id                   ZC_Id                not null,
   BillNo               ZC_Text_20           not null,
   ShipmentBillId       ZC_Id                not null,
   DispatchBillId       ZC_Id                not null,
   PlanId               ZC_Id                not null,
   CustomerId           ZC_Id                not null,
   CustomerName         ZC_Text_50           not null,
   DeliveryNo           ZC_Text_20           null,
   ReceiverName         ZC_Text_50           not null,
   ReceiverCountry      ZC_Text_20           not null,
   ReceiverProvince     ZC_Text_20           not null,
   ReceiverCity         ZC_Text_20           not null,
   ReceiverAddress      ZC_Text_50           not null,
   ReceiverContact      ZC_Text_20           null,
   ReceiverContactTel   ZC_Text_20           null,
   CarNo                ZC_Text_20           not null,
   TrailerNo            ZC_Text_10           null,
   CarrierId            ZC_Id                null,
   CarrierName          ZC_Text_50           null,
   Warehouse            ZC_Text_20           not null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateOrganId        ZC_Id                not null,
   CreateOrganName      ZC_Text_50           not null,
   CreateTime           ZC_DateTime          not null,
   OwnOrganId           ZC_Id                not null,
   OwnOrganName         ZC_Text_50           not null,
   PrintState           bit                  not null,
   ReturnTime           ZC_DateTime          null,
   DamageInfo           ZC_Text_200          null,
   CustomerTransportChargesSettlementId ZC_Id                null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'DeliverBill'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'BillNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ֵ�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'ShipmentBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'DispatchBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CustomerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'DeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'ReceiverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ���ڹ���',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'ReceiverCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ����ʡ��',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'ReceiverProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ���ڳ���',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'ReceiverCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ַ',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'ReceiverAddress'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ϵ������',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'ReceiverContact'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ϵ�˵绰',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'ReceiverContactTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CarNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ҳ���',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'TrailerNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CarrierName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ֿ�',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'Warehouse'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CreateOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CreateOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'OwnOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'OwnOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ӡ״̬��0����ӡ��1��ӡ�ɹ�',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'PrintState'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ص�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'ReturnTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'DamageInfo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ������¼����',
   'user', 'dbo', 'table', 'DeliverBill', 'column', 'CustomerTransportChargesSettlementId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'DeliverBill', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'DeliverBill', 'column', '_myUpdate'
go

alter table dbo.DeliverBill
   add constraint PK_DELIVERBILL primary key (Id)
go

/*==============================================================*/
/* Index: Index_PlanId                                          */
/*==============================================================*/
create index Index_PlanId on dbo.DeliverBill (
PlanId ASC
)
go

/*==============================================================*/
/* Table: DeliverBillCarrierTransportPrice                      */
/*==============================================================*/
create table dbo.DeliverBillCarrierTransportPrice (
   Id                   ZC_Id                not null,
   DeliverBillId        ZC_Id                not null,
   TransportPrice       ZC_Money             not null,
   TransportCharges     ZC_Money             not null default 0,
   Remark               ZC_Text_100          null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateOrganId        ZC_Id                not null,
   CreateOrganName      ZC_Text_50           not null,
   CreateTime           ZC_DateTime          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ���������˼۸��',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�������',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'DeliverBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷�',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'TransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'CreateOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'CreateOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', '_myUpdate'
go

alter table dbo.DeliverBillCarrierTransportPrice
   add constraint PK_DELIVERBILLCARRIERTRANSPORT primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_DeliverBillId                                   */
/*==============================================================*/
create unique index Index_DeliverBillId on dbo.DeliverBillCarrierTransportPrice (
DeliverBillId ASC
)
go

/*==============================================================*/
/* Table: DeliverBillCustomerTransportPrice                     */
/*==============================================================*/
create table dbo.DeliverBillCustomerTransportPrice (
   Id                   ZC_Id                not null,
   DeliverBillId        ZC_Id                not null,
   TransportPrice       ZC_Money             not null,
   TransportCharges     ZC_Money             not null default 0,
   Remark               ZC_Text_100          null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateOrganId        ZC_Id                not null,
   CreateOrganName      ZC_Text_50           not null,
   CreateTime           ZC_DateTime          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ����������۸��',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�������',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', 'DeliverBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷�',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', 'TransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', 'CreateOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', 'CreateOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'DeliverBillCustomerTransportPrice', 'column', '_myUpdate'
go

alter table dbo.DeliverBillCustomerTransportPrice
   add constraint PK_DELIVERBILLCUSTOMERTRANSPOR primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_DeliverBillId                                   */
/*==============================================================*/
create unique index Index_DeliverBillId on dbo.DeliverBillCustomerTransportPrice (
DeliverBillId ASC
)
go

/*==============================================================*/
/* Table: DeliverBillGoods                                      */
/*==============================================================*/
create table dbo.DeliverBillGoods (
   Id                   ZC_Id                not null,
   DeliverBillId        ZC_Id                not null,
   GoodsId              ZC_Id                not null,
   GoodsName            ZC_Text_50           not null,
   TypeId               ZC_Id                not null,
   TypeName             ZC_Text_50           not null,
   TypeFullPath         ZC_Text_500          not null,
   TypeFullName         ZC_Text_500          not null,
   GoodsNo              ZC_Text_20           not null,
   Brand                ZC_Text_20           null,
   SpecModel            ZC_Text_50           not null,
   GWeight              ZC_Text_20           null,
   Grade                ZC_Text_10           null,
   PieceWeight          ZC_Money             null,
   Packing              ZC_Text_10           null,
   BatchNo              ZC_Text_20           null,
   Location             ZC_Text_10           null,
   Packages             int                  null,
   Tunnages             ZC_Money             null,
   Piles                ZC_Money             null,
   TenThousands         ZC_Money             null,
   ProductionDate       ZC_Text_10           null,
   EnterWarehouseBillId ZC_Id                null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ��������',
   'user', 'dbo', 'table', 'DeliverBillGoods'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�������',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'DeliverBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'GoodsId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'GoodsName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'TypeId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����������',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'TypeName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ·��',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'TypeFullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ����',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'TypeFullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'GoodsNo'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ʒ��',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'Brand'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ͺ�',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'SpecModel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'GWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ȼ�',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'Grade'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'PieceWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ�����������',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '���α��',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'BatchNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'Location'
go

execute sp_addextendedproperty 'MS_Description', 
   '����/����',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'ProductionDate'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӧ��ⵥ����',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', 'EnterWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'DeliverBillGoods', 'column', '_myUpdate'
go

alter table dbo.DeliverBillGoods
   add constraint PK_DELIVERBILLGOODS primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_GoodsNo                                         */
/*==============================================================*/
create index Index_GoodsNo on dbo.DeliverBillGoods (
GoodsNo ASC
)
go

/*==============================================================*/
/* Index: Index_OutWarehouseId                                  */
/*==============================================================*/
create clustered index Index_OutWarehouseId on dbo.DeliverBillGoods (
DeliverBillId ASC
)
go

/*==============================================================*/
/* Table: DeliverPlan                                           */
/*==============================================================*/
create table dbo.DeliverPlan (
   Id                   ZC_Id                not null,
   PlanNo               ZC_Text_20           not null,
   PlanType             ZC_Text_10           not null,
   CustomerId           ZC_Id                not null,
   CustomerName         ZC_Text_50           not null,
   ShipmentNo           ZC_Text_20           null,
   DeliveryNo           ZC_Text_20           null,
   DeliverType          ZC_Text_10           not null,
   ReceiverName         ZC_Text_50           not null,
   ReceiverCountry      ZC_Text_20           not null,
   ReceiverProvince     ZC_Text_20           not null,
   ReceiverCity         ZC_Text_20           not null,
   ReceiverAddress      ZC_Text_50           not null,
   ReceiverContact      ZC_Text_20           null,
   ReceiverContactTel   ZC_Text_20           null,
   OrderNo              ZC_Text_20           null,
   ReceiveType          ZC_Text_10           not null,
   CarNo                ZC_Text_20           null,
   TrailerNo            ZC_Text_10           null,
   DriverName           ZC_Text_20           null,
   DriverLicenseNo      ZC_Text_20           null,
   DriverMobileTel      ZC_Text_20           null,
   DriverHomeTel        ZC_Text_20           null,
   CarrierId            ZC_Id                null,
   CarrierName          ZC_Text_50           null,
   Warehouse            ZC_Text_20           null,
   ArrivalTime          ZC_Text_10           null,
   PayerId              ZC_Id                not null,
   PayerName            ZC_Text_50           not null,
   IsConsigning         bit                  null,
   ConsignedDeliveryNo  ZC_Text_20           null,
   IsInstalment         bit                  null,
   StartCountry         ZC_Text_20           not null,
   StartProvince        ZC_Text_20           not null,
   StartCity            ZC_Text_20           not null,
   Remark               ZC_Text_500          null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateOrganId        ZC_Id                not null,
   CreateOrganName      ZC_Text_50           not null,
   CreateTime           ZC_DateTime          not null,
   OwnOrganId           ZC_Id                not null,
   OwnOrganName         ZC_Text_50           not null,
   PlanState            ZC_Text_10           not null,
   DisposeFlowStepNum   int                  null,
   DisposeFlowStepName  ZC_Text_50           null,
   DisposerId           ZC_Id                null,
   DisposerName         ZC_Text_50           null,
   IsDelete             bit                  null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ���',
   'user', 'dbo', 'table', 'DeliverPlan'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ����ţ���J20110312001',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'PlanNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ����ֽ�����ƻ����޷����ƻ��������淢���ƻ������������ƻ�',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'PlanType'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'CustomerName'
go

execute sp_addextendedproperty 'MS_Description', 
   'װ�˵���',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ShipmentNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'DeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'DeliverType'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ReceiverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ���ڹ���',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ReceiverCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ����ʡ��',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ReceiverProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ���ڳ���',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ReceiverCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ַ',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ReceiverAddress'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ϵ������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ReceiverContact'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ϵ�˵绰',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ReceiverContactTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'OrderNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ʽ',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ReceiveType'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'CarNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ҳ���',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'TrailerNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻԱ����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'DriverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻ֤��',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'DriverLicenseNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻԱ�ֻ�',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'DriverMobileTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻԱסլ�绰',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'DriverHomeTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'CarrierName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ֿ�',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'Warehouse'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ArrivalTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '���㸶�λ����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'PayerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���㸶�λ����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'PayerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƿ�Ŀ�',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'IsConsigning'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ŀ⽻������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'ConsignedDeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ڷ�����־',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'IsInstalment'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'StartCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʡ��',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'StartProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'StartCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'CreateOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'CreateOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'OwnOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'OwnOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�״̬�����ύ/���ͻ�����/������/��Ч/�ر�',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'PlanState'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ǰ���������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'DisposeFlowStepNum'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ǰ����������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'DisposeFlowStepName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ǰ�����˱���',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'DisposerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ǰ����������',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'DisposerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƿ�ɾ����־',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', 'IsDelete'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'DeliverPlan', 'column', '_myUpdate'
go

alter table dbo.DeliverPlan
   add constraint PK_DELIVERPLAN primary key (Id)
go

/*==============================================================*/
/* Index: Index_PlanNo                                          */
/*==============================================================*/
create unique index Index_PlanNo on dbo.DeliverPlan (
PlanNo ASC
)
go

/*==============================================================*/
/* Table: DeliverPlanApproveComment                             */
/*==============================================================*/
create table dbo.DeliverPlanApproveComment (
   Id                   ZC_Id                not null,
   PlanId               ZC_Id                not null,
   ApproverId           ZC_Id                not null,
   ApproverName         ZC_Text_50           null,
   IsAgreed             bit                  not null,
   ApproveComment       ZC_Text_200          null,
   ApproveTime          ZC_DateTime          not null,
   StepNum              int                  not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ����������',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment', 'column', 'ApproverId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment', 'column', 'ApproverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƿ�ͬ��',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment', 'column', 'IsAgreed'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment', 'column', 'ApproveComment'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment', 'column', 'ApproveTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����������',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment', 'column', 'StepNum'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'DeliverPlanApproveComment', 'column', '_myUpdate'
go

alter table dbo.DeliverPlanApproveComment
   add constraint PK_DELIVERPLANAPPROVECOMMENT primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_ReimburseId                                     */
/*==============================================================*/
create clustered index Index_ReimburseId on dbo.DeliverPlanApproveComment (
PlanId ASC
)
go

/*==============================================================*/
/* Table: DeliverPlanGoods                                      */
/*==============================================================*/
create table dbo.DeliverPlanGoods (
   Id                   ZC_Id                not null,
   PlanId               ZC_Id                not null,
   GoodsId              ZC_Id                not null,
   GoodsName            ZC_Text_50           not null,
   TypeId               ZC_Id                not null,
   TypeName             ZC_Text_50           not null,
   TypeFullPath         ZC_Text_500          not null,
   TypeFullName         ZC_Text_500          not null,
   GoodsNo              ZC_Text_20           not null,
   Brand                ZC_Text_20           null,
   SpecModel            ZC_Text_50           not null,
   GWeight              ZC_Text_20           null,
   Grade                ZC_Text_10           null,
   PieceWeight          ZC_Money             null,
   Packing              ZC_Text_10           null,
   BatchNo              ZC_Text_20           null,
   Location             ZC_Text_10           null,
   Packages             int                  null,
   Tunnages             ZC_Money             null,
   Piles                ZC_Money             null,
   TenThousands         ZC_Money             null,
   ProductionDate       ZC_Text_10           null,
   EnterWarehouseBillId ZC_Id                null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ������',
   'user', 'dbo', 'table', 'DeliverPlanGoods'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'GoodsId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'GoodsName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'TypeId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����������',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'TypeName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ·��',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'TypeFullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ����',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'TypeFullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'GoodsNo'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ʒ��',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'Brand'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ͺ�',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'SpecModel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'GWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ȼ�',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'Grade'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'PieceWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ�����������',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '���α��',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'BatchNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'Location'
go

execute sp_addextendedproperty 'MS_Description', 
   '����/����',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'ProductionDate'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӧ��ⵥ����',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', 'EnterWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'DeliverPlanGoods', 'column', '_myUpdate'
go

alter table dbo.DeliverPlanGoods
   add constraint PK_DELIVERPLANGOODS primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_PlanId                                          */
/*==============================================================*/
create clustered index Index_PlanId on dbo.DeliverPlanGoods (
PlanId ASC
)
go

/*==============================================================*/
/* Table: DispatchBill                                          */
/*==============================================================*/
create table dbo.DispatchBill (
   Id                   ZC_Id                not null,
   DispatchBillNo       ZC_Text_20           not null,
   CarNo                ZC_Text_20           not null,
   TrailerNo            ZC_Text_10           null,
   CarType              ZC_Text_10           null,
   DriverName           ZC_Text_20           not null,
   DriverLicenseNo      ZC_Text_20           not null,
   DriverMobileTel      ZC_Text_20           not null,
   DriverHomeTel        ZC_Text_20           not null,
   CarrierId            ZC_Id                not null,
   CarrierName          ZC_Text_50           not null,
   TotalPackages        int                  not null,
   TotalTunnages        ZC_Money             null,
   TotalPiles           ZC_Money             null,
   TotalTenThousands    ZC_Money             null,
   TotalTransportCharges ZC_Money             not null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateOrganId        ZC_Id                not null,
   CreateOrganName      ZC_Text_50           not null,
   CreateTime           ZC_DateTime          not null,
   OwnOrganId           ZC_Id                not null,
   OwnOrganName         ZC_Text_50           not null,
   BillState            ZC_Text_10           not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ���',
   'user', 'dbo', 'table', 'DispatchBill'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ�����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'DispatchBillNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'CarNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ҳ���',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'TrailerNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'CarType'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻԱ����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'DriverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻ֤��',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'DriverLicenseNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻԱ�ֻ�',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'DriverMobileTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʻԱסլ�绰',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'DriverHomeTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'CarrierName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ܼ���',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'TotalPackages'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ܶ���',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'TotalTunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ܶ���',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'TotalPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ֻ',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'TotalTenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˷�',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'TotalTransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'CreateOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'CreateOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'OwnOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'OwnOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ�״̬�����ύ/��Ч',
   'user', 'dbo', 'table', 'DispatchBill', 'column', 'BillState'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'DispatchBill', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'DispatchBill', 'column', '_myUpdate'
go

alter table dbo.DispatchBill
   add constraint PK_DISPATCHBILL primary key (Id)
go

/*==============================================================*/
/* Index: Index_DispatchBillNo                                  */
/*==============================================================*/
create unique index Index_DispatchBillNo on dbo.DispatchBill (
DispatchBillNo ASC
)
go

/*==============================================================*/
/* Table: DispatchBillDeliverPlan                               */
/*==============================================================*/
create table dbo.DispatchBillDeliverPlan (
   Id                   ZC_Id                not null,
   DispatchBillId       ZC_Id                not null,
   PlanId               ZC_Id                not null,
   Packages             int                  not null,
   Tunnages             ZC_Money             null,
   Piles                ZC_Money             null,
   TenThousands         ZC_Money             null,
   TransportChargeExpression ZC_Text_100          null,
   TransportPriceExpression ZC_Text_100          null,
   KM                   int                  null,
   TransportPrice       ZC_Money             not null,
   TransportCharges     ZC_Money             not null,
   Remark               ZC_Text_500          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ��ƻ���',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ�����',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'DispatchBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷ѹ�ʽ',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'TransportChargeExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '���۹�ʽ',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'TransportPriceExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'KM'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷Ѽ۸�',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷�',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'TransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'DispatchBillDeliverPlan', 'column', '_myUpdate'
go

alter table dbo.DispatchBillDeliverPlan
   add constraint PK_DISPATCHBILLDELIVERPLAN primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_DispatchId                                      */
/*==============================================================*/
create clustered index Index_DispatchId on dbo.DispatchBillDeliverPlan (
DispatchBillId ASC
)
go

/*==============================================================*/
/* Index: Index_DispatchId_PlanId                               */
/*==============================================================*/
create unique index Index_DispatchId_PlanId on dbo.DispatchBillDeliverPlan (
DispatchBillId ASC,
PlanId ASC
)
go

/*==============================================================*/
/* Table: DispatchBillGoods                                     */
/*==============================================================*/
create table dbo.DispatchBillGoods (
   Id                   ZC_Id                not null,
   DispatchBillId       ZC_Id                not null,
   PlanId               ZC_Id                not null,
   GoodsId              ZC_Id                not null,
   GoodsName            ZC_Text_50           not null,
   TypeId               ZC_Id                not null,
   TypeName             ZC_Text_50           not null,
   TypeFullPath         ZC_Text_500          not null,
   TypeFullName         ZC_Text_500          not null,
   GoodsNo              ZC_Text_20           not null,
   Brand                ZC_Text_20           null,
   SpecModel            ZC_Text_50           not null,
   GWeight              ZC_Text_20           null,
   Grade                ZC_Text_10           null,
   PieceWeight          ZC_Money             null,
   Packing              ZC_Text_10           null,
   BatchNo              ZC_Text_20           null,
   Location             ZC_Text_10           null,
   Packages             int                  null,
   Tunnages             ZC_Money             null,
   Piles                ZC_Money             null,
   TenThousands         ZC_Money             null,
   ProductionDate       ZC_Text_10           null,
   EnterWarehouseBillId ZC_Id                null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ������',
   'user', 'dbo', 'table', 'DispatchBillGoods'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ�����',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'DispatchBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'GoodsId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'GoodsName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'TypeId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����������',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'TypeName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ·��',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'TypeFullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ����',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'TypeFullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'GoodsNo'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ʒ��',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'Brand'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ͺ�',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'SpecModel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'GWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ȼ�',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'Grade'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'PieceWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ�����������',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '���α��',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'BatchNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'Location'
go

execute sp_addextendedproperty 'MS_Description', 
   '����/����',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'ProductionDate'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӧ��ⵥ����',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', 'EnterWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'DispatchBillGoods', 'column', '_myUpdate'
go

alter table dbo.DispatchBillGoods
   add constraint PK_DISPATCHBILLGOODS primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_DispatchId_PlanId                               */
/*==============================================================*/
create clustered index Index_DispatchId_PlanId on dbo.DispatchBillGoods (
DispatchBillId ASC,
PlanId ASC
)
go

/*==============================================================*/
/* Table: EnterWarehouseBill                                    */
/*==============================================================*/
create table dbo.EnterWarehouseBill (
   Id                   ZC_Id                not null,
   BillNo               ZC_Text_20           not null,
   PlanId               ZC_Id                null,
   CustomerId           ZC_Id                not null,
   CustomerName         ZC_Text_50           not null,
   DeliveryNo           ZC_Text_20           null,
   EnterType            ZC_Text_10           not null,
   IsConsigning         bit                  not null,
   Warehouse            ZC_Text_20           not null,
   ForceFee             ZC_Money             null,
   HasDrayage           bit                  null,
   Remark               ZC_Text_200          null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateTime           ZC_DateTime          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '��ⵥ��',
   'user', 'dbo', 'table', 'EnterWarehouseBill'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ⵥ��',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'BillNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'CustomerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'DeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ʋ����򻮲����',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'EnterType'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƿ�Ŀ�',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'IsConsigning'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ֿ�',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'Warehouse'
go

execute sp_addextendedproperty 'MS_Description', 
   '��֧��',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'ForceFee'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ж̲��ѱ�־',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'HasDrayage'
go

execute sp_addextendedproperty 'MS_Description', 
   'Remark',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʱ��',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'EnterWarehouseBill', 'column', '_myUpdate'
go

alter table dbo.EnterWarehouseBill
   add constraint PK_ENTERWAREHOUSEBILL primary key (Id)
go

/*==============================================================*/
/* Index: Index_EnterNo                                         */
/*==============================================================*/
create unique index Index_EnterNo on dbo.EnterWarehouseBill (
BillNo ASC
)
go

/*==============================================================*/
/* Index: Index_CustomerId                                      */
/*==============================================================*/
create index Index_CustomerId on dbo.EnterWarehouseBill (
CustomerId ASC
)
go

/*==============================================================*/
/* Index: Index_EnterType                                       */
/*==============================================================*/
create index Index_EnterType on dbo.EnterWarehouseBill (
EnterType ASC
)
go

/*==============================================================*/
/* Index: Index_DeliveryNo                                      */
/*==============================================================*/
create index Index_DeliveryNo on dbo.EnterWarehouseBill (
DeliveryNo ASC
)
go

/*==============================================================*/
/* Index: Index_Warehouse                                       */
/*==============================================================*/
create index Index_Warehouse on dbo.EnterWarehouseBill (
Warehouse ASC
)
go

/*==============================================================*/
/* Index: Index_CreateTime                                      */
/*==============================================================*/
create index Index_CreateTime on dbo.EnterWarehouseBill (
CreateTime ASC
)
go

/*==============================================================*/
/* Table: EnterWarehouseBillGoods                               */
/*==============================================================*/
create table dbo.EnterWarehouseBillGoods (
   Id                   ZC_Id                not null,
   EnterWarehouseBillId ZC_Id                not null,
   GoodsId              ZC_Id                not null,
   GoodsName            ZC_Text_50           not null,
   TypeId               ZC_Id                not null,
   TypeName             ZC_Text_50           not null,
   TypeFullPath         ZC_Text_500          not null,
   TypeFullName         ZC_Text_500          not null,
   GoodsNo              ZC_Text_20           not null,
   Brand                ZC_Text_20           null,
   SpecModel            ZC_Text_50           not null,
   GWeight              ZC_Text_20           null,
   Grade                ZC_Text_10           null,
   PieceWeight          ZC_Money             null,
   Packing              ZC_Text_10           null,
   BatchNo              ZC_Text_20           not null,
   Location             ZC_Text_10           not null,
   Packages             int                  not null,
   Tunnages             ZC_Money             not null,
   Piles                ZC_Money             null default 0,
   TenThousands         ZC_Money             null default 0,
   ProductionDate       ZC_Text_10           null,
   ShipmentBillGoodsIds ZC_Text_500          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '��ⵥ�����',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ⵥ����',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'EnterWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'GoodsId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'GoodsName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'TypeId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����������',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'TypeName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ·��',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'TypeFullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ����',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'TypeFullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'GoodsNo'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ʒ��',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'Brand'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ͺ�',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'SpecModel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'GWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ȼ�',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'Grade'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'PieceWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ�����������',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '���α��',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'BatchNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'Location'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'ProductionDate'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ֵ��������',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', 'ShipmentBillGoodsIds'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'EnterWarehouseBillGoods', 'column', '_myUpdate'
go

alter table dbo.EnterWarehouseBillGoods
   add constraint PK_ENTERWAREHOUSEBILLGOODS primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_EnterWarehouseId                                */
/*==============================================================*/
create clustered index Index_EnterWarehouseId on dbo.EnterWarehouseBillGoods (
EnterWarehouseBillId ASC
)
go

/*==============================================================*/
/* Index: Index_GoodsNo                                         */
/*==============================================================*/
create index Index_GoodsNo on dbo.EnterWarehouseBillGoods (
GoodsNo ASC
)
go

/*==============================================================*/
/* Index: Index_GoodsName                                       */
/*==============================================================*/
create index Index_GoodsName on dbo.EnterWarehouseBillGoods (
GoodsName ASC
)
go

/*==============================================================*/
/* Index: Index_SpecModel                                       */
/*==============================================================*/
create index Index_SpecModel on dbo.EnterWarehouseBillGoods (
SpecModel ASC
)
go

/*==============================================================*/
/* Table: Goods                                                 */
/*==============================================================*/
create table dbo.Goods (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_50           not null,
   TypeId               ZC_Id                not null default 0,
   TypeName             ZC_Text_50           not null,
   TypeFullPath         ZC_Text_500          not null default '',
   TypeFullName         ZC_Text_500          not null,
   GoodsNo              ZC_Text_20           not null,
   SpecModel            ZC_Text_100          not null,
   GWeight              ZC_Text_20           null,
   Grade                ZC_Text_10           null,
   Brand                ZC_Text_20           null,
   PieceWeight          ZC_Text_20           null,
   Packing              ZC_Text_10           null,
   Remark               ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���ﵵ����',
   'user', 'dbo', 'table', 'Goods'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'Goods', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'Goods', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'Goods', 'column', 'TypeId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����������',
   'user', 'dbo', 'table', 'Goods', 'column', 'TypeName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������·��',
   'user', 'dbo', 'table', 'Goods', 'column', 'TypeFullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ����',
   'user', 'dbo', 'table', 'Goods', 'column', 'TypeFullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Goods', 'column', 'GoodsNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ͺ�',
   'user', 'dbo', 'table', 'Goods', 'column', 'SpecModel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Goods', 'column', 'GWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ȼ�',
   'user', 'dbo', 'table', 'Goods', 'column', 'Grade'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ʒ��',
   'user', 'dbo', 'table', 'Goods', 'column', 'Brand'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Goods', 'column', 'PieceWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ�����������',
   'user', 'dbo', 'table', 'Goods', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'Goods', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Goods', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Goods', 'column', '_myUpdate'
go

alter table dbo.Goods
   add constraint PK_GOODS primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_GoodsNo                                         */
/*==============================================================*/
create unique index Index_GoodsNo on dbo.Goods (
GoodsNo ASC
)
go

/*==============================================================*/
/* Index: Index_TypeFullPath                                    */
/*==============================================================*/
create clustered index Index_TypeFullPath on dbo.Goods (
TypeFullPath ASC
)
go

/*==============================================================*/
/* Table: GoodsType                                             */
/*==============================================================*/
create table dbo.GoodsType (
   Id                   ZC_Id                not null,
   ParentId             ZC_Id                null,
   FullPath             ZC_Text_500          not null,
   Name                 ZC_Text_50           not null,
   FullName             ZC_Text_500          null,
   Remark               ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'GoodsType'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'GoodsType', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ϼ����ͱ���',
   'user', 'dbo', 'table', 'GoodsType', 'column', 'ParentId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ӹ���𵽵�ǰ����·��',
   'user', 'dbo', 'table', 'GoodsType', 'column', 'FullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'GoodsType', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ����',
   'user', 'dbo', 'table', 'GoodsType', 'column', 'FullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'GoodsType', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'GoodsType', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'GoodsType', 'column', '_myUpdate'
go

alter table dbo.GoodsType
   add constraint PK_GOODSTYPE primary key nonclustered (Id)
go

/*==============================================================*/
/* Table: IdGenerator                                           */
/*==============================================================*/
create table dbo.IdGenerator (
   Id                   uniqueidentifier     not null,
   AccountId            ZC_Id                not null,
   AccountName          ZC_Text_20           null,
   Working              smallint             not null,
   CurrentValue         ZC_Id                not null,
   StartValue           ZC_Id                null,
   MinValue             ZC_Id                null,
   MaxValue             ZC_Id                null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ڲ�����������',
   'user', 'dbo', 'table', 'IdGenerator'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'IdGenerator', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ʺű���',
   'user', 'dbo', 'table', 'IdGenerator', 'column', 'AccountId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ʺ�����',
   'user', 'dbo', 'table', 'IdGenerator', 'column', 'AccountName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������ʽ��1-������0-�ѻ�',
   'user', 'dbo', 'table', 'IdGenerator', 'column', 'Working'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ǰֵ',
   'user', 'dbo', 'table', 'IdGenerator', 'column', 'CurrentValue'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʼֵ',
   'user', 'dbo', 'table', 'IdGenerator', 'column', 'StartValue'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Сֵ',
   'user', 'dbo', 'table', 'IdGenerator', 'column', 'MinValue'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ֵ',
   'user', 'dbo', 'table', 'IdGenerator', 'column', 'MaxValue'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'IdGenerator', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'IdGenerator', 'column', '_myUpdate'
go

alter table dbo.IdGenerator
   add constraint PK_IDGENERATOR primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_StaffId_Working                                 */
/*==============================================================*/
create unique clustered index Index_StaffId_Working on dbo.IdGenerator (
AccountId ASC,
Working ASC
)
go

/*==============================================================*/
/* Table: LoginLog                                              */
/*==============================================================*/
create table dbo.LoginLog (
   Id                   ZC_Id                not null,
   OrganId              ZC_Id                not null default 0,
   OrganName            ZC_Text_50           not null default '',
   StaffId              ZC_Id                not null,
   StaffName            ZC_Text_50           not null,
   LoginTime            ZC_DateTime          not null,
   LogoutTime           ZC_DateTime          null,
   HostIP               ZC_IP                null,
   HostName             ZC_Text_50           null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'Ա����¼��־��',
   'user', 'dbo', 'table', 'LoginLog'
go

execute sp_addextendedproperty 'MS_Description', 
   '��־���',
   'user', 'dbo', 'table', 'LoginLog', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '������֯���Ż�ͻ��ı���',
   'user', 'dbo', 'table', 'LoginLog', 'column', 'OrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������֯���Ż�ͻ�������',
   'user', 'dbo', 'table', 'LoginLog', 'column', 'OrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ա�����',
   'user', 'dbo', 'table', 'LoginLog', 'column', 'StaffId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼Ա������',
   'user', 'dbo', 'table', 'LoginLog', 'column', 'StaffName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'LoginLog', 'column', 'LoginTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˳�ʱ��',
   'user', 'dbo', 'table', 'LoginLog', 'column', 'LogoutTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����IP',
   'user', 'dbo', 'table', 'LoginLog', 'column', 'HostIP'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼������',
   'user', 'dbo', 'table', 'LoginLog', 'column', 'HostName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'LoginLog', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'LoginLog', 'column', '_myUpdate'
go

alter table dbo.LoginLog
   add constraint PK_LOGINLOG primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_StaffId                                         */
/*==============================================================*/
create clustered index Index_StaffId on dbo.LoginLog (
StaffId ASC
)
go

/*==============================================================*/
/* Table: MoveWarehouseBill                                     */
/*==============================================================*/
create table dbo.MoveWarehouseBill (
   Id                   ZC_Id                not null,
   BillNo               ZC_Text_20           not null,
   CustomerId           ZC_Id                not null,
   CustomerName         ZC_Text_50           not null,
   Warehouse            ZC_Text_20           not null,
   ConsignedDeliveryNo  ZC_Text_20           null,
   Remark               ZC_Text_200          null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateTime           ZC_DateTime          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƿⵥ��',
   'user', 'dbo', 'table', 'MoveWarehouseBill'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ⵥ��',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', 'BillNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', 'CustomerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ֿ�',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', 'Warehouse'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ŀ⽻������',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', 'ConsignedDeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   'Remark',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʱ��',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'MoveWarehouseBill', 'column', '_myUpdate'
go

alter table dbo.MoveWarehouseBill
   add constraint PK_MOVEWAREHOUSEBILL primary key (Id)
go

/*==============================================================*/
/* Index: Index_BillNo                                          */
/*==============================================================*/
create unique index Index_BillNo on dbo.MoveWarehouseBill (
BillNo ASC
)
go

/*==============================================================*/
/* Index: Index_CustomerId                                      */
/*==============================================================*/
create index Index_CustomerId on dbo.MoveWarehouseBill (
CustomerId ASC
)
go

/*==============================================================*/
/* Table: MoveWarehouseBillGoods                                */
/*==============================================================*/
create table dbo.MoveWarehouseBillGoods (
   Id                   ZC_Id                not null,
   MoveWarehouseBillId  ZC_Id                not null,
   GoodsId              ZC_Id                not null,
   GoodsName            ZC_Text_50           not null,
   TypeId               ZC_Id                not null,
   TypeName             ZC_Text_50           not null,
   TypeFullPath         ZC_Text_500          not null,
   TypeFullName         ZC_Text_500          not null,
   GoodsNo              ZC_Text_20           not null,
   Brand                ZC_Text_20           null,
   SpecModel            ZC_Text_50           not null,
   GWeight              ZC_Text_20           null,
   Grade                ZC_Text_10           null,
   PieceWeight          ZC_Money             null,
   Packing              ZC_Text_10           null,
   BatchNo              ZC_Text_20           not null,
   Location             ZC_Text_10           not null,
   Packages             int                  not null,
   Tunnages             ZC_Money             not null,
   Piles                ZC_Money             null default 0,
   TenThousands         ZC_Money             null default 0,
   ProductionDate       ZC_Text_10           null,
   EnterWarehouseBillId ZC_Id                not null,
   DeliveryNo           ZC_Text_20           null,
   NewLocation          ZC_Text_10           not null,
   NewPackages          int                  not null,
   NewTunnages          ZC_Money             not null,
   NewPiles             ZC_Money             null default 0,
   NewTenThousands      ZC_Money             null default 0,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƿⵥ�����',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƿⵥ����',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'MoveWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'GoodsId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'GoodsName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'TypeId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'TypeName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ·��',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'TypeFullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ����',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'TypeFullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'GoodsNo'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ʒ��',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'Brand'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ͺ�',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'SpecModel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'GWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ȼ�',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'Grade'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'PieceWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ�����������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '���α��',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'BatchNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'Location'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'ProductionDate'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӧ��ⵥ����',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'EnterWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӧ��������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'DeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'NewLocation'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'NewPackages'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'NewTunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'NewPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '������ֻ',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', 'NewTenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'MoveWarehouseBillGoods', 'column', '_myUpdate'
go

alter table dbo.MoveWarehouseBillGoods
   add constraint PK_MOVEWAREHOUSEBILLGOODS primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_EnterWarehouseId                                */
/*==============================================================*/
create clustered index Index_EnterWarehouseId on dbo.MoveWarehouseBillGoods (
MoveWarehouseBillId ASC
)
go

/*==============================================================*/
/* Index: Index_GoodsNo                                         */
/*==============================================================*/
create index Index_GoodsNo on dbo.MoveWarehouseBillGoods (
GoodsNo ASC
)
go

/*==============================================================*/
/* Index: Index_GoodsName                                       */
/*==============================================================*/
create index Index_GoodsName on dbo.MoveWarehouseBillGoods (
GoodsName ASC
)
go

/*==============================================================*/
/* Index: Index_SpecModel                                       */
/*==============================================================*/
create index Index_SpecModel on dbo.MoveWarehouseBillGoods (
SpecModel ASC
)
go

/*==============================================================*/
/* Table: NoGenerator                                           */
/*==============================================================*/
create table dbo.NoGenerator (
   Id                   uniqueidentifier     not null,
   TableName            ZC_Text_20           not null,
   Prefix               ZC_Flag              not null,
   CurrentDate          date                 not null,
   CurrentValue         int                  not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���������',
   'user', 'dbo', 'table', 'NoGenerator'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'NoGenerator', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'NoGenerator', 'column', 'TableName'
go

execute sp_addextendedproperty 'MS_Description', 
   'ǰ׺',
   'user', 'dbo', 'table', 'NoGenerator', 'column', 'Prefix'
go

execute sp_addextendedproperty 'MS_Description', 
   'CurrentDate',
   'user', 'dbo', 'table', 'NoGenerator', 'column', 'CurrentDate'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ǰֵ',
   'user', 'dbo', 'table', 'NoGenerator', 'column', 'CurrentValue'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'NoGenerator', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'NoGenerator', 'column', '_myUpdate'
go

alter table dbo.NoGenerator
   add constraint PK_NOGENERATOR primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_TableName                                       */
/*==============================================================*/
create unique index Index_TableName on dbo.NoGenerator (
TableName ASC
)
go

/*==============================================================*/
/* Table: OpLog                                                 */
/*==============================================================*/
create table dbo.OpLog (
   Id                   ZC_Id                not null,
   StaffId              ZC_Id                not null,
   StaffName            ZC_Text_50           not null,
   OpName               ZC_Text_500          not null,
   OpParams             ZC_Text_Max          null,
   OpTime               ZC_DateTime          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'Ա��������־��',
   'user', 'dbo', 'table', 'OpLog'
go

execute sp_addextendedproperty 'MS_Description', 
   '��־���',
   'user', 'dbo', 'table', 'OpLog', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ա�����',
   'user', 'dbo', 'table', 'OpLog', 'column', 'StaffId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����Ա������',
   'user', 'dbo', 'table', 'OpLog', 'column', 'StaffName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'OpLog', 'column', 'OpName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'OpLog', 'column', 'OpParams'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'OpLog', 'column', 'OpTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'OpLog', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'OpLog', 'column', '_myUpdate'
go

alter table dbo.OpLog
   add constraint PK_OPLOG primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_StaffId                                         */
/*==============================================================*/
create clustered index Index_StaffId on dbo.OpLog (
StaffId ASC
)
go

/*==============================================================*/
/* Table: Organization                                          */
/*==============================================================*/
create table dbo.Organization (
   Id                   ZC_Id                not null,
   ParentId             ZC_Id                null,
   Name                 ZC_Text_50           not null,
   FullName             ZC_Text_1000         null,
   FullPath             ZC_Text_500          null,
   CountryName          ZC_Text_20           null,
   ProvinceName         ZC_Text_20           null,
   CityName             ZC_Text_20           null,
   Address              ZC_Text_50           null,
   PostalCode           nvarchar(10)         null,
   Remark               ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '��֯��',
   'user', 'dbo', 'table', 'Organization'
go

execute sp_addextendedproperty 'MS_Description', 
   '��֯����',
   'user', 'dbo', 'table', 'Organization', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ϼ���֯����',
   'user', 'dbo', 'table', 'Organization', 'column', 'ParentId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��֯����',
   'user', 'dbo', 'table', 'Organization', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   'ȫ����',
   'user', 'dbo', 'table', 'Organization', 'column', 'FullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��֯·�����������֯����ǰ��֯��ÿһ���������,�磺1\2\6\20',
   'user', 'dbo', 'table', 'Organization', 'column', 'FullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'Organization', 'column', 'CountryName'
go

execute sp_addextendedproperty 'MS_Description', 
   'ʡ������',
   'user', 'dbo', 'table', 'Organization', 'column', 'ProvinceName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'Organization', 'column', 'CityName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ϸ��ַ',
   'user', 'dbo', 'table', 'Organization', 'column', 'Address'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'Organization', 'column', 'PostalCode'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'Organization', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Organization', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Organization', 'column', '_myUpdate'
go

alter table dbo.Organization
   add constraint PK_ORGANIZATION primary key nonclustered (Id)
go

/*==============================================================*/
/* Table: OutWarehouseBill                                      */
/*==============================================================*/
create table dbo.OutWarehouseBill (
   Id                   ZC_Id                not null,
   BillNo               ZC_Text_20           not null,
   ShipmentBillId       ZC_Id                not null,
   PlanId               ZC_Id                not null,
   CustomerId           ZC_Id                not null,
   CustomerName         ZC_Text_50           not null,
   DeliveryNo           ZC_Text_20           null,
   OutType              ZC_Text_10           not null,
   ReceiverName         ZC_Text_50           not null,
   ReceiverCountry      ZC_Text_20           not null,
   ReceiverProvince     ZC_Text_20           not null,
   ReceiverCity         ZC_Text_20           not null,
   ReceiverAddress      ZC_Text_50           not null,
   ReceiverContact      ZC_Text_20           null,
   ReceiverContactTel   ZC_Text_20           null,
   ReceiveType          ZC_Text_10           not null,
   CarNo                ZC_Text_20           null,
   TrailerNo            ZC_Text_10           null,
   CarrierId            ZC_Id                null,
   CarrierName          ZC_Text_50           null,
   PayerId              ZC_Id                not null,
   PayerName            ZC_Text_50           not null,
   IsConsigning         bit                  not null,
   ConsignedDeliveryNo  ZC_Text_20           null,
   Warehouse            ZC_Text_20           not null,
   ForceFee             ZC_Money             null,
   Remark               ZC_Text_200          null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateTime           ZC_DateTime          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���ⵥ��',
   'user', 'dbo', 'table', 'OutWarehouseBill'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ⵥ��',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'BillNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ֵ�����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ShipmentBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'CustomerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'DeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '������𣬷�������򻮲�����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'OutType'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ReceiverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ���ڹ���',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ReceiverCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ����ʡ��',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ReceiverProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ���ڳ���',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ReceiverCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ַ',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ReceiverAddress'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ϵ������',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ReceiverContact'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ϵ�˵绰',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ReceiverContactTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ʽ',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ReceiveType'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'CarNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ҳ���',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'TrailerNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'CarrierName'
go

execute sp_addextendedproperty 'MS_Description', 
   '���㸶�λ����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'PayerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���㸶�λ����',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'PayerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƿ�Ŀ�',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'IsConsigning'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ŀ⽻������',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ConsignedDeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ֿ�',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'Warehouse'
go

execute sp_addextendedproperty 'MS_Description', 
   '��֧��',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'ForceFee'
go

execute sp_addextendedproperty 'MS_Description', 
   'Remark',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʱ��',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'OutWarehouseBill', 'column', '_myUpdate'
go

alter table dbo.OutWarehouseBill
   add constraint PK_OUTWAREHOUSEBILL primary key (Id)
go

/*==============================================================*/
/* Index: Index_CreateTime                                      */
/*==============================================================*/
create index Index_CreateTime on dbo.OutWarehouseBill (
CreateTime ASC
)
go

/*==============================================================*/
/* Index: Index_CustomerId                                      */
/*==============================================================*/
create index Index_CustomerId on dbo.OutWarehouseBill (
CustomerId ASC
)
go

/*==============================================================*/
/* Index: Index_DeliveryNo                                      */
/*==============================================================*/
create index Index_DeliveryNo on dbo.OutWarehouseBill (
DeliveryNo ASC
)
go

/*==============================================================*/
/* Index: Index_OutNo                                           */
/*==============================================================*/
create unique index Index_OutNo on dbo.OutWarehouseBill (
BillNo ASC
)
go

/*==============================================================*/
/* Index: Index_CarNo                                           */
/*==============================================================*/
create index Index_CarNo on dbo.OutWarehouseBill (
CarNo ASC
)
go

/*==============================================================*/
/* Index: Index_ReceiverName                                    */
/*==============================================================*/
create index Index_ReceiverName on dbo.OutWarehouseBill (
ReceiverName ASC
)
go

/*==============================================================*/
/* Index: Index_OutType                                         */
/*==============================================================*/
create index Index_OutType on dbo.OutWarehouseBill (
OutType ASC
)
go

/*==============================================================*/
/* Index: Index_ReceiveType                                     */
/*==============================================================*/
create index Index_ReceiveType on dbo.OutWarehouseBill (
ReceiveType ASC
)
go

/*==============================================================*/
/* Index: Index_Warehouse                                       */
/*==============================================================*/
create index Index_Warehouse on dbo.OutWarehouseBill (
Warehouse ASC
)
go

/*==============================================================*/
/* Index: Index_PlanId                                          */
/*==============================================================*/
create index Index_PlanId on dbo.OutWarehouseBill (
PlanId ASC
)
go

/*==============================================================*/
/* Table: OutWarehouseBillGoods                                 */
/*==============================================================*/
create table dbo.OutWarehouseBillGoods (
   Id                   ZC_Id                not null,
   OutWarehouseBillId   ZC_Id                not null,
   GoodsId              ZC_Id                not null,
   GoodsName            ZC_Text_50           not null,
   TypeId               ZC_Id                not null,
   TypeName             ZC_Text_50           not null,
   TypeFullPath         ZC_Text_500          not null,
   TypeFullName         ZC_Text_500          not null,
   GoodsNo              ZC_Text_20           not null,
   Brand                ZC_Text_20           null,
   SpecModel            ZC_Text_50           not null,
   GWeight              ZC_Text_20           null,
   Grade                ZC_Text_10           null,
   PieceWeight          ZC_Money             null,
   Packing              ZC_Text_10           null,
   BatchNo              ZC_Text_20           not null,
   Location             ZC_Text_10           not null,
   Packages             int                  not null,
   Tunnages             ZC_Money             not null,
   Piles                ZC_Money             null default 0,
   TenThousands         ZC_Money             null default 0,
   ProductionDate       ZC_Text_10           null,
   EnterWarehouseBillId ZC_Id                not null,
   DeliveryNo           ZC_Text_20           null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���ⵥ�����',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ⵥ����',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'OutWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'GoodsId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'GoodsName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'TypeId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����������',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'TypeName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ·��',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'TypeFullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ����',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'TypeFullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'GoodsNo'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ʒ��',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'Brand'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ͺ�',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'SpecModel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'GWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ȼ�',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'Grade'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'PieceWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ�����������',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '���α��',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'BatchNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'Location'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'ProductionDate'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӧ��ⵥ����',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'EnterWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӧ��������',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', 'DeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'OutWarehouseBillGoods', 'column', '_myUpdate'
go

alter table dbo.OutWarehouseBillGoods
   add constraint PK_OUTWAREHOUSEBILLGOODS primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_GoodsNo                                         */
/*==============================================================*/
create index Index_GoodsNo on dbo.OutWarehouseBillGoods (
GoodsNo ASC
)
go

/*==============================================================*/
/* Index: Index_OutWarehouseId                                  */
/*==============================================================*/
create clustered index Index_OutWarehouseId on dbo.OutWarehouseBillGoods (
OutWarehouseBillId ASC
)
go

/*==============================================================*/
/* Table: Position                                              */
/*==============================================================*/
create table dbo.Position (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_20           not null,
   Remark               ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'ְλ��',
   'user', 'dbo', 'table', 'Position'
go

execute sp_addextendedproperty 'MS_Description', 
   'ְλ����',
   'user', 'dbo', 'table', 'Position', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   'ְλ����',
   'user', 'dbo', 'table', 'Position', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'Position', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Position', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Position', 'column', '_myUpdate'
go

alter table dbo.Position
   add constraint PK_POSITION primary key nonclustered (Id)
go

/*==============================================================*/
/* Table: Province                                              */
/*==============================================================*/
create table dbo.Province (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_20           not null,
   CountryName          ZC_Text_20           not null,
   Remark               ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'ʡ�ݻ����Σ��ݡ������Σ�����',
   'user', 'dbo', 'table', 'Province'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Province', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   'ʡ������',
   'user', 'dbo', 'table', 'Province', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'Province', 'column', 'CountryName'
go

execute sp_addextendedproperty 'MS_Description', 
   '˵��',
   'user', 'dbo', 'table', 'Province', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Province', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Province', 'column', '_myUpdate'
go

alter table dbo.Province
   add constraint PK_PROVINCE primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_Country_Name                                    */
/*==============================================================*/
create unique index Index_Country_Name on dbo.Province (
Name ASC,
CountryName ASC
)
go

/*==============================================================*/
/* Index: Index_Country                                         */
/*==============================================================*/
create clustered index Index_Country on dbo.Province (
CountryName ASC
)
go

/*==============================================================*/
/* Table: Receiver                                              */
/*==============================================================*/
create table dbo.Receiver (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_50           not null,
   Country              ZC_Text_20           not null,
   Province             ZC_Text_20           not null,
   City                 ZC_Text_20           not null,
   Address              ZC_Text_50           not null,
   Contact              ZC_Text_20           null,
   ContactTel           ZC_Text_20           null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ��',
   'user', 'dbo', 'table', 'Receiver'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ����',
   'user', 'dbo', 'table', 'Receiver', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Receiver', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ڹ���',
   'user', 'dbo', 'table', 'Receiver', 'column', 'Country'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʡ��',
   'user', 'dbo', 'table', 'Receiver', 'column', 'Province'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ڳ���',
   'user', 'dbo', 'table', 'Receiver', 'column', 'City'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ַ',
   'user', 'dbo', 'table', 'Receiver', 'column', 'Address'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ϵ������',
   'user', 'dbo', 'table', 'Receiver', 'column', 'Contact'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ϵ�˵绰',
   'user', 'dbo', 'table', 'Receiver', 'column', 'ContactTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Receiver', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Receiver', 'column', '_myUpdate'
go

alter table dbo.Receiver
   add constraint PK_RECEIVER primary key (Id)
go

/*==============================================================*/
/* Table: ReceiverDistance                                      */
/*==============================================================*/
create table dbo.ReceiverDistance (
   Id                   ZC_Id                not null,
   ReceiverName         ZC_Text_50           not null,
   StartCountry         ZC_Text_20           not null,
   StartProvince        ZC_Text_20           not null,
   StartCity            ZC_Text_20           not null,
   KM                   int                  null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ�����',
   'user', 'dbo', 'table', 'ReceiverDistance'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'ReceiverDistance', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ����',
   'user', 'dbo', 'table', 'ReceiverDistance', 'column', 'ReceiverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'ReceiverDistance', 'column', 'StartCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʡ��',
   'user', 'dbo', 'table', 'ReceiverDistance', 'column', 'StartProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'ReceiverDistance', 'column', 'StartCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'ReceiverDistance', 'column', 'KM'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'ReceiverDistance', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'ReceiverDistance', 'column', '_myUpdate'
go

alter table dbo.ReceiverDistance
   add constraint PK_RECEIVERDISTANCE primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_1                                               */
/*==============================================================*/
create unique index Index_1 on dbo.ReceiverDistance (
StartCountry ASC,
StartProvince ASC,
StartCity ASC
)
go

/*==============================================================*/
/* Index: Index_ReceiverName                                    */
/*==============================================================*/
create clustered index Index_ReceiverName on dbo.ReceiverDistance (
ReceiverName ASC
)
go

/*==============================================================*/
/* Table: ShipmentBill                                          */
/*==============================================================*/
create table dbo.ShipmentBill (
   Id                   ZC_Id                not null,
   BillNo               ZC_Text_20           not null,
   DispatchBillId       ZC_Id                not null,
   PlanId               ZC_Id                not null,
   CustomerId           ZC_Id                not null,
   CustomerName         ZC_Text_50           not null,
   DeliveryNo           ZC_Text_20           null,
   OutType              ZC_Text_10           not null,
   ReceiverName         ZC_Text_50           not null,
   ReceiverCountry      ZC_Text_20           not null,
   ReceiverProvince     ZC_Text_20           not null,
   ReceiverCity         ZC_Text_20           not null,
   ReceiverAddress      ZC_Text_50           not null,
   ReceiverContact      ZC_Text_20           null,
   ReceiverContactTel   ZC_Text_20           null,
   ReceiveType          ZC_Text_10           not null,
   CarNo                ZC_Text_20           not null,
   TrailerNo            ZC_Text_10           null,
   CarrierId            ZC_Id                null,
   CarrierName          ZC_Text_50           null,
   Warehouse            ZC_Text_20           not null,
   CreatorId            ZC_Id                not null,
   CreatorName          ZC_Text_20           not null,
   CreateOrganId        ZC_Id                not null,
   CreateOrganName      ZC_Text_50           not null,
   CreateTime           ZC_DateTime          not null,
   OwnOrganId           ZC_Id                not null,
   OwnOrganName         ZC_Text_50           not null,
   BillState            ZC_Text_10           not null,
   PrintState           bit                  not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���ֵ���',
   'user', 'dbo', 'table', 'ShipmentBill'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ֵ���',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'BillNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ�����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'DispatchBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'CustomerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'DeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '������𣬷�������򻮲�����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'OutType'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'ReceiverName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ���ڹ���',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'ReceiverCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����λ����ʡ��',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'ReceiverProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ���ڳ���',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'ReceiverCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ַ',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'ReceiverAddress'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ϵ������',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'ReceiverContact'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ջ���λ��ϵ�˵绰',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'ReceiverContactTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ʽ',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'ReceiveType'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'CarNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ҳ���',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'TrailerNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'CarrierName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ֿ�',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'Warehouse'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˱���',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'CreateOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'CreateOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'OwnOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'OwnOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ�״̬�����ύ/��Ч',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'BillState'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ӡ״̬��0����ӡ��1��ӡ�ɹ�',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', 'PrintState'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'ShipmentBill', 'column', '_myUpdate'
go

alter table dbo.ShipmentBill
   add constraint PK_SHIPMENTBILL primary key (Id)
go

/*==============================================================*/
/* Index: Index_PlanId                                          */
/*==============================================================*/
create index Index_PlanId on dbo.ShipmentBill (
PlanId ASC
)
go

/*==============================================================*/
/* Table: ShipmentBillGoods                                     */
/*==============================================================*/
create table dbo.ShipmentBillGoods (
   Id                   ZC_Id                not null,
   ShipmentBillId       ZC_Id                not null,
   GoodsId              ZC_Id                not null,
   GoodsName            ZC_Text_50           not null,
   TypeId               ZC_Id                not null,
   TypeName             ZC_Text_50           not null,
   TypeFullPath         ZC_Text_500          not null,
   TypeFullName         ZC_Text_500          not null,
   GoodsNo              ZC_Text_20           not null,
   Brand                ZC_Text_20           null,
   SpecModel            ZC_Text_50           not null,
   GWeight              ZC_Text_20           null,
   Grade                ZC_Text_10           null,
   PieceWeight          ZC_Money             null,
   Packing              ZC_Text_10           null,
   BatchNo              ZC_Text_20           not null,
   Location             ZC_Text_10           not null,
   Packages             int                  not null,
   Tunnages             ZC_Money             not null,
   Piles                ZC_Money             null default 0,
   TenThousands         ZC_Money             null default 0,
   ProductionDate       ZC_Text_10           not null,
   EnterWarehouseBillId ZC_Id                not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '���ֵ������',
   'user', 'dbo', 'table', 'ShipmentBillGoods'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ֵ�����',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'ShipmentBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'GoodsId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'GoodsName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'TypeId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����������',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'TypeName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ·��',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'TypeFullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ����',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'TypeFullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'GoodsNo'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ʒ��',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'Brand'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ͺ�',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'SpecModel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'GWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ȼ�',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'Grade'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'PieceWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ�����������',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '���α��',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'BatchNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'Location'
go

execute sp_addextendedproperty 'MS_Description', 
   '����/����',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'ProductionDate'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӧ��ⵥ����',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', 'EnterWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'ShipmentBillGoods', 'column', '_myUpdate'
go

alter table dbo.ShipmentBillGoods
   add constraint PK_SHIPMENTBILLGOODS primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_GoodsNo                                         */
/*==============================================================*/
create index Index_GoodsNo on dbo.ShipmentBillGoods (
GoodsNo ASC
)
go

/*==============================================================*/
/* Index: Index_OutWarehouseId                                  */
/*==============================================================*/
create clustered index Index_OutWarehouseId on dbo.ShipmentBillGoods (
ShipmentBillId ASC
)
go

/*==============================================================*/
/* Table: Staff                                                 */
/*==============================================================*/
create table dbo.Staff (
   Id                   ZC_Id                not null,
   FamilyName           ZC_Text_20           null,
   Name                 ZC_Text_20           not null,
   Sex                  ZC_Flag              not null,
   OrganId              ZC_Id                null default 0,
   OrganName            ZC_Text_50           null default '',
   OrganFullPath        ZC_Text_500          null default '',
   PositionId           ZC_Id                not null,
   PositionName         ZC_Text_20           null,
   OfficeTel            ZC_PhoneNum          null,
   TelExt               ZC_PhoneNum          null,
   Fax                  ZC_PhoneNum          null,
   MobileTel1           ZC_PhoneNum          null,
   MobileTel2           ZC_PhoneNum          null,
   MobileTel3           ZC_PhoneNum          null,
   EMail                ZC_Url               null,
   QQ                   ZC_Text_20           null,
   BossStaffId          ZC_Id                not null,
   IsOrganManager       bit                  not null,
   IsOrganLeader        bit                  not null default 0,
   CreateTime           ZC_DateTime          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'Ա����',
   'user', 'dbo', 'table', 'Staff'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ա������',
   'user', 'dbo', 'table', 'Staff', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��',
   'user', 'dbo', 'table', 'Staff', 'column', 'FamilyName'
go

execute sp_addextendedproperty 'MS_Description', 
   '��',
   'user', 'dbo', 'table', 'Staff', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ա�F-Ů�ԣ�M-����',
   'user', 'dbo', 'table', 'Staff', 'column', 'Sex'
go

execute sp_addextendedproperty 'MS_Description', 
   '������֯����',
   'user', 'dbo', 'table', 'Staff', 'column', 'OrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������֯��������',
   'user', 'dbo', 'table', 'Staff', 'column', 'OrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������֯���ŵ�·��',
   'user', 'dbo', 'table', 'Staff', 'column', 'OrganFullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   'ְλ����',
   'user', 'dbo', 'table', 'Staff', 'column', 'PositionId'
go

execute sp_addextendedproperty 'MS_Description', 
   'ְλ����',
   'user', 'dbo', 'table', 'Staff', 'column', 'PositionName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�칫�绰',
   'user', 'dbo', 'table', 'Staff', 'column', 'OfficeTel'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ֻ�',
   'user', 'dbo', 'table', 'Staff', 'column', 'TelExt'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Staff', 'column', 'Fax'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƶ��绰1',
   'user', 'dbo', 'table', 'Staff', 'column', 'MobileTel1'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƶ��绰2',
   'user', 'dbo', 'table', 'Staff', 'column', 'MobileTel2'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƶ��绰3',
   'user', 'dbo', 'table', 'Staff', 'column', 'MobileTel3'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ʼ�',
   'user', 'dbo', 'table', 'Staff', 'column', 'EMail'
go

execute sp_addextendedproperty 'MS_Description', 
   'QQ����',
   'user', 'dbo', 'table', 'Staff', 'column', 'QQ'
go

execute sp_addextendedproperty 'MS_Description', 
   '��˾Ա�����',
   'user', 'dbo', 'table', 'Staff', 'column', 'BossStaffId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƿ�Ϊ��֯���Ź�����Ա��־',
   'user', 'dbo', 'table', 'Staff', 'column', 'IsOrganManager'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƿ�Ϊ��֯���Ÿ����˱�־',
   'user', 'dbo', 'table', 'Staff', 'column', 'IsOrganLeader'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʱ��',
   'user', 'dbo', 'table', 'Staff', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Staff', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Staff', 'column', '_myUpdate'
go

alter table dbo.Staff
   add constraint PK_STAFF primary key nonclustered (Id)
go

/*==============================================================*/
/* Table: Stock                                                 */
/*==============================================================*/
create table dbo.Stock (
   Id                   ZC_Id                not null,
   CustomerId           ZC_Id                not null,
   CustomerName         ZC_Text_50           not null,
   GoodsId              ZC_Id                not null,
   GoodsNo              ZC_Text_20           not null,
   GoodsName            ZC_Text_50           not null,
   Brand                ZC_Text_20           not null,
   SpecModel            ZC_Text_50           not null,
   GWeight              ZC_Text_20           not null,
   Grade                ZC_Text_10           not null,
   PieceWeight          ZC_Money             not null,
   Packing              ZC_Text_10           not null,
   BatchNo              ZC_Text_20           not null,
   Warehouse            ZC_Text_20           not null,
   Location             ZC_Text_10           not null,
   Packages             int                  not null,
   Tunnages             ZC_Money             not null,
   Piles                ZC_Money             null default 0,
   TenThousands         ZC_Money             null default 0,
   ProductionDate       ZC_Text_10           not null,
   EnterWarehouseBillId ZC_Id                not null,
   OriginalEnterWarehouseBillId ZC_Id                null,
   DeliveryNo           ZC_Text_20           null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '����ܱ�',
   'user', 'dbo', 'table', 'Stock'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'Stock', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'Stock', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'Stock', 'column', 'CustomerName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'Stock', 'column', 'GoodsId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Stock', 'column', 'GoodsNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'Stock', 'column', 'GoodsName'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ʒ��',
   'user', 'dbo', 'table', 'Stock', 'column', 'Brand'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ͺ�',
   'user', 'dbo', 'table', 'Stock', 'column', 'SpecModel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Stock', 'column', 'GWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ȼ�',
   'user', 'dbo', 'table', 'Stock', 'column', 'Grade'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Stock', 'column', 'PieceWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ�����������',
   'user', 'dbo', 'table', 'Stock', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '���α��',
   'user', 'dbo', 'table', 'Stock', 'column', 'BatchNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ֿ�',
   'user', 'dbo', 'table', 'Stock', 'column', 'Warehouse'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ',
   'user', 'dbo', 'table', 'Stock', 'column', 'Location'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Stock', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Stock', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Stock', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'Stock', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'Stock', 'column', 'ProductionDate'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӧ��ⵥ����',
   'user', 'dbo', 'table', 'Stock', 'column', 'EnterWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   'ԭʼ��ⵥ���롣��β�����ʱ�����ֶ����ڴ���EnterWarehouseBillId��ֵ����EnterWarehouseBillIdֵ����Ϊβ����ⵥ����',
   'user', 'dbo', 'table', 'Stock', 'column', 'OriginalEnterWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ӧ��������',
   'user', 'dbo', 'table', 'Stock', 'column', 'DeliveryNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Stock', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Stock', 'column', '_myUpdate'
go

alter table dbo.Stock
   add constraint PK_STOCK primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_CustomerId_GoodsId_Warehouse                    */
/*==============================================================*/
create clustered index Index_CustomerId_GoodsId_Warehouse on dbo.Stock (
CustomerId ASC,
GoodsId ASC,
Warehouse ASC
)
go

/*==============================================================*/
/* Index: Index_CustomerId_GoodsId_BatchNo_Warehouse_Location   */
/*==============================================================*/
create index Index_CustomerId_GoodsId_BatchNo_Warehouse_Location on dbo.Stock (
CustomerId ASC,
GoodsId ASC,
BatchNo ASC,
Warehouse ASC,
Location ASC
)
go

/*==============================================================*/
/* Table: StockDaily                                            */
/*==============================================================*/
create table dbo.StockDaily (
   Id                   ZC_Id                identity,
   StockId              ZC_Id                null,
   Packages             int                  not null,
   Tunnages             ZC_Money             not null,
   Piles                ZC_Money             null default 0,
   TenThousands         ZC_Money             null default 0,
   StorageFee           ZC_Money             not null,
   CreateTime           ZC_DateTime          not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '����ձ���',
   'user', 'dbo', 'table', 'StockDaily'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'StockDaily', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '����¼����',
   'user', 'dbo', 'table', 'StockDaily', 'column', 'StockId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'StockDaily', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'StockDaily', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'StockDaily', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'StockDaily', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ִ���',
   'user', 'dbo', 'table', 'StockDaily', 'column', 'StorageFee'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'StockDaily', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'StockDaily', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'StockDaily', 'column', '_myUpdate'
go

alter table dbo.StockDaily
   add constraint PK_STOCKDAILY primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_StockId_CreateTime                              */
/*==============================================================*/
create unique index Index_StockId_CreateTime on dbo.StockDaily (
StockId ASC,
CreateTime ASC
)
go

/*==============================================================*/
/* Index: Index_StockId                                         */
/*==============================================================*/
create clustered index Index_StockId on dbo.StockDaily (
StockId ASC
)
go

/*==============================================================*/
/* Index: Index_CreateTime                                      */
/*==============================================================*/
create index Index_CreateTime on dbo.StockDaily (
CreateTime ASC
)
go

/*==============================================================*/
/* Table: StockOutWarehouseDetail                               */
/*==============================================================*/
create table dbo.StockOutWarehouseDetail (
   Id                   ZC_Id                not null,
   StockId              ZC_Id                not null,
   OutWarehouseBillId   ZC_Id                not null,
   Packages             int                  not null,
   Tunnages             ZC_Money             not null,
   Piles                ZC_Money             null default 0,
   TenThousands         ZC_Money             null default 0,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '��������ϸ��¼��',
   'user', 'dbo', 'table', 'StockOutWarehouseDetail'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'StockOutWarehouseDetail', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '����¼����',
   'user', 'dbo', 'table', 'StockOutWarehouseDetail', 'column', 'StockId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ⵥ����',
   'user', 'dbo', 'table', 'StockOutWarehouseDetail', 'column', 'OutWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'StockOutWarehouseDetail', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'StockOutWarehouseDetail', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'StockOutWarehouseDetail', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'StockOutWarehouseDetail', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'StockOutWarehouseDetail', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'StockOutWarehouseDetail', 'column', '_myUpdate'
go

alter table dbo.StockOutWarehouseDetail
   add constraint PK_STOCKOUTWAREHOUSEDETAIL primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_OutWarehouseBillId                              */
/*==============================================================*/
create clustered index Index_OutWarehouseBillId on dbo.StockOutWarehouseDetail (
OutWarehouseBillId ASC
)
go

/*==============================================================*/
/* Table: SysFunction                                           */
/*==============================================================*/
create table dbo.SysFunction (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_50           not null,
   AllowOpen            bit                  not null default 0,
   AllowNew             bit                  not null default 0,
   AllowModify          bit                  not null default 0,
   AllowDelete          bit                  not null default 0,
   AllowCancel          bit                  not null default 0,
   AllowDetail          bit                  not null default 0,
   AllowSearch          bit                  not null default 0,
   AllowSubmit          bit                  not null default 0,
   AllowApprove         bit                  not null default 0,
   AllowDispatch        bit                  not null default 0,
   AllowExport          bit                  not null default 0,
   AllowImport          bit                  not null default 0,
   AllowPrint           bit                  not null default 0,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'ϵͳ���ܱ�',
   'user', 'dbo', 'table', 'SysFunction'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ܱ��',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '����򿪱�־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowOpen'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowNew'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����޸ı�־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowModify'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ɾ����־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowDelete'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ע����ȡ����־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowCancel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����鿴��ϸ',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowDetail'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ѯ��־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowSearch'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ύ��־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowSubmit'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowApprove'
go

execute sp_addextendedproperty 'MS_Description', 
   '������ȱ�־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowDispatch'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowExport'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowImport'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ӡ��־',
   'user', 'dbo', 'table', 'SysFunction', 'column', 'AllowPrint'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'SysFunction', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'SysFunction', 'column', '_myUpdate'
go

alter table dbo.SysFunction
   add constraint PK_SYSFUNCTION primary key nonclustered (Id)
go

/*==============================================================*/
/* Table: SysGroup                                              */
/*==============================================================*/
create table dbo.SysGroup (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_50           not null,
   Remark               ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'Ȩ�����',
   'user', 'dbo', 'table', 'SysGroup'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ȩ�������',
   'user', 'dbo', 'table', 'SysGroup', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ȩ��������',
   'user', 'dbo', 'table', 'SysGroup', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'SysGroup', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'SysGroup', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'SysGroup', 'column', '_myUpdate'
go

alter table dbo.SysGroup
   add constraint PK_SYSGROUP primary key nonclustered (Id)
go

/*==============================================================*/
/* Table: SysGroupPermission                                    */
/*==============================================================*/
create table dbo.SysGroupPermission (
   Id                   ZC_Id                not null,
   GroupId              ZC_Id                not null,
   FuncId               ZC_Id                not null,
   AllowOpen            bit                  not null default 0,
   AllowNew             bit                  not null default 0,
   AllowModify          bit                  not null default 0,
   AllowDelete          bit                  not null default 0,
   AllowCancel          bit                  not null default 0,
   AllowDetail          bit                  not null default 0,
   AllowSearch          bit                  not null default 0,
   AllowSubmit          bit                  not null default 0,
   AllowApprove         bit                  not null default 0,
   AllowDispatch        bit                  not null default 0,
   AllowExport          bit                  not null default 0,
   AllowImport          bit                  not null default 0,
   AllowPrint           bit                  not null default 0,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '��Ȩ�ޱ�',
   'user', 'dbo', 'table', 'SysGroupPermission'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ȩ�������',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'GroupId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ܱ��',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'FuncId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����򿪱�־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowOpen'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowNew'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����޸ı�־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowModify'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ɾ����־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowDelete'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ע����ȡ����־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowCancel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����鿴��ϸ',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowDetail'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ѯ��־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowSearch'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ύ��־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowSubmit'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowApprove'
go

execute sp_addextendedproperty 'MS_Description', 
   '������ȱ�־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowDispatch'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowExport'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowImport'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����ӡ��־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', 'AllowPrint'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'SysGroupPermission', 'column', '_myUpdate'
go

alter table dbo.SysGroupPermission
   add constraint PK_SYSGROUPPERMISSION primary key nonclustered (Id)
go

/*==============================================================*/
/* Index: Index_GroupId                                         */
/*==============================================================*/
create clustered index Index_GroupId on dbo.SysGroupPermission (
GroupId ASC
)
go

/*==============================================================*/
/* Index: Index_GroupId_FuncId                                  */
/*==============================================================*/
create unique index Index_GroupId_FuncId on dbo.SysGroupPermission (
GroupId ASC,
FuncId ASC
)
go

/*==============================================================*/
/* Table: TransportLimitedPrice                                 */
/*==============================================================*/
create table dbo.TransportLimitedPrice (
   Id                   ZC_Id                not null,
   PlanType             ZC_Text_10           not null,
   StartCountry         ZC_Text_20           not null,
   StartProvince        ZC_Text_20           not null,
   StartCity            ZC_Text_20           not null,
   DestCountry          ZC_Text_20           not null,
   DestProvince         ZC_Text_20           not null,
   DestCity             ZC_Text_20           not null,
   CarType              ZC_Text_10           not null,
   MinTunnagesOrPiles   numeric(25,9)        not null,
   MaxTunnagesOrPiles   numeric(25,9)        not null,
   StartTime            ZC_DateTime          not null,
   EndTime              ZC_DateTime          not null,
   TransportPrice       ZC_Money             not null,
   TransportCharges     ZC_Money             not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�����޼۱�',
   'user', 'dbo', 'table', 'TransportLimitedPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ����ֽ�����ƻ����޷����ƻ��������淢���ƻ������������ƻ�',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'PlanType'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'StartCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʡ��',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'StartProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'StartCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'DestCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʡ��',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'DestProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'DestCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'CarType'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ����λ������',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'MinTunnagesOrPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ����λ������',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'MaxTunnagesOrPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʼʱ��',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'StartTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֹʱ��',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'EndTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ܼ�',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', 'TransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'TransportLimitedPrice', 'column', '_myUpdate'
go

alter table dbo.TransportLimitedPrice
   add constraint PK_TRANSPORTLIMITEDPRICE primary key (Id)
go

/*==============================================================*/
/* Table: Warehouse                                             */
/*==============================================================*/
create table dbo.Warehouse (
   Id                   ZC_Id                not null,
   Name                 ZC_Text_50           not null,
   IsLease              bit                  not null,
   Remark               ZC_Text_100          null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ֿ��',
   'user', 'dbo', 'table', 'Warehouse'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Warehouse', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Warehouse', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƿ�����־',
   'user', 'dbo', 'table', 'Warehouse', 'column', 'IsLease'
go

execute sp_addextendedproperty 'MS_Description', 
   '˵��',
   'user', 'dbo', 'table', 'Warehouse', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Warehouse', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Warehouse', 'column', '_myUpdate'
go

alter table dbo.Warehouse
   add constraint PK_WAREHOUSE primary key (Id)
go

/*==============================================================*/
/* Table: _myDeleteIdTombstone                                  */
/*==============================================================*/
create table dbo._myDeleteIdTombstone (
   DetailId             ZC_Id                identity,
   TombstoneId          ZC_Id                not null,
   DeleteId             varbinary(16)        not null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'ɾ����¼������ٱ�',
   'user', 'dbo', 'table', '_myDeleteIdTombstone'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ϸ���ټ�¼����',
   'user', 'dbo', 'table', '_myDeleteIdTombstone', 'column', 'DetailId'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ټ�¼����',
   'user', 'dbo', 'table', '_myDeleteIdTombstone', 'column', 'TombstoneId'
go

execute sp_addextendedproperty 'MS_Description', 
   'ɾ����¼����',
   'user', 'dbo', 'table', '_myDeleteIdTombstone', 'column', 'DeleteId'
go

alter table dbo._myDeleteIdTombstone
   add constraint PK__MYDELETEIDTOMBSTONE primary key nonclustered (DetailId)
go

/*==============================================================*/
/* Index: Index_DeleteId                                        */
/*==============================================================*/
create clustered index Index_DeleteId on dbo._myDeleteIdTombstone (
TombstoneId ASC
)
go

/*==============================================================*/
/* Table: _myDeleteTombstone                                    */
/*==============================================================*/
create table dbo._myDeleteTombstone (
   TombstoneId          ZC_Id                identity,
   TableName            ZC_Text_30           not null,
   Scripts              ZC_Text_500          not null
)
go

execute sp_addextendedproperty 'MS_Description', 
   'ɾ����¼���ٱ�',
   'user', 'dbo', 'table', '_myDeleteTombstone'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ټ�¼����',
   'user', 'dbo', 'table', '_myDeleteTombstone', 'column', 'TombstoneId'
go

execute sp_addextendedproperty 'MS_Description', 
   'ɾ����¼����',
   'user', 'dbo', 'table', '_myDeleteTombstone', 'column', 'TableName'
go

execute sp_addextendedproperty 'MS_Description', 
   'ɾ����¼�ű�',
   'user', 'dbo', 'table', '_myDeleteTombstone', 'column', 'Scripts'
go

alter table dbo._myDeleteTombstone
   add constraint PK__MYDELETETOMBSTONE primary key nonclustered (TombstoneId)
go

/*==============================================================*/
/* Index: Index_TableName                                       */
/*==============================================================*/
create clustered index Index_TableName on dbo._myDeleteTombstone (
TableName ASC
)
go

