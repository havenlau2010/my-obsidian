create table #zz_FKSPType
(
    SourceCompanyGUID   uniqueidentifier   null,
    SourceCompanyName varchar(256)  not null,
    SourceTypeName varchar(256)     not null,
	SourceTypeCode varchar(256)     null,
	SourceTypeGUID uniqueidentifier null,
    SourceTypeClass varchar(256)     not null,
    TargetCompanyGUID  uniqueidentifier null,
    TargetCompanyName  varchar(256)     not null,
	TargetTypeName varchar(256)     not null,
	TargetTypeCode varchar(256)     null,
	TargetTypeGUID uniqueidentifier null,
)

insert into #zz_FKSPType(SourceCompanyName,SourceTypeName,TargetCompanyName,TargetTypeName,SourceTypeClass)
select '中山城市公司','城市公司一般诉讼案件立项'						,'湾区城市公司','城市公司一般诉讼案件立项','申请单类型' union all
select '中山城市公司','城市公司客户个体赔偿事件立项'					,'湾区城市公司','客户个体赔偿事件立项','申请单类型' union all
select '中山城市公司','城市公司重大诉讼案件立项'						,'湾区城市公司','城市公司重大诉讼案件立项','申请单类型' union all
select '中山城市公司','城市营销单项事务'								,'湾区城市公司','城市营销单项事务','申请单类型' union all
select '中山城市公司','备用金借款立项'									,'湾区城市公司','城市公司备用金借款立项','申请单类型' union all
select '中山城市公司','城市公司尽职调查申请'							,'湾区城市公司','城市公司尽职调查申请','申请单类型' union all
select '中山城市公司','城市品牌发布会（新进、省会、重点城市）立项'		,'湾区城市公司','城市品牌发布会（新进、省会、重点城市）立项','申请单类型' union all

select '中山城市公司','室内装修工程合同付款'							,'湾区城市公司','室内工程合同付款','合同付款类型' union all
select '中山城市公司','城市客服类合同付款'								,'湾区城市公司','城市客服类合同付款','合同付款类型' union all
select '中山城市公司','城市职能类合同付款'								,'湾区城市公司','城市职能类合同付款','合同付款类型' union all
select '中山城市公司','城市行政物资类合同付款'							,'湾区城市公司','城市行政物资类合同付款','合同付款类型' union all
select '中山城市公司','城市营销类合同付款'								,'湾区城市公司','城市营销类合同付款','合同付款类型' union all
select '中山城市公司','城市公司尽职调查类付款'							,'湾区城市公司','城市公司尽职调查类付款','合同付款类型' union all
select '中山城市公司','电商平台付款'									,'湾区城市公司','电商平台付款','合同付款类型' union all
select '中山城市公司','客户赔付付款申请'								,'湾区城市公司','城市公司客户赔付付款','合同付款类型' union all
select '中山城市公司','城市公司设计类合同付款'							,'湾区城市公司','设计类合同付款','合同付款类型' union all
select '中山城市公司','客户活动付款审批'								,'湾区城市公司','客户活动付款','合同付款类型' union all

select '中山城市公司','城市行政物资类单价执行协议付款'					,'湾区城市公司','城市行政物资类执行协议付款'					,'非合同付款类型' union all
select '中山城市公司','法务诉讼及相关费用付款'							,'湾区城市公司','法务诉讼及相关费用付款'						,'非合同付款类型' union all
select '中山城市公司','城市营销类单价执行协议付款'						,'湾区城市公司','城市营销类执行协议付款'						,'非合同付款类型' union all
select '中山城市公司','城市公司客户赔付无合同付款审批'					,'湾区城市公司','城市公司客户赔付无合同付款审批'				,'非合同付款类型' union all
select '中山城市公司','地区客户赔付付款申请'							,'湾区城市公司','城市公司客户赔付无合同付款审批'				,'非合同付款类型' union all
select '中山城市公司','城市客服类单价执行协议付款'						,'湾区城市公司','城市公司客户赔付无合同付款审批'				,'非合同付款类型' union all
select '中山城市公司','公积金医社保及相关费用付款'						,'湾区城市公司','公积金医社保及相关费用付款'					,'非合同付款类型' union all
select '中山城市公司','行政类无合同付款（油卡充值、水电、通信）'		,'湾区城市公司','行政类无合同付款（油卡充值、水电、通信）'		,'非合同付款类型' union all
select '中山城市公司','城市职能类单价执行协议付款','湾区城市公司'		,'城市职能类执行协议付款'				,'非合同付款类型' union all
select '中山城市公司','营销类京东采购付款'								,'湾区城市公司','电商平台付款'			,'非合同付款类型' union all
select '中山城市公司','城市公司设计类无合同付款'						,'湾区城市公司','设计类无合同付款'		,'非合同付款类型' union all

select '中山城市公司','城市公司薪资发放报销'							,'湾区城市公司','城市公司薪资发放'		,'日常报销类型' union all
select '中山城市公司','城市公司借款冲抵'								,'湾区城市公司','城市公司借款冲抵'		,'日常报销类型' union all
select '中山城市公司','城市出差费用报销'								,'湾区城市公司','城市出差费用报销'		,'日常报销类型' union all
select '中山城市公司','工程水电费代付'									,'湾区城市公司','片区工程水电费代付'		,'日常报销类型' union all
select '中山城市公司','城市定额类（车辆、通讯费等）'					,'湾区城市公司','城市定额类（车辆、通讯费等）','日常报销类型' union all
select '中山城市公司','城市其他类'										,'湾区城市公司','城市其他类'			,'日常报销类型' union all

select '中山城市公司','城市员工首付分期'								,'湾区城市公司','城市员工首付分期'		,'借款类型' union all
select '中山城市公司','城市备用金申请'									,'湾区城市公司','城市备用金申请'		,'借款类型' union all
select '中山城市公司','费用报销审批—城市公司'							,'湾区城市公司','城市备用金申请'		,'借款类型' union all
select '中山城市公司','项目付款审批（水费、电费等）'					,'湾区城市公司','城市备用金申请'		,'借款类型' union all
select '中山城市公司','城市公司备用金借款审批'							,'湾区城市公司','城市备用金申请'		,'借款类型' union all
select '中山城市公司','片区借款审批'									,'湾区城市公司','城市备用金申请'		,'借款类型' union all
select '中山城市公司','城市公司借款审批'								,'湾区城市公司','城市备用金申请'		,'借款类型' union all
select '中山城市公司','片区借款审批'									,'湾区城市公司','城市备用金申请'		,'借款类型'

update a set a.SourceCompanyGUID = b.BUGUID,a.TargetCompanyGUID = c.BUGUID,a.SourceTypeCode = d.FKSPTypeCode,a.SourceTypeGUID = d.FKSPTypeGUID,a.TargetTypeCode = e.FKSPTypeCode,a.TargetTypeGUID = e.FKSPTypeGUID
-- select a.SourceCompanyGUID , b.BUGUID,a.TargetCompanyGUID , c.BUGUID,a.SourceTypeCode , d.FKSPTypeCode,a.SourceTypeGUID , d.FKSPTypeGUID,a.TargetTypeCode , e.FKSPTypeCode,a.TargetTypeGUID , e.FKSPTypeGUID
from #zz_FKSPType a
left join myBusinessUnit b on a.SourceCompanyName = b.BUName and b.IsCompany = 1
left join myBusinessUnit c on a.TargetCompanyName = c.BUName and c.IsCompany = 1
join fy_FKSPType d on a.SourceTypeName = d.FKSPTypeName and a.SourceTypeClass = d.FKSPClass and d.BUGUID = b.BUGUID
left join fy_FKSPType e on a.TargetTypeName = e.FKSPTypeName and a.SourceTypeClass = e.FKSPClass and e.BUGUID = c.BUGUID
-- where 1 = 2

if not exists(select *
          from #zz_FKSPType where TargetTypeGUID is null and SourceTypeGUID is not null)
    begin
        begin tran
            begin
			
			-- select * from fy_Apply where ApplyTypeGUID in (select SourceTypeGUID from #zz_FKSPType where SourceTypeClass = '申请单类型')
			-- 申请单类型
			-- select a.SourceTypeGUID,a.SourceTypeName,b.ApplyTypeGUID,b.ApplyType,a.TargetTypeGUID,a.TargetTypeName from #zz_FKSPType a join fy_Apply b on b.ApplyTypeGUID = a.SourceTypeGUID and a.SourceTypeClass = '申请单类型'
			update b set b.ApplyTypeGUID = a.TargetTypeGUID,b.ApplyType = a.TargetTypeName from #zz_FKSPType a join fy_Apply b on b.ApplyTypeGUID = a.SourceTypeGUID and a.SourceTypeClass = '申请单类型'
			print '申请单类型 END'

			-- select * from cb_Expense where ExpenseTypeGUID in ( select SourceTypeGUID from #zz_FKSPType where SourceTypeClass = '日常报销类型')
			-- 日常报销类型
			-- select a.SourceTypeGUID,a.SourceTypeName,b.ExpenseTypeGUID,b.ExpenseTypeName,a.TargetTypeGUID,a.TargetTypeName from #zz_FKSPType a join cb_Expense b on b.ExpenseTypeGUID = a.SourceTypeGUID and a.SourceTypeClass = '日常报销类型'
			update b set b.ExpenseTypeGUID = a.TargetTypeGUID,b.ExpenseTypeName = a.TargetTypeName from #zz_FKSPType a join cb_Expense b on b.ExpenseTypeGUID = a.SourceTypeGUID and a.SourceTypeClass = '日常报销类型'
			print '日常报销类型 END'

			-- select * from cb_Loan where LoanTypeGUID in ( select SourceTypeGUID from #zz_FKSPType where SourceTypeClass = '借款类型')
			-- 借款类型
			-- select a.SourceTypeGUID,a.SourceTypeName,b.LoanTypeGUID,b.LoanTypeName,a.TargetTypeGUID,a.TargetTypeName from #zz_FKSPType a join cb_Loan b on b.LoanTypeGUID = a.SourceTypeGUID
			update b set b.LoanTypeGUID = a.TargetTypeGUID,b.LoanTypeName = a.TargetTypeName from #zz_FKSPType a join cb_Loan b on b.LoanTypeGUID = a.SourceTypeGUID and a.SourceTypeClass = '借款类型'
			print '借款类型 END'

			-- 合同付款类型
			-- select * from cb_HTFKApply where ApplyTypeGUID in ( select SourceTypeGUID from #zz_FKSPType )
			-- select a.SourceTypeGUID,a.SourceTypeName,b.ApplyTypeGUID,b.ApplyTypeName,a.TargetTypeGUID,a.TargetTypeName from #zz_FKSPType a join cb_HTFKApply b on b.ApplyTypeGUID = a.SourceTypeGUID
			update b set b.ApplyTypeGUID = a.TargetTypeGUID,b.ApplyTypeName = a.TargetTypeName from #zz_FKSPType a join cb_HTFKApply b on b.ApplyTypeGUID = a.SourceTypeGUID 
			print '合同付款类型 END'
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
        print  '未获取到目标公司申请单类型、付款审批类型'
    end
drop table #zz_FKSPType

