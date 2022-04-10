ESX = nil

local isMenuOpened = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
end)

local empla1 = true
local empla2 = true
local empla3 = true

cempla1 = vector3(-48.80249786377,-1093.8685302734,26.422357559204) -- config emplacement 1
cempla2 = vector3(-42.96117401123,-1094.5404052734,26.422351837158) -- config emplacement 2
cempla3 = vector3(-37.964790344238,-1096.7630615234,26.422351837158) -- config emplacement 3

cate = {}
voitureliste = {}

RMenu.Add("atmos", "categorie", RageUI.CreateMenu("Choix catégorie", "~b~Options :", nil, nil, "aLib", "black"))
RMenu:Get("atmos", "categorie").Closed = function()
	FreezeEntityPosition(PlayerPedId(), false)
	isMenuOpened = false
end

RMenu.Add("atmos", "voiture", RageUI.CreateSubMenu(RMenu:Get("atmos", "categorie"), "Choix voiture", nil))
RMenu:Get("atmos", "voiture").Closed = function()end

RMenu.Add("atmos", "emplacement", RageUI.CreateSubMenu(RMenu:Get("atmos", "voiture"), "Choix emplacement", nil))
RMenu:Get("atmos", "emplacement").Closed = function()end

RMenu.Add("atmos", "confirme", RageUI.CreateSubMenu(RMenu:Get("atmos", "emplacement"), "Confirmer", nil))
RMenu:Get("atmos", "confirme").Closed = function()end

RMenu.Add("atmos", "confirme2", RageUI.CreateSubMenu(RMenu:Get("atmos", "emplacement"), "Confirmer", nil))
RMenu:Get("atmos", "confirme2").Closed = function()end

RMenu.Add("atmos", "confirme3", RageUI.CreateSubMenu(RMenu:Get("atmos", "emplacement"), "Confirmer", nil))
RMenu:Get("atmos", "confirme3").Closed = function()end


local function openMenu()
	
	FreezeEntityPosition(PlayerPedId(), true)

    if isMenuOpened then return end
    isMenuOpened = true

	RageUI.Visible(RMenu:Get("atmos","categorie"), true)

	Citizen.CreateThread(function()
        while isMenuOpened do 
            RageUI.IsVisible(RMenu:Get("atmos","categorie"),true,true,true,function()
                for category = 1, #cate, 1 do
                    RageUI.ButtonWithStyle(""..cate[category].label, nil, {}, true,function(h,a,s)
                        if (s) then
                            label = cate[category].label
                            name = cate[category].name
                        end
                    end, RMenu:Get("atmos", "voiture"))
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos","voiture"),true,true,true,function()
                ESX.TriggerServerCallback('expo:voiture', function(keys2)
                    voitureliste = keys2
                end)
                for voiture = 1, #voitureliste, 1 do
                    if voitureliste[voiture].category == name then
                        RageUI.ButtonWithStyle(""..voitureliste[voiture].name, nil, {}, true,function(h,a,s)
                            if s then
                                name = voitureliste[voiture].name
                                model2 = voitureliste[voiture].model
                            end
                        end, RMenu:Get("atmos", "emplacement"))
                    end
                end
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos","emplacement"),true,true,true,function()
                RageUI.Separator("~r~→ ~b~Voiture : ~s~" ..name.. " ~r~←")
                RageUI.ButtonWithStyle("Emplacement 1", nil, {}, true,function(a,h,s)
                    if h then 
                        DrawMarker(20,cempla1.x,cempla1.y,cempla1.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                    end
                end, RMenu:Get("atmos", "confirme"))
                RageUI.ButtonWithStyle("Emplacement 2", nil, {}, true,function(a,h,s)
                    if h then 
                        DrawMarker(20,cempla2.x,cempla2.y,cempla2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                    end
                end, RMenu:Get("atmos", "confirme2"))
                RageUI.ButtonWithStyle("Emplacement 3", nil, {}, true,function(a,h,s)
                    if h then 
                        DrawMarker(20,cempla3.x,cempla3.y,cempla3.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                    end
                end, RMenu:Get("atmos", "confirme3"))
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos","confirme"),true,true,true,function()
                RageUI.ButtonWithStyle("Confirmer", nil, {}, empla1,function(h,a,s)
                    if s then
                        local model = GetHashKey(model2)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Wait(1) end
                        vehicle = CreateVehicle(model, cempla1.x,cempla1.y,cempla1.z, 190.92, true, false)
                        SetVehicleDoorsLocked(vehicle, 2)
                        FreezeEntityPosition(vehicle, true)
                        ESX.ShowNotification("Véhicule spawn !")
                        empla1 = false
                    end
                end)
                RageUI.ButtonWithStyle("Supprimer véhicule", nil, {}, not empla1,function(h,a,s)
                    if s then
                        DeleteEntity(vehicle)
                        ESX.ShowNotification("Véhicule supprimé !")
                        empla1 = true
                    end
                end)
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos","confirme2"),true,true,true,function()
                RageUI.ButtonWithStyle("Confirmer", nil, {}, empla2,function(h,a,s)
                    if s then
                        local model = GetHashKey(model2)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Wait(1) end
                        vehicle2 = CreateVehicle(model, cempla2.x,cempla2.y,cempla2.z, 156.01, true, false)
                        SetVehicleDoorsLocked(vehicle2, 2)
                        FreezeEntityPosition(vehicle2, true)
                        ESX.ShowNotification("Véhicule spawn !")
                        empla2 = false
                    end
                end)
                RageUI.ButtonWithStyle("Supprimer véhicule", nil, {}, not empla2,function(h,a,s)
                    if s then
                        DeleteEntity(vehicle2)
                        ESX.ShowNotification("Véhicule supprimé !")
                        empla2 = true
                    end
                end)
            end, function()end, 1)
            RageUI.IsVisible(RMenu:Get("atmos","confirme3"),true,true,true,function()
                RageUI.ButtonWithStyle("Confirmer", nil, {}, empla3,function(h,a,s)
                    if s then
                        local model = GetHashKey(model2)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Wait(1) end
                        vehicle3 = CreateVehicle(model, cempla3.x,cempla3.y,cempla3.z, 133.46, true, false)
                        SetVehicleDoorsLocked(vehicle3, 2)
                        FreezeEntityPosition(vehicle3, true)
                        ESX.ShowNotification("Véhicule spawn !")
                        empla3 = false
                    end
                end)
                RageUI.ButtonWithStyle("Supprimer véhicule", nil, {}, not empla3,function(h,a,s)
                    if s then
                        DeleteEntity(vehicle3)
                        ESX.ShowNotification("Véhicule supprimé !")
                        empla3 = true
                    end
                end)
            end, function()end, 1)
            
            Wait(0)
        end
    end)
end



local position = {
    {x = -33.625854492188 , y = -1103.39453125, z = 26.422348022461}   -- config point menu    
}

Citizen.CreateThread(function()
    while true do
        interval = 750
        for k in pairs(position) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            if dist <= 1.2 and not isMenuOpened then
                interval = 1
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour voir les véhicule à exposer")
                if IsControlJustPressed(1,51) then
                    openMenu()
                    ESX.TriggerServerCallback('expo:cat', function(keys)
                        cate = keys
                    end)
                end
            end
        end
    Citizen.Wait(interval)
    end
end)
