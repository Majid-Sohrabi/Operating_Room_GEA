function Y = insertion_operator(X)
    % Insertion operator: removes an element from a random position and inserts it at another position
    idx = randperm(length(X), 2); % Select two random indices
    Y = X;
    % Remove the element at idx(1)
    element = Y(idx(1));
    Y(idx(1)) = [];
    % Insert the element at idx(2)
    if idx(2) > length(Y) % If idx(2) is at the end of the array
        Y = [Y, element];
    else
        Y = [Y(1:idx(2)), element, Y(idx(2)+1:end)];
    end
end

