function i=RouletteWheelSelection(P)
    % We explained the roulette wheel selection in 574 to 580
    r=rand;
    
    c=cumsum(P);
    % We computed the probability in above 
    
    i=find(r<=c,1,'first');
    % the above equation refers to Eq. (33)

end