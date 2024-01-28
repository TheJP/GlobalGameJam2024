extends Node

signal chat_changed()


const CHAT_EMOJIS = "🐈🐱😸😹😺😻😼😽😾😿🙀"
const NAME_PARTS = [
	"cat",
	"kitten",
	"meow",
	"katze",
	"puss",
	"hoschka",
	"gatto",
	"chat",
	"kat",
	"miau",
	"kissa",
	"kot",
	"kater",
	"kedi",
	"kit",
	"rainbow",
	"maschka",
	"mouseeater",
	"busi",
	"büsi",
	"chätzli",
	"murr",
	"schnurrli",
	"lurba",
	"nana",
	"sion",
]
var chat_lines: int = 11
var chat: Array[String] = []
var chatters: Array[String] = []


func _ready():
	generate_chatters()
	call_deferred("add_chat")


func generate_chatters():
	for part in NAME_PARTS:
		var r = randf()
		if r < 0.3:
			chatters.push_back(part)
		elif r < 0.6:
			chatters.push_back("%s%d" % [part, randi_range(1, 99)])
		else:
			chatters.push_back("%s%s" % [part, NAME_PARTS[randi() % len(NAME_PARTS)]])


func add_chat():
	await get_tree().create_timer(randf_range(0.2, 4.0), false).timeout
	chat.push_back("%s: %s" % [generate_name(), generate_message()])
	while len(chat) > chat_lines:
		chat.pop_front()
	chat_changed.emit()
	add_chat()


func generate_name():
	return chatters[randi() % len(chatters)]


func generate_message():
	if randf() < 0.6:
		return CHAT_EMOJIS[randi() % len(CHAT_EMOJIS)].repeat(randi_range(1, 3))
	
	var meows = []
	while true:
		var es = 1
		while randf() > 0.5:
			es += 1
		meows.push_back(" m%sow" % "e".repeat(es))

		if randf() > 0.5:
			break
		elif randf() > 0.9:
			meows.push_back(",")

	var exclamation = "" if randf() < 0.7 else "!".repeat(randi_range(1, 3))
	var result = "%s%s" % ["".join(meows).strip_edges(), exclamation]
	result = result if randf() < 0.9 else result.to_upper()
	return result
