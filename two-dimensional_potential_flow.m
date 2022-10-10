clc;clear;
clear;clc;close all;
set(0,'defaultlinelinewidth',2)
set(0,'defaultaxeslinewidth',2);
set(0,'defaultaxesfontsize',16);
set(0,'defaulttextfontsize',16);
set(0,'DefaultLineMarkerSize',12);

nx=50; % grid number
ny=50;
x_min=-3;
y_min=-3;
x_max=3;
y_max=3;
x1=linspace(x_min,x_max,nx);
y1=linspace(y_min,y_max,ny);
[x2,y2]=meshgrid(x1,y1);  % grid

r = (x2.^2+y2.^2).^5;
theta = atan(y2./x2);

% uniform flow
V_infty=1;
P1 = V_infty*x2;    % velocity potential function
Q1 = V_infty*y2;    % streamline function
% P=P1;
% Q=Q1;

% % source
% Lambda=1;
% P2=Lambda/2/pi*log(r);
% Q2=Lambda/2/pi*theta;
% P=P2;
% Q=Q2;

% vortex
Gamma=1;
P3=Gamma/2/pi*theta;
Q3=Gamma/2/pi*log(r);
P=P3;
Q=Q3;

% % doublet
kappa=1;
P4=kappa/2/pi*cos(theta)./r;
Q4=-kappa/2/pi*sin(theta)./r;

% uniform flow + source
% P12=P1+P2;
% Q12=Q1+Q2;
% P=P12;
% Q=Q12;

% % circular cylinder without lift = uniform flow + doublet 
% P14=P1+P4;
% Q14=Q1+Q4;
% P=P14;
% Q=Q14;

% circular cylinder with lift = uniform flow + doublet + vortex
P134=P1+P3+P4;
Q134=Q1+Q3+Q4;
P=P134;
Q=Q134;

[u2,v2]=gradient(P);
% max(abs(curl(x2,y2,u2,v2)),[],'all');
d = 1;      % arrow spacing
dd = 0.1;   % arrow length

figure
contour(x2,y2,P,'--','LineColor','k','LineWidth',0.8,'LevelList',linspace(-50,50,500));                         % velocity potential
hold on
quiver(x2(1:d:end,1:d:end),y2(1:d:end,1:d:end),u2(1:d:end,1:d:end)'./dd,v2(1:d:end,1:d:end)'./dd,'color','r')   % streamline 1
% hold on 
contour(x2,y2,Q,'LineColor','k','LineWidth',0.8,'LevelList',linspace(-50,50,500));                              % streamline 2
% text(0,1,'x','color','w','FontSize',16);    % stagnation point
xlabel('$x$','Interpreter','latex'); 
ylabel('$y$','Interpreter','latex');
hold off

