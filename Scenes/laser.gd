extends RayCast2D
var zcomp=0
var parent_rotation

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_rotation=self.get_parent().get_parent().get_parent().rotation#needed to correct for direction of raycast being set to local


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fire():
	enabled=true
	add_to_group("BeamSegments")
	var scene_tree=get_tree()
	await scene_tree.physics_frame
	await scene_tree.physics_frame
	if self.is_colliding():

		#print(self.get_collision_point())
		$BeamSegment.points[1]=self.get_collision_point()-self.global_position
		$BeamSegment.points[1]=$BeamSegment.points[1].rotated(-parent_rotation)
		var hit_ref=self.get_collider()
		#print(hit_ref)
		if hit_ref.get_collision_layer_value(2)==true:#if target opaque
			hit_ref.get_parent().get_parent().destroy()
		elif hit_ref.get_collision_layer_value(1)==true:#if target reflective
			reflect(hit_ref)
	#enabled=false
	
func reflect(hit_ref):
	var reflected_laser=hit_ref.get_node("Laser")
	#finds correct beam parameters to send to raycast of hit mirror, then fires that raycast as laser
	var mirror_normal=self.get_collision_normal()
	var laser_direction=target_position.rotated(parent_rotation)#to go from local to global
	laser_direction=laser_direction.bounce(mirror_normal.normalized()).snapped(Vector2(1,1))
	if zcomp==0:#i.e. if we're operating in the 2D plane
		reflected_laser.updateandfire(get_collision_point(),laser_direction.normalized()*1000)
	else:#if using 3D
		pass#do fun things later :)

func updateandfire(collision_point,direction):#only 2D version for now
	target_position=direction.rotated(-parent_rotation)#to go from global to local
	#print(target_position)
	global_position=collision_point
	fire()

func turnoff():#called after pressing "End Turn" after firing laser
	$BeamSegment.points[1]=Vector2(0,0)
	enabled=false
