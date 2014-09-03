

function EFFECT:Init(data)
	local pos = data:GetOrigin()

	local up = Vector( 0, 0, 20 )
	local emitter = ParticleEmitter( pos )
	emitter:SetNearClip(24, 32)

	for x=1, 1 do
		local vecRan = VectorRand():GetNormalized()
		vecRan = vecRan * math.Rand(8, 12)
		vecRan.z = math.Rand(-22, -1)
	
		local particle = emitter:Add("particle/smokestack", pos + up + vecRan )
		particle:SetColor ( 0, 180, 0 )
		particle:SetVelocity( Vector(0, 0, 10 ) )
        particle:SetDieTime( 0.5 )
		particle:SetStartAlpha( 140 ) 
		particle:SetEndAlpha( 0 )
        particle:SetStartSize( math.Rand( 9, 15 ) )
        particle:SetEndSize( math.Rand( 22, 28 ) )
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
