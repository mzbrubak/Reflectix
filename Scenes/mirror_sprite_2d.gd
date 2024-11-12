extends Sprite2D

@export var selector: PackedScene

var selecting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.selection.connect(_on_selection)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if is_pixel_opaque(get_local_mouse_position()) and !selecting:
			SignalBus.selection.emit(true)
			#TODO make this global to prevent other pieces
			#left selection
			var new_selector = selector.instantiate()			
			new_selector.position.x -= 20			
			add_child(new_selector)
			#bottom selection
			var new_selector2 = selector.instantiate()			
			new_selector2.position.y -= 20			
			add_child(new_selector2)
			#top selection
			var new_selector3 = selector.instantiate()			
			new_selector3.position.y += 20			
			add_child(new_selector3)
			#right selection
			var new_selector4 = selector.instantiate()			
			new_selector4.position.x += 20			
			add_child(new_selector4)
			
			#send piece to selectors
			SignalBus.piece.emit($"..")
			
func _on_selection(selected):
	selecting = selected
