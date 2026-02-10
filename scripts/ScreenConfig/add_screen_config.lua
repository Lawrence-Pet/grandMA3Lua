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
  		commands = {{value = 1, name = "Ok"}, {value = 0, name = "cancel"}},
  		inputs = inputs,
  		autoCloseOnInput = true
  		})
  		
  		
  	if resultTable.result == 0 then
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
  	Cmd('Store ScreenConfig \"' ..name..'\"')
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