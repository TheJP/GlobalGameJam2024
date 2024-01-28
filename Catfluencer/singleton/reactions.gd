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
	current = _win_emotions[randi() % len(_win_emotions)]
	_reset_after = REACTION_AFTER_GAME


func lose():
	current = _lose_emotions[randi() % len(_lose_emotions)]
	_reset_after = REACTION_AFTER_GAME


func diarrhea():
	current = Emotion.Tongue
	_reset_after = REACTION_AFTER_GAME


func bad_makeup():
	current = Emotion.Huh
	_reset_after = REACTION_AFTER_GAME
