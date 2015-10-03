set nocount on
begin tran

/*É¾³ý¿Õ¿â´æ*/
/*delete from Stock where Packages = 0 and Tunnages = 0 and Piles = 0 and TenThousands = 0*/

/*¼ÆËã²Ö´¢·Ñ*/
declare @StockId bigint
declare @Packages int
declare @Tunnages numeric(25,9)
declare @Piles numeric(25,9)
declare @TenThousands numeric(25,9)
declare @Id bigint
declare @Today datetime

set @Today = cast((convert(nvarchar(10),dateadd(day,-1,getdate()),120) + ' 23:59:59') as datetime)

declare cursor1 cursor for 
	select Id, Packages, Tunnages, Piles, TenThousands from Stock with (tablockx,holdlock) 
open cursor1
fetch next from cursor1 into @StockId, @Packages, @Tunnages, @Piles, @TenThousands
while @@fetch_status = 0
begin
	select @Id = Id from StockDaily where StockId = @StockId and convert(nvarchar(10),CreateTime,120) = convert(nvarchar(10),@Today,120)
	if @@rowcount = 0
	begin
		insert into StockDaily 
			(
				StockId, 
				Packages, 
				Tunnages, 
				Piles,
				TenThousands,
				StorageFee, 
				CreateTime
			) 
		values 
			(
				@StockId, 
				@Packages, 
				@Tunnages, 
				@Piles,
				@TenThousands,
				0,
				@Today
			)
	end
	else
	begin
		update StockDaily set 
			Packages = @Packages, 
			Tunnages = @Tunnages,
			Piles = @Piles,
			TenThousands = @TenThousands,
			StorageFee = 0 
		where 
			Id = @Id
	end
	
	fetch next from cursor1 into @StockId, @Packages, @Tunnages, @Piles, @TenThousands
end 

close cursor1
deallocate cursor1

commit tran
go
