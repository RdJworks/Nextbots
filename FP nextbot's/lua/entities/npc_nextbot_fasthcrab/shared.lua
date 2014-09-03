AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

ENT.Base			= "base_nextbot"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Author			= "Rob"
ENT.Purpose			= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

function ENT:EnemyInRange()
	return ( self.Enemy:GetPos():Distance( self:GetPos() ) <= 80 )
end

function ENT:JumpRange()
	return ( self.Enemy:GetPos():Distance( self:GetPos() ) <= 125	)
end


function ENT:ChargeRangeRange()
	return ( self.Enemy:GetPos():Distance( self:GetPos() ) <= 150 )
end


function ENT:SetEnemy( Enemy )
	self.Enemy = player.GetAll( )[ math.random( 1, #player.GetAll( ) ) ]
end


function ENT:GetEnemy()
	return self.Enemy
end

function ENT:OnStuck()
	if self.LastPos:Distance( self.Entity:GetPos() ) < 100 then
		self.Entity:SetPos( self.LastPos )
	end
end

function ENT:OnInjured( dmginfo ) 
	self.Enemy = dmginfo:GetAttacker()
	local Pain = math.random( 1, 2 )
	
	if ( Pain == 2 ) then
		self:EmitSound( table.Random( self.PainSounds ), 511, 20 )
	end
end

function ENT:Wander()	
			self:StartActivity( ACT_RUN )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
end


function ENT:IFoundSomeone()
local TeamShit =  player.GetAll( )
	for k, v in pairs( TeamShit ) do
		if ( v:IsPlayer() and !self:EnemyInRange() and v:GetPos():Distance( self:GetPos() ) < 50 ) then
			self.Enemy = v
		end
	end
end

function ENT:HaveEnemy()

	if ( self:GetEnemy() and IsValid( self:GetEnemy() ) ) then
		if ( self:GetRangeTo( self:GetEnemy():GetPos() ) > self.LoseTargetDist ) then
			self:FindEnemy()
		elseif ( self:GetEnemy():IsPlayer() and !self:GetEnemy():Alive() ) then
			self:FindEnemy()	
		elseif ( self:GetEnemy() != nil  and self.Enemy:IsValid() ) then
			 if ( self:Charge() or self:IFoundSomeone()  or self:AttackPlayer() or self:JumpPosLadder() ) then
		
		end	
		end
		return true
	else
		
		return self:FindEnemy() 
	end
end


function ENT:ChaseEnemy( options )
	local options = options or {}
	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, self:GetEnemy():GetPos() )
	if (  !path:IsValid() ) then return "failed" end
	while ( path:IsValid() and self:HaveEnemy() ) do
		if ( path:GetAge() > 1 ) then
			path:Compute( self, self:GetEnemy():GetPos() )
		end
		path:Update( self )								
		if ( self.loco:IsStuck() ) then
			self:HandleStuck()
			return "stuck"
		end
		coroutine.yield()
	end
	return "ok"
end

	

function ENT:FindEnemy()
	local _ents = player.GetAll()
	for k,v in pairs( _ents ) do
		if ( v:IsPlayer() ) then
			self:SetEnemy( v )
			return true
		end
	end	
	self:SetEnemy( nil )
	return false
end

function ENT:AttackPlayer()
	self.loco:FaceTowards(self.Enemy:GetPos() )	
	local tracedata = {}
	tracedata.start = self:GetPos()
	tracedata.endpos = self:GetPos() + ( self:EyeAngles():Forward() * 120 )
	tracedata.filter = self
	tracedata.mins = self:OBBMins()
	tracedata.maxs = self:OBBMaxs() + Vector( 0,0, 120 )
	
	local TraceRes = util.TraceHull( tracedata )
	if ( TraceRes.Entity == self.Enemy ) then
		if ( IsValid( TraceRes.Entity ) ) then
		local Target = TraceRes.Entity
					self.loco:Jump( )
						self:StartActivity( ACT_RANGE_ATTACK1 )
							self:EmitSound( table.Random( self.AttackSound ), 355, 100 )
							if( self:EnemyInRange() ) then
								Target:TakeDamage(self.DoDamage, self)
									self:EmitSound( table.Random( self.HitSound ), 355, 100 )
							end
						end
					
					coroutine.wait( 0.5 ) --For attack to finish
					self:StartActivity( ACT_RUN )
					
			end
end




function ENT:AttackBreakable()
	local tracedata = {}
	tracedata.start = self:GetPos()
	tracedata.endpos = self:GetPos() + ( self:EyeAngles():Forward() * 60 )
	tracedata.filter = self
	tracedata.mins = self:OBBMins()
	tracedata.maxs = self:OBBMaxs()
	local TraceRes = util.TraceHull( tracedata )
	if ( IsValid(TraceRes.Entity) and TraceRes.Entity != NULL ) then
		if string.match( TraceRes.Entity:GetClass(),"func_breakable") then
				if ( Hitsleft == nil ) then
					Hitsleft = 5
				end
		self:EmitSound( table.Random( self.AttackSound ), 355, 100 )
		
		self:StartActivity( ACT_MELEE_ATTACK1 )
		
		coroutine.wait( 1.2 )
		if IsValid( TraceRes.Entity ) then
		local Target = TraceRes.Entity
		local phys = Target:GetPhysicsObject()
			if (phys != nil && phys != NULL && phys:IsValid()) then
			phys:ApplyForceCenter( self:GetForward():GetNormalized()*60000 + Vector(0, 0, 2))
			Target:EmitSound( table.Random( self.BreaksSound ), 355, 100 )
			Target:TakeDamage(self.DoDamage, self)
			Hitsleft = Hitsleft - 1
			end
		
			if ( Target != NULL and Hitsleft != nil ) then
				if Hitsleft < 1 then
						Target:Remove()
						Target:EmitSound( "Wood_Plank.Break", 355, 100 )
						if ( Hitsleft == 0 ) then 
							Hitsleft = 5
						end
					end
				end
		coroutine.wait( 0.5 )
		self:StartActivity( ACT_WALK )
		self.loco:SetAcceleration( 750 )
			return true
		end
	end
	self:StartActivity( ACT_WALK )	
	self.loco:SetAcceleration( 750 )
	return false
end
end	


function ENT:Charge()

	if ( self:ChargeRangeRange() ) then
	self.loco:SetDesiredSpeed( 450 )		-- Set the speed that we will be moving at. Don't worry, the animation will speed up/slow down to match
	self.loco:SetAcceleration( 1000 )
	else
		self.loco:SetDesiredSpeed( 200 )
	end
					
end

function ENT:JumpPosLadder()
local ladders = ents.FindByClass( "ladder_jump" )
local JumpHight = math.Clamp ( self.Enemy:GetPos():Distance( self:GetPos() ) ,100 ,300 ) 
local RumpAcSpeed = math.Clamp ( self.Enemy:GetPos():Distance( self:GetPos() ) ,0 ,500 ) 

for k, v in pairs( ladders ) do
local RTo = self:GetRangeTo( v )
		if( IsValid( v ) and RTo < 40 ) then
			self.loco:SetJumpHeight( JumpHight )
			self.loco:Jump( self.Enemy:GetPos() )
			self:StartActivity( ACT_RUN )	
		end
		if( IsValid( v ) and RTo < 80 ) then
				self.loco:SetDesiredSpeed( 250 )
				self.loco:SetAcceleration( RumpAcSpeed )
			else
			self.loco:SetDesiredSpeed( 200 )
			self.loco:SetJumpHeight( 58 )
		end
	end
end

function ENT:RunBehaviour()	

	while ( true ) do
			if self:HaveEnemy() then
				self:ChaseEnemy()
			else
				self:Wander()
			end
		coroutine.yield()
	end
end	

function ENT:OnKilled ( dmginfo, ent )
self:Remove()
 local vPoint = self:LocalToWorld( self:OBBCenter() + Vector( 0, 0, 15 ) )
		local effectdata = EffectData()
			effectdata:SetOrigin( vPoint )
			effectdata:SetNormal( self:GetForward() )
			effectdata:SetEntity( self )
			effectdata:SetScale( 0.1 )
		util.Effect( "bloodshit", effectdata, true, true )
	hook.Call("OnNPCKilled", GAMEMODE, self, dmginfo:GetAttacker(), dmginfo:GetInflictor() )
end

list.Set( "NPC", "npc_nextbot_fasthcrab", {
	Name = "Fast HeadCrab",
	Class = "npc_nextbot_FastHCrab",
	Category = "Rob's NextBot Zombies"
} )
