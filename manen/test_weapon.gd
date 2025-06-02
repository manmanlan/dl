extends Node3D


func up_attack():
	$AnimationPlayer.play("idle_attack")

func down_attack():
	$AnimationPlayer.play("idle_attack")

func right_attack():
	$AnimationPlayer.play("idle_attack")

func left_attack():
	$AnimationPlayer.play("idle_attack")

func idle_attack():
	$AnimationPlayer.play("idle_attack")
