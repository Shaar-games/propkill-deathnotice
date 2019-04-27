


net.Receive( "PlayerKilled", function(ù , é) end )

net.Receive( "propkill_identifier", function()

	local attacker = Entity( net.ReadUInt( 8 ) ) 

	local victim = Entity( net.ReadUInt( 8 ) ) 

	if !IsValid( victim ) then return end

	if !IsValid( attacker ) then
		GAMEMODE:AddDeathNotice( "prop_physics" , -1 , "prop_physics" , victim:Name(), victim:Team() )
		return
	end

	if attacker == game.GetWorld() then
		GAMEMODE:AddDeathNotice( "World" , -1 , attacker:GetClass() , victim:Name() , victim:Team() )
		return
	end

	GAMEMODE:AddDeathNotice( attacker:Name() , attacker:Team(), "prop_physics" , victim:Name(), victim:Team() )

end )