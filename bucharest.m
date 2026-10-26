clc; clear;

% ACTIONS: the cities you can drive to from each city (the roads)
roads = containers.Map();
roads('Arad')           = {'Zerind', 'Sibiu', 'Timisoara'};
roads('Zerind')         = {'Arad', 'Oradea'};
roads('Oradea')         = {'Zerind', 'Sibiu'};
roads('Sibiu')          = {'Arad', 'Oradea', 'Fagaras', 'Rimnicu Vilcea'};
roads('Timisoara')      = {'Arad', 'Lugoj'};
roads('Lugoj')          = {'Timisoara', 'Mehadia'};
roads('Mehadia')        = {'Lugoj', 'Dobreta'};
roads('Dobreta')        = {'Mehadia', 'Craiova'};
roads('Craiova')        = {'Dobreta', 'Rimnicu Vilcea', 'Pitesti'};
roads('Rimnicu Vilcea') = {'Sibiu', 'Craiova', 'Pitesti'};
roads('Fagaras')        = {'Sibiu', 'Bucharest'};
roads('Pitesti')        = {'Rimnicu Vilcea', 'Craiova', 'Bucharest'};
roads('Bucharest')      = {'Fagaras', 'Pitesti', 'Giurgiu', 'Urziceni'};
roads('Giurgiu')        = {'Bucharest'};
roads('Urziceni')       = {'Bucharest', 'Vaslui', 'Hirsova'};
roads('Hirsova')        = {'Urziceni', 'Eforie'};
roads('Eforie')         = {'Hirsova'};
roads('Vaslui')         = {'Urziceni', 'Iasi'};
roads('Iasi')           = {'Vaslui', 'Neamt'};
roads('Neamt')          = {'Iasi'};

goal     = 'Bucharest';          % GOAL
frontier = {{'Arad'}};           % waiting line of paths; the first path is just Arad
path     = frontier{1};
city     = path{end};            % STATE: the city we are in now

while ~strcmp(city, goal)                    % GOAL TEST: not in Bucharest yet? keep working
    frontier(1) = [];                        % take the first path out of the line
    next = roads(city);                      % ACTIONS: where can we drive from here?
    for i = 1:numel(next)
        frontier{end+1} = [path, next(i)];   % add one new, longer path per road
    end
    path = frontier{1};                      % the next path in line
    city = path{end};                        % its last city is our new state
end

disp(strjoin(path, ' -> '));
fprintf('Path cost = %d roads\n', numel(path) - 1);