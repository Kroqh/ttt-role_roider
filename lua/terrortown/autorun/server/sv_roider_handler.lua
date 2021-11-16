

local function ShouldRoiderDealNoDamage(ply, attacker)
	if not IsValid(ply) or not IsValid(attacker) or not attacker:IsPlayer() or attacker:GetSubRole() ~= ROLE_ROIDER then return end
	if SpecDM and (ply.IsGhost and ply:IsGhost() or (attacker.IsGhost and attacker:IsGhost())) then return end

	return true -- true to block damage event
end


hook.Add("PlayerTakeDamage", "RoiderNoDamage", function(ply, inflictor, killer, amount, dmginfo)

    if not ShouldRoiderDealNoDamage(ply, killer) then return end
    print(killer:GetActiveWeapon():GetClass())
    print(killer)
    print(amount)
    if  inflictor ~= killer and killer:GetActiveWeapon():GetClass() == "weapon_zm_improvised" then
        dmginfo:SetDamage(50)
    else
    
        print("FSDFSD")
        dmginfo:ScaleDamage(0)
	    dmginfo:SetDamage(0)
    end

end)