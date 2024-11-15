extends Node2D
@export var state=Vector3i(1,0,0)#direction of normal vector of mirror.
var destroyed=false
var state_sprite_dictionary={}#since the state of the sprite and the orientation of the mirror
#map to each other in a 1-to-1 fashion, this keeps track of which sprite corresponds to which state

var is_player1 = true;

# Called when the node enters the scene tree for the first time.
func _ready():	
	rotation=0
	set_rotation_from_state(state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func destroy():
	#print("A mirror has been destroyed!")
	$Rotation/MirrorSurface/Mirror.set_deferred("disabled",true)
	$Rotation/OpaqueSurface/Casing.set_deferred("disabled",true)
	#$OpaqueSurface/Rubble.set_deferred("disabled",false)	
	$Rotation/Red.visible = false
	$Rotation/Blue.visible = false
	if (is_player1):
		$Rotation/OpaqueSurface/Rubble/RedRubble.visible = true
	else:
		$Rotation/OpaqueSurface/Rubble/BlueRubble.visible = true
	$Rotation/CollisionShape2D.visible = false
	$Rotation.collision_mask = 0
	$Rotation.collision_layer = 0
	z_index = 0
	
func set_player1():
	z_index = 100
	is_player1 = true
	$Rotation/Red.visible = true
	$Rotation/Blue.visible = false

func set_player2():
	z_index = 100
	is_player1 = false
	$Rotation/Red.visible = false
	$Rotation/Blue.visible = true



func set_rotation_from_state(rotationstate):
	state=rotationstate
	match rotationstate:
		#First the 2D states
		Vector3i(-1,-1,0):
			$Rotation.rotation=0
		Vector3i(-1,0,0):
			$Rotation.rotation=PI/4
		Vector3i(-1,1,0):
			$Rotation.rotation=PI/2
		Vector3i(0,1,0):
			$Rotation.rotation=3*PI/4
		Vector3i(1,1,0):
			$Rotation.rotation=PI
		Vector3i(1,0,0):
			$Rotation.rotation=5*PI/4
		Vector3i(1,-1,0):
			$Rotation.rotation=3*PI/2
		Vector3i(0,-1,0):
			$Rotation.rotation=7*PI/4
		#Then the 3D states
		Vector3i(-1,-1,1):
			$Rotation.rotation=0
		Vector3i(-1,0,1):
			$Rotation.rotation=PI/4
		Vector3i(-1,1,1):
			$Rotation.rotation=PI/2
		Vector3i(0,1,1):
			$Rotation.rotation=3*PI/4
		Vector3i(1,1,1):
			$Rotation.rotation=PI
		Vector3i(1,0,1):
			$Rotation.rotation=5*PI/4
		Vector3i(1,-1,1):
			$Rotation.rotation=3*PI/2
		Vector3i(0,-1,1):
			$Rotation.rotation=7*PI/4
		Vector3i(0,0,1):
			pass#swap sprite
			$Rotation.rotation=0
	$Rotation/MirrorSurface/Laser.update_rotation()
