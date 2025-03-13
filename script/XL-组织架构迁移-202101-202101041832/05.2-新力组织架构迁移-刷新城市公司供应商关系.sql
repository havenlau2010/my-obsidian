
declare @SourceCompanyGUID  uniqueidentifier ,
    @SourceCompanyName varchar(256)  ,
    @TargetCompanyGUID    uniqueidentifier ,
    @TargetCompanyName  varchar(256)  

select @SourceCompanyName = '中山城市公司',@TargetCompanyName = '湾区城市公司'

select @SourceCompanyGUID = BUGUID from myBusinessUnit where BUName = @SourceCompanyName and IsCompany = 1
select @TargetCompanyGUID = BUGUID from myBusinessUnit where BUName = @TargetCompanyName and IsCompany = 1

if @SourceCompanyGUID is not null and @TargetCompanyGUID is not null
    begin
        begin tran
            begin
				if exists(select 1 from ys_deptprovider a join ys_deptprovider b on a.ProviderGUID = b.ProviderGUID and b.BUGUID = @TargetCompanyGUID and a.BUGUID = @SourceCompanyGUID)
				begin
					print '有重复供应商在两个公司内，请核实'
				end
				else
				begin
					update ys_deptprovider set buguid = @TargetCompanyGUID where buguid = @SourceCompanyGUID
				end
        	end
        if @@error <> 0 or @@rowcount = 0
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
        print  '未获取到城市公司GUID'
    end