function string.split(str, delimiter)
    delimiter = delimiter or "%s"  -- по умолчанию пробельные символы
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    
    for match in str:gmatch(pattern) do
        table.insert(result, match)
    end
    
    return result
end

local lram = {}

local ram = {}

local pointer = {["/"] = {name = "ram", type = "const"}

function lram.file(folder, name, data)
	lram[folder][name] = data
end

function lram.read(path)
	lram
end

function lram.remove(path)
	local p = pointer[path]
	if not p or p.type == "const" then return false end
	pointer[path] = nil
		
end
