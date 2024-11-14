extends Control
var rotate_piece=null
var rotation_buttons
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.rotation_selection.connect(on_rotate_selection)
	SignalBus.piece.connect(on_piece)
	rotation_buttons=self.get_children()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_rotate_selection(rotate_selection):
	$".".visible = rotate_selection

func on_piece(piece_node):
	if piece_node==null:
		rotate_piece=null
	else:
		rotate_piece=piece_node.get_parent()
		for rotation_button in rotation_buttons:
			rotation_button.disabled=!is_rotation_accessible(rotation_button,rotate_piece.state)

func is_rotation_accessible(rotation_button, state)->bool:
	var newstate=rotation_button.state
	if state==Vector3i(0,0,1):#straight up
		if rotation_button.state==Vector3(0,0,1):
			return false
		else:
			return true
	elif state.z==1:#up + a 2D direction
		if newstate==state:
			return false
		elif newstate==Vector3i(0,0,1):
			return true
		elif newstate.z==0:
			return (state.x==newstate.x&&state.y==newstate.y)
		elif state.x==-newstate.x&&state.y==-newstate.y:
			return true #can flip by rotating through vertical
		elif abs(state.x)==1 and abs(state.y)==1:
			return (state.x==newstate.x||state.y==newstate.y)
		else:
			return (state.x!=-newstate.x&&state.y!=-newstate.y)
	else:#2D only
		if newstate==state:
			return false
		elif newstate==Vector3i(0,0,1):
			return true
		elif newstate.z==1:
			return (state.x==newstate.x&&state.y==newstate.y)
		elif abs(state.x)==1 and abs(state.y)==1:
			return (state.x==newstate.x||state.y==newstate.y)
		else:
			return (state.x!=-newstate.x&&state.y!=-newstate.y)
		
