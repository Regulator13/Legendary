/// @description Break to walls

//Create 4x4 of small walls in place
for (var i=0; i<4; i++){
	for (var j=0; j<4; j++){
		instance_create_layer(x + i*8,y + j*8, "lay_instances", Small)
	}
}

instance_destroy(self)
