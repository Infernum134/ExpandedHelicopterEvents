EHE_OpenBox = {}

function EHE_OpenBox.CanOpenBoxes(scriptItems)
	scriptItems:addAll(getScriptManager():getItemsTag("CanOpenBoxes"))
end


function EHE_OpenBox.FOOD(recipe, result, player)
	player:getInventory():AddItems("Base.WaterBottleFull", 20)
	player:getInventory():AddItems("Base.Rice", 5)
	player:getInventory():AddItems("Base.TinnedBeans", 10)
end

---@param player IsoGameCharacter | IsoMovingObject
function EHE_OpenBox.MEDICAL(recipe, result, player)
	player:getInventory():AddItems("Hat_DustMask", 6)
	player:getInventory():AddItems("Gloves_Surgical", 12)
	local items = player:getInventory():AddItems("Base.FirstAidKit", 4)

	for i=0, items:size()-1 do
		rollInventoryContainer(items:get(i), player)
	end
end


function EHE_OpenBox.SURVIVAL(recipe, result, player)
	player:getInventory():AddItems("Base.Torch", 2)
	player:getInventory():AddItems("Base.Battery", 10)
	player:getInventory():AddItems("Radio.RadioBlack", 2)
end

function EHE_OpenBox.STASHBOX(recipe, result, player)
	player:getInventory():AddItems("WhiskeyFull", 4)
	player:getInventory():AddItems("Cigarettes", 4)
	player:getInventory():AddItems("Lighter", 2)
	player:getInventory():AddItems("Pills", 4)
	player:getInventory():AddItems("HottieZ", 10)
	player:getInventory():AddItems("Pistol2", 1)
	player:getInventory():AddItems("45Clip", 4)
	player:getInventory():AddItems("Bullets45Box", 4)
end

EHE_OpenBox.typesThatCanOpenBoxes = EHE_OpenBox.typesThatCanOpenBoxes or {}

---@param list table of type paths
function EHE_OpenBox.addCanOpenBoxTypes(list)
	for _,type in pairs(list) do
		table.insert(EHE_OpenBox.typesThatCanOpenBoxes, type)
	end
end

---Sub-mod authors will have to use the following function to add more types
EHE_OpenBox.addCanOpenBoxTypes(
		{"Base.Fork","Base.ButterKnife","Base.HuntingKnife","Base.KitchenKnife",
		 "Base.Scissors","Base.Scalpel","Base.MeatCleaver","Base.FlintKnife","Base.Machete","Base.Katana",})


---Adds "CanOpenBoxes" tag to scripts for type
---@param type string
function EHE_OpenBox.addCanOpenBoxesTag(type)
	local item = ScriptManager.instance:getItem(type);
	if item then
		local tags = item:getTags()
		local tagString = "CanOpenBoxes"

		for i=0, tags:size()-1 do
			---@type string
			local tag = tags:get(i)
			tagString = tagString..";"..tag
		end

		item:DoParam("Tags = "..tagString);
		print("--AddTag:"..type..": "..tagString);
	end
end

---For each type in EHE_OpenBox.addCanOpenBoxTypes process EHE_OpenBox.addCanOpenBoxesTag(type)
function EHE_OpenBox.addCanOpenBoxesTagToTypesThatCan()
	for _,type in pairs(EHE_OpenBox.typesThatCanOpenBoxes) do
		EHE_OpenBox.addCanOpenBoxesTag(type)
	end
end

Events.OnGameBoot.Add(EHE_OpenBox.addCanOpenBoxesTagToTypesThatCan)
