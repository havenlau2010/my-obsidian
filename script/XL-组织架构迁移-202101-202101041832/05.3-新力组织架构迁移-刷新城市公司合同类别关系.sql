
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
				declare @HtTypeName varchar(200)
				select top 1 @HtTypeName = c.HtTypeName
				-- update b set b.HtTypeGUID = d.HtTypeGUID
				FROM dbo.cb_Contract a
				INNER JOIN dbo.cb_Contract2HTType b ON a.ContractGUID = b.ContractGUID 
				JOIN dbo.cb_HtType c ON b.HtTypeGUID = c.HtTypeGUID  and b.BUGUID = @SourceCompanyGUID
				LEFT JOIN dbo.cb_HtType d ON c.HtTypeName = d.HtTypeName  AND d.BUGUID = @TargetCompanyGUID
				WHERE a.BUGUID = @TargetCompanyGUID and d.HtTypeGUID IS NULL
				if ISNULL(@HtTypeName,'') <> ''
				begin
					-- [管理类-室内装修工程合同]
					print '被迁移公司【'+@HtTypeName+'】在目标公司内不存在，请在目标公司内添加【'+@HtTypeName+'】合同类型后再操作'
				end
				else
				begin
					print 'exec'
					update b set b.HtTypeGUID = d.HtTypeGUID,b.BUGUID = @TargetCompanyGUID
						FROM dbo.cb_Contract a
						JOIN dbo.cb_Contract2HTType b ON a.ContractGUID = b.ContractGUID 
						JOIN dbo.cb_HtType c ON b.HtTypeGUID = c.HtTypeGUID  and b.BUGUID = @SourceCompanyGUID
						JOIN dbo.cb_HtType d ON c.HtTypeName = d.HtTypeName  AND d.BUGUID = @TargetCompanyGUID
						WHERE a.BUGUID = @TargetCompanyGUID
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