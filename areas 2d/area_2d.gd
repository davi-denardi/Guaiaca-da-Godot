extends Area2D
var damage_color = Color(1.0, 0.259, 0.188, 0.769)
var reset_color = Color(1.0, 1.0, 1.0, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name=="player":
		var reposiciona = body.position.x-25
		var tween = get_tree().create_tween()
		tween.tween_property(body, "position", Vector2(reposiciona,body.position.y), 0.2)
		tween.tween_property(body, "modulate", damage_color, 0.1)
		tween.tween_property(body, "modulate", reset_color, 0.5)
		
