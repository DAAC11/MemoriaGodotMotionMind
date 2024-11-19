extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

		
	pass

func _pressed() -> void:
	#var game_scene = load("res://scenes/game.tscn")
	complete_data()
	

# Extra los inputs y los envias al gameManager
func check_data():
	var codigo = %Codigo.get_text()
	var nombre = %Nombre.get_text()
	var dificultad = %Dificultad.get_item_text(%Dificultad.get_selected_id())
	#print(str(codigo)+" "+str(nombre)+" "+str(dificultad))
	GameManager.playing = true
	GameManager.code_player = codigo
	GameManager.name_player = nombre
	GameManager.difficulty = dificultad
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func complete_data():
	var output1 ="Por favor complete el campo:"
	var output2 = "Por favor complete los campos:"
	var complement = ""
	var n = 0
	var codigo = %Codigo.get_text()
	var nombre = %Nombre.get_text()
	var dificultad = %Dificultad.get_item_text(%Dificultad.get_selected_id())
	if codigo == "":
		complement += " Código"
		n+=1
	if nombre == "":
		complement += " Nombre"
		n+=1
	if dificultad == "":
		complement += " Dificultad"
		n+=1
	if n >1:
		%Warning.set_text(output2+complement)
	else:
		%Warning.set_text(output1+complement)
	if codigo !="" and nombre!="" and dificultad!="":
		check_data()
