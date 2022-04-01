extends Viewport

func _ready():
	fxaa = GraphicsSettings.fxaa
	msaa = GraphicsSettings.msaa
	shadow_atlas_size = GraphicsSettings.shadow_resolution
	shadow_atlas_quad_0 = Viewport.SHADOW_ATLAS_QUADRANT_SUBDIV_1
	shadow_atlas_quad_1 = Viewport.SHADOW_ATLAS_QUADRANT_SUBDIV_4
	shadow_atlas_quad_2 = Viewport.SHADOW_ATLAS_QUADRANT_SUBDIV_4
	shadow_atlas_quad_3 = Viewport.SHADOW_ATLAS_QUADRANT_SUBDIV_16
