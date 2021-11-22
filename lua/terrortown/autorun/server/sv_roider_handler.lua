

local function RoiderDamageAttempt(ply, attacker)
	if not IsValid(ply) or not IsValid(attacker) or not attacker:IsPlayer() or attacker:GetSubRole() ~= ROLE_ROIDER then return end
	if SpecDM and (ply.IsGhost and ply:IsGhost() or (attacker.IsGhost and attacker:IsGhost())) then return end

	return true -- true to block damage event
end


hook.Add("PlayerTakeDamage", "RoiderDamage", function(ply, inflictor, killer, amount, dmginfo)

    if not RoiderDamageAttempt(ply, killer) then return end
    if  inflictor ~= killer and inflictor:GetClass() == "weapon_zm_improvised" then
        dmginfo:SetDamage(GetConVar("ttt2_roid_cbdmg"):GetInt())
    else
    
        dmginfo:ScaleDamage(0)
	    dmginfo:SetDamage(0)
    end

end)

hook.Add("GM:TTT2PlayerPreventPush","RoiderPush", function(inflictor,ply)
    
    print(inflictor)
    print(ply)
    if not IsValid(ply) or inflictor:GetSubRole() ~= ROLE_ROIDER then return end

    

    
    
return true
end)
