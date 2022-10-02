/// instance_nth_nearest(x,y,obj,n)
//
//  Returns the id of the nth nearest instance of an object
//  to a given point or noone if none is found.
//
//      x,y       point coordinates, real
//      obj       object index (or all), real
//      n         proximity, real
//
/// GMLscripts.com/license
function instance_nth_nearest(x,y,obj,num){
    var pointx,pointy,object,n,list,nearest;
    pointx = argument0;
    pointy = argument1;
    object = argument2;
    n = argument3;
    n = min(max(1,n),instance_number(object));
    list = ds_priority_create();
    nearest = noone;
    with (object) ds_priority_add(list,id,distance_to_point(pointx,pointy));
    repeat (n) nearest = ds_priority_delete_min(list);
    ds_priority_destroy(list);
    return nearest;
}

/// @function			stat_chooser(n)
/// @description		Selects a percent multiplier from 1 to 100,000 favoring numbers around 100
/// @param base | int	The number to be multiplied
/// returns | int		Weighted number times base number
function stat_chooser(base){
	var num = irandom(9999)
	var bounds = [20, 150, 450, 850, 1550, 2950, 5250, 7050, 8050, 8750, 9250, 9590, 9790, 9910, 9970, 9990, 9999, 100000]
	var multiplier = [1, 5, 10, 30, 50, 70, 90, 110, 140, 170, 220, 300, 500, 750, 1000, 3000, 6000, 10000, 100000]
	for (var i=0; i<array_length(bounds); i++){
		if num < bounds[i]{
			return (irandom_range(multiplier[i], multiplier[i+1])*base)/100
		}
	}
}

/// @function			reduce(argument0)
/// @description		Returns: the number, but reduced so it is closer to 0.
function reduce(argument0) {
	//  Usage:
	//      speed=reduce(speed);
	//
	//  Arguments:
	//      a number  -real
	//
	//  Returns:
	//      the number, but reduced so it is closer to 0.
	return max(abs(argument0)-1,0)*sign(argument0);
}