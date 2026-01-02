function script_createHeldItemPickup(index = -1, xx = x, yy = y) {
	var _item = instance_create_layer(xx, yy, "Instances", obj_itemHeldPickup);
	
	with(_item) {
		if(index == -1) {
			index = irandom(E_item.itemCount - 1);
		}
		
		pickupIndex = index;
		
		sprite_index = script_getHeldItemSprite(index);
	}
	
	return _item;
}