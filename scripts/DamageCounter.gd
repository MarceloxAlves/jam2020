extends Node2D

var damage = 0

func _ready():
	$Damage.text = str(damage)
	$AnimationPlayer.play("damage")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
