extends Control

var nuevaPartidaButtom
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title()
	info()
	$end.play()
	print("Hola mundo")
	get_tree().set_pause(true)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func title():
	var titulo = %Titulo
	titulo.text = "Felicidades " + str(GameManager.name_player) + " Ganaste" 

func info():
	var inf = $CenterContainer/Panel/VBoxContainer/Panel/VBoxContainer/Info
	var puntaje = "Puntaje: "+ str(GameManager.score)
	var tiempo ="\nTiempo: "+ str(GameManager.seconds)+"s"
	var movimientos = "\nMovimentos: "+ str(GameManager.moves)
	var dificultad = "\nDificuldad: "+ str(GameManager.difficulty)
	inf.text = puntaje +tiempo + movimientos+ dificultad
	
	


func newGame() -> void:
	
	get_tree().set_pause(false)
	var game = get_node("/root/Game")
	
	game.resetGame()
	
	queue_free()
	pass # Replace with function body.


func _on_nueva_partida_pressed() -> void:
	newGame()
	print("Pressed nueva partida")
	
	
	pass # Replace with function body.


func _on_inicio_pressed() -> void:
	get_tree().set_pause(false)
	get_tree().change_scene_to_file("res://scenes/inicio.tscn")
	pass # Replace with function body.

func _on_dificultad_pressed() -> void:
	get_tree().set_pause(false)
	GameManager.replay = true
	get_tree().change_scene_to_file("res://scenes/inicio.tscn")
	pass # Replace with function body.
