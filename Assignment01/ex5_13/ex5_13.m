load('C:\Users\helia\Desktop\UcL\Graphical Models\Matlab\BRMLtoolkit\data\SimoHurrta.mat')

% set target planet
target_planet = 1725;

best = ones(target_planet,1)*target_planet;
best(1) = 0;
prev = zeros(target_planet,1);

% for planet 1 to planet 1724
for from_planet = 1:target_planet-1
    % minimum score till now to go to planet from_planet
    score_planet = best(from_planet);
    
    % for all planets till the target_planet
    for to_planet = from_planet + 1:target_planet
        % cost from_planet to to_planet
        from_to_cost = planet_dist(x(:,from_planet),x(:,to_planet)) - t(to_planet);
        % if that is an improvement from the previous best of the planet
        if(score_planet + from_to_cost < best(to_planet))
            best(to_planet) = score_planet + from_to_cost;
            prev(to_planet) = from_planet;
        end;
    end;
end;

last = target_planet;
while (last>1)
    disp(['Planet: ' num2str(last)]);
    last = prev(last);
end;

disp(['Best Cost: ' num2str(best(target_planet))]);
clear all;