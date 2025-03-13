use dotnet_erp60;

select *
from dbo.fy_BzCostTemplate;

-- 基础设置===>>> 标准科目库列表：
SELECT fy_BzCostTemplate.[BzCostTemplateName]                           AS [BzCostTemplateName],
       fy_BzCostTemplate.[Remarks]                                      AS [Remarks],
       fy_BzCostTemplate.[CreatedName]                                  AS [CreatedName],
       fy_BzCostTemplate.[CreatedTime]                                  AS [CreatedTime],
       fy_BzCostTemplate.[BzCostTemplateGUID]                           AS [BzCostTemplateGUID],
       fy_BzCostTemplate.[IsEnable]                                     AS [IsEnable],
       (CASE fy_BzCostTemplate.IsEnable WHEN 1 THEN '启用' ELSE '禁用' END) AS [IsEnableText]
FROM (SELECT *
      FROM (SELECT ROW_NUMBER() OVER (ORDER BY fy_BzCostTemplate.[CreatedTime] DESC ) AS num,
                   fy_BzCostTemplate.[BzCostTemplateGUID]                             AS [fy_BzCostTemplate.BzCostTemplateGUID]
            FROM dbo.fy_BzCostTemplate WITH (NOLOCK)
            WHERE (1 = 1)) AS t
      WHERE num BETWEEN 1 AND 20) AS main
         INNER JOIN dbo.fy_BzCostTemplate WITH (NOLOCK)
                    ON main.[fy_BzCostTemplate.BzCostTemplateGUID] = fy_BzCostTemplate.BzCostTemplateGUID
ORDER BY main.num;

-- 基础设置===>>> 科目设置===>>> 管理科目
go
declare @buGuid uniqueidentifier,@appCode varchar(100)
select @buGuid = BUGUID, @appCode = BuCode
from dbo.myBusinessUnit
where BUName = '武汉公司（产品演示）';
SELECT fy_Cost.[CostName]                                    AS [CostName],
       fy_Cost.[CostFullCode]                                AS [CostFullCode],
       fy_Cost.[DecisionAnalysisLevel]                       AS [DecisionAnalysisLevel],
       fy_Cost.[CostType]                                    AS [CostType],
       fy_Cost.[IsCheck]                                     AS [IsCheck],
       fy_Cost.[IsMarketType]                                AS [IsMarketType],
       fy_Cost.[RelatedMediaTypeName]                        AS [RelatedMediaTypeName],
       fy_Cost.[Remarks]                                     AS [Remarks],
       fy_Cost.[IsEnd]                                       AS [IsEnd],
       fy_Cost.[CostGUID]                                    AS [CostGUID],
       fy_Cost.[ParentGUID]                                  AS [ParentGUID],
       fy_Cost.[HierarchyCode]                               AS [HierarchyCode],
       fy_Cost.[IsDisable]                                   AS [IsDisable],
       (CASE fy_Cost.IsDisable WHEN 1 THEN '禁用' ELSE '' END) AS [IsDisableText]
FROM dbo.fy_Cost WITH (NOLOCK)
         INNER JOIN dbo.myBusinessUnit _projFilter WITH (NOLOCK)
                    ON _projFilter.BUGUID = fy_Cost.BUGUID AND fy_Cost.BUGUID = @buGuid
WHERE (1 = 1)
ORDER BY fy_Cost.[HierarchyCode] ASC;

-- 基础设置===>>> 科目设置===>>> 财务科目
go
declare @buGuid uniqueidentifier,@appCode varchar(100)
select @buGuid = BUGUID, @appCode = BuCode
from dbo.myBusinessUnit
where BUName = '武汉公司（产品演示）';
SELECT fy_FinanceCost.[FinanceCostName]                             AS [FinanceCostName],
       fy_FinanceCost.[FinanceCostFullCode]                         AS [FinanceCostFullCode],
       fy_FinanceCost.[DecisionAnalysisLevel]                       AS [DecisionAnalysisLevel],
       fy_FinanceCost.[CostNames]                                   AS [CostNames],
       fy_FinanceCost.[CostType]                                    AS [CostType],
       fy_FinanceCost.[Remarks]                                     AS [Remarks],
       fy_FinanceCost.[FinanceCostGUID]                             AS [FinanceCostGUID],
       fy_FinanceCost.[ParentGUID]                                  AS [ParentGUID],
       fy_FinanceCost.[HierarchyCode]                               AS [HierarchyCode],
       fy_FinanceCost.[IsDisable]                                   AS [IsDisable],
       (CASE fy_FinanceCost.IsDisable WHEN 1 THEN '禁用' ELSE '' END) AS [IsDisableText]
FROM dbo.fy_FinanceCost WITH (NOLOCK)
         INNER JOIN dbo.myBusinessUnit _projFilter WITH (NOLOCK) ON _projFilter.BUGUID = fy_FinanceCost.BUGUID AND
                                                                fy_FinanceCost.BUGUID = @buGuid
WHERE (1 = 1)
ORDER BY fy_FinanceCost.[HierarchyCode] ASC;

-- 基础设置===>>> 项目概况
go
declare @buGuid uniqueidentifier,@appCode varchar(100)
select @buGuid = BUGUID, @appCode = BuCode
from dbo.myBusinessUnit
where BUName = '武汉公司（产品演示）';
SELECT o.p_projectId                                                                  as ProjectId,
       o.ProjCode                                                                     as ProjectCode,
       o.ProjShortName                                                                as ProjectName,
       o.ParentGuid,
       (CASE WHEN o.IfEnd = 0 THEN 1 ELSE 0 END)                                      AS IsHasStage,
       o.BUGUID,
       o.ProjName                                                                     as ProjectFullName,
       mu.UserName                                                                    AS PrincipalName,
       o.IsEndCase                                                                    as IsEndCase,
       (CASE WHEN o.IsEndCase = 0 THEN '否' WHEN o.IsEndCase = 1 THEN '是' ELSE '' END) AS IsEndCaseText,
       o.HierarchyCode,
       @appCode                                                                       AS [Application],
       CASE WHEN o.ParentGuid IS NULL THEN 0 ELSE 1 END                               AS IsStage,
       o.SpreadName
FROM dbo.p_project                          o
         LEFT JOIN dbo.vp_interface_project p ON o.ParentGUID = p.ProjectId
         LEFT JOIN dbo.myUser AS            mu ON o.Principal = mu.UserGUID
WHERE o.BUGUID = @buGuid
  AND ISNUll(o.ApplySys,'') LIKE '%' + @appCode + '%'
ORDER BY o.HierarchyCode

-- 基础设置===>>> 费用承担主体
go
declare @buGuid uniqueidentifier
select @buGuid = BUGUID from dbo.myBusinessUnit where BUName = '武汉公司（产品演示）';
SELECT fy_SpecialBusinessUnit.[SpecialBusinessUnitName]                     AS [SpecialBusinessUnitName],
       fy_SpecialBusinessUnit.[FyStationName]                               AS [FyStationName],
       fy_SpecialBusinessUnit.[ProjectListNames]                            AS [ProjectListNames],
       fy_SpecialBusinessUnit.[IsDisable]                                   AS [IsDisable],
       fy_SpecialBusinessUnit.[IsEnd]                                       AS [IsEnd],
       fy_SpecialBusinessUnit.[SpecialBusinessUnitGUID]                     AS [SpecialBusinessUnitGUID],
       fy_SpecialBusinessUnit.[ParentGUID]                                  AS [ParentGUID],
       fy_SpecialBusinessUnit.[HierarchyCode]                               AS [HierarchyCode],
       (CASE fy_SpecialBusinessUnit.IsDisable WHEN 1 THEN '禁用' ELSE '' END) AS [IsDisabledText]
FROM dbo.fy_SpecialBusinessUnit WITH (NOLOCK)
         INNER JOIN dbo.myBusinessUnit _projFilter WITH (NOLOCK)
                    ON _projFilter.BUGUID = fy_SpecialBusinessUnit.BUGUID AND
                       fy_SpecialBusinessUnit.BUGUID = '21b01919-f243-e911-aab8-00155d0a0915'
WHERE (1 = 1)
ORDER BY fy_SpecialBusinessUnit.[HierarchyCode] ASC

-- 基础设置===>>> 费用承担主体===>>> 关联科目
GO
DECLARE @specialBUGuid UNIQUEIDENTIFIER;
select @specialBUGuid = SpecialBusinessUnitGUID from dbo.fy_SpecialBusinessUnit where SpecialBusinessUnitName = '营销管理中心';
SELECT fSBU.FyStationName,fSBU.SpecialBusinessUnitName,fSBU.ProjGUID,fSBU.ProjectListGUIDs,fC.CostName,fC.CostFullName
FROM dbo.fy_SpecialBusinessUnit fSBU
         LEFT JOIN dbo.fy_SpecialBusinessUnit2Cost fSBU2C
                   ON fSBU2C.SpecialBusinessUnitGUID = fSBU.SpecialBusinessUnitGUID
         LEFT JOIN dbo.fy_Cost fC ON fC.CostGUID = fSBU2C.CostGUID
WHERE fSBU.SpecialBusinessUnitGUID = @specialBUGuid
order by fC.HierarchyCode asc;

-- 查询某个公司的科目模板
go
declare @buGUID uniqueidentifier = '555F6791-0359-42D1-003B-08D82A1D134E'
select *
from dbo.fy_BzCostTemplate2Company tc
         join dbo.fy_BzCostTemplate t on tc.BzCostTemplateGUID = t.BzCostTemplateGUID
where BUGUID = @buGUID;
go

-- 查询该科目模板下的所有管理科目
go
declare @templateGUID uniqueidentifier = '77A91FCE-1913-0109-7F77-39F372936EB0';
select *
from dbo.fy_BzCostTemplate t
         left join dbo.fy_BzCost c on c.BzCostTemplateGUID = t.BzCostTemplateGUID
where t.BzCostTemplateGUID = @templateGUID;
go

-- 查询该科目模板下的所有财务科目
go
declare @templateGUID uniqueidentifier = '77A91FCE-1913-0109-7F77-39F372936EB0';
select *
from dbo.fy_BzCostTemplate t
         left join dbo.fy_BzFinanceCost c on c.BzCostTemplateGUID = t.BzCostTemplateGUID
where t.BzCostTemplateGUID = @templateGUID;
go

-- 查询该科目模板下的所有管理科目 及其 对应的财务科目
go
declare @templateGUID uniqueidentifier = '77A91FCE-1913-0109-7F77-39F372936EB0';
select  t.BzCostTemplateGUID,t.BzCostTemplateName,c.BzCostGUID,c.BzCostName,c.HierarchyCode,fc.BzFinanceCostGUID,fc.BzFinanceCostName
from dbo.fy_BzCostTemplate t
         left join dbo.fy_BzCost c on c.BzCostTemplateGUID = t.BzCostTemplateGUID
         left join dbo.fy_BzFinanceCost2BzCost fc2c on fc2c.BzCostGUID = c.BzCostGUID
         left join dbo.fy_BzFinanceCost fc on fc.BzFinanceCostGUID = fc2c.BzFinanceCostGUID
where t.BzCostTemplateGUID = @templateGUID
order by c.HierarchyCode
;
go


-- 新增费用承担主体 -- 选择项目列表
SELECT p_Project.[ProjName]      AS [ProjName],
       p_Project.[IsUsed]        AS [IsUsed],
       p_Project.[p_projectId]   AS [p_projectId],
       p_Project.[ParentGUID]    AS [ParentGUID],
       p_Project.[HierarchyCode] AS [HierarchyCode]
FROM dbo.p_Project WITH (NOLOCK)
         INNER JOIN dbo.vp_interface_UserProjectRight as _resFilter_vp_interface_UserProjectRight WITH (NOLOCK)
                    ON p_Project.p_projectId = _resFilter_vp_interface_UserProjectRight.p_projectId AND
                       _resFilter_vp_interface_UserProjectRight.UserGUID = null
ORDER BY p_Project.[HierarchyCode] ASC

-- 费用承担主体
select SpecialBusinessUnitGUID,SpecialBusinessUnitName,ProjGUID,ProjectListGUIDs,ProjectListNames
from dbo.fy_SpecialBusinessUnit
where SpecialBusinessUnitName = '开发间接费'
  and ParentGUID =
      (select top 1 SpecialBusinessUnitGUID from dbo.fy_SpecialBusinessUnit where SpecialBusinessUnitName = '翡翠天地');

-- 业务授权
go
declare @roleGUID uniqueidentifier
select @roleGUID = myStandardRoleId from dbo.myStandardRole where StandardRoleName = '一线体验角色'
SELECT fy_PayApprovalTypeGroup.[TypeName]                       AS [TypeName],
       fy_DataAuthPayApprovalType.[PayApprovalTypeGroupGUID]    AS [PayApprovalTypeGroupGUID],
       fy_PayApprovalTypeGroup.[ParentGUID]                     AS [ParentGUID],
       fy_PayApprovalTypeGroup.[HierarchyCode]                  AS [HierarchyCode],
       fy_DataAuthPayApprovalType.[DataAuthPayApprovalTypeGUID] AS [DataAuthPayApprovalTypeGUID]
FROM dbo.fy_DataAuthPayApprovalType WITH (NOLOCK)
         INNER JOIN dbo.fy_PayApprovalTypeGroup WITH (NOLOCK) ON fy_DataAuthPayApprovalType.PayApprovalTypeGroupGUID =
                                                             fy_PayApprovalTypeGroup.PayApprovalTypeGroupGUID
WHERE (fy_DataAuthPayApprovalType.StandardRoleGUID = @roleGUID)
ORDER BY fy_PayApprovalTypeGroup.[HierarchyCode] ASC

-- 参数设置 - 集团 - 供应商类别

-- 项目全盘预算管理

go
declare @buGuid uniqueidentifier, @YearGUID uniqueidentifier,@ProjGUID uniqueidentifier
select @ProjGUID = p_projectId from dbo.p_Project where ProjName = '百合花园（产品演示数据）'
select @buGuid = BUGUID from dbo.myBusinessUnit where BUName = '武汉公司（产品演示）';
SELECT
costs.CostGUID,
costs.HierarchyCode,
occurredAmounts.YearMonth,
ISNULL(occurredAmounts.OccurredAmount,0) AS OccurredAmount
FROM
(
	SELECT a.CostGUID,h.HierarchyCode,h.BUGUID
	FROM dbo.fy_ProjectBudgetControlCenter a WITH (NOLOCK)
	LEFT JOIN dbo.fy_Cost h WITH(NOLOCK)
	ON a.CostGUID = h.CostGUID
	WHERE a.ProjGUID = @ProjGUID AND a.BudgetIsEndCost = 1
) costs
OUTER APPLY
(
	SELECT
  e.YearMonth,
  SUM(e.OccurredCaliberAmount) AS OccurredAmount
	FROM  dbo.fy_YearBudgetPoise e WITH(NOLOCK)
	WHERE e.SpecialBusinessUnitGUID IN (
		SELECT u.SpecialBusinessUnitGUID
		FROM dbo.fy_SpecialBusinessUnit u WITH(NOLOCK)
		WHERE u.ProjGUID = @ProjGUID AND u.IsEnd = 1
	)
	AND e.CostGUID IN (
		SELECT g.CostGUID FROM dbo.fy_cost g WITH(NOLOCK)
		WHERE g.BUGUID = costs.BUGUID AND g.HierarchyCode LIKE costs.HierarchyCode + '%' AND g.IsEnd = 1
	)
	AND e.YearMonth >= '2020/1/1 0:00:00' AND e.YearMonth <= '2022/12/31 23:59:59'
  GROUP BY e.YearMonth
) occurredAmounts;

SELECT costs.CostGUID,
       costs.HierarchyCode,
       occurredAmounts.YearMonth,
       ISNULL(occurredAmounts.OccurredAmount,0) AS OccurredAmount
FROM (SELECT a.CostGUID, h.HierarchyCode, h.BUGUID
      FROM dbo.fy_ProjectBudgetControlCenter a WITH (NOLOCK)
               LEFT JOIN dbo.fy_Cost         h WITH (NOLOCK) ON a.CostGUID = h.CostGUID
      WHERE a.ProjGUID = @ProjGUID
        AND a.BudgetIsEndCost = 1)          costs
         OUTER APPLY (SELECT e.YearMonth, SUM(e.OccurredCaliberAmount) AS OccurredAmount
                      FROM dbo.fy_YearBudgetPoise e WITH (NOLOCK)
                      WHERE e.SpecialBusinessUnitGUID IN (SELECT u.SpecialBusinessUnitGUID
                                                          FROM fy_SpecialBusinessUnit u WITH (NOLOCK)
                                                          WHERE u.ProjGUID = @ProjGUID AND u.IsEnd = 1)
                        AND e.CostGUID IN (SELECT g.CostGUID
                                           FROM fy_cost g WITH (NOLOCK)
                                           WHERE g.BUGUID = costs.BUGUID
                                             AND g.HierarchyCode LIKE costs.HierarchyCode + '%'
                                             AND g.IsEnd = 1)
                        AND e.YearMonth >= @BeginDate
                        AND e.YearMonth <= @EndDate
                      GROUP BY e.YearMonth) occurredAmounts




select * from (SELECT YearGUID AS [value], YEAR AS [text],CASE WHEN GETDATE() BETWEEN StartDate AND EndDate THEN 'true' ELSE 'false' END AS isdefault
FROM dbo.fy_Year ) t ORDER BY  [text] DESC

-- 全盘预算控制方式
go
declare @ProjGUID uniqueidentifier  = 'F76D6D57-8844-E911-AAB8-00155D0A0915',@BUGUID uniqueidentifier = '21B01919-F243-E911-AAB8-00155D0A0915';
SELECT fy_Cost.[CostName]                                             AS [CostName],
       fy_Cost.[IsDisable]                                            AS [IsDisable],
       fy_ProjectBudgetControlCenter.[ControlModeEnum]                AS [ControlModeEnum],
       fy_ProjectBudgetControlCenter.[ControlMode]                    AS [ControlMode],
       fy_ProjectBudgetControlCenter.[IsBudget]                       AS [IsBudget],
       vPBCIHD.[HasData]                                              AS [HasData],
       fy_Cost.[BUGUID]                                               AS [BUGUID],
       fy_Cost.[BzCostGUID]                                           AS [BzCostGUID],
       fy_Cost.[ParentGUID]                                           AS [ParentGUID],
       fy_Cost.[CostGUID]                                             AS [CostGUID],
       fy_ProjectBudgetControlCenter.[ProjectBudgetControlCenterGUID] AS [ProjectBudgetControlCenterGUID],
       fy_Cost.[HierarchyCode]                                        AS [HierarchyCode]
FROM dbo.fy_Cost WITH (NOLOCK)
         LEFT JOIN dbo.fy_ProjectBudgetControlCenter WITH (NOLOCK)
                   ON fy_Cost.CostGUID = fy_ProjectBudgetControlCenter.CostGUID And
                      fy_ProjectBudgetControlCenter.[BUGUID] = fy_Cost.BUGUID
         INNER JOIN dbo.p_Project _projFilter WITH (NOLOCK)
                    ON _projFilter.p_projectId = fy_ProjectBudgetControlCenter.ProjGUID AND
                       fy_ProjectBudgetControlCenter.ProjGUID = @ProjGUID
         LEFT JOIN dbo.vfy_ProjectBudgetCostIsHasData vPBCIHD WITH (NOLOCK)
                   ON fy_Cost.CostGUID = vPBCIHD.CostGUID And
                      vPBCIHD.[ProjGUID] = @ProjGUID
WHERE (fy_Cost.BUGUID = @BUGUID and fy_Cost.IsDisable = 0)
ORDER BY fy_Cost.[HierarchyCode] ASC;

-- 合同立项分页列表
SELECT fy_ContractItem.[Name]                       AS [Name],
       vfy_BusinessSource.[SourceFullName]          AS [SourceFullName],
       fy_ContractItem.[SignType]                   AS [SignType],
       fy_ContractItem.[UrgencyDegree]              AS [UrgencyDegree],
       fy_ContractItem.[SecrecyRank]                AS [SecrecyRank],
       fy_ContractItem.[EstimateAmount_Bz]          AS [EstimateAmount_Bz],
       fy_ContractItem.[BzName]                     AS [BzName],
       fy_ContractItem.[ApproveState]               AS [ApproveState],
       fy_ContractItem.[IsAbort]                    AS [IsAbort],
       fy_ContractItem.[LaunchTime]                 AS [LaunchTime],
       fy_ContractItem.[ApplierName]                AS [ApplierName],
       fy_ContractItem.[ApproveStateEnum]           AS [ApproveStateEnum],
       fy_ContractItem.[IsRlevance]                 AS [IsRlevance],
       fy_ContractItem.[BzUnit]                     AS [BzUnit],
       fy_ContractItem.[IsForeignCurrencyEnabled]   AS [IsForeignCurrencyEnabled],
       fy_ContractItem.[Rate]                       AS [Rate],
       fy_ContractItem.[SecrecyRankEnum]            AS [SecrecyRankEnum],
       fy_ContractItem.[ContractItemGUID]           AS [ContractItemGUID],
       fy_ContractItem.[HtTypeGUID]                 AS [HtTypeGUID],
       fy_ContractItem.[SourceGUID]                 AS [SourceGUID],
       fy_ContractItem.[SourceTypeEnum]             AS [SourceTypeEnum],
       fy_ContractItem.[ProjGUID]                   AS [ProjGUID],
       fy_ContractItem.[ExistAmount]                AS [ExistAmount],
       fy_ContractItem.[UrgencyDegreeEnum]          AS [UrgencyDegreeEnum],
       fy_ContractItem.[CreatedTime]                AS [CreatedTime],
       fy_Contract.[ContractGUID]                   AS [ContractGUID],
       fy_Contract.[HtAmount_AdjustBz]              AS [HtAmount_AdjustBz],
       (ISNULL((fy_Contract.HtAmount_AdjustBz), 0)) AS [HtAmountJs_AdjustBz_plan]
FROM (SELECT *
      FROM (SELECT ROW_NUMBER() OVER (ORDER BY fy_ContractItem.[LaunchTime] DESC ) AS num,
                   fy_ContractItem.[ContractItemGUID]                              AS [fy_ContractItem.ContractItemGUID],
                   fy_Contract.[ContractGUID]                                      AS [fy_Contract.ContractGUID],
                   vfy_BusinessSource.[SourceGuid]                                 AS [vfy_BusinessSource.SourceGuid]
            FROM dbo.fy_ContractItem WITH (NOLOCK)
                     INNER JOIN (SELECT b2.BUGUID,
                                        b2.HierarchyCode AS BuCode,
                                        p2.ProjectId,
                                        p2.HierarchyCode AS ProjectCode
                                 FROM dbo.vp_interface_businessunit b2 WITH (NOLOCK)
                                          LEFT JOIN dbo.vp_interface_user2Project p2 WITH (NOLOCK)
                                                    ON p2.BUGUID = b2.BUGUID AND p2.UserGUID = @FilterUserGUID
                                 WHERE b2.BUType = 1
                                   AND (p2.HierarchyCode = @FilterCode OR p2.HierarchyCode LIKE 'zb.1.0000000043.%')
            ) AS _projFilter ON fy_ContractItem.ProjGUID = _projFilter.ProjectId
                     LEFT JOIN dbo.fy_Contract WITH (NOLOCK)
                               ON fy_ContractItem.ContractItemGUID = fy_Contract.ContractItemGUID And
                                  fy_Contract.[ApproveStateEnum] = 3 AND fy_Contract.[IsAbort] = 0
                     LEFT JOIN dbo.vfy_BusinessSource WITH (NOLOCK)
                               ON fy_ContractItem.SourceGUID = vfy_BusinessSource.SourceGuid
            WHERE (1 = 1)) AS t
      WHERE num BETWEEN 1 AND 20) AS main
         INNER JOIN dbo.fy_ContractItem WITH (NOLOCK)
                    ON main.[fy_ContractItem.ContractItemGUID] = fy_ContractItem.ContractItemGUID
         LEFT JOIN dbo.fy_Contract WITH (NOLOCK) ON main.[fy_Contract.ContractGUID] = fy_Contract.ContractGUID
         LEFT JOIN dbo.vfy_BusinessSource WITH (NOLOCK)
                   ON main.[vfy_BusinessSource.SourceGuid] = vfy_BusinessSource.SourceGuid
ORDER BY main.num

--查询该合同 费用分摊明细
go
declare @ContractItemGUID uniqueidentifier = '9D4F044E-B326-4AE9-5D44-08D860476E70';
SELECT fy_ContractItemFtDetail.[SpecialBusinessUnitGUID]    AS [SpecialBusinessUnitGUID],
       fy_SpecialBusinessUnit.[SpecialBusinessUnitFullName] AS [SpecialBusinessUnitFullName],
       fy_ContractItemFtDetail.[CostGUID]                   AS [CostGUID],
       fy_Cost.[CostFullName]                               AS [CostFullName],
       fy_ContractItemFtDetail.[SourceDate]                 AS [SourceDate],
       fy_ContractItemFtDetail.[FtAmount]                   AS [FtAmount],
       fy_SpecialBusinessUnit.[BUGUID]                      AS [BUGUID],
       fy_ContractItemFtDetail.[ContractItemFtDetailGUID]   AS [ContractItemFtDetailGUID],fy_ContractItemFtDetail.ContractItemGUID
FROM dbo.fy_ContractItemFtDetail WITH (NOLOCK)
         LEFT JOIN dbo.fy_SpecialBusinessUnit WITH (NOLOCK)
                   ON fy_ContractItemFtDetail.SpecialBusinessUnitGUID = fy_SpecialBusinessUnit.SpecialBusinessUnitGUID
         LEFT JOIN dbo.fy_Cost WITH (NOLOCK) ON fy_ContractItemFtDetail.CostGUID = fy_Cost.CostGUID
WHERE (fy_ContractItemFtDetail.ContractItemGUID = @ContractItemGUID)
ORDER BY fy_ContractItemFtDetail.[SpecialBusinessUnitGUID] ASC, fy_ContractItemFtDetail.[CostGUID] ASC,
         fy_ContractItemFtDetail.[SourceDate] ASC

-- 合同立项，获取签约方式列表
go
declare @BUGUID uniqueidentifier = '21B01919-F243-E911-AAB8-00155D0A0915',@UserGUID uniqueidentifier = 'B4C3E6E0-9D44-E911-AAB8-00155D0A0915';
select * from (SELECT
	DISTINCT
	ContractType.ContractTypeGUID AS [value],
	ContractType.ContractTypeName AS [text],
	ContractType.ParentContractTypeGUID AS [parent],
	ContractType.NeedApply AS NeedApply,
	ContractType.ContractTypeFullCode AS ContractTypeFullCode,
	ContractType.IsNeedAcceptance AS IsNeedAcceptance
FROM dbo.fy_ContractType ContractType
INNER JOIN dbo.fy_DataAuthHtType DataAuthHtType ON ContractType.ContractTypeGroupGUID = DataAuthHtType.ContractTypeGroupGUID
INNER JOIN dbo.MyUser2Role MyUser2Role ON DataAuthHtType.StandardRoleGUID = MyUser2Role.RoleID
WHERE MyUser2Role.UserID = @UserGUID
AND ContractType.BUGUID = @BUGUID
UNION
SELECT
	DISTINCT
	ContractType.ContractTypeGUID AS [value],
	ContractType.ContractTypeName AS [text],
	ContractType.ParentContractTypeGUID AS [parent],
	ContractType.NeedApply AS NeedApply,
	ContractType.ContractTypeFullCode AS ContractTypeFullCode,
	ContractType.IsNeedAcceptance AS IsNeedAcceptance
FROM dbo.fy_ContractType ContractType
WHERE ContractType.BUGUID = @BUGUID
AND 1 = (SELECT IsAdmin FROM dbo.myUser WHERE UserGUID = @UserGUID)) t ORDER BY ContractTypeFullCode;

-- 合同立项，获取业务归属列表
go
declare @BUGUID uniqueidentifier = '21B01919-F243-E911-AAB8-00155D0A0915',@UserGUID uniqueidentifier = 'B4C3E6E0-9D44-E911-AAB8-00155D0A0915';
SELECT A.BUGUID     AS Id,
       A.ParentGUID AS Pid,
       A.BUName     AS Text,
       A.HierarchyCode,
       1            AS SourceTypeEnum,
       A.BUGUID     AS BUGUID,
       a.BUName     AS SourceName
FROM dbo.myBusinessUnit A WITH (NOLOCK)
WHERE A.BUGUID = @BUGUID
UNION ALL
SELECT DISTINCT Id             = C.p_projectId
              , Pid            = C.BUGUID
              , Text           = C.ProjName
              , HierarchyCode  = C.HierarchyCode
              , SourceTypeEnum = 2
              , BUGUID         = C.BUGUID
              , SourceName=C.ProjName
FROM dbo.p_Project A WITH (NOLOCK)
         INNER JOIN dbo.myUserProjectMapping B WITH (NOLOCK)
                    ON A.p_projectId = B.ProjectId
         INNER JOIN dbo.p_Project C WITH (NOLOCK)
                    ON A.ParentGUID = C.p_projectId
WHERE A.BUGUID = @BUGUID
  AND A.IfEnd = 1
  AND A.ApplySys LIKE '%1206%'
  AND B.UserId = @UserGUID
  AND C.IfEnd = 0
UNION ALL
SELECT Id             = A.p_projectId
     , Pid            = A.ParentGUID
     , Text           = A.ProjShortName
     , HierarchyCode  = A.HierarchyCode
     , SourceTypeEnum = 3
     , BUGUID         = A.BUGUID
     , SourceName=a.ProjName
FROM dbo.p_Project A WITH (NOLOCK)
         INNER JOIN dbo.myUserProjectMapping B WITH (NOLOCK)
                    ON A.p_projectId = B.ProjectId
WHERE A.BUGUID = @BUGUID
  AND A.IfEnd = 1
  AND A.ApplySys LIKE '%1206%'
  AND B.UserId = @UserGUID
ORDER BY HierarchyCode;

-- 合同立项，基本信息
go
declare @oid uniqueidentifier = '9AB593F1-36BA-4BED-5282-08D8622DA4E6';
SELECT fy_ContractItem.[Name]                     AS [Name],
       fy_ContractItem.[Code]                     AS [Code],
       fy_ContractItem.[UrgencyDegreeEnum]        AS [UrgencyDegreeEnum],
       fy_ContractItem.[UrgencyDegree]            AS [UrgencyDegree],
       fy_ContractItem.[SecrecyRankEnum]          AS [SecrecyRankEnum],
       fy_ContractItem.[SecrecyRank]              AS [SecrecyRank],
       fy_ContractItem.[HtTypeGUID]               AS [HtTypeGUID],
       fy_ContractItem.[HtTypeName]               AS [HtTypeName],
       fy_ContractItem.[SourceGUID]               AS [SourceGUID],
       fy_ContractItem.[ApplierGuid]              AS [ApplierGuid],
       fy_ContractItem.[ApplierName]              AS [ApplierName],
       fy_ContractItem.[DepartmentGUID]           AS [DepartmentGUID],
       fy_ContractItem.[Department]               AS [Department],
       fy_ContractItem.[LaunchTime]               AS [LaunchTime],
       fy_ContractItem.[SignTypeGUID]             AS [SignTypeGUID],
       fy_ContractItem.[SignType]                 AS [SignType],
       fy_ContractItem.[ExistAmount]              AS [ExistAmount],
       fy_ContractItem.[EstimateAmount_Bz]        AS [EstimateAmount_Bz],
       fy_ContractItem.[IsForeignCurrencyEnabled] AS [IsForeignCurrencyEnabled],
       fy_ContractItem.[BzUnit]                   AS [BzUnit],
       fy_ContractItem.[BzName]                   AS [BzName],
       fy_ContractItem.[Rate]                     AS [Rate],
       fy_ContractItem.[EstimateAmount]           AS [EstimateAmount],
       fy_Contract.[ContractGUID]                 AS [ContractGUID],
       fy_ContractItem.[Remarks]                  AS [Remarks],
       fy_ContractItem.[AbortContent]             AS [AbortContent],
       fy_ContractItem.[Addition]                 AS [Addition],
       fy_ContractItem.[SourceTypeEnum]           AS [SourceTypeEnum],
       fy_ContractItem.[IsContractItemFt]         AS [IsContractItemFt],
       fy_ContractItem.[ApproveStateEnum]         AS [ApproveStateEnum],
       fy_ContractItem.[ApproveMode]              AS [ApproveMode],
       fy_ContractItem.[IsAbort]                  AS [IsAbort],
       fy_Contract.[ContractName]                 AS [ContractName],
       fy_ContractItem.[ApproveState]             AS [ApproveState],
       fy_ContractItem.[BUGUID]                   AS [BUGUID],
       fy_ContractItem.[CodeFormatInfo]           AS [CodeFormatInfo],
       fy_ContractItem.[ProjGUID]                 AS [ProjGUID],
       fy_ContractItem.[ContractItemGUID]         AS [ContractItemGUID],
       fy_ContractItem.[ContractItemGUID]         AS [subGrid_fy_ContractItemFtDetail_ContractItemGUID]
FROM dbo.fy_ContractItem WITH (NOLOCK)
         LEFT JOIN dbo.fy_Contract WITH (NOLOCK)
                   ON fy_ContractItem.ContractItemGUID = fy_Contract.ContractItemGUID And fy_Contract.[IsAbort] = 0 AND
                      fy_Contract.[ApproveStateEnum] != 1
WHERE fy_ContractItem.[ContractItemGUID] = @oid;

-- 合同立项 费用分摊列表
declare @fy_ContractItemFtDetail__ContractItemGUID uniqueidentifier = '9AB593F1-36BA-4BED-5282-08D8622DA4E6';
SELECT fy_ContractItemFtDetail.[SpecialBusinessUnitGUID]    AS [SpecialBusinessUnitGUID],
       fy_SpecialBusinessUnit.[SpecialBusinessUnitFullName] AS [SpecialBusinessUnitFullName],
       fy_ContractItemFtDetail.[CostGUID]                   AS [CostGUID],
       fy_Cost.[CostFullName]                               AS [CostFullName],
       fy_ContractItemFtDetail.[SourceDate]                 AS [SourceDate],
       fy_ContractItemFtDetail.[FtAmount]                   AS [FtAmount],
       fy_SpecialBusinessUnit.[BUGUID]                      AS [BUGUID],
       fy_ContractItemFtDetail.[ContractItemFtDetailGUID]   AS [ContractItemFtDetailGUID]
FROM dbo.fy_ContractItemFtDetail WITH (NOLOCK)
         LEFT JOIN dbo.fy_SpecialBusinessUnit WITH (NOLOCK)
                   ON fy_ContractItemFtDetail.SpecialBusinessUnitGUID = fy_SpecialBusinessUnit.SpecialBusinessUnitGUID
         LEFT JOIN dbo.fy_Cost WITH (NOLOCK) ON fy_ContractItemFtDetail.CostGUID = fy_Cost.CostGUID
WHERE (fy_ContractItemFtDetail.ContractItemGUID = @fy_ContractItemFtDetail__ContractItemGUID)
ORDER BY fy_ContractItemFtDetail.[SpecialBusinessUnitGUID] ASC, fy_ContractItemFtDetail.[CostGUID] ASC,
         fy_ContractItemFtDetail.[SourceDate] ASC;

--合同登记，分页列表
go
declare @FilterUserGUID uniqueidentifier = 'B4C3E6E0-9D44-E911-AAB8-00155D0A0915';
SELECT fy_Contract.[ContractName]             AS [ContractName],
       fy_Contract.[YfProviderName]           AS [YfProviderName],
       vfy_BusinessSource.[SourceFullName]    AS [SourceFullName],
       fy_Contract.[HtAmount_Bz]              AS [HtAmount_Bz],
       fy_Contract.[BzName]                   AS [BzName],
       fy_Contract.[ApproveState]             AS [ApproveState],
       fy_Contract.[IsAbort]                  AS [IsAbort],
       fy_Contract.[SignDate]                 AS [SignDate],
       fy_Contract.[JsStateEnum]              AS [JsStateEnum],
       fy_Contract.[ApproveStateEnum]         AS [ApproveStateEnum],
       fy_Contract.[IsLock]                   AS [IsLock],
       fy_Contract.[BUGUID]                   AS [BUGUID],
       fy_Contract.[HtTypeGUID]               AS [HtTypeGUID],
       fy_Contract.[HtTypeName]               AS [HtTypeName],
       fy_Contract.[ContractGUID]             AS [ContractGUID],
       fy_Contract.[DeptGUID]                 AS [DeptGUID],
       fy_ContractType.[ContractTypeFullCode] AS [ContractTypeFullCode],
       fy_Contract.[ContractCode]             AS [ContractCode],
       fy_ContractType.[ContractTypeGUID]     AS [ContractTypeGUID],
       fy_Contract.[SourceGUID]               AS [SourceGUID]
FROM (SELECT *
      FROM (SELECT ROW_NUMBER() OVER (ORDER BY fy_Contract.[SignDate] DESC ) AS num,
                   fy_Contract.[ContractGUID]                                AS [fy_Contract.ContractGUID],
                   fy_ContractType.[ContractTypeGUID]                        AS [fy_ContractType.ContractTypeGUID],
                   vfy_BusinessSource.[SourceGuid]                           AS [vfy_BusinessSource.SourceGuid]
            FROM dbo.fy_Contract WITH (NOLOCK)
                     INNER JOIN (SELECT b2.BUGUID,
                                        b2.HierarchyCode AS BuCode,
                                        p2.ProjectId,
                                        p2.HierarchyCode AS ProjectCode
                                 FROM dbo.vp_interface_businessunit               b2 WITH (NOLOCK)
                                          LEFT JOIN dbo.vp_interface_user2Project p2 WITH (NOLOCK)
                                                    ON p2.BUGUID = b2.BUGUID AND p2.UserGUID = @FilterUserGUID
                                 WHERE b2.BUType = 1
                                   AND (p2.HierarchyCode LIKE 'zb.1.0000000043.%')) AS _projFilter
                                ON fy_Contract.ProjGUID = _projFilter.ProjectId
                     INNER JOIN dbo.fy_ContractType WITH (NOLOCK)
                                ON fy_Contract.HtTypeGUID = fy_ContractType.ContractTypeGUID
                     LEFT JOIN  dbo.vfy_BusinessSource WITH (NOLOCK)
                                ON fy_Contract.SourceGUID = vfy_BusinessSource.SourceGuid And
                                   vfy_BusinessSource.[BUGUID] = fy_Contract.BUGUID
            WHERE (1 = 1)) AS t
      WHERE num BETWEEN 1 AND 20) AS main
         INNER JOIN dbo.fy_Contract WITH (NOLOCK) ON main.[fy_Contract.ContractGUID] = fy_Contract.ContractGUID
         INNER JOIN dbo.fy_ContractType WITH (NOLOCK)
                    ON main.[fy_ContractType.ContractTypeGUID] = fy_ContractType.ContractTypeGUID
         LEFT JOIN  dbo.vfy_BusinessSource WITH (NOLOCK)
                    ON main.[vfy_BusinessSource.SourceGuid] = vfy_BusinessSource.SourceGuid
ORDER BY main.num;


select BUGUID
from dbo.myBusinessUnit;

SELECT cb_Contract.[ContractName]                                         AS [ContractName],
       cb_Contract.[ContractCode]                                         AS [ContractCode],
       cb_Contract.[YfProviderName]                                       AS [YfProviderName],
       cb_Contract.[ApproveState]                                         AS [ApproveState],
       cb_Contract.[JsState]                                              AS [JsState],
       cb_Contract.[NeedJs]                                               AS [NeedJs],
       cb_Contract.[TotalAmount]                                          AS [TotalAmount],
       cb_Contract.[HtAmount_Bz]                                          AS [HtAmount_Bz],
       cb_Contract.[BzName]                                               AS [BzName],
       cb_Contract.[SignDate]                                             AS [SignDate],
       cb_Contract.[IsLock]                                               AS [IsLock],
       cb_Contract.[BuGuid]                                               AS [BuGuid],
       cb_Contract.[IsRecharging]                                         AS [IsRecharging],
       cb_Contract.[ApproveStateEnum]                                     AS [ApproveStateEnum],
       cb_Contract.[JsStateEnum]                                          AS [JsStateEnum],
       cb_Contract.[IsNeedBg]                                             AS [IsNeedBg],
       cb_Contract.[IsOverallContract]                                    AS [IsOverallContract],
       cb_Contract.[ContractGUID]                                         AS [ContractGUID],
       cb_HtType.[HtTypeFullCode]                                         AS [HtTypeFullCode],
       cb_Contract.[DeptGUID]                                             AS [DeptGUID],
       cb_Contract.[IsIntertemporal]                                      AS [IsIntertemporal],
       cb_Contract.[HtTypeGUID]                                           AS [HtTypeGUID],
       (CASE WHEN (cb_Contract.NeedJs) = (1) THEN '是' ELSE '否' END)       AS [needJsText],
       (SELECT CASE WHEN VALUE IS NULL THEN 1 ELSE VALUE END AS value
        FROM (SELECT (SELECT TOP 1 Value AS value
                      FROM dbo.myParamValue with (nolock)
                      WHERE mdl_ParamId = 'b0856218-3e8d-11e6-9cac-7427ea118c90'
                        AND ScopeId = cb_Contract.BuGuid) AS VALUE) AS A) AS [isWorkflow]
FROM (SELECT *
      FROM (SELECT ROW_NUMBER() OVER (ORDER BY cb_Contract.[SignDate] DESC, cb_Contract.[ContractName] ASC ) AS num,
                   cb_Contract.[ContractGUID]                                                                AS [cb_Contract.ContractGUID],
                   cb_HtType.[HtTypeGUID]                                                                    AS [cb_HtType.HtTypeGUID],
                   vcb_ResAuthFilterHtTypeWithAdmin.[HtTypeGUID]                                             AS [vcb_ResAuthFilterHtTypeWithAdmin.HtTypeGUID],
                   vcb_ResAuthFilterHtTypeWithAdmin.[UserGUID]                                               AS [vcb_ResAuthFilterHtTypeWithAdmin.UserGUID]
            FROM dbo.cb_Contract WITH (NOLOCK)
                     INNER JOIN (SELECT b2.BUGUID,
                                        b2.HierarchyCode AS BuCode,
                                        p2.ProjectId,
                                        p2.HierarchyCode AS ProjectCode
                                 FROM dbo.vp_interface_businessunit               b2 WITH (NOLOCK)
                                          LEFT JOIN dbo.vp_interface_user2Project p2 WITH (NOLOCK)
                                                    ON p2.BUGUID = b2.BUGUID AND p2.UserGUID = @FilterUserGUID
                                 WHERE b2.BUType = 1
                                   AND (p2.HierarchyCode = @FilterCode OR
                                        p2.HierarchyCode LIKE 'zb.9.001.001-1.%')) AS _projFilter
                                ON cb_Contract.ProjGUID = _projFilter.ProjectId
                     INNER JOIN dbo.cb_HtType WITH (NOLOCK) ON cb_Contract.HtTypeGUID = cb_HtType.HtTypeGUID
                     LEFT JOIN  dbo.vcb_ResAuthFilterHtTypeWithAdmin WITH (NOLOCK)
                                ON cb_Contract.HtTypeGUID = vcb_ResAuthFilterHtTypeWithAdmin.HtTypeGUID And
                                   vcb_ResAuthFilterHtTypeWithAdmin.[UserGUID] = @_keyword_2 AND
                                   vcb_ResAuthFilterHtTypeWithAdmin.[BUGUID] = cb_Contract.BuGuid
            WHERE (1 = 1)
              AND (cb_Contract.[JbrGUID] = @_keyword_2 OR
                   vcb_ResAuthFilterHtTypeWithAdmin.[HtTypeGUID] is not null)) AS t
      WHERE num BETWEEN 1 AND 20) AS main
         INNER JOIN dbo.cb_Contract WITH (NOLOCK) ON main.[cb_Contract.ContractGUID] = cb_Contract.ContractGUID
         INNER JOIN dbo.cb_HtType WITH (NOLOCK) ON main.[cb_HtType.HtTypeGUID] = cb_HtType.HtTypeGUID
         LEFT JOIN  dbo.vcb_ResAuthFilterHtTypeWithAdmin WITH (NOLOCK)
                    ON main.[vcb_ResAuthFilterHtTypeWithAdmin.HtTypeGUID] =
                       vcb_ResAuthFilterHtTypeWithAdmin.HtTypeGUID AND
                       main.[vcb_ResAuthFilterHtTypeWithAdmin.UserGUID] = vcb_ResAuthFilterHtTypeWithAdmin.UserGUID
ORDER BY main.num


select * from dbo.fy_ContractItem;

select *
from dbo.cb_ContractItem;

SELECT ContractName AS [text],ContractGUID AS [value] FROM dbo.fy_Contract WHERE ContractGUID=[query:ContractGUID]
union 
SELECT b.ContractName AS [text],b.ContractGUID AS [value] 
FROM dbo.fy_HTFKApply a
LEFT JOIN dbo.fy_Contract b ON b.ContractGUID=a.ContractGUID
WHERE a.HTFKApplyGUID=[query:oid]


-- 部门费用分析 - 发生口径

select ContractItemGUID,ContractItemName
from dbo.cb_Contract;

SELECT top 1 SettingValue FROM dbo.mdl_UserSetting WITH(NOLOCK) WHERE SettingType = '当前公司' AND SettingKey = '9c278c96-8d30-48c0-8da4-df1c08098751'

SELECT top 1 SettingValue FROM dbo.mdl_UserSetting WITH(NOLOCK) WHERE SettingType = '当前项目' AND SettingKey = '9c278c96-8d30-48c0-8da4-df1c08098751'


SELECT '余量为正' AS [text],1 AS [value]
UNION ALL
SELECT '余量为负' AS [text],2 AS [value]
UNION ALL
SELECT '余量为零' AS [text],3 AS [value]

select * from (SELECT  YearGUID AS [value] ,
        Year AS [text] ,
        CASE WHEN GETDATE() BETWEEN StartDate AND EndDate THEN 'true'
             ELSE 'false'
        END AS isdefault,
		StartDate,
		EndDate
FROM    dbo.fy_Year WITH (NOLOCK)) t ORDER BY  [text] DESC

SELECT * FROM dbo.[fy_YearMonth]  WHERE [YearGUID] = 'ee7578b0-0b90-4e18-ab63-2456abfa79c1'

SELECT * FROM dbo.[fy_Year]  WHERE 1 = 1

SELECT * FROM dbo.[fy_YearMonth]  WHERE 1 = 1

select *
from dbo.fy_Year where ([StartDate] <= '2020/11/19 10:30:12') AND ([EndDate] >= '2020/11/19 10:30:12')


go
declare @SpecialBusinessUnitGUID uniqueidentifier = '8cde7c30-2d9b-457e-0df5-08d7c903152b',
  @UserGUID uniqueidentifier = '9c278c96-8d30-48c0-8da4-df1c08098751',
  @IsAdmin int = 0,
  @YearGUID uniqueidentifier = 'ee7578b0-0b90-4e18-ab63-2456abfa79c1',
  @BasedOn  int = 1,
  @AllYearBeginYearMonth datetime = '2020/1/1 0:00:00',
  @AllYearEndYearMonth datetime = '2020/12/31 23:59:59'

SELECT
cost.IsDisable,
cost.CostGUID ,
cost.CostName ,
cost.HierarchyCode ,
cost.ParentGUID ,
cost.IsEndCost,
yearBudgetPoise.YearMonth,
ISNULL(y.OccurredIsBudget,0) AS OccurredIsBudget,
ISNULL(y.PayIsBudget,0) AS PayIsBudget,
ISNULL(y.OccurredBudgetIsEndCost,0) AS IsOccurredBudgetEndCost,
ISNULL(y.PayBudgetIsEndCost,0) AS IsPayBudgetEndCost,

ISNULL(yearBudgetPoise.PlanningAmount,0) AS PlanningAmount,
ISNULL(yearBudgetPoise.AdjustPlanningAmount,0) AS AdjustPlanningAmount,

ISNULL(yearBudgetPoise.TotalPlanningAmount,0) AS TotalPlanningAmount ,
ISNULL(yearBudgetPoise.RemainingAmount,0) AS RemainingAmount ,

ISNULL(yearBudgetPoise.PaidPercenty,0) AS PaidPercenty,
ISNULL(yearBudgetPoise.TotalPaidAmount,0) AS TotalPaidAmount,

ISNULL(yearBudgetPoise.PayablePercenty,0) AS PayablePercenty ,
ISNULL(yearBudgetPoise.TotalPayableAmount,0) AS TotalPayableAmount,

ISNULL(yearBudgetPoise.TotalOccupiedAndOccurredAmount,0) AS TotalOccupiedAndOccurredAmount,
ISNULL(yearBudgetPoise.OccupiedAndOccurredPercenty,0) AS OccupiedAndOccurredPercenty,

0 AS AllYearPlanningAmount,
0 AS AllYearAdjustPlanningAmount,
0 AS AllYearTotalPlanningAmount,
0 AS AllYearRemainingAmount,
0 AS AllYearOccupiedAndOccurredAmount,
0 AS AllYearPayableAmount,
0 AS AllYearOccupiedAndOccurredPercenty,
0 AS AllYearPayablePercenty
FROM
(
	SELECT DISTINCT
    c.IsDisable,
	c.CostGUID,
	c.CostName,
	c.HierarchyCode,
	c.ParentGUID,
	c.IsEnd AS IsEndCost,
	c.BUGUID
	FROM dbo.fy_DataAuthAccount a WITH(NOLOCK)
	LEFT JOIN dbo.MyUser2Role b WITH(NOLOCK)
		ON a.StandardRoleGUID = b.RoleID
	LEFT JOIN dbo.fy_Cost c WITH(NOLOCK)
		ON c.BzCostGUID = a.BzCostGUID
	LEFT JOIN dbo.fy_SpecialBusinessUnit2Cost d WITH(NOLOCK)
		ON d.CostGUID = c.CostGUID
	WHERE @IsAdmin = 0
	AND b.UserID = @UserGUID
	AND d.SpecialBusinessUnitGUID = @SpecialBusinessUnitGUID
	UNION ALL
	SELECT
        c.IsDisable,
        c.CostGUID,
        c.CostName,
        c.HierarchyCode,
        c.ParentGUID,
        c.IsEnd AS IsEndCost,
        c.BUGUID
	FROM dbo.fy_SpecialBusinessUnit2Cost d  WITH(NOLOCK)
	LEFT JOIN  dbo.fy_Cost c WITH(NOLOCK)
	ON d.CostGUID = c.CostGUID
	WHERE @IsAdmin = 1
	AND d.SpecialBusinessUnitGUID = @SpecialBusinessUnitGUID
) cost
OUTER APPLY
(
	SELECT center.OccurredIsBudget,center.PayIsBudget,
	center.OccurredBudgetIsEndCost,center.PayBudgetIsEndCost
	FROM dbo.fy_ControlCenterCost center WITH (NOLOCK)
	WHERE center.BUGUID = cost.BUGUID AND center.YearGUID = @YearGUID
	AND center.CostGUID = cost.CostGUID
) y
OUTER APPLY
(
		SELECT
    e.YearMonth,
		SUM(CASE WHEN @BasedOn = 1 THEN e.OccurredPlanningAmount
			ELSE e.PayPlanningAmount END) AS PlanningAmount,

		SUM(CASE WHEN @BasedOn = 1 THEN  e.OccurredPlanningAdjustAmount
			ELSE e.PayPlanningAdjustAmount END) AS AdjustPlanningAmount,

		SUM(CASE WHEN @BasedOn = 1 THEN e.OccurredPlanningAmount +  e.OccurredPlanningAdjustAmount
			ELSE e.PayPlanningAmount + e.PayPlanningAdjustAmount END) AS TotalPlanningAmount,

		0 AS RemainingAmount,

		SUM(e.OccurredCaliberAmount) AS TotalOccupiedAndOccurredAmount,
		0 AS OccupiedAndOccurredPercenty,

		SUM(e.PayCaliberAmount) AS TotalPayableAmount,
		0 AS PayablePercenty,

		SUM(e.ActuallyPaidCaliberAmount) AS TotalPaidAmount,
		0 AS PaidPercenty

		FROM dbo.fy_YearBudgetPoise e WITH (NOLOCK)
		WHERE e.SpecialBusinessUnitGUID = @SpecialBusinessUnitGUID
		AND e.YearMonth >= @AllYearBeginYearMonth AND e.YearMonth <= @AllYearEndYearMonth
		AND e.CostGUID = cost.CostGUID
    GROUP BY e.YearMonth
) yearBudgetPoise

select UserGUID,UserName from dbo.myUser where IsAdmin = 1 and UserCode = 'admin';


select daa.*
from dbo.fy_DataAuthAccount daa -- 数据授权科目表
left join dbo.MyUser2Role u2r on u2r.RoleID = daa.StandardRoleGUID
left join dbo.fy_Cost c on c.BzCostGUID = daa.BzCostGUID
where u2r.UserID = '4230BC6E-69E6-46A9-A39E-B929A06A84E8';


select *
from dbo.fy_BzCost;


select HtTypeName,ContractCode,ContractName,YfProviderGUID,YfProviderName,SignDate from dbo.cb_Contract
where  SignDate >= '2020-10-01' and SignDate < '2020-11-01'



SELECT [CostGUID],[BzCostGUID] FROM [fy_Cost]  WHERE (1=1) AND ([BUGUID] = @_Param0)

-- 费用分析明细(已使用-发生口径)
go
declare @BeginTime datetime = '2020/1/1 00:00:00',@EndTime datetime = '2020/11/30 23:59:00';
SELECT t.*
FROM (SELECT y.SpecialBusinessUnitGUID,
             y.CostGUID,
             y.SpecialBusinessUnitFullName AS SpecialBusinessUnitFullName,
             y.CostFullName                AS CostFullName,
             z.*
      FROM (SELECT sbu2c.SpecialBusinessUnitGUID, sbu2c.CostGUID, u.SpecialBusinessUnitFullName, c.CostFullName
            FROM dbo.fy_SpecialBusinessUnit2Cost          sbu2c WITH (NOLOCK)
                     LEFT JOIN dbo.fy_SpecialBusinessUnit u ON u.SpecialBusinessUnitGUID = sbu2c.SpecialBusinessUnitGUID
                     LEFT JOIN dbo.fy_Cost                c ON c.CostGUID = sbu2c.CostGUID
            WHERE sbu2c.SpecialBusinessUnitGUID IN ('1897281a-b1dd-46a9-75a0-08d88fe2625c')
              AND sbu2c.CostGUID IN ('41b8f0ac-91e2-4cfd-72f8-08d88fe2625d', '38e6971c-eabe-4590-72d3-08d88fe2625d',
                                     '8c74aa6a-bfec-4522-7327-08d88fe2625d', '803f0c5c-942b-4511-72bd-08d88fe2625d',
                                     '6e967285-625a-47b6-732f-08d88fe2625d')) y
               OUTER APPLY (
                               --合同立项
                               SELECT b.BUGUID,
                                      b.ContractItemGUID         AS BillGUID,
                                      a.ContractItemFtDetailGUID AS FtDetailGUID,
                                      b.LaunchTime               AS ApplyDate,
                                      b.ApproveStateEnum         AS ApproveStateEnum,
                                      b.ApproveState             AS ApproveState,
                                      1                          AS BillTypeEnum,
                                      '合同立项'                     AS BillType,
                                      b.Code                     AS BillCode,
                                      b.Name                     AS BillName,
                                      b.EstimateAmount_Bz        AS BillAmount,
                                      b.ApplierName              AS AppliedByName,
                                      a.SourceDate               AS SourceDate,
                                      a.PlanAmount               AS FtAmount
                               FROM dbo.fy_ContractItemFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_ContractItem b WITH (NOLOCK)
                                                  ON b.ContractItemGUID = a.ContractItemGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                                 AND b.IsAbort = 0
                                 AND a.PlanAmount > 0
                               UNION ALL
                               --合同
                               SELECT b.BUGUID,
                                      b.ContractGUID         AS BillGUID,
                                      a.ContractFtDetailGUID AS FtDetailGUID,
                                      b.SignDate             AS ApplyDate,
                                      b.ApproveStateEnum     AS ApproveStateEnum,
                                      b.ApproveState         AS ApproveState,
                                      2                      AS BillTypeEnum,
                                      '合同'                   AS BillType,
                                      b.ContractCode         AS BillCode,
                                      b.ContractName         AS BillName,
                                      b.HtAmount_Bz          AS BillAmount,
                                      b.JbrName              AS AppliedByName,
                                      a.SourceDate           AS SourceDate,
                                      a.FtAmount             AS FtAmount
                               FROM dbo.fy_ContractFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_Contract b WITH (NOLOCK) ON b.ContractGUID = a.ContractGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                                 AND b.IsAbort = 0
                               UNION ALL
                               --合同预付申请
                               SELECT b.BUGUID,
                                      b.HTFKApplyGUID         AS BillGUID,
                                      a.HTFKApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate             AS ApplyDate,
                                      b.ApproveStateEnum      AS ApproveStateEnum,
                                      b.ApproveState          AS ApproveState,
                                      17                      AS BillTypeEnum,
                                      '合同预付'                  AS BillType,
                                      b.ApplyCode             AS BillCode,
                                      b.Subject               AS BillName,
                                      b.ApplyAmount_Bz        AS BillAmount,
                                      b.AppliedByName         AS AppliedByName,
                                      a.SourceDate            AS SourceDate,
                                      a.PlanAmount            AS FtAmount
                               FROM dbo.fy_HTFKApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_HTFKApply b WITH (NOLOCK) ON b.HTFKApplyGUID = a.HTFKApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                                 AND b.IsPrepay = 1
                               /*
                               UNION ALL
                               --补充合同
                               SELECT b.BUGUID,
                                      b.BcContractGUID         AS BillGUID,
                                      a.BcContractFtDetailGUID AS FtDetailGUID,
                                      b.JbDate                 AS ApplyDate,
                                      b.ApproveStateEnum       AS ApproveStateEnum,
                                      b.ApproveState           AS ApproveState,
                                      3                        AS BillTypeEnum,
                                      '补充合同'                   AS BillType,
                                      b.ContractCode           AS BillCode,
                                      b.ContractName           AS BillName,
                                      b.HtAmount_Bz            AS BillAmount,
                                      b.JbrName                AS AppliedByName,
                                      a.SourceDate             AS SourceDate,
                                      a.FtAmount               AS FtAmount
                               FROM dbo.fy_BcContractFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_BcContract b WITH (NOLOCK)
                                                  ON b.BcContractGUID = a.BcContractGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                               UNION ALL
                               --合同结算
                               SELECT b.BUGUID,
                                      b.ContractBalanceGUID                          AS BillGUID,
                                      a.ContractBalanceFtDetailGUID                  AS FtDetailGUID,
                                      b.JsDate                                       AS ApplyDate,
                                      b.ApproveStateEnum                             AS ApproveStateEnum,
                                      b.ApproveState                                 AS ApproveState,
                                      4                                              AS BillTypeEnum,
                                      '合同结算'                                         AS BillType,
                                      c.ContractCode                                 AS BillCode,
                                      c.ContractName                                 AS BillName,
                                      b.JsAmount_Bz - c.HtAmount_Bz - bc.HtAmount_Bz AS BillAmount,
                                      b.JbrName                                      AS AppliedByName,
                                      a.SourceDate                                   AS SourceDate,
                                      a.FtAmount                                     AS FtAmount
                               FROM dbo.fy_ContractBalanceFtDetail              a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_ContractBalance        b WITH (NOLOCK)
                                                  ON b.ContractBalanceGUID = a.ContractBalanceGUID
                                        LEFT JOIN dbo.fy_Contract               c WITH (NOLOCK)
                                                  ON b.MasterContractGUID = c.ContractGUID
                                        LEFT JOIN (SELECT SUM(HtAmount_Bz) AS HtAmount_Bz, MasterContractGUID
                                                   FROM dbo.fy_BcContract WITH (NOLOCK)
                                                   GROUP BY MasterContractGUID) bc
                                                  ON bc.MasterContractGUID = c.ContractGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                                */
                               UNION ALL
                               --出差申请
                               SELECT b.BUGUID,
                                      b.BusinessTripApplyGUID         AS BillGUID,
                                      a.BusinessTripApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                     AS ApplyDate,
                                      b.ApproveStateEnum              AS ApproveStateEnum,
                                      b.ApproveState                  AS ApproveState,
                                      6                               AS BillTypeEnum,
                                      '出差申请'                          AS BillType,
                                      b.ApplyCode                     AS BillCode,
                                      b.Remark                        AS BillName,
                                      b.ApplyAmount                   AS BillAmount,
                                      b.AppliedByName                 AS AppliedByName,
                                      a.SourceDate                    AS SourceDate,
                                      a.PlanAmount                    AS FtAmount
                               FROM dbo.fy_BusinessTripApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_BusinessTripApply b WITH (NOLOCK)
                                                  ON b.BusinessTripApplyGUID = a.BusinessTripApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                                 AND a.PlanAmount > 0
                               UNION ALL
                               --费用申请
                               SELECT b.BUGUID,
                                      b.ExpenseApplyGUID         AS BillGUID,
                                      a.ExpenseApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                AS ApplyDate,
                                      b.ApproveStateEnum         AS ApproveStateEnum,
                                      b.ApproveState             AS ApproveState,
                                      7                          AS BillTypeEnum,
                                      '费用申请'                     AS BillType,
                                      b.ApplyCode                AS BillCode,
                                      b.Remark                   AS BillName,
                                      b.ApplyAmount              AS BillAmount,
                                      b.AppliedByName            AS AppliedByName,
                                      a.SourceDate               AS SourceDate,
                                      a.PlanAmount               AS FtAmount
                               FROM dbo.fy_ExpenseApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_ExpenseApply b WITH (NOLOCK)
                                                  ON b.ExpenseApplyGUID = a.ExpenseApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                                 AND a.PlanAmount > 0
                               UNION ALL
                               --出差申请
                               SELECT b.BUGUID,
                                      b.BusinessTripApplyGUID         AS BillGUID,
                                      a.BusinessTripApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                     AS ApplyDate,
                                      b.ApproveStateEnum              AS ApproveStateEnum,
                                      b.ApproveState                  AS ApproveState,
                                      6                               AS BillTypeEnum,
                                      '出差申请'                          AS BillType,
                                      b.ApplyCode                     AS BillCode,
                                      b.Remark                        AS BillName,
                                      b.ApplyAmount                   AS BillAmount,
                                      b.AppliedByName                 AS AppliedByName,
                                      a.SourceDate                    AS SourceDate,
                                      a.LoanAmount                    AS FtAmount
                               FROM dbo.fy_BusinessTripApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_BusinessTripApply b WITH (NOLOCK)
                                                  ON b.BusinessTripApplyGUID = a.BusinessTripApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum = 2
                                 AND b.IsApplyLoan = 1
                                 AND a.IsCoerceFt = 0
                               UNION ALL
                               --费用申请
                               SELECT b.BUGUID,
                                      b.ExpenseApplyGUID         AS BillGUID,
                                      a.ExpenseApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                AS ApplyDate,
                                      b.ApproveStateEnum         AS ApproveStateEnum,
                                      b.ApproveState             AS ApproveState,
                                      7                          AS BillTypeEnum,
                                      '费用申请'                     AS BillType,
                                      b.ApplyCode                AS BillCode,
                                      b.Remark                   AS BillName,
                                      b.ApplyAmount              AS BillAmount,
                                      b.AppliedByName            AS AppliedByName,
                                      a.SourceDate               AS SourceDate,
                                      a.LoanAmount               AS FtAmount
                               FROM dbo.fy_ExpenseApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_ExpenseApply b WITH (NOLOCK)
                                                  ON b.ExpenseApplyGUID = a.ExpenseApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum = 2
                                 AND b.IsApplyLoan = 1
                                 AND a.IsCoerceFt = 0
                               UNION ALL
                               --借款申请
                               SELECT b.BUGUID,
                                      b.LoanApplyGUID         AS BillGUID,
                                      a.LoanApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate             AS ApplyDate,
                                      b.ApproveStateEnum      AS ApproveStateEnum,
                                      b.ApproveState          AS ApproveState,
                                      8                       AS BillTypeEnum,
                                      '借款申请'                  AS BillType,
                                      b.ApplyCode             AS BillCode,
                                      b.Remark                AS BillName,
                                      b.LoanAmount            AS BillAmount,
                                      b.AppliedByName         AS AppliedByName,
                                      a.SourceDate            AS SourceDate,
                                      a.PlanAmount            AS FtAmount
                               FROM dbo.fy_LoanApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_LoanApply b WITH (NOLOCK) ON b.LoanApplyGUID = a.LoanApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                                 AND a.PlanAmount > 0
                               UNION ALL
                               --日常报销
                               SELECT b.BUGUID,
                                      b.DailyExpenseGUID         AS BillGUID,
                                      a.DailyExpenseFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                AS ApplyDate,
                                      b.ApproveStateEnum         AS ApproveStateEnum,
                                      b.ApproveState             AS ApproveState,
                                      9                          AS BillTypeEnum,
                                      '日常报销'                     AS BillType,
                                      b.ApplyCode                AS BillCode,
                                      b.ExpenseReason            AS BillName,
                                      b.ExpenseAmount            AS BillAmount,
                                      b.AppliedByName            AS AppliedByName,
                                      a.SourceDate               AS SourceDate,
                                      a.PlanAmount               AS FtAmount
                               FROM dbo.fy_DailyExpenseFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_DailyExpense b WITH (NOLOCK)
                                                  ON b.DailyExpenseGUID = a.DailyExpenseGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                               UNION ALL
                               --差旅报销
                               SELECT b.BUGUID,
                                      b.BusTripExpenseGUID         AS BillGUID,
                                      a.BusTripExpenseFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                  AS ApplyDate,
                                      b.ApproveStateEnum           AS ApproveStateEnum,
                                      b.ApproveState               AS ApproveState,
                                      10                           AS BillTypeEnum,
                                      '差旅报销'                       AS BillType,
                                      b.ApplyCode                  AS BillCode,
                                      b.ExpenseReason              AS BillName,
                                      b.ExpenseAmount              AS BillAmount,
                                      b.AppliedByName              AS AppliedByName,
                                      a.SourceDate                 AS SourceDate,
                                      a.PlanAmount                 AS FtAmount
                               FROM dbo.fy_BusTripExpenseFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_BusTripExpense b WITH (NOLOCK)
                                                  ON b.BusTripExpenseGUID = a.BusTripExpenseGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                               UNION ALL
                               --对公请款
                               SELECT b.BUGUID,
                                      b.CompanyPayApplyGUID         AS BillGUID,
                                      a.CompanyPayApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                   AS ApplyDate,
                                      b.ApproveStateEnum            AS ApproveStateEnum,
                                      b.ApproveState                AS ApproveState,
                                      11                            AS BillTypeEnum,
                                      '对公请款'                        AS BillType,
                                      b.ApplyCode                   AS BillCode,
                                      b.Subject                     AS BillName,
                                      b.ApplyAmount                 AS BillAmount,
                                      b.AppliedByName               AS AppliedByName,
                                      a.SourceDate                  AS SourceDate,
                                      a.PlanAmount                  AS FtAmount
                               FROM dbo.fy_CompanyPayApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_CompanyPayApply b WITH (NOLOCK)
                                                  ON b.CompanyPayApplyGUID = a.CompanyPayApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3))            z) t
WHERE t.FtDetailGUID IS NOT NULL
  AND t.FtAmount <> 0


-- 费用分析明细(应付-支付口径)
go
declare @BeginTime datetime = '2020/1/1 00:00:00',@EndTime datetime = '2020/11/30 23:59:00';
SELECT t.*
FROM (SELECT y.SpecialBusinessUnitGUID,
             y.CostGUID,
             y.SpecialBusinessUnitFullName AS SpecialBusinessUnitFullName,
             y.CostFullName                AS CostFullName,
             z.*
      FROM (SELECT sbu2c.SpecialBusinessUnitGUID, sbu2c.CostGUID, u.SpecialBusinessUnitFullName, c.CostFullName
            FROM dbo.fy_SpecialBusinessUnit2Cost          sbu2c WITH (NOLOCK)
                     LEFT JOIN dbo.fy_SpecialBusinessUnit u ON u.SpecialBusinessUnitGUID = sbu2c.SpecialBusinessUnitGUID
                     LEFT JOIN dbo.fy_Cost                c ON c.CostGUID = sbu2c.CostGUID
            WHERE sbu2c.SpecialBusinessUnitGUID IN ('1897281a-b1dd-46a9-75a0-08d88fe2625c')
              AND sbu2c.CostGUID IN ('41b8f0ac-91e2-4cfd-72f8-08d88fe2625d', '38e6971c-eabe-4590-72d3-08d88fe2625d',
                                     '8c74aa6a-bfec-4522-7327-08d88fe2625d', '803f0c5c-942b-4511-72bd-08d88fe2625d',
                                     '6e967285-625a-47b6-732f-08d88fe2625d')) y
               OUTER APPLY (
                               --付款申请
                               SELECT b.BUGUID,
                                      b.HTFKApplyGUID         AS BillGUID,
                                      a.HTFKApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate             AS ApplyDate,
                                      b.ApproveStateEnum      AS ApproveStateEnum,
                                      b.ApproveState          AS ApproveState,
                                      5                       AS BillTypeEnum,
                                      '付款申请'                  AS BillType,
                                      b.ApplyCode             AS BillCode,
                                      b.Subject               AS BillName,
                                      b.ApplyAmount_Bz        AS BillAmount,
                                      b.AppliedByName         AS AppliedByName,
                                      a.SourceDate            AS SourceDate,
                                      a.FtAmount              AS FtAmount
                               FROM dbo.fy_HTFKApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_HTFKApply b WITH (NOLOCK) ON b.HTFKApplyGUID = a.HTFKApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                                 AND b.IsPrepay = 0
                               UNION ALL
                               --出差申请
                               SELECT b.BUGUID,
                                      b.BusinessTripApplyGUID         AS BillGUID,
                                      a.BusinessTripApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                     AS ApplyDate,
                                      b.ApproveStateEnum              AS ApproveStateEnum,
                                      b.ApproveState                  AS ApproveState,
                                      6                               AS BillTypeEnum,
                                      '出差申请'                          AS BillType,
                                      b.ApplyCode                     AS BillCode,
                                      b.Remark                        AS BillName,
                                      b.ApplyAmount                   AS BillAmount,
                                      b.AppliedByName                 AS AppliedByName,
                                      a.SourceDate                    AS SourceDate,
                                      a.LoanAmount                    AS FtAmount
                               FROM dbo.fy_BusinessTripApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_BusinessTripApply b WITH (NOLOCK)
                                                  ON b.BusinessTripApplyGUID = a.BusinessTripApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum = 2
                                 AND b.IsApplyLoan = 1
                               UNION ALL
                               --费用申请
                               SELECT b.BUGUID,
                                      b.ExpenseApplyGUID         AS BillGUID,
                                      a.ExpenseApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                AS ApplyDate,
                                      b.ApproveStateEnum         AS ApproveStateEnum,
                                      b.ApproveState             AS ApproveState,
                                      7                          AS BillTypeEnum,
                                      '费用申请'                     AS BillType,
                                      b.ApplyCode                AS BillCode,
                                      b.Remark                   AS BillName,
                                      b.ApplyAmount              AS BillAmount,
                                      b.AppliedByName            AS AppliedByName,
                                      a.SourceDate               AS SourceDate,
                                      a.LoanAmount               AS FtAmount
                               FROM dbo.fy_ExpenseApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_ExpenseApply b WITH (NOLOCK)
                                                  ON b.ExpenseApplyGUID = a.ExpenseApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum = 2
                                 AND b.IsApplyLoan = 1
                               UNION ALL
                               --借款申请
                               SELECT b.BUGUID,
                                      b.LoanApplyGUID         AS BillGUID,
                                      a.LoanApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate             AS ApplyDate,
                                      b.ApproveStateEnum      AS ApproveStateEnum,
                                      b.ApproveState          AS ApproveState,
                                      8                       AS BillTypeEnum,
                                      '借款申请'                  AS BillType,
                                      b.ApplyCode             AS BillCode,
                                      b.Remark                AS BillName,
                                      b.LoanAmount            AS BillAmount,
                                      b.AppliedByName         AS AppliedByName,
                                      a.SourceDate            AS SourceDate,
                                      a.PlanAmount            AS FtAmount
                               FROM dbo.fy_LoanApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_LoanApply b WITH (NOLOCK) ON b.LoanApplyGUID = a.LoanApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                                 AND a.PlanAmount > 0
                               UNION ALL
                               --日常报销
                               SELECT b.BUGUID,
                                      b.DailyExpenseGUID         AS BillGUID,
                                      a.DailyExpenseFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                AS ApplyDate,
                                      b.ApproveStateEnum         AS ApproveStateEnum,
                                      b.ApproveState             AS ApproveState,
                                      9                          AS BillTypeEnum,
                                      '日常报销'                     AS BillType,
                                      b.ApplyCode                AS BillCode,
                                      b.ExpenseReason            AS BillName,
                                      b.ExpenseAmount            AS BillAmount,
                                      b.AppliedByName            AS AppliedByName,
                                      a.SourceDate               AS SourceDate,
                                      a.PlanAmount               AS FtAmount
                               FROM dbo.fy_DailyExpenseFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_DailyExpense b WITH (NOLOCK)
                                                  ON b.DailyExpenseGUID = a.DailyExpenseGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                               UNION ALL
                               --差旅报销
                               SELECT b.BUGUID,
                                      b.BusTripExpenseGUID         AS BillGUID,
                                      a.BusTripExpenseFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                  AS ApplyDate,
                                      b.ApproveStateEnum           AS ApproveStateEnum,
                                      b.ApproveState               AS ApproveState,
                                      10                           AS BillTypeEnum,
                                      '差旅报销'                       AS BillType,
                                      b.ApplyCode                  AS BillCode,
                                      b.ExpenseReason              AS BillName,
                                      b.ExpenseAmount              AS BillAmount,
                                      b.AppliedByName              AS AppliedByName,
                                      a.SourceDate                 AS SourceDate,
                                      a.PlanAmount                 AS FtAmount
                               FROM dbo.fy_BusTripExpenseFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_BusTripExpense b WITH (NOLOCK)
                                                  ON b.BusTripExpenseGUID = a.BusTripExpenseGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                               UNION ALL
                               --对公请款
                               SELECT b.BUGUID,
                                      b.CompanyPayApplyGUID         AS BillGUID,
                                      a.CompanyPayApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate                   AS ApplyDate,
                                      b.ApproveStateEnum            AS ApproveStateEnum,
                                      b.ApproveState                AS ApproveState,
                                      11                            AS BillTypeEnum,
                                      '对公请款'                        AS BillType,
                                      b.ApplyCode                   AS BillCode,
                                      b.Subject                     AS BillName,
                                      b.ApplyAmount                 AS BillAmount,
                                      b.AppliedByName               AS AppliedByName,
                                      a.SourceDate                  AS SourceDate,
                                      a.PlanAmount                  AS FtAmount
                               FROM dbo.fy_CompanyPayApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_CompanyPayApply b WITH (NOLOCK)
                                                  ON b.CompanyPayApplyGUID = a.CompanyPayApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                               UNION ALL
                               --合同预付
                               SELECT b.BUGUID,
                                      b.HTFKApplyGUID         AS BillGUID,
                                      a.HTFKApplyFtDetailGUID AS FtDetailGUID,
                                      b.ApplyDate             AS ApplyDate,
                                      b.ApproveStateEnum      AS ApproveStateEnum,
                                      b.ApproveState          AS ApproveState,
                                      17                      AS BillTypeEnum,
                                      '合同预付'                  AS BillType,
                                      b.ApplyCode             AS BillCode,
                                      b.Subject               AS BillName,
                                      b.ApplyAmount_Bz        AS BillAmount,
                                      b.AppliedByName         AS AppliedByName,
                                      a.SourceDate            AS SourceDate,
                                      a.FtAmount              AS FtAmount
                               FROM dbo.fy_HTFKApplyFtDetail       a WITH (NOLOCK)
                                        LEFT JOIN dbo.fy_HTFKApply b WITH (NOLOCK) ON b.HTFKApplyGUID = a.HTFKApplyGUID
                               WHERE a.SpecialBusinessUnitGUID = y.SpecialBusinessUnitGUID
                                 AND a.CostGUID = y.CostGUID
                                 AND a.SourceDate >= @BeginTime
                                 AND a.SourceDate <= @EndTime
                                 AND b.ApproveStateEnum IN (2, 3)
                                 AND b.IsPrepay = 1)                          z) t
WHERE t.FtDetailGUID IS NOT NULL
  AND t.FtAmount <> 0