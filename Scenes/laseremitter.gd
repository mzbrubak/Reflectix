extends Node2D
@export var state=Vector3i(1,0,0)#direction of initial laser propagation
var state_sprite_dictionary={}#since the state of the sprite and the orientation of the mirror
var hit_ref
@onready var laser=$Body/Laser
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func fire_laser():
	laser.fire()

func destroy():
	print("Lol nope")#this piece can't be destroyed
