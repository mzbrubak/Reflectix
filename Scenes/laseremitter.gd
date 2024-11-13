extends Node2D
@export var state=Vector3i(1,0,0)#direction of initial laser propagation
var state_sprite_dictionary={}#since the state of the sprite and the orientation of the mirror
var hit_ref
@onready var laser=$Rotation/Body/Laser
signal laser_fired

var is_player1 = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func fire_laser():
	laser.fire()
	laser_fired.emit()

func destroy():
	print("Lol nope")#this piece can't be destroyed
	
func set_player1():
	is_player1 = true
	#$Rotation/Red.visible = true
	#$Rotation/Blue.visible = false

func set_player2():
	is_player1 = false
	#$Rotation/Red.visible = false
	#$Rotation/Blue.visible = true
