require 'cube'
local vec3 = require 'vmath'
--define a mesh class that has operators

do
	local scale = 0.1
	local grid = Cube(scale)
	local h, w, d = 20, 20, 50
	for i=1,h*w*d-1 do
		local x = (i % (h * w) % w)
		local y = math.floor(i % (h * w) / w)
		local z = math.floor(i / (h * w))
		local a = vec3(math.random(), math.random(), math.random()):normalize()
		local n = Cube(math.random()*0.5)
		:rotate(a.x, a.y, a.z, math.random() * math.pi)
		:translate(x, y, z)
		grid = grid .. n
	end
	grid:write()
end
