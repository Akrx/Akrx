--# Akrx.

--# Referencing services.

local W = game:GetService('Workspace');

--# Referencing variables.

-- throw a warning message to the output.
local function warn(message)
	local template = '%s; %s';
	print(string.format(template, script.Name, message));
end;

local Terrain = {
	
	active = false;
	
	-- generate random terrain with the given x and z arguments.
	create = function(self, x, z)
		if x >= 20 and z >= 20 then
			if self.active then
				warn('preventing you from overwriting the current level, try clearing out the storage folder first.');
				return;
			else
				if not self.storage then
					local storage = Instance.new('Folder', W);
					storage.Name = 'Storage';
					self.storage = storage;
				end;
				self.active = not self.active;
				for x_axis = 1, x do
					for z_axis = 1, z do
						local territory = Instance.new('Part', self.storage);
						territory.Name = 'Territory';
						territory.BrickColor = BrickColor.new('Medium green');
						territory.Size = Vector3.new(3, 3, 3);
						territory.CFrame = CFrame.new(x_axis * 3, math.random() / 2, z_axis * 3);
						territory.Anchored = true;
						territory.Material = Enum.Material.Grass;
					end;
				end;
			end;
		else
			return;
		end;
	end;
	
	-- remove any existing terrain.
	clear = function(self)
		if self.active then
			self.storage:ClearAllChildren();
			self.active = not self.active;
		else
			return;
		end;
	end;
	
};

Terrain:create(20, 20);
