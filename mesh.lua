local vec3 = require 'vmath'

Mesh = {}

function Mesh:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	self.vertices = {}
	self.quads = {}
	self.normals = {}
	return o
end

function Mesh:__concat(b)
	for i, v in ipairs(b.quads) do
		b.quads[i] = v + #self.vertices
	end
	table.concat(self.vertices, b.vertices)
	table.concat(self.normals, b.normals)
	table.concat(self.quads, b.quads)
	return self
end

function Mesh:translate(x, y, z)
	for i, v in ipairs(self.vertices) do
		self.vertices[i] = v + vec3(x, y, z)
	end
	return self
end

function Mesh:scale(x, y, z)
	y = y or x
	z = z or x
	for i, v in ipairs(self.vertices) do
		self.vertices[i] = v * vec3(x, y, z)
	end
	return self
end

function Mesh:rotate(x, y, z, theta)
	for i, v in ipairs(self.vertices) do
		self.vertices[i] = v:rotate(vec3(x, y, z), theta)
	end
	return self
end

function Mesh:write(path)
	local f
	if path then
		f = assert(io.open(path, 'w'))
	else
		f = io.stdout
	end
	f:write('# OBJ file\n')
	for _, v in ipairs(self.vertices) do
		f:write(string.format("v %.4f %.4f %.4f\n", 
		v.x, v.y, v.z))
	end
	for _, v in ipairs(self.normals) do
		f:write(string.format("vn %.4f %.4f %.4f\n", 
		v.x, v.y, v.z))
	end
	for i= 1,#self.quads,4 do
		local norm_index = math.ceil(i / 4)
		f:write(string.format("f %d//%d %d//%d %d//%d %d//%d\n",
		self.quads[i], norm_index,
		self.quads[i+1], norm_index,
		self.quads[i+2], norm_index,
		self.quads[i+3], norm_index))
	end
	f:close()
end

function table.concat(a, b)
	for i=1,#b do
		a[#a+1] = b[i]
	end
	return a
end
