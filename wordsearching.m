clc; clear;

letters = 'abcdefg';                 % ACTIONS: the 7 letters we can add

% DICTIONARY: real English words that use only the letters a to g
dict = {'a','ad','be','add','age','ace','bad','bag','bed','bee','beg','cab', ...
    'cad','dab','dad','ebb','egg','fad','fed','fee','gab','gad','gag','gee', ...
    'egad','abed','aced','aged','babe','bade','bead','beef','cafe','cage', ...
    'cede','dead','deaf','deed','edge','face','fade','feed','gaff','gage', ...
    'gaga','adage','badge','cadge','caged','decaf','faced','faded','added', ...
    'ebbed','egged','dabbed','gabbed','bagged','beaded','beefed','deface', ...
    'efface','facade','decade','cabbage','baggage','defaced','effaced'};

frontier = {''};                     % START state: the empty word
found    = {};                       % the words we find

while ~isempty(frontier)                     % keep going while words are waiting
    w = frontier{end};                       % take the LAST one (depth-first)
    frontier(end) = [];                      % remove it from the list

    if ismember(w, dict)                     % GOAL TEST: is it a real word?
        found{end+1} = w;                    % yes, save it
    end

    for i = 7:-1:1                           % ACTIONS: add each letter (g first, a last)
        c = [w letters(i)];
        if any(strncmp(c, dict, length(c)))  % PRUNE: could c still become a real word?
            frontier{end+1} = c;             % yes, keep exploring it
        end
    end
end

fprintf('%s\n', found{:});
fprintf('Total words = %d\n', numel(found));