SELECT Finish,PlanEndDate,BidGUID,* FROM jd_buildingplantask WHERE BidGUID = 'C451EF2E-07EC-E911-841E-0894EF72D17D'
                                                               -- and id='c93bbd82-c97b-4d51-bbe9-d03d89709e01';


select * from data_dict where table_name = 'jd_BuildingPlan'


select * from jd_BuildingPlan where ID = '8D587166-7BBD-4432-B76F-32FE3CE0C305'

select count(1) from jd_buildingplantask where Finish <> jd_BuildingPlanTask.PlanEndDate and Finish is not null



SELECT Finish, PlanEndDate,a.TaskName,a.TaskTypeName,jBPV.VersionNo,p.ProjName,bu.BUName,pb.BuildingName,t.TempletName, a.*,jBP.*
FROM jd_buildingplantask a
         left join jd_BuildingPlan jBP on a.PlanID = jBP.ID
         join jd_BuildingPlanVersion jBPV on jBP.VersionGUID = jBPV.VersionGUID
         join p_Project p on jbp.ProjGUID = p.ProjGUID
         join myBusinessUnit bu on bu.BUGUID = p.BUGUID
         left join p_ProjBuilding pb on pb.BuildingGUID = jbp.BuildingGUID
         left join jd_WBSTemplet t on jbp.TemplateGUID = t.WBSTempletGUID
WHERE bu.BUName = '广东公司' and ProjName like '佛科院项目%' and BuildingName = '1号楼' and a.TaskName = '完成地质详勘报告'
  -- and BidGUID = 'C451EF2E-07EC-E911-841E-0894EF72D17D' -- Finish <> PlanEndDate and


select * from myBusinessUnit where BUName  = '测试公司'

select * from p_Project where BUGUID = '389EC69B-8397-E211-86D9-E41F13B4B49E' order by ProjCode

select * from myUser where UserName = '佛科院计划'
update myuser set Password = '4076F862096D1536B6CAC6866E386685' where UserName = '佛科院计划'
select * from myUser where UserCode = 'mysofterp'

select distinct  table_name,table_name_c from data_dict where table_name_c like '%楼栋%'

select * from p_ProjBuilding where BuildingGUID = 'fd262a91-c8ec-e911-841e-0894ef72d17d'

select * from ep_Building where BldGUID = 'fd262a91-c8ec-e911-841e-0894ef72d17d'