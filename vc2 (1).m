clc; clear;
rng('shuffle');

action  = {'Right', 'Suck';
    'Left',  'Suck'};
nextLoc = [2 1;
    1 2];

room = randi([1 2], 1, 2);
loc  = randi([1 2]);

place  = 'AB';
status = {'Clean', 'Dirty'};

fprintf('Start: A is %s, B is %s, vacuum is in %s\n\n', ...
    status{room(1)}, status{room(2)}, place(loc));

for step = 1:8
    s = room(loc);
    fprintf('Step %d | At %s | %s | Action: %s\n', ...
        step, place(loc), status{s}, action{loc, s});
    room(loc) = 1;
    loc = nextLoc(loc, s);
end