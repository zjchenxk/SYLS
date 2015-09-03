	
	declare @GroupId bigint
	declare @Id bigint
	
    declare Cursor1 cursor local for select Id from SysGroup 
            
    open Cursor1
    fetch next from Cursor1 into @GroupId
    while @@fetch_status = 0
    begin
		/*3045*/
		if not exists(select * from SysGroupPermission where GroupId = @GroupId and FuncId = 3045)
		begin
			select @Id = max(id) + 1 from SysGroupPermission where GroupId = @GroupId
			
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
					AllowPrint
				)
			values
				(
					@Id,
					@GroupId,
					3045,
					case when @GroupId = 1 then 1 else 0 end,/*AllowOpen*/
					0,/*AllowNew*/
					0,/*AllowModify*/
					0,/*AllowDelete*/
					0,/*AllowCancel*/
					0,/*AllowDetail*/
					case when @GroupId = 1 then 1 else 0 end,/*AllowSearch*/
					0,/*AllowSubmit*/
					0,/*AllowApprove*/
					0,/*AllowDispatch*/
					case when @GroupId = 1 then 1 else 0 end,/*AllowExport*/
					0,/*AllowImport*/
					0/*AllowPrint*/
				)
		end
	
        fetch next from Cursor1 into @GroupId
    end 
        
    close Cursor1
    deallocate Cursor1 

	