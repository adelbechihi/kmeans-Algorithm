function plot_lignes(x,classe,centres)
    n = length(classe); 
    hold on;
           
    for i = 1 : n
        pos = classe(i);
        plot([x(i,1),centres(pos,1)], [x(i,2), centres(pos,2)],'g--');
        % pause(0.001);
    end
    
end