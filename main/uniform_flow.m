function [P,Q] = uniform_flow(x,y)
% uniform flow in x direction
    vel_ify = 1;
    P = vel_ify*x;    % velocity potential function
    Q = vel_ify*y;    % streamline function
end

