extends Node2D

var player = null
var currentParent = null

onready var area = $facao/Area2D

func _ready():
	currentParent = self.get_parent()


func _process(delta):
	if(is_instance_valid(player) and currentParent.name == "World"):
		currentParent.remove_child(self)
		player.add_child(self)
	
	

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		player = body
		player.equip(self)
		
	
