RDX = nil
local Panning = false

Citizen.CreateThread(function()
	while RDX == nil do
		TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('rdx_goldpanning:Notify')
AddEventHandler('rdx_goldpanning:Notify', function(title, subtitle, opt1 ,opt2, duration)
	if Config.EnableNotify then
		exports['LRP_Notify']:DisplayLeftNotification(title, subtitle, opt1, opt2, duration)
	end
end)

RegisterNetEvent('rdx_goldpanning:StartPaning')
AddEventHandler('rdx_goldpanning:StartPaning', function()
    if not Panning then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local Water = Citizen.InvokeNative(0x5BA7A68A346A5A91, coords.x, coords.y, coords.z)
        for k,v in pairs(Config.WaterTypes) do
            if Water == Config.WaterTypes[k]['waterhash'] then
				Location = Config.WaterTypes[k]['name']
				Panning = true
                CrouchAnimAndAttach()
                Wait(6000)
                ClearPedTasks(ped)
                GoldShake()
                w = math.random(12000,28000)
				if Config.EnableMythicProgBar then
					TriggerEvent("mythic_progbar:client:progress", {
						name = "Searching_Pan",
						duration = w,
						label = 'Searching the Pan..',
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = false,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						}
					}, function(status)
						if not status then
							ClearPedTasks(ped)
							DeleteObject(entity)
							DeleteEntity(entity)
							TriggerServerEvent('rdx_goldpanning:FoundItem', Location)
							Panning = false
						end
					end)
				else
					Wait(w)
					ClearPedTasks(ped)
					DeleteObject(entity)
					DeleteEntity(entity)
					TriggerServerEvent('rdx_goldpanning:FoundItem')
					Panning = false
				end
				break
            end
        end
    end
end)

function CrouchAnimAndAttach()
    local dict = 'script_rc@cldn@ig@rsc2_ig1_questionshopkeeper'
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local boneIndex = GetEntityBoneIndexByName(ped, 'SKEL_R_HAND')
    local modelHash = GetHashKey('P_CS_MININGPAN01X')
    LoadModel(modelHash)
    entity = CreateObject(modelHash, coords.x+0.3, coords.y,coords.z, true, false, false)
    SetEntityVisible(entity, true)
    SetEntityAlpha(entity, 255, false)
    Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
    SetModelAsNoLongerNeeded(modelHash)
    AttachEntityToEntity(entity,ped, boneIndex, 0.2, 0.0, -0.2, -100.0, -50.0, 0.0, false, false, false, true, 2, true)

    TaskPlayAnim(ped, dict, 'inspectfloor_player', 1.0, 8.0, -1, 1, 0, false, false, false)
end

function GoldShake()
    local dict = 'script_re@gold_panner@gold_success'
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, 'SEARCH02', 1.0, 8.0, -1, 1, 0, false, false, false)
end

function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end