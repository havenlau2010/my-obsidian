create table #zz_ChangeBU
(
    SourceBUGUID  uniqueidentifier null,
    SourceBUCode  varchar(256)   null,
    SourceBUName varchar(256)  not null,
    SourceCompanyGUID uniqueidentifier  ,
    SourceCompanyName varchar(256)     not null,
    TargetBUGUID    uniqueidentifier null,
    TargetBUCode  varchar(256)   null,
    TargetBUName  varchar(256)  not null,
    TargetCompanyGUID  uniqueidentifier null,
    TargetCompanyName varchar(256)     not null
)

insert into  #zz_ChangeBU( SourceCompanyName, SourceBUName, TargetCompanyName,  TargetBUName )
-------迁移前所在公司--迁移前所在组织--------迁移后所在公司--迁移前所在组织
select '中山城市公司','中山总经办'			,'湾区城市公司',	'湾区总经办' union all
select '中山城市公司','中山人力行政部'		,'湾区城市公司',	'湾区人力行政部' union all
select '中山城市公司','中山运营管理部'		,'湾区城市公司',	'湾区运营管理部' union all
select '中山城市公司','中山财务管理部'		,'湾区城市公司',	'湾区财务管理部' union all
select '中山城市公司','中山投资拓展部'		,'湾区城市公司',	'湾区投资拓展部' union all

select '中山城市公司','中山成本管理部'		,'湾区城市公司',	'湾区成本管理部' union all
select '中山城市公司','中山法务部'	    	,'湾区城市公司',	'湾区法务部' union all
select '中山城市公司','中山开发报建部'		,'湾区城市公司',	'湾区开发报建部' union all
select '中山城市公司','中山客户关系部'		,'湾区城市公司',	'湾区客户关系部' union all
select '中山城市公司','中山工程管理部'		,'湾区城市公司',	'湾区工程管理部' union all

select '中山城市公司','中山设计部'	    	,'湾区城市公司',	'湾区设计管理部' union all
select '中山城市公司','中山项目工程部'		,'湾区城市公司',	'湾区工程管理部' union all
select '中山城市公司','中山帝泊湾工程部'	,'湾区城市公司',	'中山帝泊湾项目工程部' union all
select '中山城市公司','珠海新力湾工程部'	,'湾区城市公司',	'珠海新力湾花园项目工程部' union all
select '中山城市公司','中山翡翠湾工程部'	,'湾区城市公司',	'中山翡翠湾工程项目部' union all

select '中山城市公司','中山钰珑湾工程部'	,'湾区城市公司',	'中山钰珑湾项目工程部' union all
select '中山城市公司','空'				   ,'湾区城市公司',	   '湾区营销管理部' union all
select '中山城市公司','中山营销管理部'		,'湾区城市公司',	'湾区营销管理部' union all
select '中山城市公司','中山帝泊湾营销部'	,'湾区城市公司',	'中山帝泊湾项目营销部' union all
select '中山城市公司','珠海新力湾营销部'	,'湾区城市公司',	'珠海新力湾花园项目营销部' union all

select '中山城市公司','中山翡翠湾营销部'	,'湾区城市公司',	'中山翡翠湾项目营销部' union all
select '中山城市公司','中山钰珑湾营销部'	,'湾区城市公司',	'中山钰珑湾项目营销部'

update a set
a.SourceBUGUID = d.BUGUID,a.SourceBUCode = d.BUCode,a.SourceCompanyGUID = b.BUGUID
,a.TargetBUGUID = e.BUGUID,a.TargetBUCode = e.BUCode,a.TargetCompanyGUID = c.BUGUID
-- select a.SourceBUGUID , d.BUGUID,a.SourceBUCode , d.BUCode,a.SourceCompanyGUID , b.BUGUID,a.TargetBUGUID , e.BUGUID,a.TargetBUCode, e.BUCode,a.TargetCompanyGUID ,c.BUGUID
from #zz_ChangeBU a
    join  myBusinessUnit b on b.BUName = a.SourceCompanyName and b.IsCompany = 1
    join  myBusinessUnit c on  c.BUName = a.TargetCompanyName and c.IsCompany = 1
    join  mybusinessUnit d on d.BUName = a.SourceBUName and d.IsCompany = 0 and d.HierarchyCode like b.HierarchyCode+'.%'
    join  mybusinessUnit e on e.BUName = a.TargetBUName and e.IsCompany = 0 and e.HierarchyCode like c.HierarchyCode+'.%'
-- where 1 = 2
-- select * from #zz_ChangeBU
if not exists(select 1
          from #zz_ChangeBU where SourceBUGUID is null or SourceCompanyGUID is null or TargetBUGUID is null or TargetCompanyGUID is null )
    begin
        begin tran
            begin
            ---------------------------------------------------------------------------------------------- 申请单 BEGIN----------------------------------------------------------------------------------------------
            -- 申请单
            update b
            set b.DeptGUID = a.TargetBUGUID, b.DeptName = a.TargetBUName
            from #zz_ChangeBU  a join fy_Apply b on b.DeptGUID = a.SourceBUGUID
            print '申请单 completed'
            ---------------------------------------------------------------------------------------------- 申请单 END----------------------------------------------------------------------------------------------

            ---------------------------------------------------------------------------------------------- 合同 BEGIN----------------------------------------------------------------------------------------------
            -- 费用合同
            update b
            set b.DeptGUID = a.TargetBUGUID
            from #zz_ChangeBU  a join cb_Contract b on b.DeptGUID = a.SourceBUGUID and IsFyControl = 1
            print '费用合同 completed'
            ---------------------------------------------------------------------------------------------- 合同 END----------------------------------------------------------------------------------------------

            ---------------------------------------------------------------------------------------------- 费用合同结算 BEGIN----------------------------------------------------------------------------------------------
            -- 费用合同结算
            update b
            set b.JbDeptGUID = a.TargetBUGUID,b.JbDeptName = a.TargetBUName
            from #zz_ChangeBU  a join cb_HTBalance b on b.JbDeptGUID = a.SourceBUGUID join cb_Contract c on c.ContractGUID = b.ContractGUID and IsFyControl = 1
            print '费用合同结算 completed'
            ---------------------------------------------------------------------------------------------- 费用合同结算 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------付款计划 BEGIN----------------------------------------------------------------------------------------------
            /*
            没有经办部门GUID，取同公司下的部门编码去匹配
            */
            update b set b.BUGUID = a.TargetCompanyGUID,b.DeptCode = a.TargetBUCode
            from #zz_ChangeBU  a join cb_HTFKPlan b on b.DeptCode = a.SourceBUCode and b.BUGUID = a.TargetCompanyGUID join cb_Contract c on c.ContractGUID = b.ContractGUID and IsFyControl = 1
            print '付款计划 completed'
            ----------------------------------------------------------------------------------------------付款计划 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------付款申请 BEGIN----------------------------------------------------------------------------------------------
            update b set b.BUGUID = a.TargetCompanyGUID,b.ApplyBUGUID = a.TargetBUGUID
            from #zz_ChangeBU  a join cb_HTFKApply b on b.ApplyBUGUID = a.SourceBUGUID join cb_Contract c on c.ContractGUID = b.ContractGUID and IsFyControl = 1
            print '付款申请 completed'
            ----------------------------------------------------------------------------------------------付款申请 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------执行单 BEGIN----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------执行单 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------日常报销 BEGIN----------------------------------------------------------------------------------------------
            update b set b.BUGUID = a.TargetCompanyGUID,b.ApplyBUGUID = a.TargetBUGUID
            from #zz_ChangeBU  a join cb_Expense b on b.ApplyBUGUID = a.SourceBUGUID
            print '日常报销 completed'
            ----------------------------------------------------------------------------------------------日常报销 END----------------------------------------------------------------------------------------------


            ----------------------------------------------------------------------------------------------借款申请 BEGIN----------------------------------------------------------------------------------------------
            -- 借款单 -- 组织架构
            update b set b.BUGUID = a.TargetCompanyGUID,b.ApplyBUGUID = a.TargetBUGUID
            from #zz_ChangeBU  a join cb_Loan b on b.ApplyBUGUID = a.SourceBUGUID
            print '借款申请 completed'
            ----------------------------------------------------------------------------------------------借款申请 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------还款申请 BEGIN----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------还款申请 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------薪酬管理 BEGIN----------------------------------------------------------------------------------------------
            update b set b.BUGUID = a.TargetCompanyGUID,b.DeptGUID = a.TargetBUGUID
            from #zz_ChangeBU  a join fy_Emolument b on b.DeptGUID = a.SourceBUGUID
            print '薪酬管理 completed'
            ----------------------------------------------------------------------------------------------薪酬管理 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------付款登记 BEGIN----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------付款登记 END----------------------------------------------------------------------------------------------

            ----------------------------------------------------------------------------------------------通用 BEGIN----------------------------------------------------------------------------------------------

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
drop table #zz_ChangeBU

