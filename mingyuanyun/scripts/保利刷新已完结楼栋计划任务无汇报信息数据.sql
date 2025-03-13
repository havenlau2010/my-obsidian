-------- ---- ---- ---- ---- ---- ----  脚本说明 Begin -------- ---- ---- ---- ---- ---- ----
/*********************************************************************************************
 刷新场景：
   1、已完工、已延期完工的楼栋计划任务 添加默认的已完工的汇报任务数据
 刷新条件：
    1、已完工、延期已完工 的楼栋计划任务
    2、楼栋计划任务 有关联 楼栋计划 和 有关联 楼栋计划版本是【当前状态】的 楼栋计划版本
    3、不存在 已汇报完工、已延期完工的汇报记录 的 楼栋计划任务
 注意：
    1、提示  【*_bak_*】表已存在 则将该表名全部改成新表名再执行
 *********************************************************************************************/
-------- ---- ---- ---- ---- ---- ----  脚本说明 End -------- ---- ---- ---- ---- ---- ----
if object_id('jd_BuildingPlanTask_bak_RepairFinshedTaskWithNoReport') > 0
    begin
        print  'Error====>>>>>已存在该备份表数据';
        -- drop table jd_BuildingPlanTask_bak_RepairFinshedTaskWithNoReport
    end

select a.*, newid() as TaskReportID into jd_BuildingPlanTask_bak_RepairFinshedTaskWithNoReport from jd_BuildingPlanTask        a
    join jd_buildingplan        b on a.PlanID = b.ID
    join jd_buildingplanversion g on b.versionGUid = g.versionguid and g.state = '当前版本'
where
      a.TaskState >= 20
  and not exists(select 1 from jd_TaskReport b where b.TaskID = a.ID and b.EffectTaskState in (20, 21))

-- select * from jd_BuildingPlanTask_bak_RepairFinshedTaskWithNoReport

insert jd_TaskReport( id, taskid, reporttype, reportmode, actualstart, actualfinish, actualduration, completerate
                    , expecteddelaydate, applyfordelaydate, completedescription, reportdate, reporter, lastwarningstate
                    , lastcompleterate, lasttaskstate, lastactualstart, lastactualfinish, lastdelaytimes
                    , lastapplyfordelaydate, lastfinish, approvestate, plantype, lasttaskname, lastactualduration
                    , lastexpecteddelaydate, effecttaskstate)
select a.TaskReportID
     , a.id, 5, 1, a.ActualStart, a.ActualFinish
     , a.ActualDuration, 100.0000, a.ExpectedDelayDate, a.ApplyForDelayDate, '已完成，历史数据异常后台处理'
     , a.ActualEndDate, a.Hbr, a.WarningState, a.completerate, a.TaskState
     , a.ActualStart, a.ActualFinish, a.DelayTimes, a.ApplyForDelayDate, a.Finish
     , 2, a.TaskState, a.TaskName, a.ActualDuration, a.ExpectedDelayDate
     , a.TaskState
from jd_BuildingPlanTask_bak_RepairFinshedTaskWithNoReport a

/*
 ------还原脚本------
 -- 如若需要还原数据，则去掉以下注释，执行即可。
 -- jd_BuildingPlanTask_bak_RepairFinshedTaskWithNoReport 提示不存在，请换成对应的 备份表即可
delete a FROM jd_BuildingPlanTask_bak_RepairFinshedTaskWithNoReport a join jd_TaskReport b on a.TaskReportID = b.ID
 */

/*
--- 分析脚本

-- 2651
select count(1)
from jd_BuildingPlanTask    a
    left join jd_TaskReport b on a.ID = b.TaskID
where a.TaskState in (20, 21) and  b.ID is null

-- 2657
select count(a.ID)
from jd_BuildingPlanTask    a
    left join jd_TaskReport b on a.ID = b.TaskID  and b.EffectTaskState in (20,21)
where a.TaskState >=20 and  b.ID is null

-- 2657
select count(a.ID)
from jd_BuildingPlanTask    a
where a.TaskState >=20 and  not exists(select 1 from jd_TaskReport b where b.TaskID = a.ID  and b.EffectTaskState in (20,21))

-- 2651
select count(a.ID)
from jd_BuildingPlanTask    a
where a.TaskState >=20 and  not exists(select 1 from jd_TaskReport b where b.TaskID = a.ID )

select count(a.ID)
from jd_BuildingPlanTask        a
    join jd_buildingplan        b on a.PlanID = b.ID
    join jd_buildingplanversion g on b.versionGUid = g.versionguid and g.state = '当前版本'
where
      a.TaskState >= 20
  and not exists(select 1 from jd_TaskReport b where b.TaskID = a.ID and b.EffectTaskState in (20, 21))

-- 1186
select count(a.id)
from jd_buildingplantask             a
    left join jd_taskreport          b on a.id = b.taskid
    left join jd_buildingplan        c on a.planid = c.id
    left join jd_buildingplanversion g on c.versionGUid = g.versionguid
    left join p_ProjBuilding         d on c.buildingGuid = d.BuildingGUID
    left join p_Project              e on c.projguid = e.projguid
    left join mybusinessunit         f on e.buguid = f.buguid
where
      a.TaskState >= 20
  and b.id is null
  and g.state = '当前版本'
-- order by f.buname,e.ProjName,d.buildingname,a.taskname
 */