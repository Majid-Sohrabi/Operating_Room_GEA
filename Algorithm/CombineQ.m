function q=CombineQ(Position01,Position02,Mask,Model)
    
    % Find rows with at least one 1
    rowsWithOnes = find(any(Mask, 2));
    if isempty(rowsWithOnes)
        Pattern = Mask(randi(size(Mask, 1)), :);
    else
        Pattern = Mask(rowsWithOnes(randi(length(rowsWithOnes))), :);
    end

    PatternI=abs(Pattern*-1+ones(1,size(Pattern,2)));
    q=Position01.*Pattern+Position02.*PatternI;
    q;
    
    % Ans.Position=q;
    
    % %%VRP
    % [Ans.Cost Ans.Sol]=MyCost(q,Model);
    
    %%Single Machine
    %Ans.Cost=costfun(q,Model);
    
    %%14 Standard model
    % Ans.Cost=Cost(q,Model);
end
