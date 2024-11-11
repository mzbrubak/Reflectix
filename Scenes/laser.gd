extends RayCast2D
var zcomp=0
var parent_rotation

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_rotation=self.get_parent().get_parent().rotation#needed to correct for direction of raycase being set to local


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fire():
	enabled=true
	var scene_tree=get_tree()
	await scene_tree.physics_frame
	await scene_tree.physics_frame
	if self.is_colliding():
		var hit_ref=self.get_collider()
		print(hit_ref)
		if hit_ref.get_collision_layer_value(2)==true:#if target opaque
			hit_ref.get_parent().destroy()
		elif hit_ref.get_collision_layer_value(1)==true:#if target reflective
			reflect(hit_ref)
	enabled=false
	
func reflect(hit_ref):
	var reflected_laser=hit_ref.get_node("Laser")
	#finds correct beam parameters to send to raycast of hit mirror, then fires that raycast as laser
	var mirror_normal=get_collision_normal()
	mirror_normal=mirror_normal/abs(max(mirror_normal.x,mirror_normal.y))#now all components should be -1, 0 or 1
	mirror_normal=mirror_normal.snapped(Vector2(1,1))#to remove numerical instability
	var laser_direction=target_position/abs(max(target_position.x,target_position.y))
	laser_direction=laser_direction.snapped(Vector2(1,1))
	laser_direction=laser_direction.bounce(mirror_normal.normalized())
	if zcomp==0:#i.e. if we're operating in the 2D plane
		reflected_laser.updateandfire(get_collision_point(),laser_direction*1000)
	else:#if using 3D
		pass#do fun things later :)

func updateandfire(collision_point,direction):#only 2D version for now
	target_position=direction.rotated(-parent_rotation)#corrects for rotation of mirror
	print(target_position)
	global_position=collision_point
	fire()
