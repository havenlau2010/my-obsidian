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
select '中山城市公司','中山项目工程部'		,'湾区城市公司',	'湾区项目工程部' union all
select '中山城市公司','中山帝泊湾工程部'	,'湾区城市公司',	'中山帝泊湾项目工程部' union all
select '中山城市公司','珠海新力湾工程部'	,'湾区城市公司',	'珠海新力湾花园项目工程部' union all
select '中山城市公司','中山翡翠湾工程部'	,'湾区城市公司',	'中山翡翠湾工程项目部' union all

select '中山城市公司','中山钰珑湾工程部'	,'湾区城市公司',	'中山钰珑湾项目工程部' union all
select '中山城市公司','空'					,'湾区城市公司',	'湾区营销管理部' union all
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

if not exists(select 1
          from #zz_ChangeBU where SourceBUGUID is null or SourceCompanyGUID is null or TargetBUGUID is null or TargetCompanyGUID is null)
    begin
        begin tran
            begin

--费用财务账套

-- 使用项目
update b set b.BUGUID = a.TargetCompanyGUID 
from ( select distinct SourceCompanyGUID,SourceCompanyName,TargetCompanyGUID,TargetCompanyName from #zz_ChangeBU ) a  
join p_CwjkProject b on b.BUGUID = a.SourceCompanyGUID
print '使用项目 END'

-- 使用供应商表
update b set b.BUGUID = a.TargetCompanyGUID 
from ( select distinct SourceCompanyGUID,SourceCompanyName,TargetCompanyGUID,TargetCompanyName from #zz_ChangeBU ) a  
join ys_CwjkDeptProvider b on b.BUGUID = a.SourceCompanyGUID
print '使用供应商表 END'

-- 账套表
update b set b.BUGUID = a.TargetCompanyGUID 
from ( select distinct SourceCompanyGUID,SourceCompanyName,TargetCompanyGUID,TargetCompanyName from #zz_ChangeBU ) a
join p_CwjkCwzt b on b.BUGUID = a.SourceCompanyGUID
print '账套表 END'

--辅助核算对照表
-- select b.BUGUID , a.TargetCompanyGUID ,b.ObjectGUID,c.SourceBUGUID,c.TargetBUGUID,b.ObjectName,c.SourceBUName,c.TargetBUName
update b set b.BUGUID = a.TargetCompanyGUID ,b.ObjectGUID = c.TargetBUGUID, b.ObjectName = c.TargetBUName
from ( select distinct SourceCompanyGUID,SourceCompanyName,TargetCompanyGUID,TargetCompanyName from #zz_ChangeBU ) a 
join p_CwjkHsxmMap b on b.BUGUID = a.SourceCompanyGUID 
join p_CwjkHsxm d ON b.HsTypeGUID = d.HsTypeGUID AND b.CwztGUID = d.CwztGUID and d.OperObject = '部门'
join #zz_ChangeBU c on b.ObjectGUID = c.SourceBUGUID
print '辅助核算对照表 END'

--会计科目
update b set b.BUGUID = a.TargetCompanyGUID
from ( select distinct SourceCompanyGUID,SourceCompanyName,TargetCompanyGUID,TargetCompanyName from #zz_ChangeBU ) a
join p_CwjkKjkm b on b.BUGUID = a.SourceCompanyGUID
print '会计科目 END'

--会计科目选项
update b set b.BUGUID = a.TargetCompanyGUID
from ( select distinct SourceCompanyGUID,SourceCompanyName,TargetCompanyGUID,TargetCompanyName from #zz_ChangeBU ) a
join p_CwjkKjkm2OperData b on b.BUGUID = a.SourceCompanyGUID
print '会计科目选项 END'

--凭证
update b set b.BUGUID = a.TargetCompanyGUID
from ( select distinct SourceCompanyGUID,SourceCompanyName,TargetCompanyGUID,TargetCompanyName from #zz_ChangeBU ) a
join p_CwjkPz b on b.BUGUID = a.SourceCompanyGUID
print '凭证 END'

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