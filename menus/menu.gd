extends Control


func _on_start_button_pressed():
	print("test")
	get_tree().change_scene_to_file("res://maze.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
