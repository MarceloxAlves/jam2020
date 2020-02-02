extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scene = preload("res://scenes/World.tscn")

func _ready():
	pass 


func _on_TextureButton_pressed():
	$AudioStreamPlayer.play()
	$Timer.start()


func _on_Timer_timeout():
	var _change = get_tree().change_scene_to(scene)
