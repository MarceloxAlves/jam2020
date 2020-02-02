extends Node2D
var damage = 0
func _ready():
	damage = 0
	
func animate():
	$Label.text =  str(damage)
	$AnimationPlayer.play("hit")
	$Timer.start()


func _on_Timer_timeout():
	self.queue_free()
