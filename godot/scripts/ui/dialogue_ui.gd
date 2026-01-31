extends CanvasLayer

## DialogueUI - The Tamga Protocol
## Displays dialogue with typewriter effect and handles choices

@onready var portrait = $DialogueBox/MarginContainer/HBoxContainer/PortraitContainer/Portrait
@onready var speaker_name = $DialogueBox/MarginContainer/HBoxContainer/PortraitContainer/SpeakerName
@onready var dialogue_text = $DialogueBox/MarginContainer/HBoxContainer/ContentContainer/DialogueText
@onready var choices_container = $DialogueBox/MarginContainer/HBoxContainer/ContentContainer/ChoicesContainer
@onready var next_button = $DialogueBox/MarginContainer/HBoxContainer/ContentContainer/NextButton

## Typewriter effect settings
var text_speed: float = 0.03  # Seconds per character
var is_typing: bool = false
var current_text: String = ""
var current_index: int = 0

func _ready():
	# Connect to DialogueManager signals
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.line_displayed.connect(_on_line_displayed)
	DialogueManager.choices_presented.connect(_on_choices_presented)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

	# Hide initially
	hide()

func _process(_delta):
	# Allow skipping typewriter with any key
	if is_typing and Input.is_action_just_pressed("ui_accept"):
		_complete_text()

func _on_dialogue_started(dialogue_id: String):
	print("DialogueUI: Dialogue started - %s" % dialogue_id)
	show()

func _on_line_displayed(speaker: String, text: String, emotion: String):
	print("DialogueUI: Line displayed - %s: %s" % [speaker, text])

	# Update speaker name
	speaker_name.text = speaker if speaker != "narrator" else ""

	# TODO: Load portrait based on speaker
	# For now, hide portrait for narrator
	portrait.visible = (speaker != "narrator" and speaker != "player")

	# Clear choices
	_clear_choices()

	# Start typewriter effect
	current_text = text
	current_index = 0
	is_typing = true
	dialogue_text.text = ""

	# Hide next button while typing
	next_button.visible = false

	_type_next_character()

func _type_next_character():
	if current_index < current_text.length():
		dialogue_text.text += current_text[current_index]
		current_index += 1

		# Continue typing
		await get_tree().create_timer(text_speed).timeout
		_type_next_character()
	else:
		# Typing complete
		_complete_text()

func _complete_text():
	# Show full text immediately
	dialogue_text.text = current_text
	current_index = current_text.length()
	is_typing = false

func _on_choices_presented(choices: Array):
	print("DialogueUI: Choices presented - %d options" % choices.size())

	# Hide next button when choices are shown
	next_button.visible = false

	# Create button for each choice
	for i in range(choices.size()):
		var choice = choices[i]
		var button = Button.new()
		button.text = "→ " + choice.get("text", "???")
		button.pressed.connect(_on_choice_selected.bind(i))
		choices_container.add_child(button)

func _on_choice_selected(choice_index: int):
	print("DialogueUI: Choice selected - %d" % choice_index)

	# Clear choices
	_clear_choices()

	# Tell DialogueManager
	DialogueManager.select_choice(choice_index)

func _on_next_button_pressed():
	print("DialogueUI: Next button pressed")
	DialogueManager.next_line()

func _on_dialogue_ended():
	print("DialogueUI: Dialogue ended")
	hide()

func _clear_choices():
	for child in choices_container.get_children():
		child.queue_free()

	# Show next button if no choices
	next_button.visible = true
