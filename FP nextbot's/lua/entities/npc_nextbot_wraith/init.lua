include('shared.lua')

function ENT:Initialize()
	self:Precache()
	self:SetModel( "models/stalker.mdl" )
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:StartActivity( ACT_WALK )
	self:SetHealth( 80 )
	self.Entity:SetCollisionBounds( Vector(-4,-4,0), Vector(4,4,64) ) 
	self.LoseTargetDist	= 400000
	self.SearchRadius 	= 120000
	self.loco:SetDesiredSpeed( 180 )	
	self.loco:SetAcceleration( 180 )
	self.WalkSpeed = 200
	self.DoDamage =  25 
	self.LastPos = self:GetPos()
	self.AttackSound = { "npc/antlion/distract1.wav" }
	self.HitSound = { "ambient/machines/slicer2.wav", "ambient/machines/slicer1.wav", "ambient/machines/slicer3.wav","ambient/machines/slicer4.wav" }
	self.BreaksSound = { "ambient/machines/slicer2.wav", "ambient/machines/slicer1.wav", "ambient/machines/slicer3.wav","ambient/machines/slicer4.wav" }
	self.PainSounds = { "npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav" }
	self.DeathSound = { "npc/stalker/go_alert2a.wav" }
end
ENT.SoundTable = { "npc/antlion/distract1.wav", "ambient/machines/slicer2.wav", "ambient/machines/slicer1.wav", "ambient/machines/slicer3.wav","ambient/machines/slicer4.wav",
  "npc/zombie/zombie_pain1.wav", "npc/zombie/zombie_pain2.wav", "npc/zombie/zombie_pain3.wav", "npc/zombie/zombie_pain4.wav", "npc/zombie/zombie_pain5.wav", "npc/zombie/zombie_pain6.wav", "npc/stalker/go_alert2a.wav"  }
  


function ENT:Think()
	if IsValid( self ) then
	local multi = math.Clamp( self:GetVelocity():Length(), 0, 120 )
		
		self:SetRenderMode( RENDERMODE_TRANSADD )
		self:SetColor(Color( 40, 40, 40, multi ))
	end
end
