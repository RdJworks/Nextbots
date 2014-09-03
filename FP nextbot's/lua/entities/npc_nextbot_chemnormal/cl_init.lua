include('shared.lua')

function ENT:Draw()
	local emitter = ParticleEmitter(self:GetPos() , true)
	local particle = emitter:Add("effects/blood_puff", self:GetPos())
end

function GhostBarrel( ply )
	local c_Model = ents.CreateClientProp()
	c_Model:SetPos( ply:GetPos() )
	c_Model:SetModel( "models/Zombie/Classic.mdl" )
	c_Model:SetParent( ply )
	c_Model:Spawn()
end