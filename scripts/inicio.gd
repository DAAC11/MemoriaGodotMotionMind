extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkReplay()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func checkReplay():
	if GameManager.replay:
		%Codigo.text = GameManager.code_player
		%Nombre.text = GameManager.name_player
		GameManager.replay = false
