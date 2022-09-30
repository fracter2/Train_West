extends Area2D

export var knockback:int = 100



# As it is now, it also gives knockback in the Y direction.
func _physics_process(delta):
	var entity_list:Array = get_entity_list()
	if entity_list.size()!= 0:
		
		for i in entity_list:
			if not i.is_in_group("Non-pushable"):
				var dir:Vector2 = i.position - position
				dir = dir.normalized()
				i.velocity += dir * knockback


# This part was to have an area where knockback got applied just once, like as a big shove. Redundant now.
func _on_Push_Area_body_entered(body):
	pass
#	if body.is_in_group("Entity"):
#		body.velocity.x += knockback
		


func get_entity_list() -> Array:
	return get_overlapping_bodies()
	# Add code to check if its actually pushable
