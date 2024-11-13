extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in $".".get_children():
		n.set_player2()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
