--��ӹ��ܱ�
declare @FuncId bigint
declare @FuncName nvarchar(20)

set @FuncId = 6060
set @FuncName = '��ѯ������˼۸�'

insert into SysFunction
	(
		Id,
		Name,
		AllowOpen,
		AllowNew,
		AllowModify,
		AllowDelete,
		AllowCancel,
		AllowDetail,
		AllowSearch,
		AllowSubmit,
		AllowApprove,
		AllowDispatch,
		AllowExport,
		AllowImport,
		AllowPrint,
		_myInsert,
		_myUpdate
	)
values
	(
		@FuncId,
		@FuncName,
		1,
		0,
		0,
		1,
		0,
		0,
		1,
		0,
		0,
		0,
		0,
		0,
		0,
		null,
		null
	)

--���Ȩ�����
declare @GroupId bigint
declare @Id bigint

declare Cursor1 cursor local for select Id from SysGroup 
            
open Cursor1
fetch next from Cursor1 into @GroupId
        
while @@fetch_status = 0
begin
	exec GetId 1, @Id output

	insert into SysGroupPermission 
		(
			Id,
			GroupId,
			FuncId,
			AllowOpen,
			AllowNew,
			AllowModify,
			AllowDelete,
			AllowCancel,
			AllowDetail,
			AllowSearch,
			AllowSubmit,
			AllowApprove,
			AllowDispatch,
			AllowExport,
			AllowImport,
			AllowPrint,
			_myInsert,
			_myUpdate
		)
	values
		(
			@Id,
			@GroupId,
			@FuncId,
			1,
			0,
			0,
			1,
			0,
			0,
			1,
			0,
			0,
			0,
			0,
			0,
			0,
			null,
			null
		)
        
    fetch next from Cursor1 into @GroupId
end
        
close Cursor1
deallocate Cursor1 

go


