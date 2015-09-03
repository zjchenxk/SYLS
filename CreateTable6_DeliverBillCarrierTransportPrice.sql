/*==============================================================*/
/* 创建特殊承运价格表                                           */
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
   '送货单特殊承运价格表',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '记录编码',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '送货单编码',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'DeliverBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '单价',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '运费',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'TransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '备注',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '创建人编码',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'CreatorId'
go

execute sp_addextendedproperty 'MS_Description', 
   '创建人姓名',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'CreatorName'
go

execute sp_addextendedproperty 'MS_Description', 
   '创建部门办事处编码',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'CreateOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '创建部门办事处名称',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'CreateOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '发货日期',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', 'CreateTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '新增记录标志',
   'user', 'dbo', 'table', 'DeliverBillCarrierTransportPrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '记录修改标志',
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
