extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(0.95, 0.94, 0.90))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
