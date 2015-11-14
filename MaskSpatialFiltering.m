% Create a spatial mask that follows the contours of the arena and 
% apply the mask to the raw data to remove all data points that fall 
% outside of the arena as they represent noise.

%===== Make a mask that follows the outline of the arena===
% Arena may be repserented as space between 4 circles of equal and known
% radius R. However, the positions of the cirles' centres are not known,
% and will be found by fitting the data. The fitting procedure will
% minimize the Score, which is equal to the number of datapoints inside the
% circles of radius R minus number of datapoints inside circles of radius
% R+dR.



 R=367.5; % radius of circles that outline the star-shaped arena
 Rdist=530; % distance between the centre of the arena and the centre of a circle
 dR=10;   % parameter, needed for fitting procedure
 
load(data); % this should load a file with variables x, y and t,
            % that represent x and y coordinates and time code of all tracked 
            % flies in the course of an experiment
             
% x=nx;
% y=ny;            
 
 % xa0 and ya0 set the initial values for the centre of the arena
 % ang0 sets the initial direction from the centre of the arena to the 
 % centre of the top circle
 xa0=mean([min(x), max(x)]);
 ya0=mean([min(y), max(y)]);
 ang0=pi/2;

 % pars is a vector that contains initial approximations of arena
 % coordinates and direction to the upper circle. The values of pars will
 % be optimized by the fminsearch function below.
 pars=[xa0 ya0 ang0]; 
 
 % pars0 is a vector with initial parameter values
 pars0=pars;
 
 % pars_optimal is a vector that contains values of [x_coordinate_of_arena,
 % y_coordinate_of_arena, direction_to_upper_circle] after fitting to the
 % raw data. These parametres will define the mask, and should ideally be
 % very close to the countours of the actual arena. The optimization
 % procedure is designed to minimize the Score, which is the difference
 % between the amount of datapoints that fall within circles with radius R
 % and circles with radius R+dR. Ideally, circles with radius R will contain
 % no datapoints, and will be located just at the borders of the arena, 
%  and circles with radius R+dR will contain datapoints that fall near the 
% edges of the arena.
 pars_optimal=fminsearch(@ (pars) Score(x,y, pars, R, dR, Rdist), pars0, ...
     optimset('MaxIter',100000000,...
    'MaxFunEvals',100000000,'TolX',1e-15,'TolFun',1e-15,  'FunValCheck','on'));
 
% ========= Remove datapoints that fall outside ofthe mask==============
% Find datapoints that fall outside of the arena (i.e. inside the circles
% with radius R) and remove them from the dataset, as they represent noise

% xa, ya and ang are the coordinates of arena centre and the direction to
% the upper circle
xa=t_ans(1);
ya=t_ans(2);
ang=t_ans(3);

% xc contains x-coordinates of the four circles
xc=[xa+Rdist*cos(ang); xa+Rdist*cos(ang-pi/2); ...
    xa-Rdist*cos(ang); xa-Rdist*cos(ang-pi/2)];

% yc contains y-coordinates of the four circles
yc=[ya+Rdist*sin(ang); ya+Rdist*sin(ang-pi/2); ...
    ya-Rdist*sin(ang); ya-Rdist*sin(ang-pi/2)];

for i=1:4
    % find indexes of datapoints that fall within circles (thus outside of
    % the arena)
    ind=find((x-xc(i)).^2+(y-yc(i)).^2<R^2);
    
    % delete these datapoints from the general set    
    x(ind)=[];
    y(ind)=[];
    t(ind)=[];
end;

 