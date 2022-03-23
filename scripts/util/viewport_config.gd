extends Viewport

func _ready():
	fxaa = GraphicsSettings.fxaa
	msaa = GraphicsSettings.msaa
	shadow_atlas_size = GraphicsSettings.shadow_resolution
