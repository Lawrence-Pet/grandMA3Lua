return function()
    -- Stage() creates a handle to the selected sequence.
    local stagenum = TextInput("Autocreation of groups based on stage", "Please type stage ID:")
    local stagecmd = "Stage "..tostring(stagenum)

    -- This returns a LIST of objects from the command, in our case we select one object
    -- so the first element is what we want to look at
    local MyStage = ObjectList(stagecmd)
    -- Check that a list was returned - if not then exit function.
    if MyStage == nil then
        ErrPrintf("There is no stage with that number.")
        return
    end
    
    Printf("Printing children of "..MyStage[1].name)
    -- Get a handle to the second child object, This should be the fixtures child.
    Printf("=============== PRINTING ALL CHILDREN IN STAGE ===============")
    childs = MyStage[1]:Children()
    for i = 1, #childs do
        -- Text is printed for each child.
        Printf(" Child " .. i .. " = " .. childs[i].name)
    end
    Printf("================ END OF PRINT ================")
end