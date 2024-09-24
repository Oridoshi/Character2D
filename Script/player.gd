extends CharacterBody2D

const SPEED = 300.0
const ACCELERATION = 3000

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var mouvement = Vector2(
		Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft"),
		Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	)
	
	# Normaliser la direction si sa longueur est supérieure à 1
	if mouvement.length() > 1.0:
		mouvement = mouvement.normalized()
	
	# Déplacer le personnage
	velocity = velocity.move_toward(mouvement * SPEED, delta * ACCELERATION)
	move_and_slide()
	
	 #Gérer l'animation ou l'orientation du sprite
	_update_animation(mouvement)

func _update_animation(direction: Vector2) -> void:
	if direction.x < 0: # Se déplace à gauche
		animated_sprite.flip_h = true
		animated_sprite.play("run")
	elif direction.x > 0: # Se déplace à droite
		animated_sprite.flip_h = false
		animated_sprite.play("run")
	elif direction.y != 0: # Se déplace en haut ou en bas
		animated_sprite.play("run")
	else: # Pas de mouvement
		animated_sprite.play("idle")
