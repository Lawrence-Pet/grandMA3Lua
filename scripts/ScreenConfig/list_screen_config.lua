return function()
    local list = ObjectList('ScreenConfig *')
    for i, sc in ipairs(list) do
        Echo(string.format('%d: %s', i, sc.name))
    end
end