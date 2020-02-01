extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scene = preload("res://scenes/World.tscn")

func _ready():
	pass 

func _on_Button_pressed():
	get_tree().change_scene_to(scene)
