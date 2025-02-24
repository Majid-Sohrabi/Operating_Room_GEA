function Snew_Position = Mutation(S_Position, model)
    % Selection function: selects the appropriate neighborhood function based on RM
    % Inputs:
    %   - S_Position: Current solution (chromosome)
    %   - RM: Neighborhood function selector (1=swap, 2=reversion, 3=insertion, 4=random)
    %   - model: Additional model parameters (not used in this implementation but reserved for future use)
    % Output:
    %   - Snew_Position: New solution after applying the selected neighborhood function
    
    RM = randi([1, 4]);
    switch RM
        case 1
            Snew_Position = swap_operator(S_Position);
        case 2
            Snew_Position = reversion_operator(S_Position);
        case 3
            Snew_Position = insertion_operator(S_Position);
        case 4
            Snew_Position = random_neighbor_operator(S_Position);
        otherwise
            error('Invalid RM value. Choose 1 (swap), 2 (reversion), 3 (insertion), or 4 (random).');
    end
end