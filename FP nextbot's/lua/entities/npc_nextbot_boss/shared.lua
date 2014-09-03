AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

ENT.Base			= "base_nextbot"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Author			= "Rob"
ENT.Purpose			= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

function ENT:Precache()
--Models--
util.PrecacheModel( "models/Zombie/Classic.mdl" )
	
--Sounds--	
	for k, v in pairs( self.SoundTable ) do
		util.PrecacheSound( v )
	end
end

function ENT:EnemyInRange()
	return ( self.Enemy:GetPos():Distance( self:GetPos() ) <= 90 )
end


function ENT:SetEnemy( Enemy )
	self.Enemy = player.GetAll( )[math.random( 1, #player.GetAll( ) ) ]
end

function ENT:Wander()
			self:StartActivity( ACT_WALK )
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
		end

function ENT:GetEnemy()
	return self.Enemy
end

function ENT:OnStuck()
	if self.LastPos:Distance( self.Entity:GetPos() ) < 100 then
		self.Entity:SetPos( self.LastPos )
		self:StartActivity( ACT_WALK )	
	end
end
function ENT:OnInjured( dmginfo ) 
	self.Enemy = dmginfo:GetAttacker()
	local Pain = math.random( 1, 2 )
	
	if ( Pain == 2 ) then
		self:EmitSound( table.Random( self.PainSounds ), 511, 100 )
	end
end


function ENT:IFoundSomeone()
local TeamShit =  player.GetAll( )
	for k, v in pairs( TeamShit ) do
		if ( v:IsPlayer()  and !self:EnemyInRange() and v:GetPos():Distance( self:GetPos() ) < 70 ) then
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
			 if ( self:AttackPlayer() or self:IFoundSomeone() or self:JumpPosLadder() ) then
		else
		if
			( self:AttackProp() or self:AttackBreakable() ) then
		end
		end	
		end
		return true
	else
		
		return self:FindEnemy() 
	end
end


function ENT:FindEnemy()
	local Targets = player.GetAll( )
		for k,v in pairs( Targets ) do
		if ( v:IsPlayer() and v:GetPos():Distance( self:GetPos() ) < self.SearchRadius ) then
			self:SetEnemy( v )
			self.loco:FaceTowards(self.Enemy:GetPos( self ) )
			return true
		end
	end	
	self:SetEnemy( nil )
	return false
end

function ENT:ChaseEnemy( options )

	local options = options or {}

	local path = Path( "Follow" )
	path:SetMinLookAheadDistance( options.lookahead or 300 )
	path:SetGoalTolerance( options.tolerance or 20 )
	path:Compute( self, self:GetEnemy():GetPos() )		-- Compute the path towards the enemy's position

	if (  !path:IsValid() ) then return "failed" end

	while ( path:IsValid() and self:HaveEnemy() ) do
	
		if ( path:GetAge() > 1 ) then					-- Since we are following the player we have to constantly remake the path
			path:Compute( self, self:GetEnemy():GetPos() )-- Compute the path towards the enemy's position again
		end
		path:Update( self )								-- This function moves the bot along the path
		
		-- If we're stuck ) then call the HandleStuck function and abandon
		if ( self.loco:IsStuck() ) then
			self:HandleStuck()
			return "stuck"
		end

		coroutine.yield()

	end

	return "ok"

end

function ENT:AttackProp()
	local tracedata = {}
	tracedata.start = self:GetPos()
	tracedata.endpos = self:GetPos() + ( self:EyeAngles():Forward() * 60 )
	tracedata.filter = self
	tracedata.mins = self:OBBMins()
	tracedata.maxs = self:OBBMaxs() * 1.3
	
	local TraceRes = util.TraceHull(tracedata)
	if ( TraceRes.Hit ) then
	if IsValid(TraceRes.Entity) and TraceRes.Entity ~= NULL then
		if string.match( TraceRes.Entity:GetClass(),"prop_physics") then
				if Hitsleft == nil then
					Hitsleft = 5
				end
		self:EmitSound( table.Random( self.AttackSound ), 355, 50 )
		self:StartActivity( ACT_MELEE_ATTACK1 )
		
		coroutine.wait( 1.2 )
		if IsValid( TraceRes.Entity ) then
		local Target = TraceRes.Entity
		local phys = Target:GetPhysicsObject()
			if (phys != nil && phys != NULL && phys:IsValid()) then
			phys:ApplyForceCenter( self:GetForward():GetNormalized()*60000 +self.Enemy:GetPos() )
			Target:EmitSound( table.Random( self.BreaksSound ), 355, 100 )
			Target:TakeDamage(self.DoDamage, self)
			Hitsleft = Hitsleft - 1
			end
		
			if Target != NULL and Hitsleft != nil then
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
			return true
		end
	end
	self:StartActivity( ACT_WALK )	
	return false
end
end
end


function ENT:AttackPlayer()
	self.loco:FaceTowards(self.Enemy:GetPos() )	
	local tracedata = {}
	tracedata.start = self:GetPos()
	tracedata.endpos = self:GetPos() + ( self:EyeAngles():Forward() * 60  + Vector( 0, 0, 20 ))
	tracedata.filter = self
	tracedata.mins = self:OBBMins()
	tracedata.maxs = self:OBBMaxs()
	
	local TraceRes = util.TraceHull( tracedata )
	if ( TraceRes.Entity == self.Enemy ) then
		self:StartActivity( ACT_MELEE_ATTACK1 )
		self:EmitSound( table.Random( self.AttackSound ), 355, 50 )
		coroutine.wait( 1.2 )
		
		if IsValid( TraceRes.Entity ) then
		local Target = TraceRes.Entity
			if (  self:EnemyInRange() ) then
						Target:TakeDamage(self.DoDamage, self)
							self:EmitSound( table.Random( self.HitSound ), 355, 100 )
							print( type( npc_nextbot_Boss ) )
						end
					end
					coroutine.wait( 0.5 ) --For attack to finish
					self:StartActivity( ACT_WALK )
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
	if IsValid(TraceRes.Entity) and TraceRes.Entity ~= NULL then
		if string.match( TraceRes.Entity:GetClass(),"func_breakable") then
				if Hitsleft == nil then
					Hitsleft = 5
				end
		self:EmitSound( table.Random( self.AttackSound ), 355, 50 )
		
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
		
			if Target != NULL and Hitsleft != nil then
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
			return true
		end
	end
	self:StartActivity( ACT_WALK )	
	return false
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
			self:StartActivity( ACT_WALK )	
		end
		if( IsValid( v ) and RTo < 80 ) then
				self.loco:SetDesiredSpeed( 250 )
				self.loco:SetAcceleration( RumpAcSpeed )
			else
			self.loco:SetDesiredSpeed( 100 )
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

function ENT:OnKilled ( dmginfo )
self:Remove()
	self:Remove()
	 local vPoint = self:LocalToWorld( self:OBBCenter() + Vector( 0, 0, 15 ) )
		local effectdata = EffectData()
			effectdata:SetOrigin( vPoint )
			effectdata:SetNormal( self:GetForward() )
			effectdata:SetEntity( self )
		util.Effect( "wraithdeath", effectdata, true, true )
	hook.Call("OnNPCKilled", GAMEMODE, self, dmginfo:GetAttacker(), dmginfo:GetInflictor() )
end
	
	
list.Set( "NPC", "npc_nextbot_boss", {
	Name = "Zombie",
	Class = "npc_nextbot_Boss",
	Category = "Rob's NextBot Zombies"
} )
