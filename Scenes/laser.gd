extends Node2D
@export var state=Vector3i(1,0,0)#direction of initial laser propagation
var state_sprite_dictionary={}#since the state of the sprite and the orientation of the mirror

# Called when the node enters the scene tree for the first time.
func _ready():
	start_laser()
	var scene_tree=get_tree()
	await scene_tree.physics_frame
	await scene_tree.physics_frame
	print($Body/RayCast2D.is_colliding())
	stop_laser()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_laser():
	$Body/RayCast2D.enabled=true

func stop_laser():
	$Body/RayCast2D.enabled=false

func destroy():
	print("Lol nope")#this piece can't be destroyed
