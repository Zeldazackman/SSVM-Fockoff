require "/scripts/vore/npcvore.lua"

isDigest	= true
effect 		= "npcdigestvore"
breasts = nil

playerLines = {}

playerLines["idle"] = {	""
}

playerLines["eat"] = {	""
}

playerLines["release"] = {	""
}

playerLines["request"] = {	""
}

playerLines["leave"] = {	""
}

playerLines["die"] = {	""
}


	
function initHook()
	if storage.breasts == nil then
		breasts = 0
	else
		breasts = storage.breasts
	end
	setBreasts()
end

function feedHook()
	if request[1] then
		sayLine( playerLines["request"] )
	else
		sayLine( playerLines["eat"] )
	end
	world.spawnProjectile( "npcanimchomp" , world.entityPosition( tempTarget ), entity.id(), {0, 0}, false)
	world.spawnProjectile( "swallowprojectile" , world.entityPosition( tempTarget ), entity.id(), {0, 0}, false)
end

function deathHook()
	if containsPlayer(input) then
		sayLine ( playerLines["die"] )
	end
	if breasts < 3 then
		breasts = breasts + 1
		storage.breasts = breasts
	end
	setBreasts()
end

function digestHook(id, time, dead)
	if containsPlayer() then
		sayLine( playerLines["release"] )
	end
end

function releaseHook(input, time)
	if containsPlayer() then
		sayLine( playerLines["leave"] )
	end
end

function requestHook(input)
	if containsPlayer() then
		sayLine( playerLines["request"] )
	end
	world.spawnProjectile( "npcanimchomp" , world.entityPosition( victim[#victim] ), entity.id(), {0, 0}, false)
	world.spawnProjectile( "swallowprojectile" , world.entityPosition( victim[#victim] ), entity.id(), {0, 0}, false)
end

function setBreasts()
	if breasts == 0 then
		legs[1] = "loydsoil1"
		chest[2] = "loydchestbelly"
	elseif breasts == 1 then
		legs[1] = "loydsoil2"
		chest[2] = "loydchestbelly"
	elseif breasts == 2 then
		legs[1] = "loydsoil3"
		chest[2] = "loydchestbelly"
	else
		legs[1] = "loydsoil4"
		chest[2] = "loydchestbelly"
	end
end

function updateHook()
	if containsPlayer and math.random(700) == 1 then
		sayLine( playerLines["idle"] )
	end
end