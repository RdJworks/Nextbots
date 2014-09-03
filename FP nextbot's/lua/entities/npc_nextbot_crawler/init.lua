include('shared.lua')

function ENT:Initialize()
	self:Precache()
	self:SetModel( "models/Zombie/Classic_torso.mdl" )
	self:StartActivity( ACT_WALK )
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetHealth( 45 )
	self:SetBodygroup( 1, 1 )
	self.Entity:SetCollisionBounds( Vector(-4,-4,0), Vector(4,4,32) ) 
	self.LoseTargetDist	= 400000	-- How far the enemy has to be before we lose them
	self.SearchRadius 	= 120000
	self.loco:SetJumpHeight( 58 )	
	self.loco:SetDesiredSpeed( 100 )		-- Set the speed that we will be moving at. Don't worry, the animation will speed up/slow down to match
	self.loco:SetAcceleration( 100 )
	self.WalkSpeed = 200
	self.DoDamage =  12 
	self.LastPos = self:GetPos()
	self.AttackSound = { "npc/zombie/zo_attack1.wav", "npc/zombie/zo_attack2.wav", }
	self.HitSound = { "npc/zombie/claw_strike1.wav" }
	self.BreaksSound = { "npc/zombie/zombie_pound_door.wav", }
	self.PainSounds = { "npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav" }
end

ENT.SoundTable = {"npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav", 
"npc/zombie/zombie_pound_door.wav", "npc/zombie/claw_strike1.wav", "npc/zombie/zo_attack1.wav", "npc/zombie/zo_attack2.wav" }



function ENT:Think()

end
