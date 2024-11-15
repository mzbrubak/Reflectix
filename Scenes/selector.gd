extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RenderTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass	

func _on_body_entered(body) -> void:
	if (body.visible):
		queue_free()

func _on_timer_timeout() -> void:	
	$".".visible=true
