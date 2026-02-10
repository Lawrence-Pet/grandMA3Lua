-- LUA for listing screenconfigs in system monitor (Nice to have)
-- Author: Peter Lundestad Lawrence

return function()
    local list = ObjectList('ScreenConfig *')
    for i, sc in ipairs(list) do
        Echo(string.format('%d: %s', i, sc.name))
    end
end