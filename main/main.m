%===============================================================
%   Two-dimensional potential flow
%===============================================================
%
%   Code History:
%   06/10/2022 | gyc | code was generated
%   ------------------------------------------------------------
%
%   Description:
%   Type your choice with numbers to set the elementry flows
%   (1: uniform flow, 2: source, 3: vortex, 4: doublet)
%   then the code will calculte the velocity field and its velo-
%   city potential function and streamline function. 
%   The code will plot the streamline of the potential flow.
%   ------------------------------------------------------------
%
%===============================================================

%%
clear;clc;close all;
set(0,'defaultlinelinewidth',2)
set(0,'defaultaxeslinewidth',2);
set(0,'defaultaxesfontsize',16);
set(0,'defaulttextfontsize',16);
set(0,'DefaultLineMarkerSize',12);

%% init
P = 0; Q = 0;
P_temp = 0; Q_temp = 0;
flowname = ''; choice = '';
prompt = 'Enter your choice (1: uniform flow, 2: source/sink, 3: vortex, 4: doublet): ';
x = input(prompt);
x_str = num2str(x);
x_char = x_str(:);

for i = 1:length(x_char)
    char_temp = str2double(x_char(i));
    if char_temp ~= 1 && char_temp ~= 2 && char_temp ~= 3 && char_temp ~= 4
%         flowname = strcat(flowname,'uniform_flow_');
%     elseif char_temp == 2
%         flowname = strcat(flowname,'source_');
%     elseif char_temp == 3
%         flowname = strcat(flowname,'vortex_');
%     elseif char_temp == 4
%         flowname = strcat(flowname,'doublet_');
        disp('Wrong number, please input the right number again.');
        return;
    end
end

%% grid
nx=200;   ny=200;       % grid number
x_max=4;  y_max=x_max;  % size of computational domain
x_min=-x_max; y_min=-y_max; 
x_1d=linspace(x_min,x_max,nx);
y_1d=linspace(y_min,y_max,ny);
[x_2d,y_2d]=meshgrid(x_1d,y_1d); % grid

%% calculate
% calculate velocity potential function and streamline function
for i = 1:length(x_char)
    switch str2double(x_char(i))
        case 1
            choice = strcat(choice, 'uniform_flow,') ;
            [P_temp, Q_temp] = uniform_flow(x_2d,y_2d);
            P = P + P_temp; Q = Q + Q_temp;
        case 2
            prompt = 'Enter the position of the source/sink (default: 0): ';
            x_0 = input(prompt);
            if isempty(x_0)
                x_0 = 0;                
            end
            prompt = 'Enter the strength of the source/sink (default: 2*pi): ';
            Lambda = input(prompt);
            if isempty(Lambda)
                Lambda = 2*pi;                
            end
            if Lambda>0
                choice = strcat(choice, 'source,') ;
            elseif Lambda<0
                choice = strcat(choice, 'sink,') ;
            end
            [P_temp, Q_temp] = source_sink(x_2d,y_2d,x_0,Lambda);
            P = P + P_temp; Q = Q + Q_temp;
        case 3
            choice = strcat(choice, 'vortex,') ;
            [P_temp, Q_temp] = vortex(x_2d,y_2d);
            P = P + P_temp; Q = Q + Q_temp;
        case 4
            choice = strcat(choice, 'doublet,') ;
            [P_temp, Q_temp] = doublet(x_2d,y_2d);
            P = P + P_temp; Q = Q + Q_temp;
    end
end

if choice(end) == ','
    choice = choice(1:end-1);
end

fprintf('Your choice is: %s\n',choice);
[u,v]=gradient(P);
vel_magn = (u.^2+v.^2).^0.5;

%% plot
figure

% contour line of velocity potential
% contour(x_2d,y_2d,P,'--','LineColor','k','LineWidth',0.8,'LevelList',linspace(-50,50,500));                         % velocity potential
% hold on

% contour of velocity potential
% pcolor(x_2d,y_2d,P);
% shading interp; shading flat;
% colormap jet
% colorbar 
% hold on 

% streamline 
contour(x_2d,y_2d,Q,'LineColor','k','LineWidth',0.8,'LevelList',linspace(-50,50,500));      
hold off

% --------------image settings-------------------
xlabel('$x$','Interpreter','latex'); 
ylabel('$y$','Interpreter','latex');
box on
axis equal
% -----------------------------------------------

% ---------------output image--------------------
% set output_img = 1 to output image
output_img=1;
if(output_img==1)
    img = gcf;
    filename = strrep(choice,',','_');
    filename = strcat('../images/',filename,'.png');
    print(img, '-dpng', '-r600', filename);
end
% -----------------------------------------------

disp('Done!');