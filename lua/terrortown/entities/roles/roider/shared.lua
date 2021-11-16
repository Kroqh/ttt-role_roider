if SERVER then
	  AddCSLuaFile()
    resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_roid.vmt")
end

function ROLE:PreInitialize()
    self.color                      = Color(210, 31, 60, 255)

    self.abbr                       = "roid"

    self.preventFindCredits         = false
    self.preventKillCredits         = false
    self.preventTraitorAloneCredits = false
    self.preventWin                 = false
    self.unknownTeam                = false
    self.defaultTeam                = TEAM_TRAITOR


    -- do settings
    self.conVarData = {
        pct          = 0.25, -- necessary: percentage of getting this role selected (per player)
        maximum      = 1, -- maximum amount of roles in a round
        minPlayers   = 5, -- minimum amount of players until this role is able to get selected
        togglable    = true, -- option to toggle a role for a client if possible (F1 menu)
        random       = 33

    }

    teamKillsMultiplier = -1

    killsMultiplier = 1

    bodyFoundMuliplier = 0


    surviveBonusMultiplier = 1

    survivePenaltyMultiplier = 0

    aliveTeammatesBonusMultiplier = 1


    allSurviveBonusMultiplier = 0

    timelimitMultiplier = -1

    suicideMultiplier = -1
    

    
end

function ROLE:Initialize()
    roles.SetBaseRole(self, ROLE_TRAITOR)
end

-- , "JesterPickupWeapon"
if SERVER then

    -- the roider is not able to pick up molotov cocktails or confgrenades
   hook.Add("PlayerCanPickupWeapon", function(ply, wep)
      if not IsValid(ply) or not IsValid(wep) or ply:GetSubRole() ~= ROLE_ROIDER then return end

      if wep:GetClass() == "weapon_zm_molotov" then
         return false
      end

      if wep:GetClass() == "weapon_ttt_confgrenade" then
        return false
      end
    end)

end
if CLIENT then
	function ROLE:AddToSettingsMenu(parent)
		local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

		form:MakeSlider({
			serverConvar = "ttt2_roid_cbdmg",
			label = "Crowbar damage",
			min = 0,
			max = 100,
			decimal = 0
		})
	end
end