ESX = exports["es_extended"]:getSharedObject()

RegisterCommand("halloween", function()
	OpenHalloweenShop()
end)

OpenHalloweenShop = function(_type)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pistol_menu', {
		title = "Sklep Halloween 🎃",
		align = 'center',
		elements = {
			{label = "x1 Limitowane Auto Halloweenowe - 50000x Cukierek Halloween", cfgid = "limitafura"},
			{label = "x1 Skrzynia Kart Graficznych 50/50 - 20000x Cukierek Halloween", cfgid = "karta_graficzna"},
			{label = "x1 Amulet Szybkości - 7500x Cukierek Halloween", cfgid = "amulet_speed"},
			{label = "x1 Skrzynia OnlyCase - 550x Cukierek Halloween", cfgid = "halloweencase"},
			{label = "x10000 Gotówka - 15x Cukierek Halloween", cfgid = "cash"},
        }
	}, function(data, menu)
		TriggerServerEvent("nh-halloween:buyItem", data.current.cfgid)
        menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent("nh-halloween:useAmulet", function()
	FreezeEntityPosition(PlayerPedId(), true)
	if(Config.IsOnly) then
		exports["only_taskbar"]:progresBar(3500, "Uzywanie Amuletu", false, true)
	end
	FreezeEntityPosition(PlayerPedId(), false)
	local timer = 0
	local playerPed  = PlayerPedId()
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 18905)
	ESX.ShowNotification("~b~Użyto ~r~[Amulet Szybkości]")
	while timer < 3600 do
		ResetPlayerStamina(player)
		SetRunSprintMultiplierForPlayer(player, 1.48)
		Citizen.Wait(2000)
		timer = timer + 2
		SetRunSprintMultiplierForPlayer(player, 1.0)
	end
end)




-- local PedProperties = {
--     ["Running"] = false,
--     ["Shooting"] = false

-- }

-- local SafeEvents = {}

-- local Ped = {
--     ["Id"] = PlayerPedId()
-- }

-- DecorRegister('RegisterZombie', 2)

-- AddRelationshipGroup('ZOMBIE')
-- SetRelationshipBetweenGroups(0, GetHashKey('ZOMBIE'), GetHashKey('PLAYER'))
-- SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), GetHashKey('ZOMBIE'))

-- CreateThread(function()
--     while(1) do
--         Wait(1500)
--         Ped = {
--             ["Id"] = PlayerPedId()
--         }

--         ESX.TriggerServerCallback("nh-haloween:getEvents", function(res)
--             SafeEvents = res
--         end)
--     end
-- end)

-- CreateThread(function()
--     while(1) do
--         Wait(50)
--         if(IsPedRunning(Ped.Id)) then
--             PedProperties["Running"] = true
--         else
--             PedProperties["Running"] = false
--         end

--         if(IsPedShooting(Ped.Id)) then
--             PedProperties["Shooting"] = true
--         else
--             PedProperties["Shooting"] = false
--         end
--     end
-- end)

-- CreateThread(function()
--     while(1) do
--         Wait(1000)

--         SetPedDensityMultiplierThisFrame(1.0)
--         SetScenarioPedDensityMultiplierThisFrame(1.0, 1.0)

--         SetRandomVehicleDensityMultiplierThisFrame(0.0)
--         SetParkedVehicleDensityMultiplierThisFrame(0.0)
--         SetVehicleDensityMultiplierThisFrame(0.0)
--     end
-- end)
-- -- TEST

-- Citizen.CreateThread(function()
--     while true do
--         Wait(20)
	        
-- 		local Zombie = -1
-- 	 	local Success = false
-- 		local Handler, Zombie = FindFirstPed()

-- 	    repeat
--         	Citizen.Wait(10)

--             -- if(GetEntityHealth(Zombie) <= 1 or IsPedDeadOrDying(Zombie)) then

-- 			-- 	-- TriggerServerEvent(SafeEvents["GiveReward"])
--             --     -- DeleteEntity(Zombie)
--             --     -- Wait(50)
--             -- end

-- 	        if IsPedHuman(Zombie) and not IsPedAPlayer(Zombie) and not IsPedDeadOrDying(Zombie, true) then
-- 	            if not DecorExistOn(Zombie, 'RegisterZombie') then
-- 	                ClearPedTasks(Zombie)
-- 	                ClearPedSecondaryTask(Zombie)
-- 	                ClearPedTasksImmediately(Zombie)
-- 	                TaskWanderStandard(Zombie, 10.0, 10)
-- 	                SetPedRelationshipGroupHash(Zombie, 'ZOMBIE')
-- 	                ApplyPedDamagePack(Zombie, 'BigHitByVehicle', 0.0, 1.0)
-- 	                SetEntityHealth(Zombie, 200)

-- 	                RequestAnimSet('move_m@drunk@verydrunk')
-- 	                while not HasAnimSetLoaded('move_m@drunk@verydrunk') do
-- 	                    Citizen.Wait(0)
-- 	                end
-- 	                SetPedMovementClipset(Zombie, 'move_m@drunk@verydrunk', 1.0)

-- 	                SetPedConfigFlag(Zombie, 100, false)
-- 	                DecorSetBool(Zombie, 'RegisterZombie', true)
-- 	            end

-- 	            SetPedRagdollBlockingFlags(Zombie, 1)
-- 			    SetPedCanRagdollFromPlayerImpact(Zombie, false)
-- 			    SetPedSuffersCriticalHits(Zombie, true)
-- 			    SetPedEnableWeaponBlocking(Zombie, true)
-- 			    DisablePedPainAudio(Zombie, true)
-- 			    StopPedSpeaking(Zombie, true)
-- 			    SetPedDiesWhenInjured(Zombie, false)
-- 			    StopPedRingtone(Zombie)
-- 			    SetPedMute(Zombie)
-- 			    SetPedIsDrunk(Zombie, true)
-- 			    SetPedConfigFlag(Zombie, 166, false)
-- 			    SetPedConfigFlag(Zombie, 170, false)
-- 			    SetBlockingOfNonTemporaryEvents(Zombie, true)
-- 			    SetPedCanEvasiveDive(Zombie, false)
-- 			    RemoveAllPedWeapons(Zombie, true)

-- 	            local PlayerCoords = GetEntityCoords(PlayerPedId())
-- 	            local PedCoords = GetEntityCoords(Zombie)
-- 	            local Distance = #(PedCoords - PlayerCoords)
-- 	            local DistanceTarget

-- 				if(#(PlayerCoords - PedCoords) <= 10.0) then
-- 					print(123)
-- 					if(IsPedDeadOrDying(Zombie)) then
-- 						ESX.Game.Utils.DrawText3D(PedCoords, "TEST", 1, 1)
-- 					end
-- 				else
-- 					print(321)
-- 				end
-- 				print(#(PlayerCoords - PedCoords))

-- 	           	if PedProperties["Shooting"] then
-- 	                DistanceTarget = 120.0
-- 	            elseif PedProperties["Running"] then
-- 	                DistanceTarget = 50.0
-- 	            else
-- 	                DistanceTarget = 20.0
-- 	            end

-- 	            if Distance <= DistanceTarget and not IsPedInAnyVehicle(PlayerPedId(), false) then
-- 	                TaskGoToEntity(Zombie, PlayerPedId(), -1, 0.0, 2.0, 1073741824, 0)
-- 	            end

-- 	            if Distance <= 1.3 then
-- 	                if not IsPedRagdoll(Zombie) and not IsPedGettingUp(Zombie) then
-- 	                	local health = GetEntityHealth(PlayerPedId())
-- 	                    if health == 0 then
-- 	                        ClearPedTasks(Zombie)
-- 	                        TaskWanderStandard(Zombie, 10.0, 10)
-- 	                    else
-- 	                        RequestAnimSet('melee@unarmed@streamed_core_fps')
-- 	                        while not HasAnimSetLoaded('melee@unarmed@streamed_core_fps') do
-- 	                            Citizen.Wait(10)
-- 	                        end

-- 	                        TaskPlayAnim(Zombie, 'melee@unarmed@streamed_core_fps', 'ground_attack_0_psycho', 8.0, 1.0, -1, 48, 0.001, false, false, false)

-- 	                        ApplyDamageToPed(PlayerPedId(), 5, false)
-- 	                    end
-- 	                end
-- 	            end
	            
-- 	            if not NetworkGetEntityIsNetworked(Zombie) then
-- 	                DeleteEntity(Zombie)
-- 	            end
-- 	        end
	        
-- 	        Success, Zombie = FindNextPed(Handler)
-- 	   	until not (Success)

--     	EndFindPed(Handler)
--    	end
-- end)
