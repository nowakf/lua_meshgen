local ffi = require 'ffi'

local function slurp(path)
	local f = assert(io.open(path, 'rb'))
	local contents = f:read('*all')
	f:close()
	return contents
end

ffi.cdef(slurp('./mathc_stripped.h'))

local mathc = ffi.load("./libvec.so")

local vec3
--check mathc.h if you need more functions
local mt = {
	__add = function(a, b) 
		local v = vec3(0,0,0)
		mathc.vec3_add(v.v, a.v, b.v)
		return v
	end,
	__mul = function(a, b)
		local v = vec3(0, 0, 0)
		mathc.vec3_multiply(v.v, a.v, b.v)
		return v
	end,
	__sub = function(a, b)
		local v = vec3(0,0,0)
		mathc.vec3_subtract(v.v, a.v, b.v)
		return v
	end,
	__unm = function(self) 
		self.v = mathc.vec3_negative(self.v, self.v)
		return self
	end,
	__eq = function(a, b)
		return mathc.vec3_is_equal(a.v, b.v)
	end,
	
	__index = {
		rotate = function(self, rotation_axis, radians)
			local v = vec3(0,0,0)
			mathc.vec3_rotate(v.v, self.v, rotation_axis.v, radians)
			return v
		end,
		dot = function(self, other)
			return mathc.vec3_dot(self.v, other.v)
		end,
		cross = function(self, other)
			local v = vec3(0,0,0)
			mathc.vec3_cross(v.v, self.v, other.v)
			return v
		end,
		normalize = function(self)
			local v = vec3(0,0,0)
			mathc.vec3_normalize(v.v, self.v)
			return v
		end,
		length = function(self)
			return mathc.vec3_length(self.v)
		end,
		distance = function(self, other)
			return mathc.vec3_distance(self.v, other.v)
		end,
	}
}

vec3 = ffi.metatype("struct vec3", mt)

return vec3


