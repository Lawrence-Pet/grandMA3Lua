-- LUA for adding screenconfig and macro for switching automatically
-- Author: Peter Lundestad Lawrence
-- NOTE: It automatically assigns appearance "ScreenConfig Macro" to the macro.
--       To make sure to add or change this to look as you wish!

local function AddScreenConfig(display, name)
  if not name or name == '' then
  	Echo("Need a name, empty string or None passed")
  	local inputs = {
		{name = "ScreenConfigName", value = "My New Screenconfig"}
		}
	  
	  -- resultTable stores values from messagebox
	  local resultTable = MessageBox({
  		title = "Peter Plugin ScreenConfChange",
  		message = "Type the name of your new ScreenConfig",
  		commands = {{value = 1, name = "Ok"}, {value = 2, name = "cancel"}},
  		inputs = inputs,
  		autoCloseOnInput = true
  		})
  		
  	-- This value is 2 since "please" or "enter" is 0
  	if resultTable.result == 2 then
  		return false
  	
  	else
  		if resultTable.inputs["ScreenConfigName"] == '' then
  			Echo("No name entered")
  			return false
		  end
  			
  		name = resultTable.inputs["ScreenConfigName"]
  		Echo("Registered name: " .. name)
	  end
  	
  end
  
  if ObjectList('ScreenConfig \"' .. name .. '\"')[1] ~= nil then
  	local msg = 'ScreenConfig "' .. name .. '" is allready configured'
  	MessageBox({
  		title = "Peter Plugin ScreenConfChange",
  		message = msg,
  		timeout = 10000, --milliseconds
  		commands = {{value = 1, name = "Ok"}},
  		})
  	return true
  	
  else
  	Echo("Adding New ScreenConfig")
  	
  	--Store Screen Config
	  Cmd('Store ScreenConfig \"' ..name..'\"')
	  
	  -- Store Macro
	  Cmd('Store Macro \"'.. name ..'\" /overwrite')
	  Cmd('Insert Macro \"' .. name .. '\".' .. 1)
	  Cmd('Set Macro \"' .. name .. '\".' .. 1 .. ' Property "Command" "ScreenConfiguration '.. name ..'"')
	  Cmd('Assign Appearance "ScreenConfig Macro" at Macro \"' .. name ..'\"')

  	local msg = 'Added ScreenConfig "' .. name .. '"'
  	MessageBox({
  		title = "Peter Plugin ScreenConfChange",
  		message = msg,
  		timeout = 10000, --milliseconds
  		commands = {{value = 1, name = "Ok"}},
  		})
  	return false
  end
end

return AddScreenConfig