extends Area2D
class_name Hurtbox

var hurtbox_collision_node: CollisionShape2D
var HS_CONST:float = 0.005 # .4 in smash

func _init():
	# Need to be updated based on player or enemy
	collision_layer = 0
	collision_mask = 0
	
func _ready():
	self.area_entered.connect(on_area_entered) 
	
func on_area_entered(hitbox: Hitbox):
	if hitbox.owner == self.owner:
		return 
		
	if hitbox == null:
		return 
	
	# TODO: Chang this to owner 
	var attacker = hitbox.get_parent().get_parent().get_parent()
	var attacker_state: State = hitbox.owner.current_action_state
	
	#print("Attacker: ", attacker)
	#print("Attacker State: ", attacker_state)
	
	if self.owner.has_method("hurtbox_entered"):
		var kb = calc_knockback(attacker_state.damage, attacker_state.knockback_base, 
		attacker_state.knockback_growth)
		var ad = calc_attacker_direction(attacker)
		var ls = calc_launch_speed(kb)
		var lv = calc_launch_velocity(attacker_state.angle, ls, ad)
		var hs = calc_hitstun(kb)
		
		self.owner.hurtbox_entered(attacker_state.damage, kb, ls, lv, ad, hs)

func calc_attacker_direction(attacker):
	var ad = attacker.global_position - self.global_position
	#print("ad: ", ad)
	return ad
	
func calc_knockback(damage, kbb, kbg):
	var character = self.owner
	var p = character.health + damage
	var w = character.weight
	var d = damage
	var s = kbg 
	var b = kbb
	
	#print("p: ", p)
	#print("w: ", w) 
	#print("d: ", d)
	#print("s: ", s)
	#print("b: ", b)
	
	var kb = ((((((p / 10) + (p * d / 20)) * (200 / w + 100)) * 1.4) + 18) * s) + b
	#print("kb: ", kb)
	return kb
	
func calc_launch_speed(kb):
	var ls = kb * 0.03 # try .004
	#print("ls: ", ls)
	return ls 
	
func calc_launch_velocity(angle, ls, ad):
	angle = abs(angle) # Make sure the angle is always positive 
	var lv := Vector2() 
	# Set vector x and y based on attack move's pre-defined angle
	lv.x = cos(deg_to_rad(angle))
	lv.y = sin(deg_to_rad(angle))

	# Make lv positive or negative based on attack direction
	if ad.x > 0: lv.x *= -1
	#if ad.y < 0: lv.y *= -1 # Might be wrong 

	# Multiply launch velocity values by the launch speed 
	lv.x *= ls
	lv.y *= -ls
	#print("lv: ", lv)
	return lv

func calc_hitstun(kb):
	var hs = int(kb * HS_CONST)
	#print(hs)
	return hs
