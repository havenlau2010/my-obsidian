
 -- ef47544b-cbec-e911-841e-0894ef72d17d&ProjGUID=019d4086-eff1-e711-8f2a-40f2e9d83efd&funcid=31010101&type=m&isPub=0
select * from p_ProjBuilding where ProjGUID='019d4086-eff1-e711-8f2a-40f2e9d83efd'


 SELECT BuildingGUID
      , BuildingCode
      , Floor
      , ProductTypeCode
      , ProductTypeName
      , ProjBidGUID
      , BidName
 FROM p_ProjBuilding where BuildingGUID = 'fd262a91-c8ec-e911-841e-0894ef72d17d'

select * from p_ProjBid where ProjBidGUID = 'C451EF2E-07EC-E911-841E-0894EF72D17D'

select * from data_dict where table_name = 'p_ProjBid'