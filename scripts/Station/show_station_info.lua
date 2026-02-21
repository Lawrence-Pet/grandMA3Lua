local function safeGet(h, prop)
    local ok, val = pcall(function() return h:Get(prop) end)
    if ok then return val end
    return nil
end

local function walk(h, depth, maxdepth)
    -- 1) Check if max depth is reached
    if maxdepth and depth >= maxdepth then
        return false
    end

    -- 2) Check current object
    local name = safeGet(h, "Name")
    if name == "OutputStations" then
        Printf("")
        Printf("=== FOUND OutputStations (depth %d) ===", depth)
        h:Dump()
        Printf("")
        Printf("=== LISTING OUTPUT STATIONS ===")
        local OutputStations = h:Children() or {}
        for _,s in ipairs(OutputStations) do
            local check = safeGet(s, "Name")
            if check then
                s:Dump()
                Printf("")
            end
        end
        Printf("================================")
        return true
    end

    -- 3) Recurse into children
    local children = h:Children()
    if not children then
        return false
    end

    for _, child in ipairs(children) do
        if walk(child, depth + 1, maxdepth) then
            return true
        end
    end

    return false
end

return function()
    local MAX_DEPTH = 8
    local root = DeviceConfiguration()

    Printf("Finding OutputStations (max depth %d)", MAX_DEPTH)

    local found = walk(root, 0, MAX_DEPTH)

    if not found then
        Printf("OutputStations not found within max depth %d", MAX_DEPTH)
    end
end