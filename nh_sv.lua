ESX = exports["es_extended"]:getSharedObject()

Server_Config = {
    ["halloweencase"] = {
        ["Price"] = 550,
        ["ItemName"] = "vikonowa",
        ["ItemCount"] = 1 
    },
    ["amulet_speed"] = {
        ["Price"] = 7500,
        ["ItemName"] = "amulet_speed",
        ["ItemCount"] = 1
    },
    ["karta_graficzna"] = {
        ["Price"] = 20000,
        ["ItemName"] = "50karta",
        ["ItemCount"] = 1
    },
    ["limitafura"] = {
        ["Price"] = 50000,
        ["ItemName"] = "bon46",
        ["ItemCount"] = 1
    },
    ["cash"] = {
        ["Price"] = 15,
        ["ItemName"] = "cash",
        ["ItemCount"] = 15000
    }
}

RegisterServerEvent('esx:onPlayerDeath', function(data)
	local killerSource = data["killerServerId"]
    local killerData = ESX.GetPlayerFromId(killerSource)

    killerData.addInventoryItem("cukieras", math.random(1, 10))
end)

RegisterServerEvent("nh-halloween:buyItem", function(confidId)
    local src = source 
    local data = ESX.GetPlayerFromId(src)
    ItemProperties = {
        ["Price"] = Server_Config[confidId].Price,
        ["ItemName"] = Server_Config[confidId].ItemName,
        ["ItemCount"] = Server_Config[confidId].ItemCount
    }

    if(data.getInventoryItem("cukieras").count >= ItemProperties["Price"]) then
        if(confidId == "cash") then
            print(ItemProperties["ItemCount"])
            data.addMoney(ItemProperties["ItemCount"])
        else
            data.addInventoryItem(ItemProperties["ItemName"], ItemProperties["ItemCount"])
        end
        data.removeInventoryItem("cukieras", ItemProperties["Price"])
        if(Config.IsOnly) then
            exports['only_logs']:SendLog(src, "Kupił ze sklepu halloween: " .. ItemProperties["ItemName"] .. " w ilości: " .. ItemProperties["ItemCount"].. " za: " .. ItemProperties["Price"], "halloweensklep")
        end
    else
        data.showNotification("~b~Nie Posidasz wystarczająco ~r~[Cukierek Halloween]")
    end
end)


ESX.RegisterUsableItem("amulet_speed", function(source)
    local src = source 
    local data = ESX.GetPlayerFromId(src)

    TriggerClientEvent("nh-halloween:useAmulet", src)
end)