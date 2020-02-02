extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var  player =  get_parent().get_node('Player')
onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	timer.wait_time += 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	$HBoxContainer/VBoxContainer/HP2/PlayerSword.value =player.sword_life
	$HBoxContainer/time.text =  str(round($Timer.time_left))
	$HBoxContainer/MarginContainer/HBoxContainer/metal.text =  str(round(player.quant_item))
	
	if (round($Timer.time_left) == 10):
		$HBoxContainer/time.add_color_override("font_color", Color(1,0,0,1))
	

func _on_Timer_ready():
	print("d")


func _on_Timer_timeout():
	$HBoxContainer/time.add_color_override("font_color", Color(1,1,1,1))
	self.get_parent().horda_add()
	timer.wait_time += 5
