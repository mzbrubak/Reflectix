extends Node2D
@export var state=Vector3i(1,0,0)#direction of initial laser propagation
var state_sprite_dictionary={}#since the state of the sprite and the orientation of the mirror
var hit_ref
@onready var laser=$Rotation/Body/Laser
signal laser_fired

var is_player1 = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation=0
	set_rotation_from_state(state)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func fire_laser():
	$Zap.play()
	laser.fire()
	laser_fired.emit()
	
func destroy():	
	SignalBus.end_turn_button.disabled = true
	SignalBus.music.stop()	
	$Timer.start()	

func _on_timer_timeout() -> void:
	SignalBus.end_condition.emit(!is_player1)
	$GameOver.play()	
	
func set_player1():
	is_player1 = true
	#$Rotation/Red.visible = true
	#$Rotation/Blue.visible = false
	#$Rotation/Body/Laser.mesh.material.albedo_color = Color(255,0,0,0)
func set_player2():
	is_player1 = false
	#$Rotation/Red.visible = false
	$Rotation/BlueLaser.visible = true
	$Rotation/RedLaser.visible = false
	#$Rotation/Blue.visible = true
	#$Rotation/Body/Laser.mesh.material.albedo_color = Color(0,0,255,0)

func set_rotation_from_state(rotationstate):
	state=rotationstate
	match rotationstate:
		#First the 2D states
		Vector3i(1,0,0):
			$Rotation.rotation=0
		Vector3i(1,-1,0):
			$Rotation.rotation=PI/4
		Vector3i(0,-1,0):
			$Rotation.rotation=PI/2
		Vector3i(-1,-1,0):
			$Rotation.rotation=3*PI/4
		Vector3i(-1,0,0):
			$Rotation.rotation=PI
		Vector3i(-1,1,0):
			$Rotation.rotation=5*PI/4
		Vector3i(0,1,0):
			$Rotation.rotation=3*PI/2
		Vector3i(1,1,0):
			$Rotation.rotation=7*PI/4

		#Then the 3D states

		Vector3i(1,0,1):
			$Rotation.rotation=0
		Vector3i(1,-1,1):
			$Rotation.rotation=PI/4
		Vector3i(0,-1,1):
			$Rotation.rotation=PI/2
		Vector3i(-1,-1,1):
			$Rotation.rotation=3*PI/4
		Vector3i(-1,0,1):
			$Rotation.rotation=PI
		Vector3i(-1,1,1):
			$Rotation.rotation=5*PI/2
		Vector3i(0,1,1):
			$Rotation.rotation=3*PI/2
		Vector3i(1,1,1):
			$Rotation.rotation=7*PI/2
		Vector3i(0,0,1):
			pass#swap sprite
			$Rotation.rotation=0
			
	$Rotation/Body/Laser.update_rotation()
