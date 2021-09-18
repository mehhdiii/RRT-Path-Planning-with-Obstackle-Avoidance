ITER = 1500; 

start_point = [5 5];

goal_point = [-10 5];

map = [start_point]; 
epsilon = 0.3; 

%obstacles: 
obstacles = [2 3 2; 
             7 8 2;
             -1 -1 2;
             -8 -5 2]; %centers and radii
viscircles(obstacles(:, 1:end-1) ,obstacles(:, end), 'Color', 'g')


 hold on
 plot(start_point(1),start_point(2),'r*')
 plot(goal_point(1),goal_point(2),'r*')
 
for i=1:ITER-1
    
    
    X_rand = 10*randn([1, 2]); %take a random point in the environment
    
    %calculate which point in the existing map has the smallest distance to
    %X_rand
   [smallest_idx] = closest_point(map,X_rand); 
    X_near = map(smallest_idx, :); 
    X_new = X_near + (X_rand - X_near)/norm(X_rand - X_near)*epsilon ; %new point is proportional to the distance from the nearest point
    
    dis_from_obs = sqrt((X_new(1)-obstacles(:, 1)).^2 + (X_new(2)-obstacles(:, 2)).^2); 
    if sum(dis_from_obs > obstacles(:, end))==4
        map = [map; X_new]; 
        con = [X_near; X_new];
        line(con(:,1), con(:,2))
    end
    
    
    
    
    

end
