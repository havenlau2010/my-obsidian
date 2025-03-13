
create table #ChangeSpecialBusinessUnit
(
    Id              int identity (1,1),
    Year            int              null,
    SpecialUnitGUID uniqueidentifier not null
)
declare @TargetCompanyName varchar(256), @TargetCompanyGUID uniqueidentifier,@RowNumber int,@RowNumberIndex int
-- 请将此处set 修改为要更新 城市公司名字
set @TargetCompanyName = '湾区城市公司'
select @RowNumber = 0, @RowNumberIndex = 1, @TargetCompanyGUID = newid()
select @TargetCompanyGUID = BUGUID
from myBusinessUnit
where
      BUName = @TargetCompanyName
  and IsCompany = 1
  -- and 1 = 2
insert into #ChangeSpecialBusinessUnit(SpecialUnitGUID, Year)
select a.SpecialUnitGUID, a.Year
from ys_SpecialBusinessUnit              a
    join ys_SpecialBusinessUnit          b
    on a.ParentGUID = b.SpecialUnitGUID and a.Year = b.Year and b.SpecialUnitName = '营销全成本'
    join (select a.year, a.OrderCode
          from ys_SpecialBusinessUnit     a
              join ys_SpecialBusinessUnit b
              on a.ParentGUID = b.SpecialUnitGUID and a.Year = b.Year and b.SpecialUnitName = '营销全成本'
          where a.BUGUID = @TargetCompanyGUID
          group by a.year, a.OrderCode
          having count(a.OrderCode) > 1) c on a.Year = c.Year and a.OrderCode = c.OrderCode
where
    a.BUGUID = @TargetCompanyGUID

select @RowNumber = count(*)
from #ChangeSpecialBusinessUnit
if @RowNumber > 0
    begin
        begin tran begin
            while @RowNumberIndex <= @RowNumber begin
                update a
                set a.OrderCode = b.NewOrderCode
                from ys_SpecialBusinessUnit     a
                    left join (select a.year, isnull(max(cast(a.OrderCode as int)),0) + 1 as NewOrderCode
                               from ys_SpecialBusinessUnit a
                               where a.BUGUID = @TargetCompanyGUID
                               group by a.year) b on a.Year = b.Year
                where
                        a.SpecialUnitGUID =
                        (select SpecialUnitGUID from #ChangeSpecialBusinessUnit where id = @RowNumberIndex)
                set @RowNumberIndex = @RowNumberIndex + 1
            end
        end
        if @@error <> 0
            begin
                rollback tran
                print '执行失败'
            end
        else
            begin
                commit tran
                print '执行成功'
            end
    end
else
    begin
        print '未获取到要更新排序编码预算部门'
    end
drop table #ChangeSpecialBusinessUnit