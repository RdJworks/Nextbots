include('shared.lua')

function ENT:Initialize()

	self:SetModel( "models/Zombie/Classic.mdl" )
	self:SetBodygroup( 1, 1 )
	self:StartActivity( ACT_WALK )
	self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	self:SetHealth( 140 )
	self.Entity:SetCollisionBounds( Vector( -12 ,-12 ,0 ), Vector( 12 ,12 ,72 ) ) 
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
	self:SetColor(Color( 200, 255, 200, 255 ))


end



function ENT:Fart()
                local vPoint = self:LocalToWorld( self:OBBCenter() )
                        local effectdata = EffectData()
                                effectdata:SetOrigin( vPoint )
                                util.Effect( "getshit", effectdata, true, true )

end


function ENT:Think()

if ( self.FartTimer == nil ) then self.FartTimer = CurTime() + 1 end

if ( self.FartTimer  < CurTime() ) then
self:Fart()
self.FartTimer = CurTime() + 0.2
end
end