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

if SERVER then

    hook.Add("TTT2PlayerPreventPush","RoiderPush", function(inflictor,ply)
        if not IsValid(ply) or inflictor:GetSubRole() ~= ROLE_ROIDER then return end
        
        local tr = inflictor:GetEyeTrace(MASK_SHOT)
        local pushvel = tr.Normal * GetConVar("ttt_crowbar_pushforce"):GetFloat() * GetConVar("ttt2_roid_cbpush"):GetInt()
        pushvel.z = math.Clamp(pushvel.z, 50, 100) -- limit the upward force to prevent launching

        ply:SetVelocity(ply:GetVelocity() + pushvel)
        inflictor:SetAnimation(PLAYER_ATTACK1)
        ply.was_pushed = {
            att = inflictor,
            t = CurTime(),
            wep = inflictor:GetActiveWeapon():GetClass(),
        }


        return true
    end)
end

if CLIENT then
	function ROLE:AddToSettingsMenu(parent)
		local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

        form:MakeSlider({
		    serverConvar = "ttt2_roid_cbdmg",
		    label = "label_crowbar_dmg",
		    min = 0,
		    max = 100,
		    decimal = 0
		})
        form:MakeSlider({
		    serverConvar = "ttt2_roid_cbpush",
		    label = "label_roider_push_multi",
		    min = 1,
		    max = 10,
		    decimal = 0
		})
	end
end