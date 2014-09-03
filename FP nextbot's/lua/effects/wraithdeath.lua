
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
		particle:SetColor ( Color ( 40, 40, 40 ) )
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
				particle:SetColor( 255, 0, 0 )
	end
	for x=1, 80 do
		local vecRan = VectorRand():GetNormalized()
		vecRan = vecRan * math.Rand(16, 24)
		vecRan.z = math.Rand(-44, -2)
	
		local particle = emitter:Add("effects/blood_puff", pos + up + vecRan )
		particle:SetColor ( Color(  40, 40, 40 ) )
		particle:SetVelocity( Vector( math.Rand( -180, 180 ) , math.Rand( -180, 180 ) , math.Rand( 40,60  ) ) )
        particle:SetDieTime( math.Rand( 0.27, 0.35 ) )
		particle:SetStartAlpha( 255 ) 
		particle:SetEndAlpha( 0 )
        particle:SetStartSize( 12 )
        particle:SetEndSize( 16 )
	end
		for x=1, 60 do
		local vecRan = VectorRand():GetNormalized()
		vecRan = vecRan * math.Rand( 16, 24 )
		vecRan.z = math.Rand( -44, -2 )
	
		local particle = emitter:Add("effects/blooddrop", pos + up + vecRan )
		particle:SetColor (  40, 40, 40  )
		particle:SetVelocity( Vector( math.Rand( -60, 60 ) , math.Rand(-60, 60 ) , math.Rand( 12,30  ) ) )
        particle:SetDieTime( math.Rand( 0.45, 0.55 ) )
		particle:SetStartAlpha( 255 ) 
		particle:SetEndAlpha( 0 )
        particle:SetStartSize( 20 )
        particle:SetEndSize( 8 )
	end
		
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end