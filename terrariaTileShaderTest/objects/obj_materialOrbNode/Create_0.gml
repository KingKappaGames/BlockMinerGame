event_inherited();

materialType = 2;

image_blend = materialType >= 0 ? tileColors[materialType] : tileColorsDecorative[abs(materialType)];

timer = 0;

essential = true;