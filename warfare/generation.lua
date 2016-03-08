--# Akrx.

--# Referencing services.

local W = game:GetService('Workspace');
local T = game:GetService('Teams');
local P = game:GetService('Players');

--# Referencing variables.

-- throw a warning message to the output.
local function warn(message)
	local template = '%s; %s';
	print(string.format(template, script.Name, message));
end;

-- sort the teams based on who's actually playing.
local function sortTeams()
	local new_teams = {};
	for i, v in next, T:GetChildren() do
		for x, y in next, P:GetPlayers() do
			if y.TeamColor == v.TeamColor then
				table.insert(new_teams, v);
			end;
		end;
	end;
	return new_teams;
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
	
	-- instantiate spawn locations if that team is rendered 'active'.
	spawn = function(self)
		local teams = T:GetChildren();
		local terrain = self.storage:GetChildren();
		local last;
		for i = 1, #teams do
			repeat
				wait();
				local territory = terrain[math.random(1, #terrain)];
				if last then
					if (last.Position - territory.Position).magnitude >= 10 then
						local spawn_point = Instance.new('Part', territory);
						spawn_point.Name = 'Spawn';
						spawn_point.Size = Vector3.new(1, 1, 1);
						spawn_point.BrickColor = teams[i].TeamColor;
						spawn_point.CFrame = territory.CFrame * CFrame.new(0, 2.5, 0);
						last = spawn_point;
					end;
				else
					local spawn_point = Instance.new('Part', territory);
					spawn_point.Name = 'Spawn';
					spawn_point.Size = Vector3.new(1, 1, 1);
					spawn_point.BrickColor = teams[i].TeamColor;
					spawn_point.CFrame = territory.CFrame * CFrame.new(0, 2.5, 0);
					last = spawn_point;
				end;
			until
			last;
			last = nil;
		end
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
