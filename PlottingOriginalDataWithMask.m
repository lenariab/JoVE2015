figure
plot(nx,ny,'.r', 'MarkerSize', 4)
axis equal
hold on
xa=t_ans(1);
ya=t_ans(2);
ang=t_ans(3);
xc=[xa+Rdist*cos(ang); xa+Rdist*cos(ang-pi/2); ...
xa-Rdist*cos(ang); xa-Rdist*cos(ang-pi/2)];
yc=[ya+Rdist*sin(ang); ya+Rdist*sin(ang-pi/2); ...
ya-Rdist*sin(ang); ya-Rdist*sin(ang-pi/2)];

h1=circle(xc(1), yc(1), R);
h2=circle(xc(1), yc(1), R+dR);
h3=circle(xc(2), yc(2), R+dR);
h4=circle(xc(2), yc(2), R);
h5=circle(xc(3), yc(3), R);
h6=circle(xc(3), yc(3), R+dR);
h7=circle(xc(4), yc(4), R+dR);
h8=circle(xc(4), yc(4), R);
set([h1 h2 h3 h4 h5 h6 h7 h8], 'Color', 'k')


xa=xa0;
ya=ya0;
ang=ang0;
xc=[xa+Rdist*cos(ang); xa+Rdist*cos(ang-pi/2); ...
xa-Rdist*cos(ang); xa-Rdist*cos(ang-pi/2)];
yc=[ya+Rdist*sin(ang); ya+Rdist*sin(ang-pi/2); ...
ya-Rdist*sin(ang); ya-Rdist*sin(ang-pi/2)];
h1=circle(xc(1), yc(1), R);
h2=circle(xc(1), yc(1), R+dR);
h3=circle(xc(2), yc(2), R+dR);
h4=circle(xc(2), yc(2), R);
h5=circle(xc(3), yc(3), R);
h6=circle(xc(3), yc(3), R+dR);
h7=circle(xc(4), yc(4), R+dR);
h8=circle(xc(4), yc(4), R);
set([h1 h2 h3 h4 h5 h6 h7 h8], 'Color', 'r')