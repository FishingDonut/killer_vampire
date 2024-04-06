extends CanvasLayer

@onready var counter_kill_label = $MarginContainer/GridKill/CounterKill
@onready var counter_time_label = $MarginContainer/GridTime/CounterTime
@onready var counter_score_label = $MarginContainer/GridScore/CounterScore

var timer: float
var seconds: float
var minutes: float
var hours: float

func _ready():
	counter_score_label.text = str("%09d" % Global.counter_score)
	counter_kill_label.text = str("%06d" % Global.counter_kill)
	
	timer = 0.0
	seconds = 0.0
	minutes = 0.0
	hours = 0.0


func _process(delta):
	counter_score_label.text = str("%09d" % Global.counter_score)
	counter_kill_label.text = str("%06d" % Global.counter_kill)

func _physics_process(delta):
	_update_timer(delta)


func _update_timer(delta):
	timer+=delta
	if timer >= 1:
		timer = 0
		seconds += 1
		if seconds >= 60:
			seconds = 0
			minutes += 1
			if minutes >= 60:
				minutes = 0
				hours += 1
				if hours >= 60:
					hours = 0
	_update_counter_time()
	
	
func _update_counter_time():
	counter_time_label.text = str("%02d" % hours) + ":" + str("%02d" % minutes) + ":" + str("%02d" % seconds)
