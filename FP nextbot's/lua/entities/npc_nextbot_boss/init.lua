include('shared.lua')

function ENT:Initialize()
	self:Precache()
	self:SetModel( "models/Zombie/Classic.mdl" )
	self:SetBodygroup( 1, 1 )
	self.Attacking = true
	self:StartActivity( ACT_WALK )
	self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	self:SetHealth( 380 )
	self.Entity:SetCollisionBounds( Vector( -4 ,-4 ,0 ), Vector( 4 ,4 ,64 ) ) 
	self.LoseTargetDist	= 400000	
	self.SearchRadius 	= 120000
	self.loco:SetDesiredSpeed( 150 )
	self.loco:SetAcceleration( 150 )
	self.WalkSpeed = 200
	self.DoDamage =  25 
	self.LastPos = self:GetPos( )
	self.AttackSound = { "npc/zombie/zo_attack1.wav", "npc/zombie/zo_attack2.wav", }
	self.HitSound = { "npc/zombie/claw_strike1.wav" }
	self.BreaksSound = { "npc/zombie/zombie_pound_door.wav", }
	self.PainSounds = { "npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav" }
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetColor( Color( 10, 10, 10, 150 ) )
end

ENT.SoundTable = {"npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav", 
"npc/zombie/zombie_pound_door.wav", "npc/zombie/claw_strike1.wav", "npc/zombie/zo_attack1.wav", "npc/zombie/zo_attack2.wav" }

function ENT:Think()

end

