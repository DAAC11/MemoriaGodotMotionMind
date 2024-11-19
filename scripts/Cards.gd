extends TextureButton
class_name Cards

# Atributos
var value
var face
var back

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	set_ignore_texture_size(true)
	set_h_size_flags(Control.SIZE_EXPAND_FILL)
	set_v_size_flags(Control.SIZE_EXPAND_FILL)
	set_stretch_mode(TextureButton.STRETCH_KEEP_ASPECT_CENTERED)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Metodos
func _init(v) -> void:
	value = v
	face = load("res://assets/cards/tile-"+str(v)+".png")
	back = load("res://assets/cards/BackCard5.png")
	
	set_texture_normal(back)
	
func flip():
	if get_texture_normal() == back:
		set_texture_normal(face)
	else:
		set_texture_normal(back)


func _pressed() -> void:
	get_node("/root/Game").chooseCard(self)
