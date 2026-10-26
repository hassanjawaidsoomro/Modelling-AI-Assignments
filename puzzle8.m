clc; clear;

start = [7 2 4 5 0 6 8 3 1];     % START state, row by row (0 = the blank)
goal  = [0 1 2 3 4 5 6 7 8];     % GOAL state

% ACTIONS: for each blank position 1-9, the positions it can swap with
moves = {[2 4], [1 3 5], [2 6], [1 5 7], [2 4 6 8], [3 5 9], [4 8], [5 7 9], [6 8]};

queue  = zeros(200000, 9);       % waiting line of states, one state per row
parent = zeros(200000, 1);       % parent(i) = row of the state that led to row i
queue(1,:) = start;
seen = containers.Map(char(start + '0'), true);   % states already visited
k = 1;  last = 1;                % k = row being explored, last = last row filled

while ~isequal(queue(k,:), goal)               % GOAL TEST: is this the goal state?
    s = queue(k,:);
    b = find(s == 0);                          % where is the blank?
    for n = moves{b}                           % ACTION: slide the blank to neighbour n
        t = s;  t([b n]) = t([n b]);           % new state: swap blank and neighbour
        key = char(t + '0');
        if ~isKey(seen, key)                   % only keep states we haven't seen
            seen(key) = true;
            last = last + 1;
            queue(last,:) = t;                 % add to the back of the line
            parent(last) = k;                  % remember where it came from
        end
    end
    k = k + 1;                                 % next state in line
end

path = k;                                      % walk back from the goal to the start
while parent(k) > 0
    k = parent(k);
    path = [k path];
end

fprintf('Solved in %d moves (path cost = %d)\n\n', numel(path)-1, numel(path)-1);
for p = path
    disp(reshape(queue(p,:), 3, 3)');          % show each board (0 = blank)
    fprintf('\n');
end