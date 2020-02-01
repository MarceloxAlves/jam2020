extends Node2D

onready var player = get_tree().get_root().get_node("World").get_node("Player")

func _on_Area2D_body_entered(body):
	if (body.name == "Player"):
		player.equip()
