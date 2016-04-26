-- Collection of utilities for handling Components
Component = {}

Component.all = {}

-- Create a Component class with the specified name and fields
-- which will automatically get a constructor accepting the fields as arguments
function Component.create(name, fields, defaults)
	local component = class(name)

	if fields then
    defaults = defaults or {}
		component.initialize = function(self, ...)
      local args = {...}
			for index, field in ipairs(fields) do
				self[field] = args[index] or defaults[field]
			end
		end
	end

	Component.register(component)

	return component
end

-- Register a Component to make it available to Component.load
function Component.register(componentClass)
	Component.all[componentClass.name] = componentClass
end

-- Load multiple components and populate the calling functions namespace with them
-- This should only be called from the top level of a file!
function Component.load(names)
	local env = {}
	setmetatable(env, {
		__index = _G,
		__newindex = _G
	})
	setfenv(2, env)

	for _, name in pairs(names) do
		env[name] = Component.all[name]
	end
end

