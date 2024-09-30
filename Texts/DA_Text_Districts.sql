insert or replace into LocalizedText
    (Language,      Tag,                                                        Text)
values

    ("zh_Hans_CN",  "LOC_TOOLTIP_DISTRICT_CITIZEN_YIELDS_HEADER",               "每个在此区域中工作的 [ICON_Citizen] 专家收益："),
    ("zh_Hans_CN",  "LOC_CITIZEN_AMENITY",                                      "{1_Amount: number +#,###;-#,###} [ICON_Amenities] 宜居度"),
    ("zh_Hans_CN",  "LOC_TYPE_TRAIT_CITIZENSLOTS",                              "{1_Amount} [ICON_Citizen] 公民槽位"),


    ("zh_Hans_CN",  "LOC_DA_DISTRICT_CAMPUS_DESCRIPTION",                       "您城市中的科学发展区。"),
    ("zh_Hans_CN",  "LOC_DA_DISTRICT_COMMERCIAL_HUB_DESCRIPTION",               "城市中专注于金融和贸易的区域。"),
    ("zh_Hans_CN",  "LOC_DA_DISTRICT_THEATER_DESCRIPTION",                      "您城市里的文化传播区域。"),
    ("zh_Hans_CN",  "LOC_DA_DISTRICT_HOLY_SITE_DESCRIPTION",                    "您城市里的宗教祭祀区。可以作新宗教的发源地。其中建筑均可使用信仰值购买。"),
    ("zh_Hans_CN",  "LOC_DA_DISTRICT_ENCAMPMENT_DESCRIPTION",                   "您城市里的军事机构驻地。拥有区域防御，可作为陆地军事单位的征召地点，城市消耗 [ICON_CITIZEN] 人口加速单位和奇观的建造时不再消耗凝聚力。获得等于驻扎单位等级的 [ICON_PRODUCTION] 生产力相邻加成。"),
    ("zh_Hans_CN",  "LOC_ENCAMPMENT_CITIZEN_RUSH_UNITS_DESCRIPTION",            "花费{1_unity}凝聚力，城市将失去{2_pop} [ICON_Citizen] 人口，并为当前项目的建造投入{3_Amount} [ICON_PRODUCTION] 生产力。"), 
    ("zh_Hans_CN",  "LOC_ENCAMPMENT_CITIZEN_RUSH_UNITS_TITLE",                  "强制征召"), 
    ("zh_Hans_CN",  "LOC_ENCAMPMENT_CITIZEN_RUSH_UNITS_TOOLTIP",                "消耗 [ICON_CITIZEN] 人口和凝聚力加速单位或奇观的建造"), 
    ("zh_Hans_CN",  "LOC_ENCAMPMENT_CITIZEN_RUSH_UNITS_DISABLED_POP",           "[COLOR_Red]城市需要至少拥有2 [ICON_CITIZEN] 人口。[ENDCOLOR]"), 
    ("zh_Hans_CN",  "LOC_ENCAMPMENT_CITIZEN_RUSH_UNITS_DISABLED_UNITY",         "[COLOR_Red]需要拥有城市 [ICON_CITIZEN] 人口数量三倍的凝聚力。[ENDCOLOR]"), 

    ("zh_Hans_CN",  "LOC_PRODUCTION_TO_FOOD_ENABLED",                           "兴修水利:已开启[NEWLINE]为本城 [ICON_CITIZEN] 公民+1 [ICON_food] 食物并-1 [ICON_PRODUCTION] 生产力"), 
    ("zh_Hans_CN",  "LOC_PRODUCTION_TO_FOOD_DISABLED",                          "兴修水利:已关闭[NEWLINE]开启后，为本城 [ICON_CITIZEN] 公民+1 [ICON_food] 食物并-1 [ICON_PRODUCTION] 生产力"),

    ("zh_Hans_CN",  "LOC_DAM_TRANSITION_ENABLED",                               "当前状态：保障通航[NEWLINE]为本城相邻河流的区域+1 [ICON_production] 生产力。可以切换为“供给灌溉”"),
    ("zh_Hans_CN",  "LOC_DAM_TRANSITION_DISABLED",                              "当前状态：供给灌溉[NEWLINE]为本城相邻河流的单元格+1 [ICON_food] 食物。可以切换为“保障通航”"),


    ("zh_Hans_CN",  "LOC_DA_DISTRICT_HARBOR_DESCRIPTION",                       "城市中的海事相关区域。可作为海上军事单位的征召地点。"),
    ("zh_Hans_CN",  "LOC_DA_DISTRICT_ENTERTAINMENT_COMPLEX_DESCRIPTION",        "城市中供市民享乐的区域。"),
    ("zh_Hans_CN",  "LOC_DA_DISTRICT_AQUEDUCT_DESCRIPTION",                     "城市的水利区域，不占用城市可建造的区域总数，由建造者花费3 [ICON_Charges] 劳动力建造。区域从相邻河流、湖泊、绿洲或山脉引水，将水源供的 [ICON_Housing] 住房提升至6。若与地热裂缝相邻，提供+1 [ICON_Amenities] 宜居度。干旱时可防止 [ICON_Food] 食物损失。[NEWLINE]为本城+20%人口增长速度，允许本城开启“兴修水利”状态。"),
    ("zh_Hans_CN",  "LOC_DA_DISTRICT_DAM_DESCRIPTION",                          "城市的水利区域，不占用城市可建造的区域总数，由建造者花费4 [ICON_Charges] 劳动力建造。可使所在河流不再洪水泛滥（但来自洪水的产出减半），还可在干旱时防止 [ICON_Food] 食物损失。堤坝所在单元格必须至少有两个面被河流穿过。[NEWLINE]为本城相邻河流的单元格+2 [ICON_gold] 金币，城市在河流边建造区域时+30%建造速度，允许本城在“供给灌溉”和“保障通航”状态间切换。");

