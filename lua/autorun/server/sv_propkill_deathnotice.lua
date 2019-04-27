

AddCSLuaFile("autorun/client/cl_propkill_deathnotice.lua")

local Owners = {}
	
local function PlyOwner( ent )
	if Owners[ent] then
		return Owners[ent]
	else
		return nil
	end
end

local function RegisterOwner( ply, model, entity )
	Owners[entity] = ply
end
	
hook.Add("PlayerSpawnedProp"		,"propkill_identifier",RegisterOwner)
hook.Add("PlayerSpawnedRagdoll"		,"propkill_identifier",RegisterOwner)
hook.Add("PlayerSpawnedSENT"		,"propkill_identifier",RegisterOwner)
hook.Add("PlayerSpawnedVehicle"		,"propkill_identifier",RegisterOwner)

util.AddNetworkString("propkill_identifier")

local function PlayerDeath( victim, inflictor, attacker )

	if inflictor == attacker and PlyOwner( inflictor ) then
		net.Start("propkill_identifier" , true)
		net.WriteUInt( PlyOwner( inflictor ):EntIndex() , 8 )
		net.WriteUInt( victim:EntIndex() , 8 )
		net.Broadcast()

		if PlyOwner( inflictor ) != victim then
			PlyOwner( inflictor ):AddFrags( 1 )
		end
 	end

 	if inflictor == Entity( 0 ) then
 		net.Start("propkill_identifier" , true)
		net.WriteUInt( 0 , 8 )
		net.WriteUInt( victim:EntIndex() , 8 )
		net.Broadcast()
 	end

end

hook.Add("PlayerDeath","Propkill_Identifier",PlayerDeath )