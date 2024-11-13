extends Node2D
@export var state=Vector3i(1,0,0)#direction of normal vector of mirror.
var destroyed=false
var state_sprite_dictionary={}#since the state of the sprite and the orientation of the mirror
#map to each other in a 1-to-1 fashion, this keeps track of which sprite corresponds to which state


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func destroy():
	print("A mirror has been destroyed!")
	$Rotation/MirrorSurface/Mirror.set_deferred("disabled",true)
	$Rotation/OpaqueSurface/Casing.set_deferred("disabled",true)
	#$OpaqueSurface/Rubble.set_deferred("disabled",false)
