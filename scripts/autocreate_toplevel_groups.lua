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

    -- Get a handle to the second child object, This should be the MyFixtures child if a stage is selected.
    local MyFixtures = MyStage[1]:Ptr(2)
    -- Print some feedback.
    if MyFixtures ~= nil then
        if MyFixtures.name == "Fixtures" then
            Printf("=============== PRINTING ALL TOP LEVEL FIX IN STAGE 1 ===============")
            childs = MyFixtures:Children()
            table.sort(childs, function(a, b)
                local a_is_string = type(a.fid) == "string"
                local b_is_string = type(b.fid) == "string"
            
                if a_is_string and not b_is_string then
                    return true  -- Strings come first
                elseif not a_is_string and b_is_string then
                    return false -- Numbers come after strings
                elseif not a_is_string and not b_is_string then
                    return a.fid < b.fid  -- Sort numbers in ascending order
                else
                    return a.fid < b.fid  -- Sort strings alphabetically if both are strings
                end
            end)
            for i = 1, #childs do
                if childs[i].fid ~= "None" then
                    -- Text is printed for each child.
                    Printf(" Creating group for Child " .. i .. " = " .. childs[i].name .. " FID: " .. childs[i].fid)
                    Cmd("Fixture " .. childs[i].fid)
                    Cmd("Down")
                    Cmd('Store Group "' .. childs[i].name .. ' ' .. childs[i].fid ..'" /overwrite')
                    Cmd("Clear")
                else
                    Printf("Found toplevel without FID, moving on")
                end
            end
            Printf("================ END OF PRINT ================")
        else
        	ErrPrintf(MyFixtures.name)
        end
    else
        ErrPrintf("The object do not have a child object.")
    end
end