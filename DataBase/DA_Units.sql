


UPDATE Units SET Cost = 48, CostProgressionParam1 = 8 WHERE UnitType = 'UNIT_BUILDER';
UPDATE Units SET Cost = 80, CostProgressionParam1 = 40 WHERE UnitType = 'UNIT_SETTLER';
UPDATE Units SET Cost = 75, CostProgressionParam1 = 25, 
CostProgressionModel = 'COST_PROGRESSION_PREVIOUS_COPIES' WHERE UnitType = 'UNIT_TRADER';
UPDATE Units SET Cost = 150, CostProgressionParam1 = 10 WHERE UnitType = 'UNIT_APOSTLE';
UPDATE Units SET Cost = 75, CostProgressionParam1 = 5 WHERE UnitType = 'UNIT_MISSIONARY';
-- add worker's basic building charges
update Units set BuildCharges = 4 where UnitType = 'UNIT_BUILDER' and BuildCharges < 4;


-- update UnitOperations set BaseProbability = 10, Turns = 1 where OperationType like 'UNITOPERATION_SPY%';
-- update Districts set TravelTime = 1;



