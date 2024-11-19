extends Control


@onready var Game = get_node("/root/Game")
var difficulty = GameManager.difficulty
var deck = Array()
var card1: Cards
var card2: Cards
var matchTimer :Timer = Timer.new()
var flipTimer :Timer = Timer.new()
var secondsTimer :Timer = Timer.new()
var score = 0
var seconds = 0
var moves = 0
var scoreLabel
var timerLabel
var movesLabel
var resetButton
var pauseButton
var exitButton
# URL de la API de Google Apps Script que creaste
var url := "https://script.google.com/macros/s/AKfycbxAsUMvPFyWcIfjbfa3NSp_2IjUOL7H7q0PvNpRYVuIQ2_rXRXUq-nDPJ-RmoH6_Pljfw/execc"


var goal
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(difficulty+ GameManager.difficulty)
	$Sounds/start.play()
	fillDeck()
	dealDeck()
	setupTimers()
	setupHUD()
	print(GameManager.code_player)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func resetGame():
	#Borrar las cartas y eliminar los punteros de las cartas
	for c in range(deck.size()):
		deck[c].queue_free()
	deck.clear()
	score = 0
	seconds = 0
	moves = 0
	scoreLabel.text = str(score)
	timerLabel.text = str(seconds)
	movesLabel.text = str(moves)

	fillDeck()
	dealDeck()
	get_tree().set_pause(false)


func setupTimers():
	flipTimer.connect("timeout",Callable(self, "turnOverCards"))
	flipTimer.set_one_shot(true)
	add_child(flipTimer)
	
	matchTimer.connect("timeout",Callable(self, "matchCardsAndScore"))
	matchTimer.set_one_shot(true)
	add_child(matchTimer)
	
	secondsTimer.connect("timeout",Callable(self, "countSeconds"))
	add_child(secondsTimer)
	secondsTimer.start()
	
func setupHUD(): # Asigna los punteros del nodo Hud a los valores score, moves, T
	scoreLabel = Game.get_node("HUD/Panel/Sections/SScore/score")
	timerLabel = Game.get_node("HUD/Panel/Sections/STime/seconds")
	movesLabel = Game.get_node("HUD/Panel/Sections/SMoves/moves")
	scoreLabel.text = str(score)
	timerLabel.text = str(seconds)
	movesLabel.text = str(moves)
	resetButton = Game.get_node("HUD/Panel/Sections/Sbuttons/ButtonReset")
	resetButton.connect("pressed",Callable(self,"resetGame"))
	exitButton = Game.get_node("HUD/Panel/Sections/Sbuttons2/ExitButton")
	exitButton.connect("pressed",Callable(self,"exitGame"))

func exitGame():
	get_tree().set_pause(false)
	get_tree().change_scene_to_file("res://scenes/inicio.tscn")
	
func countSeconds():
	seconds += 1
	timerLabel.text = str(seconds)

func fillDeck():
	
	var nDeck = 0
	if difficulty == "2x3":
		nDeck = 3
		goal = 3
		get_node("grid").set_columns(3)
	elif difficulty == "4x4":
		nDeck = 8
		goal = 8
		get_node("grid").set_columns(4)
	elif difficulty == "4x6":
		nDeck = 12
		goal = 12
		get_node("grid").set_columns(6)
	else:
		nDeck = 8
		goal = 8
		get_node("grid").set_columns(4)
		
	var v = 0
	while v < nDeck:
		deck.append(Cards.new(v))
		deck.append(Cards.new(v))
		v += 1
		
func dealDeck():
	deck.shuffle()
	var c = 0
	while c < deck.size():
		Game.get_node("grid").add_child(deck[c])
		c +=1
		
func chooseCard(c : Cards):
	if card1 == null:
		card1 = c
		card1.flip()
		$Sounds/card.play()
		card1.set_disabled(true)
		
	elif card2 == null:
		card2 = c
		card2.flip()
		$Sounds/card.play()
		card2.set_disabled(true)
		moves += 1
		movesLabel.text = str(moves)
		
		checkCards()
		
func checkCards():
	if card1.value == card2.value:
		matchTimer.start(0.5)
		$Sounds/god.play()
	else:
		flipTimer.start(0.5)
		$Sounds/fail.play()
		
func turnOverCards():
	card1.flip()
	card2.flip()
	card1.set_disabled(false)
	card2.set_disabled(false)
	card1 = null
	card2 = null
	
func matchCardsAndScore():
	score += 1
	scoreLabel.text = str(score) # Actualiza el score en el label correspondiente
	card1.set_modulate(Color(0.7,0.7,0.7,0.5))
	card2.set_modulate(Color(0.7,0.7,0.7,0.5))
	card1 = null
	card2 = null
	if score == goal:
		GameManager.score =  score
		GameManager.seconds = seconds
		GameManager.moves = moves
		callWin()
		print("Win" + str(goal))

func callWin():
	$HTTP.send_data(createData())
	var winScene = preload("res://scenes/win.tscn")
	var win = winScene.instantiate()
	Game.add_child(win)
	
# Función que se ejecuta cuando el jugador gana la partida
func createData():
	var data ={
	  "Codigo": str(GameManager.code_player),
	  "Nombre":str(GameManager.name_player),
	  "Dificultad":str(GameManager.difficulty),
	  "Tiempo":str(GameManager.seconds) ,
	  "Movimientos":str(GameManager.moves) ,
	  "Puntaje": str(GameManager.score)
	}
	
	return data
