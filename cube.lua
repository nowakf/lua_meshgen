require 'mesh'
local vec3 = require 'vmath'

function Cube(size)
	self = Mesh:new{size or 1}
	local unit_cube_vertices = {
		 vec3( 1.0, 1.0,-1.0),
		 vec3( 1.0,-1.0,-1.0),
		 vec3( 1.0, 1.0, 1.0),
		 vec3( 1.0,-1.0, 1.0),
		 vec3(-1.0, 1.0,-1.0),
		 vec3(-1.0,-1.0,-1.0),
		 vec3(-1.0, 1.0, 1.0),
		 vec3(-1.0,-1.0, 1.0),
	}
	local unit_cube_faces = {
		1, 5, 7, 3, --
		4, 3, 7, 8,
		8, 7, 5, 6,
		6, 2, 4, 8,
		2, 1, 3, 4,
		6, 5, 1, 2, --
	}
	local normals = {
		 vec3(0, 1, 0),
		 vec3(0, 0, 1),
		 vec3(-1, 0, 0),
		 vec3(0, -1, 0),
		 vec3(1, 0, 0),
		 vec3(0, 0, -1),

	}

	self.vertices = unit_cube_vertices
	self.normals = normals
	self.quads = unit_cube_faces

	return self:scale(size)
end
