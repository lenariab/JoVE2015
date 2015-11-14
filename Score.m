% SCORE is a function that calculates the value, dScore, used in the
% optimization procedure of MaskSpatialFiltering.m to fit the outlines
% of the fly arena to the experimental data.
% Inputs to the function:
% x - x-coordinates of the datato be fitted
% y - y-coordinates of the data to be fitted
% pars = [xa ya ang]  - a vector with initial values of arena coordinates 
%                       and the direction to the upper circle.
% R - radius of each of the 4 circles that outline the arena
% dR - a parameter that is required to calculate the score.
% Rdist - distance between the centre of the arena and the centre of a circle


function [dScore]=Score(x,y,pars, R, dR, Rdist)
 
% xa, ya and ang are the coordinates of arena centre and the direction to
% the upper circle
 xa=pars(1);
 ya=pars(2);
 ang=pars(3);
 
% xc contains x-coordinates of the four circles
 xc=[xa+Rdist*cos(ang); xa+Rdist*cos(ang-pi/2); ...
     xa-Rdist*cos(ang); xa-Rdist*cos(ang-pi/2)];
 
 % yc contains x-coordinates of the four circles
 yc=[ya+Rdist*sin(ang); ya+Rdist*sin(ang-pi/2); ...
     ya-Rdist*sin(ang); ya-Rdist*sin(ang-pi/2)];
     
 % find indexes of datapoints that are contained within circles with radius
 % R
 indR1=find((x-xc(1)).^2+(y-yc(1)).^2<R^2);
 indR2=find((x-xc(2)).^2+(y-yc(2)).^2<R^2);
 indR3=find((x-xc(3)).^2+(y-yc(3)).^2<R^2);
 indR4=find((x-xc(4)).^2+(y-yc(4)).^2<R^2);
 
 % find indexes of datapoints that are contained within circles with radius
 % R+dR. 
 inddR1=find((x-xc(1)).^2+(y-yc(1)).^2<(R+dR)^2);
 inddR2=find((x-xc(2)).^2+(y-yc(2)).^2<(R+dR)^2);
 inddR3=find((x-xc(3)).^2+(y-yc(3)).^2<(R+dR)^2);
 inddR4=find((x-xc(4)).^2+(y-yc(4)).^2<(R+dR)^2);
 
 if numel(inddR1)>numel(indR1) & numel(inddR2)>numel(indR2)&...
         numel(inddR3)>numel(indR3) & numel(inddR4)>numel(indR4)
     
 dScore=numel(indR1)+numel(indR2)+numel(indR3)+numel(indR4)-...
     (numel(inddR1)+numel(inddR2)+numel(inddR3)+numel(inddR4))
 else dScore=10000000;
 end;