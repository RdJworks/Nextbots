local function CollideCallbackSmall( particle, hitpos, hitnormal )
	if particle:GetDieTime() == 0 then return end
	particle:SetDieTime( 0 )

	if math.random( 1 , 6 ) == 3 then
		sound.Play( "physics/flesh/flesh_bloody_impact_hard1.wav", hitpos, 50, math.Rand( 95, 105 ) )
		util.Decal( "Impact.Flesh", hitpos + hitnormal, hitpos - hitnormal )
	end
end

local function CollideCallback( oldparticle, hitpos, hitnormal )
	if oldparticle:GetDieTime() == 0 then return end
	oldparticle:SetDieTime( 0 )

	local pos = hitpos + hitnormal

	if math.random( 1, 6 ) == 3 then
		sound.Play( "physics/flesh/flesh_squishy_impact_hard"..math.random( 4 )..".wav", hitpos, 50, math.Rand( 95, 105 ) )
		util.Decal( "Blood", pos, hitpos - hitnormal )
	end

	local num = math.random( -4, 4 )
	if num < 1 then return end

	local nhitnormal = hitnormal * 90

	local emitter = ParticleEmitter(pos)
	for i=1, num do
		local particle = emitter:Add( "decals/blood1", pos )
		particle:SetLighting( true )
		particle:SetVelocity( VectorRand():GetNormalized() * math.Rand( 75, 150 ) + nhitnormal )
		particle:SetDieTime( 3 )
		particle:SetStartAlpha( 255 )
		particle:SetEndAlpha( 255 )
		particle:SetStartSize( math.Rand( 1.5, 2.5 ) )
		particle:SetEndSize( 1.5 )
		particle:SetRoll( math.Rand( -25, 25 ) )
		particle:SetRollDelta( math.Rand( -25, 25 ) )
		particle:SetAirResistance( 5 )
		particle:SetGravity( Vector(0, 0, -600 ) )
		particle:SetCollide( true )
		particle:SetColor( 255, 0, 0 )
		particle:SetCollideCallback( CollideCallbackSmall )
	end
	emitter:Finish()
end

function EFFECT:Init( data )
	local pos = data:GetOrigin()

	local up = Vector( 0, 0, 20 )
	local emitter = ParticleEmitter( pos )
	emitter:SetNearClip(24, 32)

	for x=1, 60 do
		local vecRan = VectorRand():GetNormalized()
		vecRan = vecRan * math.Rand( 16, 24 )
		vecRan.z = math.Rand( -44, -2 )
	
		local particle = emitter:Add("effects/blood_gore", pos + up + vecRan )
		particle:SetColor ( Color ( 255, 0, 0 ) )
		particle:SetVelocity( Vector( math.Rand( -60, 60 ) , math.Rand( -60, 60 ) , math.Rand( 12,30  ) ) )
				particle:SetDieTime( math.Rand( 0.4, 1.5 ) )
				particle:SetStartAlpha( 200 )
				particle:SetEndAlpha( 200 )
				particle:SetStartSize( math.Rand( 3, 4 ) )
				particle:SetEndSize( 2 )
				particle:SetRoll( math.Rand( 0, 360 ) )
				particle:SetRollDelta( math.Rand( -20, 20 ) )
				particle:SetAirResistance( 8 )
				particle:SetGravity( Vector( 0, 0, 50 ) )
				particle:SetCollide( true )
				particle:SetColor( 255, 0, 0 )
	end
	for x=1, 50 do
		local vecRan = VectorRand():GetNormalized()
		vecRan = vecRan * math.Rand(16, 24)
		vecRan.z = math.Rand(-44, -2)
	
		local particle = emitter:Add("effects/blood_puff", pos + up + vecRan )
		particle:SetColor ( Color(  0, 0, 0 ) )
		particle:SetVelocity( Vector( math.Rand( -120, 120 ) , math.Rand( -120, 120 ) , math.Rand( 12,20  ) ) )
        particle:SetDieTime( math.Rand( 0.27, 0.35 ) )
		particle:SetStartAlpha( 255 ) 
		particle:SetEndAlpha( 0 )
        particle:SetStartSize( 8 )
        particle:SetEndSize( 16 )
	end
		for x=1, 50 do
		local vecRan = VectorRand():GetNormalized()
		vecRan = vecRan * math.Rand( 16, 24 )
		vecRan.z = math.Rand( -44, -2 )
	
		local particle = emitter:Add("effects/blooddrop", pos + up + vecRan )
		particle:SetColor (  180, 0, 0  )
		particle:SetVelocity( Vector( math.Rand( -60, 60 ) , math.Rand(-60, 60 ) , math.Rand( 12,30  ) ) )
        particle:SetDieTime( math.Rand( 0.45, 0.55 ) )
		particle:SetStartAlpha( 255 ) 
		particle:SetEndAlpha( 0 )
        particle:SetStartSize( 20 )
        particle:SetEndSize( 8 )
	end
		
	for x=1, 50 do
		local vecRan = VectorRand():GetNormalized()
		vecRan = vecRan * math.Rand( 26, 34 )
		vecRan.z = math.Rand( -64, -4 )
	
		local particle = emitter:Add("decals/blood1", pos + up + vecRan )
		particle:SetColor (  180, 0, 0  )
		particle:SetVelocity( Vector( math.Rand( -220, 220 ) , math.Rand(-220, 220 ) , math.Rand( 60,90  ) ) )
        particle:SetDieTime( math.Rand( 1.2, 2.5 ) )
        particle:SetGravity( Vector( 0, 0, -600 ) )
		particle:SetStartAlpha( 255 ) 
		particle:SetAirResistance( 5 )
		particle:SetRoll( math.Rand( 0, 160 ) )
		particle:SetRollDelta( math.Rand( -20, 20 ) )
		particle:SetCollide( true )
		particle:SetLighting( true )
		particle:SetEndAlpha( 0 )
        particle:SetStartSize( math.Rand( 4, 7 ) )
        particle:SetEndSize( math.Rand( 4, 7 ) )
		particle:SetBounce( 0.5 )
		particle:SetCollideCallback( CollideCallback )
	end
	
		for x=1, 50 do
		local vecRan = VectorRand():GetNormalized()
		vecRan = vecRan * math.Rand( 6, 12 )
		vecRan.z = math.Rand( -12, -1 )
	
		local particle = emitter:Add("decals/blood"..math.Rand( 1, 4 ), pos  )
		particle:SetColor (  180, 0, 0  )
		particle:SetVelocity( Vector( math.Rand( -30, 30 ) , math.Rand(-30, 30 ) , math.Rand( 140 ,160 ) ) )
        particle:SetDieTime( math.Rand( 1.2, 2.5 ) )
        particle:SetGravity( Vector( 0, 0, math.Rand( -400, -600 ) ) )
		particle:SetStartAlpha( 255 ) 
		particle:SetAirResistance(5)
		particle:SetRoll(math.Rand(0, 160))
		particle:SetRollDelta( math.Rand( -20, 20 ) )
		particle:SetCollide( true )
		particle:SetLighting( true )
		particle:SetEndAlpha( 0 )
        particle:SetStartSize( math.Rand( 4, 7 ) )
        particle:SetEndSize( math.Rand( 4, 7 ) )
		particle:SetBounce( 0.2 )
		particle:SetCollideCallback( CollideCallback )
	end



	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end