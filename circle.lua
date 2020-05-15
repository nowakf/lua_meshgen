require 'mesh'
local vec3 = require 'vmath'

function Circle(r, resolution)
	local r = r or 1
	local self = Mesh:new{r}
	local arc = math.pi / 2 --1/4 of a circle
	--ech 
	-- since we have 4 vertexes, it needs to be
	-- * 4
	for i=0,r do
		local x = math.cos(arc/r * i)
		local y = math.sin(arc/r * i)
		for i=1,4 do
			x, y = -y, x
			table.insert(self.vertices, vec3(x, y, 0.0))
		end
	end

	--but how do you get the quads all worked out?
	--some kind of recursive subdivision thing?
	return self:scale(r, r, r)
end
