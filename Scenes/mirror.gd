extends Node2D
@export var state=Vector3i(1,0,0)#direction of normal vector of mirror.
var destroyed=false
var state_sprite_dictionary={}#since the state of the sprite and the orientation of the mirror
#map to each other in a 1-to-1 fashion, this keeps track of which sprite corresponds to which state

var is_player1 = true;

# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.

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
	$Rotation/OpaqueSurface/Rubble/Sprite2D.visible = true
	$Rotation/CollisionShape2D.visible = false
	z_index = 1
	
func set_player1():
	is_player1 = true
	$Rotation/Red.visible = true
	$Rotation/Blue.visible = false

func set_player2():
	is_player1 = false
	$Rotation/Red.visible = false
	$Rotation/Blue.visible = true
