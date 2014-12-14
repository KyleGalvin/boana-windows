function _lua_get_script(file) 
	local f = io.open(file,"rb")
	if f then
		print("file found!",file,f)
		local contents = f:read("*all") 
		print("returning contents...")
		return contents
	else
		print("file not found!",file)
		return nil
	end
end


table.insert(package.loaders, 1, function(name)
	print('custom package loader')
	local module = _lua_get_script('./boana-core/' .. name .. '.lua')

	if module then
		return function()
			local f, e = loadstring(module)
 			if f then
				return f()
			else
 				print(e)
			end
		end
	else
		module = _lua_get_script('./Win32/' .. name .. '.lua')
		if module then
			return function()
				local f, e = loadstring(module)
	 			if f then
					return f()
				else
	 				print(e)
				end
			end
		end
	end
end)


local main =  require 'main'
print("what?")
print("what what?",main)