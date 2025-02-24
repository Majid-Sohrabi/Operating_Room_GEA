function Y = swap_operator(X)
    % Swap operator: swaps two random positions in the chromosome
    idx = randperm(length(X), 2); % Select two random indices
    Y = X;
    % Swap the elements
    Y([idx(1), idx(2)]) = X([idx(2), idx(1)]);
end

