--# Akrx.

--# Referencing services.

local W = game:GetService("Workspace");

--# Referencing variables.

-- throw a warning message to the output.
local function warn(message)
  local template = "%s; %s";
  print(string.format(template, script.Name, message));
end;
