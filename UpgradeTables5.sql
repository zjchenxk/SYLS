/*==============================================================*/
/* 1.�����汾��                                                   */
/*==============================================================*/
update AppVersion set Version = N'5.0.0.0'

/*==============================================================*/
/* 2.������ͬ��                                                   */
/*==============================================================*/
create table dbo.Temp_EnterWarehouseBillGoods (
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
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ⵥ����',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'EnterWarehouseBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'GoodsId'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'GoodsName'
go

execute sp_addextendedproperty 'MS_Description', 
   '����������',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'TypeId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����������',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'TypeName'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ·��',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'TypeFullPath'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������ȫ����',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'TypeFullName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'GoodsNo'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ʒ��',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'Brand'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ͺ�',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'SpecModel'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'GWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ȼ�',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'Grade'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'PieceWeight'
go

execute sp_addextendedproperty 'MS_Description', 
   '��װ�����������',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'Packing'
go

execute sp_addextendedproperty 'MS_Description', 
   '���α��',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'BatchNo'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'Location'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '��������',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'ProductionDate'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ֵ��������',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', 'ShipmentBillGoodsIds'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Temp_EnterWarehouseBillGoods', 'column', '_myUpdate'
go

alter table dbo.Temp_EnterWarehouseBillGoods
   add constraint PK_TEMP_ENTERWAREHOUSEBILLGOODS primary key nonclustered (Id)
go

create clustered index Index_EnterWarehouseId on dbo.Temp_EnterWarehouseBillGoods (
EnterWarehouseBillId ASC
)
go

create index Index_GoodsNo on dbo.Temp_EnterWarehouseBillGoods (
GoodsNo ASC
)
go

create index Index_GoodsName on dbo.Temp_EnterWarehouseBillGoods (
GoodsName ASC
)
go

create index Index_SpecModel on dbo.Temp_EnterWarehouseBillGoods (
SpecModel ASC
)
go

insert into dbo.Temp_EnterWarehouseBillGoods 
	(
		Id,
		EnterWarehouseBillId,
		GoodsId,
		GoodsName,
		TypeId,
		TypeName,
		TypeFullPath,
		TypeFullName,
		GoodsNo,
		Brand,
		SpecModel,
		GWeight,
		Grade,
		PieceWeight,
		Packing,
		BatchNo,
		Location,
		Packages,
		Tunnages,
		Piles,
		TenThousands,
		ProductionDate,
		ShipmentBillGoodsIds
	) 
select 
	Id,
	EnterWarehouseBillId,
	GoodsId,
	GoodsName,
	TypeId,
	TypeName,
	TypeFullPath,
	TypeFullName,
	GoodsNo,
	Brand,
	SpecModel,
	GWeight,
	Grade,
	PieceWeight,
	Packing,
	BatchNo,
	Location,
	Packages,
	Tunnages,
	Piles,
	TenThousands,
	ProductionDate,
	N''
from 
	dbo.EnterWarehouseBillGoods
go

drop table dbo.EnterWarehouseBillGoods
go

execute sp_rename N'dbo.Temp_EnterWarehouseBillGoods', N'EnterWarehouseBillGoods', 'OBJECT'
go

execute sp_rename N'PK_TEMP_ENTERWAREHOUSEBILLGOODS', N'PK_ENTERWAREHOUSEBILLGOODS', 'OBJECT'
go


/*==============================================================*/
/* 3.�������˼۸��                                               */
/*==============================================================*/
create table dbo.Temp_CarrierTransportPrice (
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
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���˵�λ����',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'CarrierId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'StartCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʡ��',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'StartProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'StartCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'DestCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʡ��',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'DestProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'DestCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ����ֽ�����ƻ����޷����ƻ��������淢���ƻ������������ƻ�',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'PlanType'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʼʱ��',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'StartTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֹʱ��',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'EndTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Temp_CarrierTransportPrice', 'column', '_myUpdate'
go

alter table dbo.Temp_CarrierTransportPrice
   add constraint PK_TEMP_CARRIERTRANSPORTPRICE primary key nonclustered (Id)
go

create clustered index Index_CarrierId on dbo.Temp_CarrierTransportPrice (
CarrierId ASC
)
go

insert into dbo.Temp_CarrierTransportPrice 
	(
		Id,
		CarrierId,
		StartCountry,
		StartProvince,
		StartCity,
		DestCountry,
		DestProvince,
		DestCity,
		PlanType,
		StartTime,
		EndTime,
		TransportPrice
	) 
select 
	Id,
	CarrierId,
	StartCountry,
	StartProvince,
	StartCity,
	DestCountry,
	DestProvince,
	DestCity,
	PlanType,
	'2011-01-01 00:00:00',
	'9999-12-31 23:59:59',
	TransportPrice
from 
	dbo.CarrierTransportPrice
go

drop table dbo.CarrierTransportPrice
go

execute sp_rename N'dbo.Temp_CarrierTransportPrice', N'CarrierTransportPrice', 'OBJECT'
go

execute sp_rename N'PK_TEMP_CARRIERTRANSPORTPRICE', N'PK_CARRIERTRANSPORTPRICE', 'OBJECT'
go

/*==============================================================*/
/* 4.�����ͻ�����۸��                                         */
/*==============================================================*/
create table dbo.Temp_CustomerTransportPrice (
   Id                   ZC_Id                not null,
   CustomerId           ZC_Id                not null,
   StartCountry         ZC_Text_20           not null,
   StartProvince        ZC_Text_20           not null,
   StartCity            ZC_Text_20           not null,
   DestCountry          ZC_Text_20           not null,
   DestProvince         ZC_Text_20           not null,
   DestCity             ZC_Text_20           not null,
   MinTunnagesOrPiles   int                  not null,
   MaxTunnagesOrPiles   int                  not null,
   StartTime            ZC_DateTime          not null,
   EndTime              ZC_DateTime          not null,
   TransportPrice       ZC_Money             not null,
   RiverCrossingCharges ZC_Money             null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����۸��',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'CustomerId'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'StartCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʡ��',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'StartProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'StartCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'DestCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʡ��',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'DestProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'DestCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ����λ������',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'MinTunnagesOrPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ����λ������',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'MaxTunnagesOrPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʼʱ��',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'StartTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֹʱ��',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'EndTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', 'RiverCrossingCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Temp_CustomerTransportPrice', 'column', '_myUpdate'
go

alter table dbo.Temp_CustomerTransportPrice
   add constraint PK_TEMP_CUSTOMERTRANSPORTPRICE primary key nonclustered (Id)
go

create clustered index Index_CustomerId on dbo.Temp_CustomerTransportPrice (
CustomerId ASC
)
go

insert into dbo.Temp_CustomerTransportPrice 
	(
		Id,
		CustomerId,
		StartCountry,
		StartProvince,
		StartCity,
		DestCountry,
		DestProvince,
		DestCity,
		MinTunnagesOrPiles,
		MaxTunnagesOrPiles,
		StartTime,
		EndTime,
		TransportPrice,
		RiverCrossingCharges
	) 
select 
	Id,
	CustomerId,
	StartCountry,
	StartProvince,
	StartCity,
	DestCountry,
	DestProvince,
	DestCity,
	MinTunnagesOrPiles,
	MaxTunnagesOrPiles,
	'2011-01-01 00:00:00',
	'9999-12-31 23:59:59',
	TransportPrice,
	RiverCrossingCharges
from 
	dbo.CustomerTransportPrice
go

drop table dbo.CustomerTransportPrice
go

execute sp_rename N'dbo.Temp_CustomerTransportPrice', N'CustomerTransportPrice', 'OBJECT'
go

execute sp_rename N'PK_TEMP_CUSTOMERTRANSPORTPRICE', N'PK_CUSTOMERTRANSPORTPRICE', 'OBJECT'
go

/*==============================================================*/
/* 5.�����ͻ���֧�Ѽ۸��                                       */
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

create clustered index Index_CustomerId on dbo.CustomerForceFeePrice (
CustomerId ASC
)
go

declare @CustomerId bigint
declare @LoadingForceFeePrice numeric(25,9)
declare @UnloadingForceFeePrice numeric(25,9)
declare @NewId bigint

declare Cursor1 cursor local for 
	select Id, LoadingForceFeePrice, UnloadingForceFeePrice from Customer 
            
open Cursor1
fetch next from Cursor1 into @CustomerId, @LoadingForceFeePrice, @UnloadingForceFeePrice
    
while @@fetch_status = 0
begin
    exec GetId 1, @NewId output 
    
    insert into CustomerForceFeePrice 
        (
            Id,
            CustomerId,
			StartTime,
			EndTime,
			LoadingForceFeePrice,
			UnloadingForceFeePrice
        )
    values
        (
            @NewId,
			@CustomerId,
			'2011-01-01 00:00:00',
			'9999-12-31 23:59:59',
			@LoadingForceFeePrice,
			@UnloadingForceFeePrice
        )
    
    fetch next from Cursor1 into @CustomerId, @LoadingForceFeePrice, @UnloadingForceFeePrice
end 
        
close Cursor1
deallocate Cursor1 
go

/*==============================================================*/
/* 6.�����ͻ��ִ��Ѽ۸��                                       */
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

create clustered index Index_CustomerId on dbo.CustomerStorageFeePrice (
CustomerId ASC
)
go

declare @CustomerId bigint
declare @StorageFeePrice numeric(25,9)
declare @NewId bigint

declare Cursor2 cursor local for 
	select Id, StorageFeePrice from Customer 
            
open Cursor2
fetch next from Cursor2 into @CustomerId, @StorageFeePrice
    
while @@fetch_status = 0
begin
    exec GetId 1, @NewId output 
    
    insert into CustomerStorageFeePrice 
        (
            Id,
            CustomerId,
			StartTime,
			EndTime,
			StorageFeePrice
        )
    values
        (
            @NewId,
			@CustomerId,
			'2011-01-01 00:00:00',
			'9999-12-31 23:59:59',
			@StorageFeePrice
        )
    
    fetch next from Cursor2 into @CustomerId, @StorageFeePrice
end 
        
close Cursor2
deallocate Cursor2
go

/*==============================================================*/
/* 7.�����ͻ���                                                 */
/*==============================================================*/
create table dbo.Temp_Customer (
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
   'user', 'dbo', 'table', 'Temp_Customer'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ͻ�����',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'Name'
go

execute sp_addextendedproperty 'MS_Description', 
   'ȫ��',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'FullName'
go

execute sp_addextendedproperty 'MS_Description', 
   'Ԥ����棨�֣�',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'WarningStock'
go

execute sp_addextendedproperty 'MS_Description', 
   'ֹͣ������棨�֣�',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'StopStock'
go

execute sp_addextendedproperty 'MS_Description', 
   '���㹫ʽ',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'SettlementExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '�Ƽ۷�ʽ',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'ValuationMode'
go

execute sp_addextendedproperty 'MS_Description', 
   'ë����',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'GrossWeightRate'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'OwnOrganId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������Ű��´�����',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', 'OwnOrganName'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Temp_Customer', 'column', '_myUpdate'
go

alter table dbo.Temp_Customer
   add constraint PK_TEMP_CUSTOMER primary key nonclustered (Id)
go

create unique index Index_Name on dbo.Temp_Customer (
Name ASC
)
go

insert into dbo.Temp_Customer 
	(
		Id,
		Name,
		FullName,
		WarningStock,
		StopStock,
		SettlementExpression,
		ValuationMode,
		GrossWeightRate,
		Remark,
		OwnOrganId,
		OwnOrganName
	) 
select 
	Id,
	Name,
	FullName,
	WarningStock,
	StopStock,
	SettlementExpression,
	ValuationMode,
	GrossWeightRate,
	Remark,
	OwnOrganId,
	OwnOrganName
from 
	dbo.Customer
go

drop table dbo.Customer
go

execute sp_rename N'dbo.Temp_Customer', N'Customer', 'OBJECT'
go

execute sp_rename N'PK_TEMP_CUSTOMER', N'PK_CUSTOMER', 'OBJECT'
go

/*==============================================================*/
/* 8.���������޼۱�                                             */
/*==============================================================*/
create table dbo.Temp_TransportLimitedPrice (
   Id                   ZC_Id                not null,
   PlanType             ZC_Text_10           not null,
   StartCountry         ZC_Text_20           not null,
   StartProvince        ZC_Text_20           not null,
   StartCity            ZC_Text_20           not null,
   DestCountry          ZC_Text_20           not null,
   DestProvince         ZC_Text_20           not null,
   DestCity             ZC_Text_20           not null,
   CarType              ZC_Text_10           not null,
   MinTunnagesOrPiles   int                  not null,
   MaxTunnagesOrPiles   int                  not null,
   StartTime            ZC_DateTime          not null,
   EndTime              ZC_DateTime          not null,
   TransportPrice       ZC_Money             not null,
   _myInsert            bit                  null,
   _myUpdate            bit                  null
)
go

execute sp_addextendedproperty 'MS_Description', 
   '�����޼۱�',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ����ֽ�����ƻ����޷����ƻ��������淢���ƻ������������ƻ�',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'PlanType'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'StartCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ʡ��',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'StartProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'StartCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'DestCountry'
go

execute sp_addextendedproperty 'MS_Description', 
   '����ʡ��',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'DestProvince'
go

execute sp_addextendedproperty 'MS_Description', 
   '�������',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'DestCity'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'CarType'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ����λ������',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'MinTunnagesOrPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��λ����λ������',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'MaxTunnagesOrPiles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ʼʱ��',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'StartTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֹʱ��',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'EndTime'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷Ѽ۸�',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Temp_TransportLimitedPrice', 'column', '_myUpdate'
go

alter table dbo.Temp_TransportLimitedPrice
   add constraint PK_TEMP_TRANSPORTLIMITEDPRICE primary key (Id)
go

insert into dbo.Temp_TransportLimitedPrice 
	(
		Id,
		PlanType,
		StartCountry,
		StartProvince,
		StartCity,
		DestCountry,
		DestProvince,
		DestCity,
		CarType,
		MinTunnagesOrPiles,
		MaxTunnagesOrPiles,
		StartTime,
		EndTime,
		TransportPrice
	) 
select 
	Id,
	PlanType,
	StartCountry,
	StartProvince,
	StartCity,
	DestCountry,
	DestProvince,
	DestCity,
	CarType,
	MinTunnagesOrPiles,
	MaxTunnagesOrPiles,
	'2011-01-01 00:00:00',
	'9999-12-31 23:59:59',
	TransportPrice
from 
	dbo.TransportLimitedPrice
go

drop table dbo.TransportLimitedPrice
go

execute sp_rename N'dbo.Temp_TransportLimitedPrice', N'TransportLimitedPrice', 'OBJECT'
go

execute sp_rename N'PK_TEMP_TRANSPORTLIMITEDPRICE', N'PK_TRANSPORTLIMITEDPRICE', 'OBJECT'
go

/*==============================================================*/
/* 9.�������ȼƻ���                                             */
/*==============================================================*/
create table dbo.Temp_DispatchBillDeliverPlan (
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
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '���ȵ�����',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'DispatchBillId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷ѹ�ʽ',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'TransportChargeExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '���۹�ʽ',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'TransportPriceExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'KM'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷Ѽ۸�',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷�',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'TransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Temp_DispatchBillDeliverPlan', 'column', '_myUpdate'
go

alter table dbo.Temp_DispatchBillDeliverPlan
   add constraint PK_TEMP_DISPATCHBILLDELIVERPLAN primary key nonclustered (Id)
go

create clustered index Index_DispatchId on dbo.Temp_DispatchBillDeliverPlan (
DispatchBillId ASC
)
go

create unique index Index_DispatchId_PlanId on dbo.Temp_DispatchBillDeliverPlan (
DispatchBillId ASC,
PlanId ASC
)
go

insert into dbo.Temp_DispatchBillDeliverPlan 
	(
		Id,
		DispatchBillId,
		PlanId,
		Packages,
		Tunnages,
		Piles,
		TenThousands,
		TransportChargeExpression,
		TransportPriceExpression,
		KM,
		TransportPrice,
		TransportCharges,
		Remark
	) 
select 
	Id,
	DispatchBillId,
	PlanId,
	Packages,
	Tunnages,
	Piles,
	TenThousands,
	TransportChargeExpression,
	TransportPriceExpression,
	KM,
	TransportPrice,
	TransportCharges,
	N''
from 
	dbo.DispatchBillDeliverPlan
go

drop table dbo.DispatchBillDeliverPlan
go

execute sp_rename N'dbo.Temp_DispatchBillDeliverPlan', N'DispatchBillDeliverPlan', 'OBJECT'
go

execute sp_rename N'PK_TEMP_DISPATCHBILLDELIVERPLAN', N'PK_DISPATCHBILLDELIVERPLAN', 'OBJECT'
go

/*==============================================================*/
/* 10.������ͬ�ƻ���                                            */
/*==============================================================*/
create table dbo.Temp_ContractDeliverPlan (
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
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼����',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'Id'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ͬ����',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'ContractId'
go

execute sp_addextendedproperty 'MS_Description', 
   '�ƻ�����',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'PlanId'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'Packages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'Tunnages'
go

execute sp_addextendedproperty 'MS_Description', 
   '����',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'Piles'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ֻ',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'TenThousands'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷ѹ�ʽ',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'TransportChargeExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '���۹�ʽ',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'TransportPriceExpression'
go

execute sp_addextendedproperty 'MS_Description', 
   '������',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'KM'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷Ѽ۸�',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'TransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�˷�',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'TransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '��ע',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'Remark'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����۸�',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'ApprovedTransportPrice'
go

execute sp_addextendedproperty 'MS_Description', 
   '�����˷�',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', 'ApprovedTransportCharges'
go

execute sp_addextendedproperty 'MS_Description', 
   '������¼��־',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', '_myInsert'
go

execute sp_addextendedproperty 'MS_Description', 
   '��¼�޸ı�־',
   'user', 'dbo', 'table', 'Temp_ContractDeliverPlan', 'column', '_myUpdate'
go

alter table dbo.Temp_ContractDeliverPlan
   add constraint PK_TEMP_CONTRACTDELIVERPLAN primary key nonclustered (Id)
go

create clustered index Index_DispatchId on dbo.Temp_ContractDeliverPlan (
ContractId ASC
)
go

create unique index Index_DispatchId_PlanId on dbo.Temp_ContractDeliverPlan (
ContractId ASC,
PlanId ASC
)
go

insert into dbo.Temp_ContractDeliverPlan 
	(
		Id,
		ContractId,
		PlanId,
		Packages,
		Tunnages,
		Piles,
		TenThousands,
		TransportChargeExpression,
		TransportPriceExpression,
		KM,
		TransportPrice,
		TransportCharges,
		Remark,
		ApprovedTransportPrice,
		ApprovedTransportCharges
	) 
select 
	Id,
	ContractId,
	PlanId,
	Packages,
	Tunnages,
	Piles,
	TenThousands,
	TransportChargeExpression,
	TransportPriceExpression,
	KM,
	TransportPrice,
	TransportCharges,
	N'',
	ApprovedTransportPrice,
	ApprovedTransportCharges
from 
	dbo.ContractDeliverPlan
go

drop table dbo.ContractDeliverPlan
go

execute sp_rename N'dbo.Temp_ContractDeliverPlan', N'ContractDeliverPlan', 'OBJECT'
go

execute sp_rename N'PK_TEMP_CONTRACTDELIVERPLAN', N'PK_CONTRACTDELIVERPLAN', 'OBJECT'
go
