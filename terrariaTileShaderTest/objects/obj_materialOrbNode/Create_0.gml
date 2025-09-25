event_inherited();

materialType = 2;

image_blend = materialType >= 0 ? global.tileColors[materialType] : global.tileColorsDecorative[abs(materialType)];

essential = true;