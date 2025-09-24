function script_pickaxeMineNormal(xx, yy) {
	gml_pragma("forceinline");
	
	return script_breakTileAtPos(xx, yy); // expand i guess
}