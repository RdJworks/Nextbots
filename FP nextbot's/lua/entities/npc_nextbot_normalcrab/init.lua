include('shared.lua')

function ENT:Initialize()

	self:SetModel( "models/headcrabclassic.mdl" )
	self.Attacking = true
	self:StartActivity( ACT_RUN )
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetHealth( 40 )
	self.Entity:SetCollisionBounds( Vector(0,0,0), Vector( 8, 8,32) ) 
	self.LoseTargetDist	= 400000	-- How far the enemy has to be before we lose them
	self.SearchRadius 	= 120000
	self.loco:SetJumpHeight( 58 )	
	self.loco:SetDesiredSpeed( 150 )		-- Set the speed that we will be moving at. Don't worry, the animation will speed up/slow down to match
	self.loco:SetAcceleration( 150 )
	self.WalkSpeed = 200
	self.DoDamage =  6
	self.LastPos = self:GetPos()
	self.AttackSound = { "NPC_HeadCrab.Attack" }
	self.HitSound = { "NPC_HeadCrab.Bite" }
	self.BreaksSound = { "npc/zombie/zombie_pound_door.wav", }
	self.PainSounds = { "NPC_HeadCrab.Pain" }
end

function ENT:Think()
end
