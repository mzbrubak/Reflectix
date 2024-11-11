extends Node2D
@export var state=Vector3i(1,0,0)#direction of initial laser propagation
var state_sprite_dictionary={}#since the state of the sprite and the orientation of the mirror
var hit_ref
@onready var laser=$Body/RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func fire_laser():
	laser.enabled=true
	var scene_tree=get_tree()
	await scene_tree.physics_frame
	await scene_tree.physics_frame
	if laser.is_colliding():
		hit_ref=laser.get_collider()
		print(hit_ref)
		if hit_ref.get_collision_layer_value(2)==true:
			hit_ref.get_parent().destroy()
		elif hit_ref.get_collision_layer_value(1)==true:
			reflect()
	laser.enabled=false

func reflect():#put code from laser here 
	print("This is gonna reflect")
	pass

func destroy():
	print("Lol nope")#this piece can't be destroyed
