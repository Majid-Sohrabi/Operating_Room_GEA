function Y = reversion_operator(X)
    % Reversion operator: reverses the order of elements between two random indices
    idx = sort(randperm(length(X), 2)); % Select two random indices and sort them
    Y = X;
    % Reverse the subsequence
    Y(idx(1):idx(2)) = X(idx(1):idx(2));
end


