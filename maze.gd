extends Node2D

var time_elapsed       := 0.0
var counter: int       =  1
var started: bool      =  false
var ended: bool        =  false
var playerLoc: Vector2 =  Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	playerLoc = $LevelObjects/Player.position
	print("Game Ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("reset"):
		time_elapsed = 0.0
		counter = 1
		started = false
		ended = false
		$HUD/VBoxContainer/TimerLabel.text = "00:00:00"
		# tp player to start
		$LevelObjects/Player.position = playerLoc

		# reset map
		$Map/Container/Map1.visible = false
		$Map/Container/Map2.visible = false
		$Map/Container/Map3.visible = false
		$Map/Container/Map4.visible = false
		$LevelObjects/Map/Map1.visible = true
		$LevelObjects/Map/Map2.visible = true
		$LevelObjects/Map/Map3.visible = true
		$LevelObjects/Map/Map4.visible = true
		print("Game Reset")
	if started == true and ended == false:
		time_elapsed += delta
		if time_elapsed >= 1.0:
			time_elapsed = 0.0
			counter += 1
			$HUD/VBoxContainer/TimerLabel.text = str(counter/3600).pad_zeros(2) + ":" + str(counter/60).pad_zeros(2) + ":" + str(counter%60).pad_zeros(2)
	elif started == true and ended == true:
		#display end screen
		print("Game Ended")
	else:
		$HUD/VBoxContainer/TimerLabel.text = "00:00:00"


func _on_end_body_exited(body):
	if ended == false and started == true:
		ended = true
		print("Game Ended")
	elif ended == true and started == true:
		print("No Double Ending")
	else:
		print("Game Not Started Yet")


func _on_start_body_exited(body):
	if started == false and ended == false:
		started = true
		print("Game Started")
	elif started == true and ended == false:
		print("No Double Starting")
	else:
		print("Game Already Ended")


func _on_map_1_body_entered(body):
	$Map/Container/Map1.visible = true
	$LevelObjects/Map/Map1.visible = false


func _on_map_2_body_entered(body):
	$Map/Container/Map2.visible = true
	$LevelObjects/Map/Map2.visible = false


func _on_map_3_body_entered(body):
	$Map/Container/Map3.visible = true
	$LevelObjects/Map/Map3.visible = false


func _on_map_4_body_entered(body):
	$Map/Container/Map4.visible = true
	$LevelObjects/Map/Map4.visible = false

