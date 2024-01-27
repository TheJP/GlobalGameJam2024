extends Label


func _ready():
	render_chat()
	ChatGlobal.chat_changed.connect(render_chat)


func render_chat():
	text = "\n".join(ChatGlobal.chat)
