extends MarginContainer

onready var player = get_parent().get_node('Player')
onready var timer = $Timer

func _ready():
	set_process(true)
	timer.wait_time += 5


func _process(_delta):

	$PC/HBoxContainer/VBoxContainer/HP2/PlayerSword.value =player.sword_life
	$PC/HBoxContainer/VBoxContainer/HP/HBoxContainer/life.value =  player.hp
	$PC/HBoxContainer/time.text =  str(round($Timer.time_left))
	$PC/HBoxContainer/HBoxContainer/metal.text =  str(round(player.quant_item))

	
	if (round($Timer.time_left) == 10):
		$PC/HBoxContainer/time.add_color_override("font_color", Color(1,0.8,0.8,1))
	

func _on_Timer_ready():
	print("d")


func _on_Timer_timeout():
	$PC/HBoxContainer/time.add_color_override("font_color", Color(1,1,1,1))
	self.get_parent().horda_add()
	timer.wait_time += 5
