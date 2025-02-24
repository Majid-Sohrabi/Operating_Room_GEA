function Y = random_neighbor_operator(X)
    % Random neighbor operator: generates a new random solution different from the input solution
    n = length(X);
    while true
        Y = randperm(n); % Generate a random permutation
        if ~isequal(Y, X) % Ensure the new solution is different from the current solution
            break;
        end
    end
end


