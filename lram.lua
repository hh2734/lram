local lram = {}

local ram = {[""] = {type = "folder", stat = "const"}}

function string.split(str, delimetr)
    delimetr = delimetr or "%s"
    local result = {}
    local pattern = string.format("([^%s]+)", delimetr)
    for match in str:gmatch(pattern) do
        table.insert(result, match)
    end
    return result
end
local function mc(var, ...)
    local v = {...}
    local k
    for _, val in pairs(v) do
        if var == val then return true else k = _ end
    end
    return false, k
end
local function ra(var, y)
    y = y or 0
    if #var - y <= 0 then return table.concat(var), true end
    local out = {}
    for i = 1, #var - y do
        table.insert(out, var[i])
    end
    return table.concat(out)
end
local function path(addr)
    return ram[addr] or false
end
local function new(addr, data)
    data.type = data.type or ""
    data.stat = data.stat or ""
    data.text = tostring(data.text)
    if mc("", data.type) or not mc(data.stat, "const", "norm") then return false end
    
    local p = path(addr)
    if p then return false end
    
    local x = addr:split("/")
    local y, root = ra(x, 1)
    if root then ram[addr] = data return true end
    local p = path(y)
    
    if p then return false end
    
    ram[addr] = data
    return true
end

function lram.file(name, text, stat)
    if stat then stat = "const" else stat = "norm" end
    local out = new(name, {type = "file", stat = stat, text = text})
    return out
end

function lram.folder(name, text, stat)
    if stat then stat = "const" else stat = "norm" end
    local out = new(name, {type = "folder", stat = stat})
    return out
end

function lram.read(addr)
    local p = path(addr)
    if not p or p.type ~= "file" then return false end
    return p.text
end

function lram.remove(addr)
    local p = path(addr)
    if not p or p.stat == "const" then return false end
    ram[addr] = nil
    return true
end

return lram
