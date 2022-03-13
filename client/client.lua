ESX = nil
local hasCinematic = false
local hasCinematics = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    while true do 
       Citizen.Wait(500)
       if VarColor == Config.couleur.couleur1 then VarColor = Config.couleur.couleur2 else VarColor = Config.couleur.couleur1 end 
   end 
end)


 -- MENU
 local mainMenu = RageUI.CreateMenu("", "Filtre") 
 local MenuPrincipal = RageUI.CreateSubMenu(mainMenu, "", "Dream Dev'") -- Changer ici pour changer le nom dans les menus
 local menufiltre1 = RageUI.CreateSubMenu(MenuPrincipal, "", "Dream Dev'") -- Changer ici pour changer le nom dans les menus
 local menuoptions = RageUI.CreateSubMenu(MenuPrincipal, "", "Dream Dev'") -- Changer ici pour changer le nom dans les menus
 local menuoptimisation = RageUI.CreateSubMenu(MenuPrincipal, "", "Dream Dev'") -- Changer ici pour changer le nom dans les menus
 local open = false
 
 mainMenu.Closed = function() 
     open = false 
 end 
 
 function menufiltre()
     if open then 
         open = false 
             RageUI.Visible(MenuPrincipal, false) 
         return 
     else 
         open = true 
             RageUI.Visible(MenuPrincipal, true)
         Citizen.CreateThread(function()
             while open do 
					   RageUI.IsVisible(MenuPrincipal, function()

                        RageUI.Button("Menu Filtre", "Menu pour voir tous les filtres", {RightLabel = "→→→"}, true, {
							onSelected = function()
						end
						}, menufiltre1)

						   RageUI.Button("Options", "Menu pour voir toutes les options", {RightLabel = "→→→"}, true, {
							onSelected = function()
						end
						}, menuoptions)

                        RageUI.Button("Optimisation", "Menu pour voir toutes les optimisations possible", {RightLabel = "→→→"}, true, {
							onSelected = function()
						end
						}, menuoptimisation)

                        RageUI.Button("Fermer le menu", "Permet de fermer le menu", {RightLabel = ""}, true, {
                            onSelected = function()
                                open = false
                                end
                        })

            end)


            RageUI.IsVisible(menufiltre1, function()

                RageUI.Separator(VarColor.."↓ Filtre ↓") 

                   RageUI.Button("Filtre normal", "Remettre le filtre de base", {RightLabel = ""}, true, {
                    onSelected = function()
                        SetTimecycleModifier('')
                        ESX.ShowNotification('Vous avez mit le filtre ' ..Config.couleurnotif..'"Normal"~w~')
                        PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                        Citizen.Wait(1)
                        end
                })

                RageUI.Button("Couleurs Améliorée", "Mettre le filtre couleurs améliorée", {RightLabel = ""}, true, {
                    onSelected = function()
                        SetTimecycleModifier('tunnel')
                        ESX.ShowNotification('Vous avez mit le filtre '..Config.couleurnotif..'"Couleurs améliorée"~w~')
                        PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                        Citizen.Wait(1)
                        end
                })

                RageUI.Button("Couleur Amplifiées", "Mettre le filtre couleurs amplifiées", {RightLabel = ""}, true, {
                    onSelected = function()
                        SetTimecycleModifier('rply_saturation')
                        ESX.ShowNotification('Vous avez mit la vue en '..Config.couleurnotif..'"Amplifiées"~w~')
                        PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                        Citizen.Wait(1)
                end
                })

                RageUI.Button("Cinema", "Mettre le filtre cinema", {RightLabel = ""}, true, {
                    onSelected = function()
                        SetTimecycleModifier('cinema')
                        ESX.ShowNotification('Vous avez mit la vue en mode '..Config.couleurnotif..'"Cinema"~w~')
                        PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                        Citizen.Wait(1)
                    end
                })

                RageUI.Button("Noir et blanc", "Mettre le filtre noir et blanc", {RightLabel = ""}, true, {
                    onSelected = function()
                        SetTimecycleModifier('rply_saturation_neg')
                        ESX.ShowNotification('Vous avez mit la vue en '..Config.couleurnotif..'"Noir et blanc"~w~')
                        PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                        Citizen.Wait(1)
                    end
                })

    end)

    RageUI.IsVisible(menuoptions, function()

        RageUI.Separator(VarColor.."↓ Options ↓") 

           RageUI.Button("Afficher/cacher l'HUD", "Afficher/cacher l'HUD", {RightLabel = ""}, true, {
            onSelected = function()
                hudonoff = not hudonoff
                if hudonoff == true then
                    ESX.UI.HUD.SetDisplay(0.0)
                    TriggerEvent('es:setMoneyDisplay', 0.0) -- modifier les triggers si se ne sont pas les bon
                    TriggerEvent('esx_status:setDisplay', 0.0)
                    ExecuteCommand('togglehud off')
                else
                    ESX.UI.HUD.SetDisplay(1.0)
                    TriggerEvent('es:setMoneyDisplay', 1.0)
                    TriggerEvent('esx_status:setDisplay', 1.0)
                    ExecuteCommand('togglehud on')
                end
                end
        })

        RageUI.Button("Afficher/cacher la map", "Afficher/cacher la map", {RightLabel = ""}, true, {
            onSelected = function()
                maponoff = not maponoff
                if maponoff == true then
                    DisplayRadar(false)
                else
                    DisplayRadar(true)
                end
                end
        })

        RageUI.Button("Mode cinematique", "Activer/Desactiver le mode cinematique", {RightLabel = ""}, true, {
            onSelected = function()
                hasCinematic = not hasCinematic
                if hasCinematic == true then
                    SendNUIMessage({openCinema = true})
                    ESX.UI.HUD.SetDisplay(0.0)
                    TriggerEvent('es:setMoneyDisplay', 0.0)
                    TriggerEvent('esx_status:setDisplay', 0.0)
                    DisplayRadar(false)
                    ExecuteCommand('togglehud off')
                else
                    SendNUIMessage({openCinema = false})
                    ESX.UI.HUD.SetDisplay(1.0)
                    TriggerEvent('es:setMoneyDisplay', 1.0)
                    TriggerEvent('esx_status:setDisplay', 1.0)
                    DisplayRadar(true)
                    ExecuteCommand('togglehud on')
                end
                end
        })

        RageUI.Button("Juste les barres noir", "Activer/Desactiver juste les barres noir", {RightLabel = ""}, true, {
            onSelected = function()
                hasCinematics = not hasCinematics
                if hasCinematics == true then
                    SendNUIMessage({openCinema = true})
                    ESX.UI.HUD.SetDisplay(0.0)
                else
                    SendNUIMessage({openCinema = false})
                end
                end
        })

end)

RageUI.IsVisible(menuoptimisation, function()

    RageUI.Separator(VarColor.."↓ Optimisation ↓") 

       RageUI.Button("Syncronisation", "Syncronisation", {RightLabel = ""}, true, {
        onSelected = function()
            Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
            ClearWeatherTypePersist()
            SetWeatherTypeNowPersist(CurrentWeather)
            SetWeatherTypeNow(CurrentWeather)
            SetWeatherTypePersist(CurrentWeather)
            ESX.ShowNotification(Config.couleurnotif..'Syncronisation effectuée !')
            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
            Citizen.Wait(1)
            end
    })

    RageUI.Button("Optimisation", "Optimiser le plus de chose possible", {RightLabel = ""}, true, {
        onSelected = function()
            ESX.ShowNotification(Config.couleurnotif..'Optimisation en cours...')
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            ClearHelp()
            ClearNotificationsPos()
            ClearPedInPauseMenu()
            ClearFloatingHelp()
            ClearGpsPlayerWaypoint()
            ClearGpsRaceTrack()
            ClearReminderMessage()
            ClearThisPrint()
        
            Citizen.Wait(2090)
            RemoveLoadingPrompt()
            Citizen.Wait(100)
            ESX.ShowNotification(Config.couleurnotif..'Optimisation effectuée !')
            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
            Citizen.Wait(1)
            end
    })

end)
			 

                
             Wait(0)
             end
         end)
     end
 end
 
 -- MARKERS
 
Keys.Register(Config.touche, 'FILTRE', 'Ouvrir le menu des filtres', function()
    menufiltre()
end)

print("^6Dream Dev' : discord.gg/47TbZDCeun | Dev par Quentin-Dream#2053^7")

-- ! LE MENU N'AS PAS ETE CREE 100% PAR MOI, IL Y A CERTAINE FONCTION QUI ON ETE REPRISE DE D'AUTRE SCRIPT ! --