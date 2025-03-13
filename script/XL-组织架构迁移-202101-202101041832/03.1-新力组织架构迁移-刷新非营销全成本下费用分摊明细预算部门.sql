create table #zz_ChangeDepartment
(
    SourceBUName   varchar(256)     not null,
    SourceDeptGUID uniqueidentifier null,
    SourceDeptName varchar(256)     not null,
    TargetBUName    varchar(256)     not null,
    TargetDeptGUID  uniqueidentifier null,
    TargetDeptName  varchar(256)     not null,
    Year int not null
)

insert into #zz_ChangeDepartment(SourceBUName, SourceDeptName, TargetBUName, TargetDeptName,Year)
select SourceBUName, SourceDeptName,TargetBUName,TargetDeptName,Year from (
select      2000 Year	,'' SourceBUName,'' SourceDeptName,'' TargetBUName,'' TargetDeptName union all

select      2021	,'中山城市公司'			,'房修-人力行政部'	,'湾区城市公司'	,'房修-人力行政部' union all
select      2021	,'中山城市公司'			,'房修-业务部'		,'湾区城市公司'	,'房修-业务部' union all
select      2021	,'中山城市公司'			,'新力量前三月费用'	,'湾区城市公司'	,'新力量前三月费用' union all
select      2021	,'中山城市公司'			,'工程管理部'		,'湾区城市公司'	,'工程管理部' union all
select      2021	,'中山城市公司'			,'总经办'			,'湾区城市公司'	,'总经办' union all
select      2021	,'中山城市公司'			,'项目工程部'		,'湾区城市公司'	,'项目工程部' union all
select      2021	,'中山城市公司'			,'运营管理部'		,'湾区城市公司'	,'运营管理部' union all
select      2021	,'中山城市公司'			,'设计管理部'		,'湾区城市公司'	,'设计管理部' union all
select      2021	,'中山城市公司'			,'投资拓展部'		,'湾区城市公司'	,'投资拓展部' union all
select      2021	,'中山城市公司'			,'人力行政部'		,'湾区城市公司'	,'人力行政部' union all
select      2021	,'中山城市公司'			,'客户关系部'		,'湾区城市公司'	,'客户关系部' union all
select      2021	,'中山城市公司'			,'成本管理部'		,'湾区城市公司'	,'成本管理部' union all
select      2021	,'中山城市公司'			,'开发报建部'		,'湾区城市公司'	,'开发报建部' union all
select      2021	,'中山城市公司'			,'财务管理部'		,'湾区城市公司'	,'财务管理部' union all
select      2021	,'中山城市公司'			,'法务部'			,'湾区城市公司'	,'法务部' union all
			
select      2020	,'中山城市公司'			,'工程管理部'		,'湾区城市公司'	,'工程管理部' union all
select      2020	,'中山城市公司'			,'总经办'	 		,'湾区城市公司'	,'总经办' union all
select      2020	,'中山城市公司'			,'项目工程部'		,'湾区城市公司'	,'项目工程部' union all
select      2020	,'中山城市公司'			,'运营管理部'		,'湾区城市公司'	,'运营管理部' union all
select      2020	,'中山城市公司'			,'设计管理部'		,'湾区城市公司'	,'设计管理部' union all
select      2020	,'中山城市公司'			,'投资拓展部'		,'湾区城市公司'	,'投资拓展部' union all
select      2020	,'中山城市公司'			,'人力行政部'		,'湾区城市公司'	,'人力行政部' union all
select      2020	,'中山城市公司'			,'客户关系部'		,'湾区城市公司'	,'客户关系部' union all
select      2020	,'中山城市公司'			,'成本管理部'		,'湾区城市公司'	,'成本管理部' union all
select      2020	,'中山城市公司'			,'开发报建部'		,'湾区城市公司'	,'开发报建部' union all
select      2020	,'中山城市公司'			,'财务管理部'		,'湾区城市公司'	,'财务管理部' union all
select      2020	,'中山城市公司'			,'法务部'			,'湾区城市公司'	,'法务部' union all
select      2020	,'中山城市公司'			,'房修-人力行政部'	,'湾区城市公司'	,'房修-人力行政部' union all
select      2020	,'中山城市公司'			,'房修-业务部'		,'湾区城市公司'	,'房修-业务部' union all
select      2020	,'中山城市公司'			,'新力量前三月费用'	,'湾区城市公司'	,'新力量前三月费用' union all
			
select      2019	,'中山城市公司'			,'工程管理部'		,'湾区城市公司'	,'工程管理部' union all
select      2019	,'中山城市公司'			,'总经办'			,'湾区城市公司'	,'总经办' union all
select      2019	,'中山城市公司'			,'项目工程部'		,'湾区城市公司'	,'项目工程部' union all
select      2019	,'中山城市公司'			,'运营管理部'		,'湾区城市公司'	,'运营管理部' union all
select      2019	,'中山城市公司'			,'设计管理部'		,'湾区城市公司'	,'设计管理部' union all
select      2019	,'中山城市公司'			,'投资拓展部'		,'湾区城市公司'	,'投资拓展部' union all
select      2019	,'中山城市公司'			,'人力行政部'		,'湾区城市公司'	,'人力行政部' union all
select      2019	,'中山城市公司'			,'客户关系部'		,'湾区城市公司'	,'客户关系部' union all
select      2019	,'中山城市公司'			,'成本管理部'		,'湾区城市公司'	,'成本管理部' union all
select      2019	,'中山城市公司'			,'开发报建部'		,'湾区城市公司'	,'开发报建部' union all
select      2019	,'中山城市公司'			,'财务管理部'		,'湾区城市公司'	,'财务管理部' union all
select      2019	,'中山城市公司'			,'法务部'			,'湾区城市公司'	,'法务部' union all
			
select      2018	,'中山城市公司'			,'品质管理部'		,'湾区城市公司' ,'项目工程部' union all
select      2018	,'中山城市公司'			,'总经办'			,'湾区城市公司'	,'总经办' union all
select      2018	,'中山城市公司'			,'项目工程部'		,'湾区城市公司'	,'项目工程部' union all
select      2018	,'中山城市公司'			,'运营管理部'		,'湾区城市公司'	,'运营管理部' union all
select      2018	,'中山城市公司'			,'设计管理部'		,'湾区城市公司'	,'设计管理部' union all
select      2018	,'中山城市公司'			,'投资拓展部'		,'湾区城市公司'	,'投资拓展部' union all
select      2018	,'中山城市公司'			,'人力行政部'		,'湾区城市公司'	,'人力行政部' union all
select      2018	,'中山城市公司'			,'客户关系部'		,'湾区城市公司'	,'客户关系部' union all
select      2018	,'中山城市公司'			,'成本管理部'		,'湾区城市公司'	,'成本管理部' union all
select      2018	,'中山城市公司'			,'开发报建部'		,'湾区城市公司'	,'开发报建部' union all
select      2018	,'中山城市公司'			,'财务管理部'		,'湾区城市公司'	,'财务管理部' union all
select      2018	,'中山城市公司'			,'法务部'			,'湾区城市公司'	,'法务部' union all
			
select      2017	,'中山城市公司'			,'总经办'			,'湾区城市公司'	,'总经办' union all
select      2017	,'中山城市公司'			,'项目工程部'		,'湾区城市公司'	,'项目工程部' union all
select      2017	,'中山城市公司'			,'运营品质部'		,'湾区城市公司'	,'运营品质部' union all
select      2017	,'中山城市公司'			,'设计管理部'		,'湾区城市公司'	,'设计管理部' union all
select      2017	,'中山城市公司'			,'投资拓展部'		,'湾区城市公司'	,'投资拓展部' union all
select      2017	,'中山城市公司'			,'人力行政部'		,'湾区城市公司'	,'人力行政部' union all
select      2017	,'中山城市公司'			,'客户关系部'		,'湾区城市公司'	,'客户关系部' union all
select      2017	,'中山城市公司'			,'成本管理部'		,'湾区城市公司'	,'成本管理部' union all
select      2017	,'中山城市公司'			,'开发报建部'		,'湾区城市公司'	,'开发报建部' union all
select      2017	,'中山城市公司'			,'财务管理部'		,'湾区城市公司'	,'财务管理部' union all
select      2017	,'中山城市公司'			,'法务部'			,'湾区城市公司'	,'法务部' 
) tmp where tmp.year <> 2000


UPDATE a
set
    a.SourceDeptGUID = c.SpecialUnitGUID
  , a.TargetDeptGUID = e.SpecialUnitGUID
  , a.TargetDeptName = CONVERT(VARCHAR(4), a.Year) + '年-' + f.SpecialUnitName + '-'+ e.SpecialUnitName
FROM #zz_ChangeDepartment                 a
    INNER JOIN dbo.myBusinessUnit         b ON a.SourceBUName = b.BUName
    INNER JOIN dbo.ys_SpecialBusinessUnit c ON b.BUGUID = c.BUGUID AND a.SourceDeptName = c.SpecialUnitName and c.Year = a.Year
    INNER JOIN dbo.myBusinessUnit         d ON a.TargetBUName = d.BUName
    INNER JOIN dbo.ys_SpecialBusinessUnit e ON d.BUGUID = e.BUGUID AND a.TargetDeptName = e.SpecialUnitName and e.Year = a.Year
    INNER JOIN dbo.ys_SpecialBusinessUnit f ON e.ParentGUID = f.SpecialUnitGUID AND f.Year = a.Year
where f.SpecialUnitName != '营销全成本'
-- and 1 = 2

if not exists(select 1
          from #zz_ChangeDepartment where SourceDeptGUID is null or TargetDeptGUID is null)
    begin
        begin tran
            begin
            ---------------------------------------------------------------------------------------------- 申请单 BEGIN----------------------------------------------------------------------------------------------
            -- 申请单  组织架构
            -- fy_Apply b on b.DeptGUID = a.SourceDeptGUID
            -- 申请单分摊明细
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment  a
                join fy_Apply_FtDetail b on b.DeptGUID = a.SourceDeptGUID
            -- 申请单月分摊明细
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment         a
                join fy_Apply_FtDetail_Period b on b.DeptGUID = a.SourceDeptGUID

            print '申请单 END'
            ---------------------------------------------------------------------------------------------- 申请单 END----------------------------------------------------------------------------------------------

            ---------------------------------------------------------------------------------------------- 合同 BEGIN----------------------------------------------------------------------------------------------
            -- 合同 组织架构
            -- cb_Contract b on b.DeptGUID = a.SourceDeptGUID
            -- 合同月分摊明细
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment            a
                join fy_Contract_FtDetail_Period b on b.DeptGUID = a.SourceDeptGUID
                join cb_Contract c on b.ContractGUID = c.ContractGUID and c.IsFyControl = 1

            -- 部门科目合同使用明细
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment           a
                join ys_DeptCost2ContractUseDtl b on b.DeptGUID = a.SourceDeptGUID
                join cb_Contract c on b.ContractGUID = c.ContractGUID and c.IsFyControl = 1
            -- 合同结算表 组织架构
            -- cb_HTBalance b on b.JbDeptGUID = a.SourceDeptGUID
            -- 合同变更表 组织架构
            -- cb_HtAlter b on b.JbDeptGuid = a.SourceDeptGUID
            -- 合同结算月度分摊明细
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment             a
                join fy_HTBalance_FtDetail_Period b on b.DeptGUID = a.SourceDeptGUID
                join cb_HTBalance c on b.HTBalanceGUID = c.HTBalanceGUID
                join cb_Contract d on c.ContractGUID = d.ContractGUID and d.IsFyControl = 1

            -- 合同付款申请
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment             a
                join cb_DeptCostUseDtl b on b.DeptGUID = a.SourceDeptGUID
                join cb_Contract c on b.ContractGUID = c.ContractGUID and c.IsFyControl = 1

            -- 合同变更明细
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment             a
                join fy_HtAlter_FtDetail_Period b on b.DeptGUID = a.SourceDeptGUID
                join cb_HtAlter c on c.HtAlterGUID = b.HtAlterGUID
			    join cb_Contract d on d.ContractGUID = c.ContractGUID and d.IsFyControl = 1

            print '合同 END'
            ---------------------------------------------------------------------------------------------- 合同 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------付款计划 BEGIN----------------------------------------------------------------------------------------------
            -- 付款计划 -- 未知
            /*
            update b
            set b.DeptGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment a
                join cb_MonthPlan     b on b.DeptGUID = a.SourceDeptGUID
            */
            -- 付款计划明细 -- 组织架构
            -- update b set b.DeptGUID = a.TargetDeptGUID,b.DeptName = a.TargetDeptName ,b.JbDeptGUID from #zz_ChangeDepartment a join cb_MonthPlanDtl b on b.JbDeptGUID = a.SourceDeptGUID
            ----------------------------------------------------------------------------------------------付款计划 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------付款申请 BEGIN----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------付款申请 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------执行单 BEGIN----------------------------------------------------------------------------------------------
            -- 执行单
            -- select b.DeptGUID,a.SourceDeptGUID,a.SourceDeptName,a.TargetDeptGUID,a.TargetDeptName from #zz_ChangeDepartment a join ys_fy_ExecutionInfo b on b.DeptGUID = a.SourceDeptGUID
            /*
            update b
            set b.DeptGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment    a
                join ys_fy_ExecutionInfo b on b.DeptGUID = a.SourceDeptGUID
            */

            -- 执行单分摊明细
            -- select b.DeptGUID,a.SourceDeptGUID,a.SourceDeptName,a.TargetDeptGUID,a.TargetDeptName from #zz_ChangeDepartment a join ys_fy_ExecutionDetails b on b.DeptGUID = a.SourceDeptGUID
            /*
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProcessGUID = a.TargetDeptGUID,b.ProcessName=a.TargetDeptName
            from #zz_ChangeDepartment       a
                join ys_fy_ExecutionDetails b on b.DeptGUID = a.SourceDeptGUID
            */
            ----------------------------------------------------------------------------------------------执行单 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------日常报销 BEGIN----------------------------------------------------------------------------------------------
            -- 报销单  -- 组织架构
            -- cb_Expense b on b.ApplyBUGUID = a.SourceDeptGUID
            -- 报销单分摊明细 在通用中
            /*
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID,b.ProceedingName=a.TargetDeptName
            from #zz_ChangeDepartment  a
                join ys_DeptCostUseDtl b on b.DeptGUID = a.SourceDeptGUID
            */
            -- 日常报销冲账明细表
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName
            from #zz_ChangeDepartment         a
                join cb_Expense_FluentDetails b on b.DeptGUID = a.SourceDeptGUID

            -- 分摊费项明细实际使用审核信息表 在通用中
            /*
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingName=a.TargetDeptName
            from #zz_ChangeDepartment         a
                join ys_DeptCostUsedInfoForSH b on b.DeptGUID = a.SourceDeptGUID
            */
            print '日常报销 END'
            ----------------------------------------------------------------------------------------------日常报销 END----------------------------------------------------------------------------------------------


            ----------------------------------------------------------------------------------------------借款申请 BEGIN----------------------------------------------------------------------------------------------
            -- 借款单 -- 组织架构
            -- cb_Loan b on b.ApplyBUGUID = a.SourceDeptGUID

            -- 借款单分摊明细
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment a
                join cb_Loan_FtDetail b on b.DeptGUID = a.SourceDeptGUID

            -- 借款单科目比例
            update b
            set b.DeptGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment a
                join cb_loan_kmBL     b on b.DeptGUID = a.SourceDeptGUID

            print '借款申请 END'
            ----------------------------------------------------------------------------------------------借款申请 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------还款申请 BEGIN----------------------------------------------------------------------------------------------
            -- 还款申请单
            -- update b set b.DeptGUID = a.TargetDeptGUID,b.DeptName = a.TargetDeptName ,b.PaymentUnitGUID,b.PaymentUnit from #zz_ChangeDepartment a join cb_LoanReturn b on b.PaymentUnitGUID = a.SourceDeptGUID

            -- 还款申请单明细
            update b
            set b.DeptGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment       a
                join cb_LoanReturn_FtDetail b on b.DeptGUID = a.SourceDeptGUID

            print '还款申请 END'
            ----------------------------------------------------------------------------------------------还款申请 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------薪酬管理 BEGIN----------------------------------------------------------------------------------------------
            -- 薪酬单 -- 组织架构
            -- fy_Emolument b on b.DeptGUID = a.SourceDeptGUID

            -- 薪酬单明细 在通用中
            /*
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment  a
                join ys_DeptCostUseDtl b on b.DeptGUID = a.SourceDeptGUID
            */
            ----------------------------------------------------------------------------------------------薪酬管理 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------付款登记 BEGIN----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------付款登记 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------通用 BEGIN----------------------------------------------------------------------------------------------
            -- 部门科目使用明细
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment  a
                join cb_DeptCostUseDtl b on b.DeptGUID = a.SourceDeptGUID

            -- 部门科目使用明细
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName,b.ProceedingGUID = a.TargetDeptGUID
            from #zz_ChangeDepartment  a
                join ys_DeptCostUseDtl b on b.DeptGUID = a.SourceDeptGUID

            -- 分摊费项实际使用审核信息
            update b
            set b.DeptGUID = a.TargetDeptGUID, b.DeptName = a.TargetDeptName
            from #zz_ChangeDepartment         a
                join ys_DeptCostUsedInfoForSH b on b.DeptGUID = a.SourceDeptGUID

            -- 年度部门科目预算
            -- update b set b.DeptGUID = a.TargetDeptGUID from #zz_ChangeDepartment a join ys_YearPlanDept2Cost b on b.DeptGUID = a.SourceDeptGUID

            -- 年度部门事项预算
            --update b set b.DeptGUID = a.TargetDeptGUID from #zz_ChangeDepartment a join ys_YearPlanProceeding2Cost b on b.DeptGUID = a.SourceDeptGUID


            -- fy_ExpenseType 报销类型 BUGUID
            -- fy_FKSPType 付款审批类型 BUGUID

            print '费用明细 END'
            ----------------------------------------------------------------------------------------------通用 END----------------------------------------------------------------------------------------------
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
        print  '未获取到预算部门GUID'
    end
drop table #zz_ChangeDepartment

