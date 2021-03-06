extends Area2D

var active = false
onready var player = get_node("../../KinematicBody2D")

func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')


func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("dialogic_default_action") and active:
			get_tree().paused = true
			var dialog = Dialogic.start('TalkingToASpaceship')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)

func unpause(_timeline_name):
	get_tree().paused = false
	active = false

func _on_NPC_body_entered(body):
	if body == player:
		active = true

func _on_NPC_body_exited(body):
	if body == player:
		active = false
