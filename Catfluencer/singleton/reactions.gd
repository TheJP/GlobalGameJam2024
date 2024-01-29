extends Node


enum Emotion {
	Cry,
	Glasses,
	Grumpy,
	Huh,
	Neutral,
	Polite,
	Shook,
	Tongue,
}


const REACTION_AFTER_GAME = 2.0
var current: Emotion = Emotion.Neutral
var _reset_after: float = 0
var _win_emotions = [Emotion.Glasses, Emotion.Polite]
var _lose_emotions = [Emotion.Cry, Emotion.Grumpy]


func _process(delta):
	if _reset_after > 0:
		if _reset_after <= delta:
			_reset_after = 0
			current = Emotion.Neutral
		else:
			_reset_after -= delta


func win():
	show_emotion(_win_emotions[randi() % len(_win_emotions)], REACTION_AFTER_GAME)


func lose():
	show_emotion(_lose_emotions[randi() % len(_lose_emotions)], REACTION_AFTER_GAME)


func diarrhea():
	show_emotion(Emotion.Tongue, REACTION_AFTER_GAME)


func bad_makeup():
	show_emotion(Emotion.Huh, REACTION_AFTER_GAME)


## if duration is 0, the emotion will be shown indefinitely
func show_emotion(emotion: Emotion, duration: float = 0):
	current = emotion
	_reset_after = duration
