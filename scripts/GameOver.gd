extends Node2D

var scene = preload("res://scenes/World.tscn")

func _ready():
	pass # Replace with function body.


func _on_TextureButton_pressed():
	var _change = get_tree().change_scene_to(scene)
