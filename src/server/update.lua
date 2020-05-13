---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by iTexZ.
--- DateTime: 13/05/2020 14:12
---

local project = "RageUI"
local api = "https://api.dylan-malandain.io/github/opensource/"

RegisterNetEvent('rageui:version')
AddEventHandler('rageui:version', function()
    PerformHttpRequest(string.format('%s%s', api, project), function(error, response, headers)
        local data = json.decode(response)
        local current = json.decode(LoadResourceFile(GetCurrentResourceName(), 'rageui.json'))
        -- current.version
        print('\n')
        print('^0-------------------------------------------------------------------------------')
        if (data ~= nil) then
            if (data.request.error == false) then
                if (data.data.version > current.version) then
                    print(string.format('[rageui] ^6API - Response Time : %s^0', data.request.executionTime))
                    print(string.format('[rageui] ^8You need to update your %s version. You version is %s last is %s^0', data.data.name, current.version, data.data.version))
                    print('\n')
                    print('[rageui] Patch Notes')
                    local content = json.decode(data.data.patch_notes)[1]
                    for i = 1, #content.content do
                        for x, v in pairs(content.content[i]) do
                            print(string.format('%s %s', '^0[rageui]', v))
                        end
                    end
                    print('\n')
                    print(string.format('^0[rageui] Download last update here : ^6https://github.com/iTexZoz/%s', project))
                else
                    print("\n")
                    print(string.format('[rageui] ^2You have the latest version of RageUI.^0'))
                    -- Is Update
                end
            else
                print("\n")
                print(string.format('[rageui] ^8An error occurred while retrieving from the remote api.^0'))
            end
            local content = json.decode(data.data.patch_notes)[1]
            print("\n")
            print(string.format('%s %s', '^0[rageui]', content.additional[1]))
        else
            print("\n")
            print(string.format('[rageui] ^8An error occurred while retrieving from the remote api.^0'))
        end
        print('\n')
        print('^0-------------------------------------------------------------------------------')
        print('\n')
    end, 'GET', '', { ["Content-Type"] = 'application/json' })
end)

Citizen.CreateThread(function()
    while true do
        TriggerEvent('rageui:version')
        Citizen.Wait(100 * 1000)
    end
end)
