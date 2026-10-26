clc; clear;

% ROADS: each row is one road between two cities
edges = {'Arad','Zerind';       'Arad','Sibiu';          'Arad','Timisoara';
    'Zerind','Oradea';     'Oradea','Sibiu';        'Sibiu','Fagaras';
    'Sibiu','Rimnicu Vilcea'; 'Timisoara','Lugoj';  'Lugoj','Mehadia';
    'Mehadia','Dobreta';   'Dobreta','Craiova';     'Craiova','Rimnicu Vilcea';
    'Craiova','Pitesti';   'Rimnicu Vilcea','Pitesti'; 'Pitesti','Bucharest';
    'Fagaras','Bucharest'; 'Bucharest','Giurgiu';   'Bucharest','Urziceni';
    'Urziceni','Vaslui';   'Urziceni','Hirsova';    'Hirsova','Eforie';
    'Vaslui','Iasi';       'Iasi','Neamt'};

% HEURISTIC h: straight-line distance from each city to Bucharest
h = containers.Map( ...
    {'Arad','Bucharest','Craiova','Dobreta','Eforie','Fagaras','Giurgiu','Hirsova', ...
    'Iasi','Lugoj','Mehadia','Neamt','Oradea','Pitesti','Rimnicu Vilcea','Sibiu', ...
    'Timisoara','Urziceni','Vaslui','Zerind'}, ...
    [366 0 160 242 161 176 77 151 226 244 241 234 380 100 193 253 329 80 199 374]);

% ACTIONS: the cities joined to city c by a road (the other end of each road)
nbrs = @(c) [edges(strcmp(edges(:,1), c), 2); edges(strcmp(edges(:,2), c), 1)];

goal     = 'Bucharest';
path     = {'Arad'};             % the path we are on now
frontier = {};                   % waiting list of other paths
visited  = {};                   % cities already expanded

while ~strcmp(path{end}, goal)                       % GOAL TEST
    city = path{end};                                % current state
    visited{end+1} = city;
    next = nbrs(city);                               % ACTIONS: where can we go?
    for j = 1:numel(next)
        if ~ismember(next{j}, visited)               % skip cities we already expanded
            frontier{end+1} = [path next(j)];        % add the longer path to the list
        end
    end
    [~, i] = min(cellfun(@(p) h(p{end}), frontier)); % GREEDY: smallest h among waiting paths
    path = frontier{i};                              % take that path
    frontier(i) = [];                                % and remove it from the list
end

disp(strjoin(path, ' -> '));
fprintf('Cities expanded: %s\n', strjoin(visited, ', '));
fprintf('Number of roads = %d\n', numel(path) - 1);