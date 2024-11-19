extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _pressed() -> void:
	if !get_tree().is_paused():
		get_tree().set_pause(true)
		set_texture_normal(load("res://assets/ui/play.png"))

	elif get_tree().is_paused():
		get_tree().set_pause(false)
		set_texture_normal(load("res://assets/ui/pause.png"))
		
	#print("Pause the game")
