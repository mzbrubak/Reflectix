extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.rotation_selection.connect(on_rotate_selection)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_rotate_selection(rotate_selection):
	$".".visible = rotate_selection
