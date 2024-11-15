extends Sprite2D

@export var selector: PackedScene
@onready var mirror = $"../.."

var selecting = false
var player1_moving = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.selection.connect(_on_selection)
	SignalBus.is_player1_moving.connect(_on_player_moving)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if is_pixel_opaque(get_local_mouse_position()) and visible and !SignalBus.has_move_been_made and !selecting:
			if $"../..".is_player1 != player1_moving:
				return
			
			SignalBus.selection.emit(true)
			SignalBus.rotation_selection.emit(true)
			#TODO make this global to prevent other pieces
			#left selection
			var new_selector = selector.instantiate()			
			new_selector.position.x -= 20						
			mirror.add_child(new_selector)
			#bottom selection
			var new_selector2 = selector.instantiate()			
			new_selector2.position.y -= 20			
			mirror.add_child(new_selector2)
			#top selection
			var new_selector3 = selector.instantiate()			
			new_selector3.position.y += 20			
			mirror.add_child(new_selector3)
			#right selection
			var new_selector4 = selector.instantiate()			
			new_selector4.position.x += 20			
			mirror.add_child(new_selector4)
			
			#diagonals
			var new_selector_diagonal = selector.instantiate()	
			new_selector_diagonal.position.x -= 20			
			new_selector_diagonal.position.y -= 20			
			mirror.add_child(new_selector_diagonal)
			
			var new_selector_diagonal2 = selector.instantiate()			
			new_selector_diagonal2.position.x += 20				
			new_selector_diagonal2.position.y += 20			
			mirror.add_child(new_selector_diagonal2)
			
			var new_selector_diagonal3 = selector.instantiate()			
			new_selector_diagonal3.position.x += 20				
			new_selector_diagonal3.position.y -= 20			
			mirror.add_child(new_selector_diagonal3)
			
			var new_selector_diagonal4 = selector.instantiate()			
			new_selector_diagonal4.position.x -= 20	
			new_selector_diagonal4.position.y += 20	
			mirror.add_child(new_selector_diagonal4)
			
			#send piece to selectors
			SignalBus.piece.emit($"..")
			print($"..")
func _on_selection(selected):
	selecting = selected
	#print(self,"selected=",selecting)

func _on_player_moving(player_moving):
	player1_moving = player_moving
