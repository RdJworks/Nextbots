include('shared.lua')

function ENT:Initialize()
	self:Precache()
	self:SetModel( "models/Zombie/Poison.mdl" )
	self:SetBodygroup( 1, 1 )
	self:SetBodygroup( 2, 1 )
	self:SetBodygroup( 3, 1 )
	self:SetBodygroup( 4, 1 )
	self:SetBodygroup( 5, 1 )
	self:StartActivity( ACT_WALK )
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetHealth( 150 )
	self.Entity:SetCollisionBounds( Vector( -4 ,-4 ,0 ), Vector( 10 ,12 ,64 ) ) 
	self.LoseTargetDist	= 400000	-- How far the enemy has to be before we lose them
	self.SearchRadius 	= 120000
	self.loco:SetDesiredSpeed( 50 )		-- Set the speed that we will be moving at. Don't worry, the animation will speed up/slow down to match
	self.loco:SetAcceleration( 50 )
	self.WalkSpeed = 200
	self.DoDamage =  25 
	self.LastPos = self:GetPos()
	self.AttackSound = { "npc/zombie_poison/pz_warn1.wav", "npc/zombie_poison/pz_warn2.wav", }
	self.HitSound = { "npc/zombie/claw_strike1.wav" }
	self.BreaksSound = { "npc/zombie/zombie_pound_door.wav" }
end

ENT.SoundTable = { "npc/zombie_poison/pz_warn1.wav", "npc/zombie_poison/pz_warn2.wav", "npc/zombie/claw_strike1.wav", "npc/zombie/zombie_pound_door.wav" }

function ENT:Think()
end

